local expBoost = Action()

function expBoost.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if not player then
		return false
	end

	local playerKV = player:kv()
	local expBoostCount = tonumber(playerKV:get(GameStore.Kv.expBoostCount)) or 0

	if expBoostCount >= 3 then -- Xp boost can only be used 3 times a day
		player:say("You have reached the limit for today, try again after Server Save.", TALKTYPE_MONSTER_SAY)
		return true
	end

	local remainingBoost = player:getExpBoostStamina()
	if remainingBoost > 0 then -- If player still has an active xp boost, don't let him use another one
		player:say("You already have an active XP boost.", TALKTYPE_MONSTER_SAY)
		return true
	end

	player:setStoreXpBoost(100)
	player:setExpBoostStamina(remainingBoost + 3600)
	playerKV:set(GameStore.Kv.expBoostCount, expBoostCount + 1)
	item:remove(1)
	player:say("You will receive +100% bonus XP for 60 minutes.", TALKTYPE_MONSTER_SAY)
	return true
end

expBoost:id(39036)
expBoost:register()
