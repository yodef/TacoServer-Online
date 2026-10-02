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
	item:remove()
	local locker = Game.createItem(3497, 1, pos)
	if locker then
		pos:sendMagicEffect(CONST_ME_MAGIC_BLUE)
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Your Tibiora's box has transformed into a House Depot Locker!")
	end
	return true
end

tibiorasBox:id(3997)
tibiorasBox:register()

local repackLocker = Action()

function repackLocker.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if not target or not target:isItem() then
		return false
	end

	local targetId = target:getId()
	if (targetId >= 3497 and targetId <= 3500) or (targetId >= 2449 and targetId <= 2452) then
		local tile = target:getTile()
		if not tile or not tile:getHouse() then
			player:sendCancelMessage("You can only repack a depot locker inside a house.")
			return true
		end

		local pos = target:getPosition()
		target:remove()
		Game.createItem(2791, 1, pos)
		pos:sendMagicEffect(CONST_ME_POFF)
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You have packed the depot locker back into a locker kit.")
		return true
	end

	return false
end

repackLocker:id(3304)
repackLocker:register()
