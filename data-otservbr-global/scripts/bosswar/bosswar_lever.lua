local bossWar = Action()

local majorBosses = {
{id = 1, name = "King Zelos"},
{id = 2, name = "The Source of Corruption"},
{id = 3, name = "Ancient Spawn of Morgathla"},
{id = 4, name = "The Last Lore Keeper"},
{id = 5, name = "Urmahlullu the Immaculate"},
{id = 6, name = "the brainstealer"},
{id = 7, name = "Magma Bubble"},
{id = 8, name = "The First Dragon"},
{id = 9, name = "Ferumbras"},
{id = 10, name = "Lokathmor"},
{id = 11, name = "Mazzinor"},
{id = 12, name = "Ghulosh"},
{id = 13, name = "Gorzindel"},
{id = 14, name = "The Pale Worm"},
{id = 15, name = "World Devourer"},
{id = 16, name = "The Nightmare Beast"},
{id = 17, name = "Plagirath"},
{id = 18, name = "Mazoran"},
{id = 19, name = "Razzagorn"},
{id = 20, name = "Ragiaz"},
{id = 21, name = "Tarbaz"},
{id = 22, name = "Shulgrax"},
}

local randomBoss = {
{id = 1, name = "Duke Krule"},
{id = 2, name = "Earl Osam"},
{id = 3, name = "Drume"},
{id = 4, name = "Orshabaal"},
{id = 5, name = "Morgaroth"},
{id = 6, name = "Zoralurk"},
{id = 7, name = "Ghazbaran"},
{id = 8, name = "Scarlett Etzel"},
{id = 9, name = "Grand Master Oberon"},
{id = 10, name = "Lady Tenebris"},
{id = 11, name = "Melting Frozen Horror"},
{id = 12, name = "Count Vlarkorth"},
{id = 13, name = "Lord Azaram"},
{id = 14, name = "Sir Baeloc"},
{id = 15, name = "Sir Nictros"},
{id = 16, name = "Mounted Thorn Knight"},
{id = 17, name = "Lloyd"},
{id = 18, name = "Soul of Dragonking Zyrtarch"},
{id = 19, name = "The Time Guardian"},
{id = 20, name = "Timira the Many-Headed"},
{id = 21, name = "Ravenous Hunger"},
{id = 22, name = "The Unarmored Voidborn"},
{id = 23, name = "The Souldespoiler"},
{id = 24, name = "The False God"},
{id = 25, name = "Essence of Malice"},
{id = 26, name = "Ratmiral Blackwhiskers"},
{id = 27, name = "Gnomevil"},
{id = 28, name = "Deathstrike"},
{id = 29, name = "Abyssador"},
{id = 30, name = "Malofur Mangrinder"},
{id = 31, name = "the duke of the depths"},
{id = 32, name = "the count of the core"},
{id = 33, name = "the monster"},
{id = 34, name = "Brokul"},
{id = 35, name = "The Unwelcome"},
{id = 36, name = "The Dread Maiden"},
{id = 37, name = "The Fear Feaster"},
{id = 38, name = "Maxxenius"},
{id = 39, name = "Anomaly"},
{id = 40, name = "Realityquake"},
{id = 41, name = "Rupture"},
{id = 42, name = "Eradicator"},
{id = 43, name = "Outburst"},
{id = 44, name = "Izcandar The Banished"},
{id = 45, name = "Alptramun"},
{id = 46, name = "Plagueroot"},
{id = 47, name = "Deep Terror"},
{id = 48, name = "Apocalypse"},
{id = 49, name = "the baron from below"},
}

local config = {
    boss = {
		--name = bossName,
        position = Position(32150, 32301, 7),
    },
    playerPositions = {
        { pos = Position(32134, 32297, 6), teleport = Position(32141, 32301, 7) },
        { pos = Position(32134, 32298, 6), teleport = Position(32141, 32301, 7) },
	{ pos = Position(32134, 32299, 6), teleport = Position(32141, 32301, 7) },
        { pos = Position(32134, 32300, 6), teleport = Position(32141, 32301, 7) },
	{ pos = Position(32134, 32301, 6), teleport = Position(32141, 32301, 7) },
    },
    specPos = {
        from = Position(32139, 32294, 7),
        to = Position(32154, 32309, 7),
    },
    --teleportTimer = 30,
	--cooldownTimer = 35,
	teleportTimer = 10 * 60, -- 10 minutes
	--cooldownTimer = 3 * 60 * 60, -- 3 hours
	--storage = 15051 -- Needs to be unique, used for player cooldown
}

local function removeMonsterFromArea(fromPos, toPos)
    local exitPosition = Position(32139, 32301, 7)
    for _x = fromPos.x, toPos.x do
        for _y = fromPos.y, toPos.y do
            for _z = fromPos.z, toPos.z do
                local tile = Tile(Position(_x, _y, _z))
                if tile then
                    local creatures = tile:getCreatures()
                    if creatures then
                        for _, creature in ipairs(creatures) do
                            if creature:isMonster() then
                                creature:remove()
                                print("There's a creature, removing it..")
                            elseif creature:isPlayer() then
                                creature:teleportTo(exitPosition)
                                print("There's a player, teleporting them out of the boss room..")
                            end
                        end
                    end
                end
            end
        end
    end
    return false
end

-- Part of teleportation of players, entrance
function isPositionEqual(pos1, pos2)
    return pos1.x == pos2.x and pos1.y == pos2.y and pos1.z == pos2.z
end

function bossWar.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	local difficulty = player:getStorageValue(15054)
    --if player:getStorageValue(config.storage) > os.time() then -- Is player cooldown locked?
        --local remainingCooldown = player:getStorageValue(config.storage) - os.time()
        --player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You need to wait " .. os.date("!%X", remainingCooldown) .. " before you can enter the Boss War Arena again." )
       -- return true
    --end
    local playerOnTile = false
    for _, positionData in ipairs(config.playerPositions) do
        if isPositionEqual(player:getPosition(), positionData.pos) then
            playerOnTile = true
            break
        end
    end
    -- If player is not on tile, return false to avoid spawning monsters and execute script
    if not playerOnTile then
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You can enter the Boss War Arena, please stand on one of the tiles and use the lever. Make sure you select the difficulty using command !bosswar.")
        return false
    end
    -- Does one of the players have a cooldown?
    local cooldownPlayerOnTile = false
    for _, positionData in ipairs(config.playerPositions) do
        local tile = Tile(positionData.pos)
        for _, creature in ipairs(tile:getCreatures()) do
            --if creature:isPlayer() and creature:getStorageValue(config.storage) > os.time() then
                --cooldownPlayerOnTile = true
                --break
            --end
        end
    end
    if cooldownPlayerOnTile then
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "One of the players on the tiles has cooldown to join the Boss War Arena.")
        return true
    end
    -- If lever is pressed, and cooldown is active.
    if item.itemid == 8912 then
        player:say("Cling..", TALKTYPE_MONSTER_SAY)
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "This arena is still active. Please wait a few minutes.")
        return true
    end
	-- PLATININUM TOKEN COST
	if difficulty <= 0 then --DIFFICULTY EASY
		local cost = 1
		if not player:removeItem(22723, cost) then
			player:say("You have to pay ".. cost .." platinum tokens to enter in EASY.", TALKTYPE_MONSTER_SAY)
			return true
		end
	elseif difficulty == 1 then --DIFFICULTY MEDIUM
		if not player:removeItem(20272, 1) then		
			player:say("You need a bronze epic key to enter in MEDIUM.", TALKTYPE_MONSTER_SAY)
			return true				
		end
	elseif difficulty == 2 then --DIFFICULTY HARD		
		if not player:removeItem(20270, 1) then		
			player:say("You need a silver epic key to enter in HARD.", TALKTYPE_MONSTER_SAY)
			return true
		end
	elseif difficulty == 3 then --DIFFICULTY INFERNO
		if not player:removeItem(20273, 1) then				
			player:say("You need a golden epic key to enter in INFERNO.", TALKTYPE_MONSTER_SAY)
			return true
		end
	elseif difficulty == 4 then --DIFFICULTY NIGHTMARE
		if not player:removeItem(20271, 1) then		
			player:say("You need a platinum epic key to enter in NIGHTMARE.", TALKTYPE_MONSTER_SAY)
			return true
		end
	elseif difficulty >= 5 then --DEATHMATCH MODE
		local cost = 5
		if not player:removeItem(22723, cost) then		
			player:say("You have to pay ".. cost .." platinum tokens to enter a DEATHMATCH mode.", TALKTYPE_MONSTER_SAY)
			return true
		end
	end
		--BOSS SELECTION/SUMMONING
	local bossName1 = randomBoss[math.random(1, #randomBoss)].name
	local bossName2 = randomBoss[math.random(1, #randomBoss)].name
	local bossName3 = randomBoss[math.random(1, #randomBoss)].name
	local bossName4 = randomBoss[math.random(1, #randomBoss)].name
	local bossName5 = randomBoss[math.random(1, #randomBoss)].name
	local bossName6 = randomBoss[math.random(1, #randomBoss)].name
	local bossName7 = randomBoss[math.random(1, #randomBoss)].name
	local bossName8 = randomBoss[math.random(1, #randomBoss)].name
	local majorbossName1 = majorBosses[math.random(1, #majorBosses)].name
	local majorbossName2 = majorBosses[math.random(1, #majorBosses)].name
	local majorbossName3 = majorBosses[math.random(1, #majorBosses)].name
	
	--BOSS DELAY
	local delay = 1 * 60 * 1000  -- 1 min
	--TIMER
	addEvent(function() player:say("Arena Event: 5 minutes left...", TALKTYPE_MONSTER_SAY) end, delay * 5)
	addEvent(function() player:say("Arena Event: 3 minutes left...", TALKTYPE_MONSTER_SAY) end, delay * 7)
	addEvent(function() player:say("Arena Event: 1 minute left.", TALKTYPE_MONSTER_SAY) end, delay * 9)
	addEvent(function() player:say("Arena Event: 10 seconds left!", TALKTYPE_MONSTER_SAY) end, (590 * 1000))
	addEvent(function() player:say("Arena Event: 3 seconds left!", TALKTYPE_MONSTER_SAY) end, (597 * 1000))
	addEvent(function() player:say("Arena Event: 2 seconds left!", TALKTYPE_MONSTER_SAY) end, (598 * 1000))
	addEvent(function() player:say("Arena Event: 1 seconds left!", TALKTYPE_MONSTER_SAY) end, (599 * 1000))
	--BOSS SUMMON
	local function createBoss(bossName)
		Game.createMonster(bossName, config.boss.position, 1)					
	end
	
    -- If lever time is over or reset
    if item.itemid == 8911 then
        item:transform(8912)		
		if difficulty <= 0 then --DIFFICULTY EASY
			Game.createMonster(bossName1, config.boss.position, 1)
			addEvent(function() createBoss(bossName2) end, delay * 2)
			addEvent(function() createBoss(bossName3) end, delay * 4)
			addEvent(function() createBoss(bossName4) end, delay * 6)
			Broadcast("Boss War Arena A started on EASY difficulty. You have only 10 minutes to fight!")		
		elseif difficulty == 1 then --DIFFICULTY MEDIUM	
			Game.createMonster(bossName1, config.boss.position, 1)
			addEvent(function() createBoss(bossName2) end, delay * 2)
			addEvent(function() createBoss(bossName3) end, delay * 4)
			addEvent(function() createBoss(majorbossName1) end, delay * 5)
			Broadcast("Boss War Arena A started on MEDIUM difficulty. You have only 10 minutes to fight!")
		elseif difficulty == 2 then --DIFFICULTY HARD
			Game.createMonster(bossName1, config.boss.position, 1)
			Game.createMonster(bossName2, config.boss.position, 1)
			addEvent(function() createBoss(bossName3) end, delay * 3)
			addEvent(function() createBoss(bossName4) end, delay * 3)
			addEvent(function() createBoss(majorbossName2) end, delay * 3)
			Broadcast("Boss War Arena A started on HARD difficulty. You have only 10 minutes to fight!")
		elseif difficulty == 3 then --DIFFICULTY INFERNO
				Game.createMonster(majorbossName1, config.boss.position, 1)
				Game.createMonster(majorbossName2, config.boss.position, 1)
				Game.createMonster(bossName1, config.boss.position, 1)
				Game.createMonster(bossName2, config.boss.position, 1)
				Game.createMonster(bossName3, config.boss.position, 1)
				Broadcast("Boss War Arena A started on INFERNO difficulty. You have only 10 minutes to fight!")
		elseif difficulty == 4 then --DIFFICULTY NIGHTMARE
				Game.createMonster(majorbossName1, config.boss.position, 1)
				Game.createMonster(majorbossName2, config.boss.position, 1)
				Game.createMonster(majorbossName3, config.boss.position, 1)
				Game.createMonster(bossName1, config.boss.position, 1)
				Game.createMonster(bossName2, config.boss.position, 1)
				Game.createMonster(bossName3, config.boss.position, 1)
				Game.createMonster(bossName4, config.boss.position, 1)
				Broadcast("Boss War Arena A started on NIGHTMARE difficulty. You have only 10 minutes to fight!")
		elseif difficulty >= 5 then --DEATMATCH MODE	
			Game.createMonster(bossName1, config.boss.position, 1)	
			addEvent(function() createBoss(bossName2) end, delay * 1)
			addEvent(function() createBoss(bossName3) end, delay * 1)
			addEvent(function() createBoss(bossName4) end, delay * 3)
			addEvent(function() createBoss(bossName5) end, delay * 3)
			addEvent(function() createBoss(majorbossName1) end, delay * 5)
			addEvent(function() createBoss(bossName6) end, delay * 7)
			addEvent(function() createBoss(bossName7) end, delay * 7)
			addEvent(function() createBoss(bossName8) end, delay * 7)
			Broadcast("Boss War Arena A started on DEATHMATCH mode. Slay the all the bosses you can in 10 minutes!")
		end		
        -- teleport player(s)
        for _, positionData in ipairs(config.playerPositions) do
            local posTile = Tile(positionData.pos)
            local newTeleportPos = positionData.teleport

            local creatures = posTile:getCreatures()
            if creatures then -- make sure getCreatures doesn't return nil
                for _, creature in ipairs(creatures) do
                    if creature:isPlayer() then
                        local playerName = creature:getName()

                        print("Teleporting player(s) into boss room:", playerName)
                        creature:teleportTo(newTeleportPos, true)
                        newTeleportPos:sendMagicEffect(CONST_ME_TELEPORT)

                        -- Set player cooldown
                        --creature:setStorageValue(config.storage, os.time() + config.cooldownTimer) -- cooldown timer
			creature:setStorageValue(15053, 1)
                    end
                end
            end
        end

        addEvent(function() -- Change lever back once time is up
            item:transform(8911)
            -- Kick players, remove mobs from radius
            removeMonsterFromArea(config.specPos.from, config.specPos.to)
            player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Time is up! Event has concluded on Boss War Arena A.")
        end, config.teleportTimer * 1000)
    end
    return true
end

bossWar:aid(2600)
bossWar:register()