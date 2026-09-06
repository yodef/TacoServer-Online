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

bossWarTp:position({ x = 32659, y = 31230, z = 7 }, {x = 32659, y = 31215, z = 8})
bossWarTp:register()
