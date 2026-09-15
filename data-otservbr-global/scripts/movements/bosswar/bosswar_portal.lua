local bossWarTp = MoveEvent()

function bossWarTp.onStepIn(creature, item, position, fromPosition)
	local player = creature:getPlayer()
	if not player then
		return true
	end	
	player:setStorageValue(15053, 0)
	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You have left the Boss War Arena.")
	return true
end

bossWarTp:position({ x = 32139, y = 32301, z = 7}, { x = 32139, y = 32301, z = 7})
bossWarTp:register()
