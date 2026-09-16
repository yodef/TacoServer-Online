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
	{ text = "The demonic flames of Azzilon forge the greatest weapons!" },
	{ text = "Bring me your Inferniarch weapons and demonic spoils to unleash their true power." },
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
-- RECIPES & WEAPONS DEFINITION
-- =========================================================

local RECIPES = {
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

local WEAPON_FAMILIES = {
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
		base = 49530,
		rending = 49879,
		draining = 49880,
		siphoning = 49881,
	},
	wand = {
		name = "inferniarch wand",
		base = 49528,
		rending = 49882,
		draining = 49883,
		siphoning = 49884,
	},
	rod = {
		name = "inferniarch rod",
		base = 49529,
		rending = 49885,
		draining = 49886,
		siphoning = 49887,
	},
	claws = {
		name = "inferniarch claws",
		base = 50250,
		rending = 50251,
		draining = 50252,
		siphoning = 50253,
	},
}

-- Fast lookup map: itemId -> { familyKey = "bow", variant = "base"|"rending"|"draining"|"siphoning" }
local ITEM_LOOKUP = {}
for famKey, famData in pairs(WEAPON_FAMILIES) do
	for variant, itemId in pairs(famData) do
		if variant ~= "name" then
			ITEM_LOOKUP[itemId] = {
				family = famKey,
				variant = variant,
			}
		end
	end
end

-- Helper: Check missing materials
local function getMissingMaterials(player, recipeKey)
	local recipe = RECIPES[recipeKey]
	if not recipe then
		return nil
	end

	local missing = {}
	for _, mat in ipairs(recipe.materials) do
		local have = player:getItemCount(mat.id)
		if have < mat.count then
			table.insert(missing, {
				name = mat.name,
				needed = mat.count,
				have = have,
			})
		end
	end
	return missing
end

-- Helper: Find all Inferniarch weapons carried by player
local function getPlayerInferniarchWeapons(player)
	local found = {}
	for itemId, info in pairs(ITEM_LOOKUP) do
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

-- Temporary session state per player
local pendingTrades = {}

local function resetPlayerState(playerId)
	pendingTrades[playerId] = nil
	npcHandler:setTopic(playerId, 0)
end

local function onReleaseFocus(npc, creature)
	local playerId = creature:getId()
	resetPlayerState(playerId)
end

local function formatRecipeDescription(recipeKey)
	local recipe = RECIPES[recipeKey]
	if not recipe then
		return ""
	end
	local parts = {}
	for _, m in ipairs(recipe.materials) do
		table.insert(parts, string.format("%dx %s", m.count, m.name))
	end
	return table.concat(parts, ", ")
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

	-- 1. INFORMATION / HELP / RECIPES
	if MsgContains(msg, "recipe") or MsgContains(msg, "recipes") then
		npcHandler:say({
			"I can forge three types of demonic infusions for your Inferniarch weapons:",
			"{Rending}: " .. formatRecipeDescription("rending") .. ".",
			"{Siphoning}: " .. formatRecipeDescription("siphoning") .. ".",
			"{Draining}: " .. formatRecipeDescription("draining") .. ".",
			"Which infusion do you seek to {forge}?",
		}, npc, creature)
		return true
	end

	if MsgContains(msg, "forge") or MsgContains(msg, "infuse") or MsgContains(msg, "infusion") or MsgContains(msg, "transform") then
		npcHandler:say("Which demonic infusion would you like to forge? I can grant {rending}, {siphoning}, or {draining}.", npc, creature)
		return true
	end

	-- 2. SELECTION OF INFUSION TYPE
	local selectedRecipe = nil
	if MsgContains(msg, "rending") then
		selectedRecipe = "rending"
	elseif MsgContains(msg, "siphoning") then
		selectedRecipe = "siphoning"
	elseif MsgContains(msg, "draining") then
		selectedRecipe = "draining"
	end

	if selectedRecipe then
		local weapons = getPlayerInferniarchWeapons(player)
		if #weapons == 0 then
			npcHandler:say("You do not possess any Inferniarch weapon to infuse. Bring me one along with the required demonic materials.", npc, creature)
			resetPlayerState(playerId)
			return true
		end

		-- Filter out weapons that already have this variant
		local upgradable = {}
		for _, w in ipairs(weapons) do
			if w.variant ~= selectedRecipe then
				table.insert(upgradable, w)
			end
		end

		if #upgradable == 0 then
			npcHandler:say("All the Inferniarch weapons in your possession already possess the " .. RECIPES[selectedRecipe].name .. " infusion!", npc, creature)
			resetPlayerState(playerId)
			return true
		end

		-- If exactly one eligible weapon is carried
		if #upgradable == 1 then
			local targetWeapon = upgradable[1]
			local fam = WEAPON_FAMILIES[targetWeapon.family]
			local targetItemId = fam[selectedRecipe]
			local missing = getMissingMaterials(player, selectedRecipe)

			if #missing > 0 then
				local missingList = {}
				for _, m in ipairs(missing) do
					table.insert(missingList, string.format("%s (%d/%d)", m.name, m.have, m.needed))
				end
				npcHandler:say(string.format("To infuse your %s with {%s}, you still require: %s.", ItemType(targetWeapon.itemId):getName(), RECIPES[selectedRecipe].name, table.concat(missingList, ", ")), npc, creature)
				resetPlayerState(playerId)
				return true
			end

			-- Player has the materials and 1 weapon: ask confirmation
			pendingTrades[playerId] = {
				recipe = selectedRecipe,
				sourceItemId = targetWeapon.itemId,
				targetItemId = targetItemId,
				family = targetWeapon.family,
			}
			npcHandler:setTopic(playerId, 10)
			npcHandler:say(string.format("I can infuse your {%s} into a {%s} using your materials. Are you sure you wish to proceed? {yes} / {no}", ItemType(targetWeapon.itemId):getName(), ItemType(targetItemId):getName()), npc, creature)
			return true
		end

		-- If player has multiple different eligible weapons
		pendingTrades[playerId] = {
			recipe = selectedRecipe,
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

	-- 3. SPECIFIC WEAPON SELECTION (When carrying multiple)
	if npcHandler:getTopic(playerId) == 5 and pendingTrades[playerId] and pendingTrades[playerId].eligible then
		local trade = pendingTrades[playerId]
		local chosenWeapon = nil
		for _, w in ipairs(trade.eligible) do
			if MsgContains(msg, w.family) then
				chosenWeapon = w
				break
			end
		end

		if not chosenWeapon then
			npcHandler:say("I didn't catch that. Please state which weapon you wish to infuse, or say {cancel}.", npc, creature)
			return true
		end

		local fam = WEAPON_FAMILIES[chosenWeapon.family]
		local targetItemId = fam[trade.recipe]
		local missing = getMissingMaterials(player, trade.recipe)

		if #missing > 0 then
			local missingList = {}
			for _, m in ipairs(missing) do
				table.insert(missingList, string.format("%s (%d/%d)", m.name, m.have, m.needed))
			end
			npcHandler:say(string.format("To infuse your %s with {%s}, you still require: %s.", ItemType(chosenWeapon.itemId):getName(), RECIPES[trade.recipe].name, table.concat(missingList, ", ")), npc, creature)
			resetPlayerState(playerId)
			return true
		end

		pendingTrades[playerId] = {
			recipe = trade.recipe,
			sourceItemId = chosenWeapon.itemId,
			targetItemId = targetItemId,
			family = chosenWeapon.family,
		}
		npcHandler:setTopic(playerId, 10)
		npcHandler:say(string.format("I can infuse your {%s} into a {%s} using your materials. Are you sure you wish to proceed? {yes} / {no}", ItemType(chosenWeapon.itemId):getName(), ItemType(targetItemId):getName()), npc, creature)
		return true
	end

	-- 4. CONFIRMATION (YES / NO)
	if npcHandler:getTopic(playerId) == 10 and pendingTrades[playerId] then
		if MsgContains(msg, "yes") then
			local trade = pendingTrades[playerId]
			local recipe = RECIPES[trade.recipe]

			-- Final check of weapon and materials
			if player:getItemCount(trade.sourceItemId) < 1 then
				npcHandler:say("You no longer have the required weapon with you!", npc, creature)
				resetPlayerState(playerId)
				return true
			end

			local missing = getMissingMaterials(player, trade.recipe)
			if #missing > 0 then
				npcHandler:say("You no longer have all the required demonic materials!", npc, creature)
				resetPlayerState(playerId)
				return true
			end

			-- Deduct materials
			for _, mat in ipairs(recipe.materials) do
				player:removeItem(mat.id, mat.count)
			end

			-- Transform weapon (retaining tier, attributes, socketing if possible)
			local weaponItem = player:getItemById(trade.sourceItemId, true)
			if weaponItem then
				weaponItem:transform(trade.targetItemId)
			else
				player:removeItem(trade.sourceItemId, 1)
				player:addItem(trade.targetItemId, 1, true)
			end

			-- Visual & audio effect
			npc:getPosition():sendMagicEffect(CONST_ME_FIREWORK_RED)
			player:getPosition():sendMagicEffect(CONST_ME_MAGIC_RED)

			npcHandler:say(string.format("By the fires of Azzilon, it is finished! Behold your newly forged {%s}!", ItemType(trade.targetItemId):getName()), npc, creature)
			resetPlayerState(playerId)
			return true
		elseif MsgContains(msg, "no") or MsgContains(msg, "cancel") then
			npcHandler:say("As you wish. Return when you are ready to forge greatness.", npc, creature)
			resetPlayerState(playerId)
			return true
		end
	end

	return true
end

npcHandler:setCallback(CALLBACK_SET_INTERACTION, function(npc, creature) return true end)
npcHandler:setCallback(CALLBACK_REMOVE_INTERACTION, onReleaseFocus)
npcHandler:setMessage(MESSAGE_GREET, "Greetings, mortal. I am |NAME|. The ancient forge obeys my command. I can imbue your Inferniarch weapons with {rending}, {siphoning}, or {draining} infusions. Ask me about the {recipes} or what you wish to {forge}.")
npcHandler:setMessage(MESSAGE_FAREWELL, "May the infernal flames temper your resolve.")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Farewell.")
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

-- Register NPC
npcType:register(npcConfig)
