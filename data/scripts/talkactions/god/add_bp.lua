-- !addbp PlayerName, 500
-- /addbp PlayerName, 500

local addBp = TalkAction("!addbp", "/addbp")

function addBp.onSay(player, words, param)
	-- Create log
	logCommand(player, words, param)

	if not param or param:trim() == "" then
		player:sendCancelMessage("Usage: !addbp <player name>, <amount>")
		return true
	end

	local split = param:split(",")
	if #split < 2 then
		player:sendCancelMessage("Usage: !addbp <player name>, <amount>")
		return true
	end

	local targetName = split[1]:trim()
	local amount = tonumber(split[2]:trim())

	if not amount or amount <= 0 then
		player:sendCancelMessage("Invalid amount. Please specify a positive number.")
		return true
	end

	local storageKey = 14020

	local targetPlayer = Player(targetName)
	if targetPlayer then
		local current = math.max(0, targetPlayer:getStorageValue(storageKey))
		local newTotal = current + amount
		targetPlayer:setStorageValue(storageKey, newTotal)
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, string.format("Successfully added %d Bounty Points to %s (Online). New balance: %d BP.", amount, targetPlayer:getName(), newTotal))
		targetPlayer:sendTextMessage(MESSAGE_EVENT_ADVANCE, string.format("%s has added %d Bounty Points to your character. You now have %d BP.", player:getName(), amount, newTotal))
		targetPlayer:getPosition():sendMagicEffect(CONST_ME_MAGIC_GREEN)
		logger.info("[addBp] {} added {} BP to online player {}", player:getName(), amount, targetPlayer:getName())
		return true
	end

	-- Player is offline, update database directly
	local resultId = db.storeQuery(string.format("SELECT `id`, `name` FROM `players` WHERE `name` = %s", db.escapeString(targetName)))
	if resultId then
		local charName = result.getString(resultId, "name")
		local charId = result.getNumber(resultId, "id")
		result.free(resultId)

		local curQuery = db.storeQuery(string.format("SELECT `value` FROM `player_storage` WHERE `player_id` = %d AND `key` = %d", charId, storageKey))
		local current = 0
		if curQuery then
			current = math.max(0, result.getNumber(curQuery, "value"))
			result.free(curQuery)
		end
		local newTotal = current + amount

		db.query(string.format("INSERT INTO `player_storage` (`player_id`, `key`, `value`) VALUES (%d, %d, %d) ON DUPLICATE KEY UPDATE `value` = %d", charId, storageKey, newTotal, newTotal))
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, string.format("Successfully added %d Bounty Points to %s (Offline). Previous: %d BP, New: %d BP.", amount, charName, current, newTotal))
		logger.info("[addBp] {} added {} BP to offline player {}", player:getName(), amount, charName)
	else
		player:sendCancelMessage(string.format("Player '%s' does not exist.", targetName))
	end

	return true
end

addBp:separator(" ")
addBp:groupType("god")
addBp:register()
