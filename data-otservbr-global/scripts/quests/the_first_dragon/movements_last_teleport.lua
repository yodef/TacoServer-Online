local lastTeleport = MoveEvent()

function lastTeleport.onStepIn(creature, item, position, fromPosition)
	local player = creature:getPlayer()
	if not player then
		return true
	end

	local destination = { x = 33585, y = 30990, z = 14 }

	if player:getStorageValue(Storage.Quest.U11_02.TheFirstDragon.FirstDragonTimer) < os.time() then
		position:sendMagicEffect(CONST_ME_TELEPORT)
		player:teleportTo(destination)
		player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
	else
		player:teleportTo(fromPosition, true)
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You have to wait to challenge The First Dragon again!")
		player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
	end

	return true
end

lastTeleport:uid(24889)
lastTeleport:aid(24889)
lastTeleport:register()
