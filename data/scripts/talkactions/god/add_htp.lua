-- !addhtp PlayerName, 1500
-- /addhtp PlayerName, 1500

local addHtp = TalkAction("!addhtp", "/addhtp")

function addHtp.onSay(player, words, param)
	-- Create log
	logCommand(player, words, param)

	if not param or param:trim() == "" then
		player:sendCancelMessage("Usage: !addhtp <player name>, <amount>")
		return true
	end

	local split = param:split(",")
	if #split < 2 then
		player:sendCancelMessage("Usage: !addhtp <player name>, <amount>")
		return true
	end

	local targetName = split[1]:trim()
	local amount = tonumber(split[2]:trim())

	if not amount or amount <= 0 then
		player:sendCancelMessage("Invalid amount. Please specify a positive number.")
		return true
	end

	local targetPlayer = Player(targetName)
	if targetPlayer then
		targetPlayer:addTaskHuntingPoints(amount)
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, string.format("Successfully added %d Hunting Task Points to %s (Online). New balance: %d HTP.", amount, targetPlayer:getName(), targetPlayer:getTaskHuntingPoints()))
		targetPlayer:sendTextMessage(MESSAGE_EVENT_ADVANCE, string.format("%s has added %d Hunting Task Points to your character. You now have %d HTP.", player:getName(), amount, targetPlayer:getTaskHuntingPoints()))
		targetPlayer:getPosition():sendMagicEffect(CONST_ME_MAGIC_GREEN)
		logger.info("[addHtp] {} added {} HTP to online player {}", player:getName(), amount, targetPlayer:getName())
		return true
	end

	-- Player is offline, update database directly
	local resultId = db.storeQuery(string.format("SELECT `id`, `name`, `task_points` FROM `players` WHERE `name` = %s", db.escapeString(targetName)))
	if resultId then
		local charName = result.getString(resultId, "name")
		local charId = result.getNumber(resultId, "id")
		local currentPoints = result.getNumber(resultId, "task_points")
		result.free(resultId)

		local newPoints = currentPoints + amount
		db.query(string.format("UPDATE `players` SET `task_points` = %d WHERE `id` = %d", newPoints, charId))
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, string.format("Successfully added %d Hunting Task Points to %s (Offline). Previous: %d HTP, New: %d HTP.", amount, charName, currentPoints, newPoints))
		logger.info("[addHtp] {} added {} HTP to offline player {}", player:getName(), amount, charName)
	else
		player:sendCancelMessage(string.format("Player '%s' does not exist.", targetName))
	end

	return true
end

addHtp:separator(" ")
addHtp:groupType("god")
addHtp:register()
