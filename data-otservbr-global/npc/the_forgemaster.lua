local internalNpcName = "The Forgemaster"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookType = 160, -- Dwarven / Blacksmith look
	lookHead = 0,
	lookBody = 114,
	lookLegs = 94,
	lookFeet = 0,
	lookAddons = 0,
}

npcConfig.flags = {
	floorchange = false,
}

npcConfig.voices = {
	interval = 15000,
	chance = 40,
	{ text = "The demonic flames of Azzilon and the power of ancient tokens obey my forge!" },
	{ text = "Bring me your Eldritch weapons and platinum tokens to craft Gilded armaments." },
	{ text = "Only the true masters of Rotten Blood can awaken the Grand Sanguine weapons." },
	{ text = "Rending, siphoning, draining... which demonic infusion calls to you?" },
}

local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)

npcType.onThink = function(npc, interval)
	npcHandler:onThink(npc, interval)
end

npcType.onAppear = function(npc, creature)
	npcHandler:onAppear(npc, creature)
end

npcType.onDisappear = function(npc, creature)
	npcHandler:onDisappear(npc, creature)
end

npcType.onMove = function(npc, creature, fromPosition, toPosition)
	npcHandler:onMove(npc, creature, fromPosition, toPosition)
end

npcType.onSay = function(npc, creature, type, message)
	npcHandler:onSay(npc, creature, type, message)
end

npcType.onCloseChannel = function(npc, creature)
	npcHandler:onCloseChannel(npc, creature)
end

-- =========================================================
-- CONSTANTS & DEFINITIONS
-- =========================================================

local ITEM_PLATINUM_TOKEN = 22723

-- 1. INFERNIARCH RECIPES & FAMILIES
local INFERNIARCH_RECIPES = {
	rending = {
		name = "Rending",
		materials = {
			{ id = 49892, count = 1,  name = "Skin of Gralvalon" },
			{ id = 12541, count = 1,  name = "Demonic Finger" },
			{ id = 22728, count = 10, name = "Vexclaw Talon" },
			{ id = 49894, count = 50, name = "Demonic Matter" },
			{ id = 5954,  count = 10, name = "Demon Horn" },
			{ id = 6499,  count = 35, name = "Demonic Essence" },
			{ id = 6558,  count = 35, name = "Flask of Demonic Blood" },
		},
	},
	siphoning = {
		name = "Siphoning",
		materials = {
			{ id = 49891, count = 1,  name = "Skin of Twisterror" },
			{ id = 22730, count = 10, name = "Some Grimeleech Wings" },
			{ id = 49894, count = 50, name = "Demonic Matter" },
			{ id = 6499,  count = 75, name = "Demonic Essence" },
			{ id = 9647,  count = 50, name = "Demonic Skeletal Hand" },
		},
	},
	draining = {
		name = "Draining",
		materials = {
			{ id = 49893, count = 1,  name = "Skin of Malvaroth" },
			{ id = 9663,  count = 10, name = "Piece of Dead Brain" },
			{ id = 49894, count = 50, name = "Demonic Matter" },
			{ id = 6558,  count = 75, name = "Flask of Demonic Blood" },
			{ id = 5526,  count = 50, name = "Demon Dust" },
		},
	},
}

local INFERNIARCH_FAMILIES = {
	bow = {
		name = "inferniarch bow",
		base = 49520,
		rending = 49858,
		draining = 49859,
		siphoning = 49860,
	},
	arbalest = {
		name = "inferniarch arbalest",
		base = 49522,
		rending = 49861,
		draining = 49862,
		siphoning = 49863,
	},
	battleaxe = {
		name = "inferniarch battleaxe",
		base = 49523,
		rending = 49864,
		draining = 49865,
		siphoning = 49866,
	},
	greataxe = {
		name = "inferniarch greataxe",
		base = 49524,
		rending = 49867,
		draining = 49868,
		siphoning = 49869,
	},
	flail = {
		name = "inferniarch flail",
		base = 49525,
		rending = 49870,
		draining = 49871,
		siphoning = 49872,
	},
	warhammer = {
		name = "inferniarch warhammer",
		base = 49526,
		rending = 49873,
		draining = 49874,
		siphoning = 49875,
	},
	blade = {
		name = "inferniarch blade",
		base = 49527,
		rending = 49876,
		draining = 49877,
		siphoning = 49878,
	},
	slayer = {
		name = "inferniarch slayer",
		base = 49528,
		rending = 49879,
		draining = 49880,
		siphoning = 49881,
	},
	wand = {
		name = "inferniarch wand",
		base = 49529,
		rending = 49882,
		draining = 49883,
		siphoning = 49884,
	},
	rod = {
		name = "inferniarch rod",
		base = 49530,
		rending = 49885,
		draining = 49886,
		siphoning = 49887,
	},
	claws = {
		name = "inferniarch claws",
		base = 50183,
		rending = 50184,
		draining = 50185,
		siphoning = 50186,
	},
}

-- 2. GILDED ELDRITCH UPGRADES (Base Eldritch -> Gilded Eldritch via Platinum Tokens)
local GILDED_UPGRADES = {
	["bow"] = {
		name = "gilded eldritch bow",
		baseId = 36664,
		targetId = 36665,
		tokens = 75,
		level = 250,
	},
	["wand"] = {
		name = "gilded eldritch wand",
		baseId = 36668,
		targetId = 36669,
		tokens = 75,
		level = 250,
	},
	["rod"] = {
		name = "gilded eldritch rod",
		baseId = 36674,
		targetId = 36675,
		tokens = 75,
		level = 250,
	},
	["spade"] = {
		name = "gilded eldritch crescent moon spade",
		baseId = 50169,
		targetId = 50170,
		tokens = 75,
		level = 250,
	},
	["claymore"] = {
		name = "gilded eldritch claymore",
		baseId = 36657,
		targetId = 36658,
		tokens = 100,
		level = 270,
	},
	["warmace"] = {
		name = "gilded eldritch warmace",
		baseId = 36659,
		targetId = 36660,
		tokens = 100,
		level = 270,
	},
	["greataxe"] = {
		name = "gilded eldritch greataxe",
		baseId = 36661,
		targetId = 36662,
		tokens = 100,
		level = 270,
	},
}

-- 3. GRAND SANGUINE UPGRADES (Base Sanguine -> Grand Sanguine via Rotten Blood Drops)
local SANGUINE_MATERIALS = {
	{ id = 43895, count = 1,  name = "Bag You Covet" },
	{ id = 43850, count = 25, name = "Dark Obsidian Splinter" },
	{ id = 43852, count = 25, name = "Darklight Basalt Chunk" },
	{ id = 43846, count = 25, name = "Decayed Finger Bone" },
	{ id = 43847, count = 25, name = "Rotten Vermin Ichor" },
	{ id = 43853, count = 25, name = "Darklight Core" },
}

local SANGUINE_UPGRADES = {
	["blade"] = {
		name = "grand sanguine blade",
		baseId = 43864,
		targetId = 43865,
	},
	["cudgel"] = {
		name = "grand sanguine cudgel",
		baseId = 43866,
		targetId = 43867,
	},
	["hatchet"] = {
		name = "grand sanguine hatchet",
		baseId = 43868,
		targetId = 43869,
	},
	["razor"] = {
		name = "grand sanguine razor",
		baseId = 43870,
		targetId = 43871,
	},
	["bludgeon"] = {
		name = "grand sanguine bludgeon",
		baseId = 43872,
		targetId = 43873,
	},
	["battleaxe"] = {
		name = "grand sanguine battleaxe",
		baseId = 43874,
		targetId = 43875,
	},
	["bow"] = {
		name = "grand sanguine bow",
		baseId = 43877,
		targetId = 43878,
	},
	["crossbow"] = {
		name = "grand sanguine crossbow",
		baseId = 43879,
		targetId = 43880,
	},
	["coil"] = {
		name = "grand sanguine coil",
		baseId = 43882,
		targetId = 43883,
	},
	["rod"] = {
		name = "grand sanguine rod",
		baseId = 43885,
		targetId = 43886,
	},
	["claws"] = {
		name = "grand sanguine claws",
		baseId = 50157,
		targetId = 50158,
	},
}

-- Fast reverse lookup tables for player inventory checking
local INFERNIARCH_ITEM_TO_FAMILY = {}
for familyKey, familyData in pairs(INFERNIARCH_FAMILIES) do
	INFERNIARCH_ITEM_TO_FAMILY[familyData.base] = { family = familyKey, variant = "base" }
	INFERNIARCH_ITEM_TO_FAMILY[familyData.rending] = { family = familyKey, variant = "rending" }
	INFERNIARCH_ITEM_TO_FAMILY[familyData.draining] = { family = familyKey, variant = "draining" }
	INFERNIARCH_ITEM_TO_FAMILY[familyData.siphoning] = { family = familyKey, variant = "siphoning" }
end

local GILDED_BASE_TO_KEY = {}
for gKey, gData in pairs(GILDED_UPGRADES) do
	GILDED_BASE_TO_KEY[gData.baseId] = gKey
end

local SANGUINE_BASE_TO_KEY = {}
for sKey, sData in pairs(SANGUINE_UPGRADES) do
	SANGUINE_BASE_TO_KEY[sData.baseId] = sKey
end

local SANGUINE_ORDERED_KEYS = {
	"crossbow",
	"bow",
	"battleaxe",
	"hatchet",
	"bludgeon",
	"cudgel",
	"razor",
	"blade",
	"coil",
	"rod",
	"claws",
}

local GILDED_ORDERED_KEYS = {
	"bow",
	"wand",
	"rod",
	"spade",
	"claymore",
	"warmace",
	"greataxe",
}

-- =========================================================
-- STATE & HELPER FUNCTIONS
-- =========================================================

local pendingTrades = {}

local function resetPlayerState(playerId)
	pendingTrades[playerId] = nil
	npcHandler:setTopic(playerId, 0)
end

local function onReleaseFocus(npc, creature)
	local player = Player(creature)
	if player then
		resetPlayerState(player:getId())
	end
end

-- 1. Helper: Inferniarch weapons in inventory
local function getPlayerInferniarchWeapons(player)
	local found = {}
	for itemId, info in pairs(INFERNIARCH_ITEM_TO_FAMILY) do
		local count = player:getItemCount(itemId)
		if count > 0 then
			table.insert(found, {
				itemId = itemId,
				family = info.family,
				variant = info.variant,
				count = count,
			})
		end
	end
	return found
end

-- 2. Helper: Eldritch weapons in inventory
local function getPlayerEldritchWeapons(player)
	local found = {}
	for baseId, key in pairs(GILDED_BASE_TO_KEY) do
		local count = player:getItemCount(baseId)
		if count > 0 then
			table.insert(found, {
				key = key,
				data = GILDED_UPGRADES[key],
				count = count,
			})
		end
	end
	return found
end

-- 3. Helper: Sanguine weapons in inventory
local function getPlayerSanguineWeapons(player)
	local found = {}
	for baseId, key in pairs(SANGUINE_BASE_TO_KEY) do
		local count = player:getItemCount(baseId)
		if count > 0 then
			table.insert(found, {
				key = key,
				data = SANGUINE_UPGRADES[key],
				count = count,
			})
		end
	end
	return found
end

-- Helper: Missing materials for Inferniarch
local function getMissingInferniarchMaterials(player, recipeKey)
	local recipe = INFERNIARCH_RECIPES[recipeKey]
	if not recipe then return {} end
	local missing = {}
	for _, m in ipairs(recipe.materials) do
		local have = player:getItemCount(m.id)
		if have < m.count then
			table.insert(missing, { name = m.name, have = have, needed = m.count })
		end
	end
	return missing
end

-- Helper: Missing materials for Grand Sanguine
local function getMissingSanguineMaterials(player)
	local missing = {}
	for _, m in ipairs(SANGUINE_MATERIALS) do
		local have = player:getItemCount(m.id)
		if have < m.count then
			table.insert(missing, { name = m.name, have = have, needed = m.count })
		end
	end
	return missing
end

local function formatRecipeDescription(materials)
	local parts = {}
	for _, m in ipairs(materials) do
		table.insert(parts, string.format("%dx %s", m.count, m.name))
	end
	return table.concat(parts, ", ")
end

-- Helper: Process a chosen Gilded Eldritch weapon
local function handleGildedWeaponSelection(npc, creature, player, playerId, key)
	local upgrade = GILDED_UPGRADES[key]
	if not upgrade then
		return false
	end

	local baseName = ItemType(upgrade.baseId):getName()
	local targetName = ItemType(upgrade.targetId):getName()
	local tokensHave = player:getItemCount(ITEM_PLATINUM_TOKEN)

	if player:getItemCount(upgrade.baseId) < 1 then
		npcHandler:say(string.format("To refine into a {%s}, you still require: %s (0/1), Platinum Tokens (%d/%d).", targetName, baseName, tokensHave, upgrade.tokens), npc, creature)
		npcHandler:setTopic(playerId, 20)
		return true
	end

	if tokensHave < upgrade.tokens then
		npcHandler:say(string.format("To refine your {%s} into a {%s}, you require %d platinum tokens, but you currently possess %d.", baseName, targetName, upgrade.tokens, tokensHave), npc, creature)
		npcHandler:setTopic(playerId, 20)
		return true
	end

	pendingTrades[playerId] = {
		type = "gilded",
		sourceItemId = upgrade.baseId,
		targetItemId = upgrade.targetId,
		tokens = upgrade.tokens,
	}
	npcHandler:setTopic(playerId, 10)
	npcHandler:say(string.format("I can refine your {%s} into a magnificent {%s} for %d platinum tokens. Do you wish to proceed? {yes} / {no}", baseName, targetName, upgrade.tokens), npc, creature)
	return true
end

-- Helper: Process a chosen Grand Sanguine weapon
local function handleSanguineWeaponSelection(npc, creature, player, playerId, key)
	local upgrade = SANGUINE_UPGRADES[key]
	if not upgrade then
		return false
	end

	local baseName = ItemType(upgrade.baseId):getName()
	local targetName = ItemType(upgrade.targetId):getName()

	local missing = getMissingSanguineMaterials(player)
	if #missing > 0 then
		local missingList = {}
		for _, m in ipairs(missing) do
			table.insert(missingList, string.format("%s (%d/%d)", m.name, m.have, m.needed))
		end
		npcHandler:say(string.format("To ascend your %s into a %s, you still require: %s.", baseName, targetName, table.concat(missingList, ", ")), npc, creature)
		npcHandler:setTopic(playerId, 30)
		return true
	end

	-- Player has all Rotten Blood materials, check if they have the base weapon
	if player:getItemCount(upgrade.baseId) < 1 then
		npcHandler:say(string.format("You possess all the Rotten Blood relics! However, you must bring me your {%s} (level 600) to ascend it into a {%s}.", baseName, targetName), npc, creature)
		npcHandler:setTopic(playerId, 30)
		return true
	end

	-- Player has both base weapon AND all materials
	pendingTrades[playerId] = {
		type = "sanguine",
		sourceItemId = upgrade.baseId,
		targetItemId = upgrade.targetId,
	}
	npcHandler:setTopic(playerId, 10)
	npcHandler:say(string.format("I can awaken the catastrophic power within your {%s} and forge it into a {%s}! Are you certain you wish to consume your Rotten Blood relics? {yes} / {no}", baseName, targetName), npc, creature)
	return true
end

-- =========================================================
-- DIALOGUE CALLBACK
-- =========================================================

local function creatureSayCallback(npc, creature, msgType, message)
	local player = Player(creature)
	if not player then
		return false
	end

	local playerId = player:getId()
	if not npcHandler:checkInteraction(npc, creature) then
		return false
	end

	local msg = string.lower(message)

	-- ---------------------------------------------------------
	-- 1. HELP / RECIPES / FORGE OVERVIEW
	-- ---------------------------------------------------------
	if MsgContains(msg, "recipe") or MsgContains(msg, "recipes") then
		npcHandler:say({
			"I command three distinct arts of forgecraft:",
			"1. {Inferniarch Infusions}: Imbue your Inferniarch weapons with {rending}, {siphoning}, or {draining} using demonic spoils.",
			"2. {Gilded Eldritch}: Refine level 250-270 Eldritch weapons into their {gilded} forms in exchange for {platinum tokens} (75 or 100 tokens).",
			"3. {Grand Sanguine}: Ascend level 600 Sanguine weapons into supreme {grand sanguine} armaments using 1x {bag you covet} and Rotten Blood essences.",
			"Which discipline do you wish to explore?",
		}, npc, creature)
		return true
	end

	if MsgContains(msg, "forge") or MsgContains(msg, "upgrade") or MsgContains(msg, "transform") then
		npcHandler:say("Which branch of the forge do you wish to work on? I offer {inferniarch} infusions, {gilded} eldritch refinements, or {grand sanguine} ascensions.", npc, creature)
		return true
	end

	-- ---------------------------------------------------------
	-- 2. BRANCH: INFERNIARCH INFUSIONS
	-- ---------------------------------------------------------
	if MsgContains(msg, "inferniarch") or MsgContains(msg, "infuse") or MsgContains(msg, "infusion") then
		npcHandler:say({
			"For Inferniarch weapons, I can forge three distinct demonic infusions:",
			"{Rending}: " .. formatRecipeDescription(INFERNIARCH_RECIPES.rending.materials) .. ".",
			"{Siphoning}: " .. formatRecipeDescription(INFERNIARCH_RECIPES.siphoning.materials) .. ".",
			"{Draining}: " .. formatRecipeDescription(INFERNIARCH_RECIPES.draining.materials) .. ".",
			"Which infusion do you seek to {forge}?",
		}, npc, creature)
		return true
	end

	local selectedInfusion = nil
	if MsgContains(msg, "rending") then
		selectedInfusion = "rending"
	elseif MsgContains(msg, "siphoning") then
		selectedInfusion = "siphoning"
	elseif MsgContains(msg, "draining") then
		selectedInfusion = "draining"
	end

	if selectedInfusion then
		local weapons = getPlayerInferniarchWeapons(player)
		if #weapons == 0 then
			npcHandler:say("You do not possess any Inferniarch weapon to infuse. Bring me one along with the required demonic materials.", npc, creature)
			resetPlayerState(playerId)
			return true
		end

		local upgradable = {}
		for _, w in ipairs(weapons) do
			if w.variant ~= selectedInfusion then
				table.insert(upgradable, w)
			end
		end

		if #upgradable == 0 then
			npcHandler:say("All the Inferniarch weapons in your possession already possess the " .. INFERNIARCH_RECIPES[selectedInfusion].name .. " infusion!", npc, creature)
			resetPlayerState(playerId)
			return true
		end

		if #upgradable == 1 then
			local targetWeapon = upgradable[1]
			local fam = INFERNIARCH_FAMILIES[targetWeapon.family]
			local targetItemId = fam[selectedInfusion]
			local missing = getMissingInferniarchMaterials(player, selectedInfusion)

			if #missing > 0 then
				local missingList = {}
				for _, m in ipairs(missing) do
					table.insert(missingList, string.format("%s (%d/%d)", m.name, m.have, m.needed))
				end
				npcHandler:say(string.format("To infuse your %s with {%s}, you still require: %s.", ItemType(targetWeapon.itemId):getName(), INFERNIARCH_RECIPES[selectedInfusion].name, table.concat(missingList, ", ")), npc, creature)
				resetPlayerState(playerId)
				return true
			end

			pendingTrades[playerId] = {
				type = "inferniarch",
				recipe = selectedInfusion,
				sourceItemId = targetWeapon.itemId,
				targetItemId = targetItemId,
			}
			npcHandler:setTopic(playerId, 10)
			npcHandler:say(string.format("I can infuse your {%s} into a {%s} using your demonic materials. Are you sure you wish to proceed? {yes} / {no}", ItemType(targetWeapon.itemId):getName(), ItemType(targetItemId):getName()), npc, creature)
			return true
		end

		pendingTrades[playerId] = {
			type = "inferniarch",
			recipe = selectedInfusion,
			eligible = upgradable,
		}
		npcHandler:setTopic(playerId, 5)
		local choices = {}
		for _, w in ipairs(upgradable) do
			table.insert(choices, "{" .. w.family .. "}")
		end
		npcHandler:say("You carry more than one Inferniarch weapon. Which one would you like to infuse: " .. table.concat(choices, ", ") .. "?", npc, creature)
		return true
	end

	-- Inferniarch weapon selection when carrying multiple
	if npcHandler:getTopic(playerId) == 5 and pendingTrades[playerId] and pendingTrades[playerId].type == "inferniarch" then
		local trade = pendingTrades[playerId]
		local chosenWeapon = nil
		for _, w in ipairs(trade.eligible) do
			if MsgContains(msg, w.family) then
				chosenWeapon = w
				break
			end
		end

		if not chosenWeapon then
			npcHandler:say("I didn't catch that. Please state which Inferniarch weapon you wish to infuse, or say {cancel}.", npc, creature)
			return true
		end

		local fam = INFERNIARCH_FAMILIES[chosenWeapon.family]
		local targetItemId = fam[trade.recipe]
		local missing = getMissingInferniarchMaterials(player, trade.recipe)

		if #missing > 0 then
			local missingList = {}
			for _, m in ipairs(missing) do
				table.insert(missingList, string.format("%s (%d/%d)", m.name, m.have, m.needed))
			end
			npcHandler:say(string.format("To infuse your %s with {%s}, you still require: %s.", ItemType(chosenWeapon.itemId):getName(), INFERNIARCH_RECIPES[trade.recipe].name, table.concat(missingList, ", ")), npc, creature)
			resetPlayerState(playerId)
			return true
		end

		pendingTrades[playerId] = {
			type = "inferniarch",
			recipe = trade.recipe,
			sourceItemId = chosenWeapon.itemId,
			targetItemId = targetItemId,
		}
		npcHandler:setTopic(playerId, 10)
		npcHandler:say(string.format("I can infuse your {%s} into a {%s} using your materials. Are you sure you wish to proceed? {yes} / {no}", ItemType(chosenWeapon.itemId):getName(), ItemType(targetItemId):getName()), npc, creature)
		return true
	end

	-- ---------------------------------------------------------
	-- 3. BRANCH: GILDED ELDRITCH WEAPONS
	-- ---------------------------------------------------------
	if MsgContains(msg, "gilded") or MsgContains(msg, "eldritch") or MsgContains(msg, "platinum token") or MsgContains(msg, "tokens") then
		for _, key in ipairs(GILDED_ORDERED_KEYS) do
			if MsgContains(msg, key) then
				return handleGildedWeaponSelection(npc, creature, player, playerId, key)
			end
		end

		local eldritchWeapons = getPlayerEldritchWeapons(player)
		local carriedText = ""
		if #eldritchWeapons > 0 then
			local carriedList = {}
			for _, w in ipairs(eldritchWeapons) do
				table.insert(carriedList, "{" .. ItemType(w.data.baseId):getName() .. "}")
			end
			carriedText = "In your inventory, I see: " .. table.concat(carriedList, ", ") .. "."
		else
			carriedText = "You do not currently carry any Eldritch weapon in your inventory."
		end

		npcHandler:say({
			"I can refine any standard Eldritch weapon into its {gilded} counterpart in exchange for {platinum tokens}:",
			"- Level 250 (75 tokens): {eldritch bow}, {eldritch wand}, {eldritch rod}, or {eldritch spade}.",
			"- Level 270 (100 tokens): {eldritch claymore}, {eldritch warmace}, or {eldritch greataxe}.",
			carriedText .. " Which Eldritch weapon would you like to refine?",
		}, npc, creature)
		npcHandler:setTopic(playerId, 20)
		return true
	end

	-- Gilded choice when in topic 20
	if npcHandler:getTopic(playerId) == 20 then
		for _, key in ipairs(GILDED_ORDERED_KEYS) do
			if MsgContains(msg, key) then
				return handleGildedWeaponSelection(npc, creature, player, playerId, key)
			end
		end
		npcHandler:say("I didn't catch that. Please state which Eldritch weapon you wish to refine (e.g. {bow}, {wand}, {claymore}), or say {cancel}.", npc, creature)
		return true
	end

	-- Unique Gilded weapon keywords said anytime
	if MsgContains(msg, "spade") or MsgContains(msg, "claymore") or MsgContains(msg, "warmace") then
		for _, key in ipairs({"claymore", "warmace", "spade"}) do
			if MsgContains(msg, key) then
				return handleGildedWeaponSelection(npc, creature, player, playerId, key)
			end
		end
	end

	-- ---------------------------------------------------------
	-- 4. BRANCH: GRAND SANGUINE ASCENSION
	-- ---------------------------------------------------------
	if MsgContains(msg, "grand sanguine") or MsgContains(msg, "sanguine") or MsgContains(msg, "ascension") or MsgContains(msg, "rotten") or MsgContains(msg, "grand") then
		for _, key in ipairs(SANGUINE_ORDERED_KEYS) do
			if MsgContains(msg, key) then
				return handleSanguineWeaponSelection(npc, creature, player, playerId, key)
			end
		end

		local sanguineWeapons = getPlayerSanguineWeapons(player)
		local carriedText = ""
		if #sanguineWeapons > 0 then
			local carriedList = {}
			for _, w in ipairs(sanguineWeapons) do
				table.insert(carriedList, "{" .. ItemType(w.data.baseId):getName() .. "}")
			end
			carriedText = "In your inventory, I see: " .. table.concat(carriedList, ", ") .. "."
		else
			carriedText = "You do not currently carry any Sanguine weapon in your inventory."
		end

		npcHandler:say({
			"The Grand Sanguine weapons are the pinnacle of devastation. I can ascend all 11 level 600 Sanguine weapons into their {Grand Sanguine} forms:",
			"- Swords: {sanguine blade} (1h) or {sanguine razor} (2h)",
			"- Clubs: {sanguine cudgel} (1h) or {sanguine bludgeon} (2h)",
			"- Axes: {sanguine hatchet} (1h) or {sanguine battleaxe} (2h)",
			"- Distance: {sanguine bow} or {sanguine crossbow}",
			"- Magic: {sanguine coil} (wand) or {sanguine rod}",
			"- Fist: {sanguine claws}",
			carriedText .. " Which weapon would you like to ascend?",
		}, npc, creature)
		npcHandler:setTopic(playerId, 30)
		return true
	end

	-- Sanguine choice when in topic 30
	if npcHandler:getTopic(playerId) == 30 then
		for _, key in ipairs(SANGUINE_ORDERED_KEYS) do
			if MsgContains(msg, key) then
				return handleSanguineWeaponSelection(npc, creature, player, playerId, key)
			end
		end
		npcHandler:say("I didn't catch that. Please state which Sanguine weapon you wish to ascend (e.g. {blade}, {bow}, {claws}), or say {cancel}.", npc, creature)
		return true
	end

	-- Unique Sanguine weapon keywords said anytime
	if MsgContains(msg, "razor") or MsgContains(msg, "bludgeon") or MsgContains(msg, "cudgel") or MsgContains(msg, "coil") then
		for _, key in ipairs({"razor", "bludgeon", "cudgel", "coil"}) do
			if MsgContains(msg, key) then
				return handleSanguineWeaponSelection(npc, creature, player, playerId, key)
			end
		end
	end

	-- ---------------------------------------------------------
	-- 5. CONFIRMATION (YES / NO / CANCEL)
	-- ---------------------------------------------------------
	if npcHandler:getTopic(playerId) == 10 and pendingTrades[playerId] then
		if MsgContains(msg, "yes") then
			local trade = pendingTrades[playerId]

			-- Verify base weapon still in inventory
			if player:getItemCount(trade.sourceItemId) < 1 then
				npcHandler:say("You no longer possess the required base weapon!", npc, creature)
				resetPlayerState(playerId)
				return true
			end

			-- Branch execution
			if trade.type == "inferniarch" then
				local missing = getMissingInferniarchMaterials(player, trade.recipe)
				if #missing > 0 then
					npcHandler:say("You no longer possess all the required demonic materials!", npc, creature)
					resetPlayerState(playerId)
					return true
				end

				for _, mat in ipairs(INFERNIARCH_RECIPES[trade.recipe].materials) do
					player:removeItem(mat.id, mat.count)
				end

				local weaponItem = player:getItemById(trade.sourceItemId, true)
				if weaponItem then
					weaponItem:transform(trade.targetItemId)
				else
					player:removeItem(trade.sourceItemId, 1)
					player:addItem(trade.targetItemId, 1, true)
				end

				npc:getPosition():sendMagicEffect(CONST_ME_FIREWORK_RED)
				player:getPosition():sendMagicEffect(CONST_ME_MAGIC_RED)
				npcHandler:say(string.format("By the fires of Azzilon, it is finished! Behold your newly forged {%s}!", ItemType(trade.targetItemId):getName()), npc, creature)

			elseif trade.type == "gilded" then
				if player:getItemCount(ITEM_PLATINUM_TOKEN) < trade.tokens then
					npcHandler:say("You no longer have enough platinum tokens!", npc, creature)
					resetPlayerState(playerId)
					return true
				end

				player:removeItem(ITEM_PLATINUM_TOKEN, trade.tokens)

				local weaponItem = player:getItemById(trade.sourceItemId, true)
				if weaponItem then
					weaponItem:transform(trade.targetItemId)
				else
					player:removeItem(trade.sourceItemId, 1)
					player:addItem(trade.targetItemId, 1, true)
				end

				npc:getPosition():sendMagicEffect(CONST_ME_FIREWORK_YELLOW)
				player:getPosition():sendMagicEffect(CONST_ME_MAGIC_GREEN)
				npcHandler:say(string.format("The platinum binds seamlessly with the ancient relics! Behold your glorious {%s}!", ItemType(trade.targetItemId):getName()), npc, creature)

			elseif trade.type == "sanguine" then
				local missing = getMissingSanguineMaterials(player)
				if #missing > 0 then
					npcHandler:say("You no longer possess all the required Rotten Blood relics!", npc, creature)
					resetPlayerState(playerId)
					return true
				end

				for _, mat in ipairs(SANGUINE_MATERIALS) do
					player:removeItem(mat.id, mat.count)
				end

				local weaponItem = player:getItemById(trade.sourceItemId, true)
				if weaponItem then
					weaponItem:transform(trade.targetItemId)
				else
					player:removeItem(trade.sourceItemId, 1)
					player:addItem(trade.targetItemId, 1, true)
				end

				npc:getPosition():sendMagicEffect(CONST_ME_FIREWORK_RED)
				player:getPosition():sendMagicEffect(CONST_ME_MORTAREA)
				npcHandler:say(string.format("The darkness of Bakragore shudders in fear! Your {%s} has ascended into perfection!", ItemType(trade.targetItemId):getName()), npc, creature)
			end

			resetPlayerState(playerId)
			return true

		elseif MsgContains(msg, "no") or MsgContains(msg, "cancel") then
			npcHandler:say("As you wish. Return when you are ready to forge greatness.", npc, creature)
			resetPlayerState(playerId)
			return true
		end
	end

	-- Cancel or decline at any topic
	if MsgContains(msg, "cancel") or MsgContains(msg, "no") then
		if npcHandler:getTopic(playerId) > 0 then
			npcHandler:say("As you wish. Return when you are ready to forge greatness.", npc, creature)
			resetPlayerState(playerId)
			return true
		end
	end

	return true
end

npcHandler:setCallback(CALLBACK_SET_INTERACTION, function(npc, creature) return true end)
npcHandler:setCallback(CALLBACK_REMOVE_INTERACTION, onReleaseFocus)
npcHandler:setMessage(MESSAGE_GREET, "Greetings, mortal. I am The Forgemaster. The ancient forge obeys my command. I can forge demonic {inferniarch} infusions, refine {gilded} eldritch weapons, or awaken ultimate {grand sanguine} ascensions. Ask me about the {recipes} or what you wish to {forge}.")
npcHandler:setMessage(MESSAGE_FAREWELL, "May the primordial flames temper your resolve.")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Farewell.")
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

-- Register NPC
npcType:register(npcConfig)
