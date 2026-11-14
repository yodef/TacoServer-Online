local UniqueTable = {
	-- Tazhadur entrance
	[35001] = {
		crystalPos = { x = 33234, y = 32276, z = 12 },
		range = 10,
		newPos = { x = 32015, y = 32466, z = 8 },
		bossName = "Tazhadur",
		bossPos = { x = 32018, y = 32465, z = 8 },
	},
	-- Kalyassa entrance
	[35002] = {
		crystalPos = { x = 33160, y = 31320, z = 5 },
		range = 10,
		newPos = { x = 32078, y = 32456, z = 8 },
		bossName = "Kalyassa",
		bossPos = { x = 32079, y = 32459, z = 8 },
	},
	-- Zorvorax entrance
	[35003] = {
		crystalPos = { x = 33003, y = 31593, z = 11 },
		range = 10,
		newPos = { x = 32008, y = 32396, z = 8 },
		bossName = "Zorvorax",
		bossPos = { x = 32015, y = 32396, z = 8 },
	},
	-- Gelidrazah entrance
	[35004] = {
		crystalPos = { x = 32276, y = 31367, z = 4 },
		range = 10,
		newPos = { x = 32076, y = 32402, z = 8 },
		bossName = "Gelidrazah the Frozen",
		bossPos = { x = 32078, y = 32400, z = 8 },
	},
}

local entranceTeleport = MoveEvent()
function entranceTeleport.onStepIn(creature, item, position, fromPosition)
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
			if v.crystalPos and position.x == v.crystalPos.x and position.y == v.crystalPos.y and position.z == v.crystalPos.z then
				setting = v
				break
			end
		end
	end

	if not setting then
		return true
	end

	if player:getStorageValue(Storage.Quest.U11_02.TheFirstDragon.Questline) < 1 then
		player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
		player:teleportTo(fromPosition)
		player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
		player:say("You must speak with Tamoril before challenging the dragon ancestors.", TALKTYPE_MONSTER_SAY)
		return true
	end

	if roomIsOccupied(setting.bossPos, false, setting.range, setting.range) then
		player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
		player:teleportTo(fromPosition)
		player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
		player:say("Someone is fighting against the boss! You need to wait a while.", TALKTYPE_MONSTER_SAY)
		return true
	end

	if not player:canFightBoss(setting.bossName) then
		player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
		player:teleportTo(fromPosition)
		player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
		player:say("You have to wait to challenge this enemy again!", TALKTYPE_MONSTER_SAY)
		return true
	end

	local monster = Game.createMonster(setting.bossName, setting.bossPos, true, true)
	if not monster then
		logger.warn("[FirstDragon] Failed to spawn {} at {}", setting.bossName, Position(setting.bossPos):toString())
		player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
		player:teleportTo(fromPosition)
		player:say("The boss could not be summoned right now. Please try again.", TALKTYPE_MONSTER_SAY)
		return true
	end

	player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
	player:teleportTo(setting.newPos)
	player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
	player:say("You have ten minutes to kill and loot this boss. Otherwise you will lose that chance and will be kicked out.", TALKTYPE_MONSTER_SAY)
	player:setBossCooldown(setting.bossName, os.time() + 2 * 3600)
	addEvent(clearBossRoom, 60 * 10 * 1000, player.uid, setting.bossPos, false, setting.range, setting.range, fromPosition)
	return true
end

-- Register entrance crystals by position
for _, setting in pairs(UniqueTable) do
	if setting.crystalPos then
		entranceTeleport:position(Position(setting.crystalPos))
	end
end
entranceTeleport:register()

-- Dedicated hub portal to Zorvorax's crystal room (Tamoril tower roof Z=5)
local hubZorvoraxPortal = MoveEvent()
function hubZorvoraxPortal.onStepIn(creature, item, position, fromPosition)
	local player = creature:getPlayer()
	if not player then
		return true
	end

	-- Clean up broken dest=(0,0,0) teleport item if present on this tile
	local tile = Tile(Position(32914, 31020, 5))
	if tile then
		local tItem = tile:getItemById(25054)
		if tItem and tItem:getDestination() == Position(0, 0, 0) then
			tItem:remove()
		end
	end

	player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
	player:teleportTo(Position(33004, 31593, 11))
	player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
	return true
end
hubZorvoraxPortal:position(Position(32914, 31020, 5))
hubZorvoraxPortal:register()
