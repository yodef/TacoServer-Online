local lastTeleport = MoveEvent()

function lastTeleport.onStepIn(creature, item, position, fromPosition)
	local player = creature:getPlayer()
	if not player then
		return true
	end

	local destination = Position(33585, 30990, 14)

	local timer = player:getStorageValue(Storage.Quest.U11_02.TheFirstDragon.FirstDragonTimer)
	if timer > os.time() then
		player:teleportTo(fromPosition, true)
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You have to wait to challenge The First Dragon again!")
		player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
		return true
	end

	local access = player:getStorageValue(Storage.Quest.U11_02.TheFirstDragon.AccessCave)
	if access < 4 then
		player:teleportTo(fromPosition, true)
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You must sacrifice all four dragon relics to enter The First Dragon's sanctuary.")
		player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
		return true
	end

	position:sendMagicEffect(CONST_ME_TELEPORT)
	player:teleportTo(destination)
	player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
	return true
end

lastTeleport:uid(24889)
lastTeleport:aid(24889)
lastTeleport:position(Position(33597, 30996, 14))
lastTeleport:register()

-- Exit teleport from lever room back to cave entrance
local leverExitTeleport = MoveEvent()
function leverExitTeleport.onStepIn(creature, item, position, fromPosition)
	local player = creature:getPlayer()
	if not player then
		return true
	end

	player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
	player:teleportTo(Position(33597, 30994, 14))
	player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
	return true
end

-- Typical back teleport in lever room
leverExitTeleport:position(Position(33585, 30989, 14))
leverExitTeleport:register()
