-- Reward Chest Expiration System
-- Limits the time boss reward bags stay in the Reward Chest to prevent massive accumulation.
-- Configured for Option 2: 3 days (72 hours).

REWARD_CHEST_EXPIRATION_TIME = 3 * 24 * 60 * 60 -- 3 days in seconds (259200)

function Player.purgeExpiredRewards(self, notifyPlayer)
	local rewardList = self:getRewardList()
	if not rewardList or #rewardList == 0 then
		return 0
	end

	local nowMs = os.time() * 1000
	local expireMs = REWARD_CHEST_EXPIRATION_TIME * 1000
	local expiredCount = 0

	for _, rewardId in ipairs(rewardList) do
		local timestampMs = (rewardId > 1000000000000) and rewardId or (rewardId * 1000)
		if (nowMs - timestampMs) >= expireMs then
			local reward = self:getReward(rewardId, false)
			if reward then
				local size = reward:getSize()
				for i = size - 1, 0, -1 do
					local item = reward:getItem(i)
					if item then
						item:remove()
					end
				end
				reward:remove()
			end
			self:removeReward(rewardId)
			expiredCount = expiredCount + 1
		end
	end

	if expiredCount > 0 then
		self:save()
		if notifyPlayer then
			self:sendTextMessage(
				MESSAGE_STATUS,
				string.format("Notice: %d boss reward(s) have expired and were removed from your reward chest (time limit: 3 days).", expiredCount)
			)
		end
		logger.info(string.format("[RewardExpiration] Purged %d expired boss reward(s) from %s (GUID: %d).", expiredCount, self:getName(), self:getGuid()))
	end

	return expiredCount
end

-- Periodic check for all online players (runs every 15 minutes)
local rewardExpirationGlobal = GlobalEvent("RewardChestExpirationPeriodic")

function rewardExpirationGlobal.onThink(interval)
	for _, player in ipairs(Game.getPlayers()) do
		player:purgeExpiredRewards(true)
	end
	return true
end

rewardExpirationGlobal:interval(15 * 60 * 1000)
rewardExpirationGlobal:register()

-- Login hook to purge expired rewards before player opens chest
local rewardExpirationLogin = CreatureEvent("RewardChestExpirationLogin")

function rewardExpirationLogin.onLogin(player)
	player:purgeExpiredRewards(true)
	return true
end

rewardExpirationLogin:register()
