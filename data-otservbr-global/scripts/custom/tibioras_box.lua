local tibiorasBox = Action()

function tibiorasBox.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	local tile = item:getTile()
	if not tile or not tile:getHouse() then
		player:sendCancelMessage("You can only use Tibiora's box inside a house.")
		return true
	end

	if fromPosition.x == CONTAINER_POSITION then
		player:sendCancelMessage("Please place Tibiora's box on the floor in your house first.")
		return true
	end

	local pos = item:getPosition()
	item:transform(2449, 1)
	pos:sendMagicEffect(CONST_ME_MAGIC_BLUE)
	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Your Tibiora's box has transformed into a House Depot Locker!")
	return true
end

tibiorasBox:id(3997)
tibiorasBox:register()
