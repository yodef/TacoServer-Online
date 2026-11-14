local UniqueTable = {
	-- Tazhadur exit
	[35005] = {
		exitPos = { x = 32013, y = 32467, z = 8 },
		backPos = { x = 33234, y = 32278, z = 12 },
	},
	-- Kalyassa exit
	[35006] = {
		exitPos = { x = 32076, y = 32457, z = 8 },
		backPos = { x = 33162, y = 31320, z = 5 },
	},
	-- Zorvorax exit
	[35007] = {
		exitPos = { x = 32006, y = 32395, z = 8 },
		backPos = { x = 33002, y = 31595, z = 11 },
	},
	-- Gelidrazah exit
	[35008] = {
		exitPos = { x = 32077, y = 32404, z = 8 },
		backPos = { x = 32278, y = 31367, z = 4 },
	},
}

local exitTeleport = MoveEvent()
function exitTeleport.onStepIn(creature, item, position, fromPosition)
	local player = creature:getPlayer()
	if not player then
		return true
	end

	local setting = nil
	if item then
		setting = UniqueTable[item.uid] or UniqueTable[item.actionid]
	end
	if not setting then
		for _, v in pairs(UniqueTable) do
			if v.exitPos and position.x == v.exitPos.x and position.y == v.exitPos.y and position.z == v.exitPos.z then
				setting = v
				break
			end
		end
	end

	if not setting then
		return true
	end

	player:teleportTo(setting.backPos)
	player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
	return true
end

-- Register exit crystals by position
for _, setting in pairs(UniqueTable) do
	if setting.exitPos then
		exitTeleport:position(Position(setting.exitPos))
	end
end
exitTeleport:register()

-- Return teleport from First Dragon Lava Shrine back to Tamoril's Tower
local shrineReturnPortal = MoveEvent()
function shrineReturnPortal.onStepIn(creature, item, position, fromPosition)
	local player = creature:getPlayer()
	if not player then
		return true
	end
	player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
	player:teleportTo(Position(32912, 31017, 5))
	player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
	return true
end
-- Step south onto 33047, 32715, 3 to return to Tamoril's Hub
shrineReturnPortal:position(Position(33047, 32715, 3))
shrineReturnPortal:register()
