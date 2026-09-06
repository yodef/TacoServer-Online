local waterIds = { 622, 4597, 4598, 4599, 4600, 12561, 12563, 4601, 4602, 4609, 4610, 4611, 4612, 4613, 4614, 629, 630, 631, 632, 633, 634, 7236, 9582, 13988, 13989, 12560, 21414 }
local lootTrash = { 3119, 3123, 3264, 3409, 3578 }
local lootCommon = { 3035, 3051, 3052, 3580, 236, 237 }
local lootRare = { 3026, 3029, 3032, 7158, 7159 }
local lootVeryRare = { 281, 282, 9303 }
local lootVeryRare1 = { 281, 12557 }
local lootRare1 = { 3026, 12557 }
local lootCommon1 = { 3035, 237, 12557 }

local elementals = {
	chances = {
		{ from = 0, to = 500, itemId = 3026 }, -- white pearl
		{ from = 501, to = 801, itemId = 3029 }, -- small sapphire
		{ from = 802, to = 1002, itemId = 3032 }, -- small emerald
		{ from = 1003, to = 1053, itemId = 281 }, -- giant shimmering pearl (green)
		{ from = 1054, to = 1104, itemId = 282 }, -- giant shimmering pearl (brown)
		{ from = 1105, to = 1115, itemId = 9303 }, -- leviathan's amulet
	},
}

local fishingTry = {--FISHABLE CREATURES
	--{name = "Fish", chance = 850, tries = 1, level = 11},THIS WAS THE 1st TEST
	{name = "Crab", chance = 750, tries = 1, level = 11 },	
	{name = "Calamary", chance = 333, tries = 2, level = 12 },
	{name = "Northern Pike", chance = 150, tries = 2, level = 12 },
	{name = "Crocodile", chance = 500, tries = 3, level = 13 },
	{name = "Tortoise", chance = 450, tries = 3, level = 13 },	
	{name = "Manta Ray", chance = 80, tries = 10, level = 13 },
	{name = "Quara Mantassin Scout", chance = 450, tries = 4, level = 18 },	
	{name = "Thornback Tortoise", chance = 333, tries = 4, level = 18 },
	{name = "Blood Crab", chance = 666, tries = 4, level = 18 },
	{name = "Deepsea Blood Crab", chance = 666, tries = 4, level = 18 },
	{name = "Groam", chance = 30, tries = 15, level = 18 },
	{name = "Abyssal Calamary", chance = 250, tries = 4, level = 18 },
	{name = "Quara Constrictor Scout", chance = 250, tries = 4, level = 18 },
	{name = "Quara Predator Scout", chance = 250, tries = 5, level = 21 },
	{name = "Quara Constrictor", chance = 230, tries = 5, level = 21 },	
	{name = "Slick Water Elemental", chance = 210, tries = 5, level = 21 },
	{name = "Quara Pincher Scout", chance = 250, tries = 6, level = 25 },
	{name = "Quara Mantassin", chance = 230, tries = 6, level = 25 },
	{name = "Water Elemental", chance = 210, tries = 6, level = 25 },
	{name = "Quara Hydromancer Scout", chance = 310, tries = 7, level = 30 },
	{name = "Shark", chance = 450, tries = 7, level = 30 },
	{name = "Renegade Quara Constrictor", chance = 250, tries = 8, level = 35 },
	{name = "Renegade Quara Mantassin", chance = 230, tries = 8, level = 35 },
	{name = "Quara Hydromancer", chance = 210, tries = 8, level = 35 },
	{name = "Massive Water Elemental", chance = 250, tries = 8, level = 35 },
	{name = "Young Sea Serpent", chance = 350, tries = 8, level = 35 },
	{name = "Deepling Spellsinger", chance = 360, tries = 8, level = 35 },
	{name = "Roaring Water Elemental", chance = 250, tries = 9, level = 40 },	
	{name = "Quara Pincher", chance = 210, tries = 9, level = 40 },	
	{name = "Quara Predator", chance = 180, tries = 9, level = 40 },
	{name = "Renegade Quara Hydromancer", chance = 180, tries = 9, level = 40 },
	{name = "Deepling Warrior", chance = 360, tries = 9, level = 40 },	
	{name = "Crustacea Gigantica", chance = 50, tries = 30, level = 45 },	
	{name = "Renegade Quara Pincher", chance = 310, tries = 10, level = 45 },
	{name = "Sea Serpent", chance = 610, tries = 10, level = 45 },
	{name = "Deepling Guard", chance = 360, tries = 10, level = 45 },	
	{name = "Seacrest Serpent", chance = 280, tries = 14, level = 50 },
	{name = "Renegade Quara Predator", chance = 310, tries = 14, level = 50 },
	{name = "Deepling Elite", chance = 360, tries = 14, level = 50 },
	{name = "Serpent Spawn", chance = 270, tries = 14, level = 50 },
	{name = "Foam Stalker", chance = 280, tries = 14, level = 50 },
	{name = "Two-Headed Turtle", chance = 280, tries = 14, level = 50 },
	{name = "Thul", chance = 16, tries = 40, level = 50 },
	{name = "Deepling Tyrant", chance = 360, tries = 16, level = 60 },	
	{name = "Leviathan", chance = 16, tries = 80, level = 60 },
	{name = "The Noxious Spawn", chance = 16, tries = 80, level = 60 },
	{name = "Rogue Naga", chance = 270, tries = 16, level = 60 },
	{name = "Corrupt Naga", chance = 250, tries = 16, level = 60 },
	{name = "Naga Archer", chance = 250, tries = 18, level = 65 },
	{name = "Naga Warrior", chance = 290, tries = 18, level = 65 },
	{name = "Deathling Spellsinger", chance = 280, tries = 20, level = 70 },
	{name = "Deathling Scout", chance = 280, tries = 20, level = 70 },
	{name = "Tanjis", chance = 16, tries = 165, level = 75 },
	{name = "Obujos", chance = 14, tries = 155, level = 75 },
	{name = "Jaul", chance = 13, tries = 190, level = 80 },
	{name = "Brokul", chance = 15, tries = 170, level = 80 },
	{name = "Squid Warden", chance = 250, tries = 35, level = 90 },
	{name = "Brain Squid", chance = 210, tries = 35, level = 90 },
	{name = "Rage Squid", chance = 230, tries = 35, level = 90 },
	{name = "Timira the Many-Headed", chance = 7, tries = 250, level = 95 },
	{name = "Bony Sea Devil", chance = 150, tries = 50, level = 100 },
	{name = "Turbulent Elemental", chance = 150, tries = 50, level = 100 },
}

local useWorms = true

local function refreeIceHole(position)
	local iceHole = Tile(position):getItemById(7237)
	if iceHole then
		iceHole:transform(7200)
	end
end

local fishing = Action()

function fishing.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if not table.contains(waterIds, target.itemid) then
		return false
	end
	
local inPz = player:getTile():hasFlag(TILESTATE_PROTECTIONZONE)
local inFight = player:isPzLocked() or player:getCondition(CONDITION_INFIGHT, CONDITIONID_DEFAULT)
    if inPz then
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You can't fish while you are in a protection zone.")
        return false
    end

	local targetId = target.itemid
	if targetId == 9582 then
		local owner = target:getAttribute(ITEM_ATTRIBUTE_CORPSEOWNER)
		if owner ~= 0 and owner ~= player.uid then
			player:sendTextMessage(MESSAGE_FAILURE, "You are not the owner.")
			return true
		end
	
		toPosition:sendMagicEffect(CONST_ME_WATERSPLASH)
		target:transform(target.itemid + 1)

		local chance = math.random(10000)
		for i = 1, #elementals.chances do
			local randomItem = elementals.chances[i]
			if chance >= randomItem.from and chance <= randomItem.to then
				player:addItem(randomItem.itemId, 1)
			end
			if chance > 1115 then
				player:say("There was just rubbish in it.", TALKTYPE_MONSTER_SAY)
				return true
			end
		end
	end

	if targetId == 12560 then
		toPosition:sendMagicEffect(CONST_ME_WATERSPLASH)
		local rareChance = math.random(100)
		if rareChance == 1 then
			player:addItem(lootVeryRare1[math.random(#lootVeryRare1)], 1)
		elseif rareChance <= 3 then
			player:addItem(lootRare1[math.random(#lootRare1)], 1)
		elseif rareChance <= 10 then
			player:addItem(lootCommon1[math.random(#lootCommon1)], 1)
		else
			player:addItem(lootTrash[math.random(#lootTrash)], 1)
		end
		return true
	end

	if targetId ~= 7236 then
		toPosition:sendMagicEffect(CONST_ME_LOSEENERGY)
	end

	if targetId == 622 or targetId == 13989 then
		return true
	end

	if useWorms and targetId == 21414 and player:removeItem("worm", 1) then
		if player:getStorageValue(Storage.Quest.U10_55.Dawnport.TheDormKey) == 2 then
			if math.random(100) >= 97 then
				player:addItem(21402, 1)
				player:setStorageValue(Storage.Quest.U10_55.Dawnport.TheDormKey, 3)
				player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "With a giant splash, you have an enormous fish out of the water.")
				return true
			end
		elseif math.random(100) <= math.min(math.max(10 + (player:getEffectiveSkillLevel(SKILL_FISHING) - 10) * 0.597, 10), 50) then
			player:addItem(3578, 1)
		end
	end

	if player:getItemCount(3492) > 0 then
		player:addSkillTries(SKILL_FISHING, 1, true)
	end

	if math.random(100) <= math.min(math.max(10 + (player:getEffectiveSkillLevel(SKILL_FISHING) - 10) * 0.597, 10), 50) then
		if useWorms and not player:removeItem("worm", 1) then
			return true
		end

		if targetId == 13988 then
			target:transform(targetId + 1)
			target:decay()

			if math.random(100) >= 97 then
				player:addItem(13992, 1)
				return true
			end
		elseif targetId == 7236 then
			target:transform(7237)
			local position = target:getPosition()
			addEvent(refreeIceHole, 1000 * 60 * 15, position)
			local rareChance = math.random(100)
			if rareChance == 1 then
				player:addItem(7158, 1)
				return true
			elseif rareChance <= 4 then
				player:addItem(3580, 1)
				return true
			elseif rareChance <= 10 then
				player:addItem(7159, 1)
				return true
			end
		end	
	
-- FISHING SYSTEM
local triesMultiplier = 3.0
local fishingLevel = player:getSkillLevel(6) --FISHING LEVEL WITHOUT LOYALTY BONUS
local tryChance = math.random(1, #fishingTry)
local choice = fishingTry[tryChance]
local summonChance = math.random(1,1000) - fishingLevel -- choice.chance turns into 100.0% format
	if fishingLevel >= choice.level then	--DECIDING IF player HAS ENOUGH SKILL TO CATCH
		if summonChance > choice.chance then --DECIDING IF CHOICE HITS A CHANCE OF SUCCESS
			player:say("You thought it was ".. choice.name ..", but it was a Fish...", TALKTYPE_MONSTER_SAY)
			Game.createMonster("Fish", player:getPosition(), 1)
			player:addSkillTries(SKILL_FISHING, 2 * triesMultiplier)
			player:getPosition():sendMagicEffect(175)
		else
			Game.createMonster(choice.name, player:getPosition(), 1)
			player:addSkillTries(SKILL_FISHING, choice.tries * triesMultiplier)
			player:say("Fishing LV.".. fishingLevel ..": You catched a ".. choice.name .."!", TALKTYPE_MONSTER_SAY)
			player:addExperience(choice.tries * 5000)
			player:getPosition():sendMagicEffect(34)
		end
	else
		player:say("You need level ".. choice.level.." to fish ".. choice.name .."...", TALKTYPE_MONSTER_SAY)
		player:addItem(3123,1)
		player:addItem(3492,2)
		player:addSkillTries(SKILL_FISHING, 1 * triesMultiplier)
		player:getPosition():sendMagicEffect(54)
	end
end
	return true
end

fishing:id(3483)
fishing:allowFarUse(true)
fishing:register()
