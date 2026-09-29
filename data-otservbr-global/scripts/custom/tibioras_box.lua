local tibiorasBox = Action()

function tibiorasBox.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	local tile = item:getTile()
	if not tile or not tile:getHouse() then
		player:sendCancelMessage("You can only use Tibiora's box inside a house.")
		return true
	end

	if fromPosition.x == CONTAINER_POSITION then
		player:sendCancelMessage("Please place Tibiora's box on the floor or furniture in your house first.")
		return true
	end

	-- Return false to allow Canary C++ to process the depot container and open the personal depot locker
	return false
end

tibiorasBox:id(3997)
tibiorasBox:register()
