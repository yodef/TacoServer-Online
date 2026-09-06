local internalNpcName = "Cledwyn"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 150
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookType = 128,
	lookHead = 114,
	lookBody = 0,
	lookLegs = 76,
	lookFeet = 94,
	lookAddons = 3,
}

npcConfig.flags = {
	floorchange = false,
}

npcConfig.currency = 22516

npcConfig.shop = {
	{ itemName = "magic shield potion", clientId = 35563, buy = 1 },
	{ itemName = "zaoan helmet", clientId = 10385, buy = 8 },
	{ itemName = "glooth cape", clientId = 21164, buy = 1 },
	{ itemName = "gold token", clientId = 22721, buy = 10 },
	{ itemName = "mpa", clientId = 3366, buy = 11 },
	{ itemName = "witchhunter's coat", clientId = 7993, buy = 3 },
	{ itemName = "voltage armor", clientId = 8051, buy = 5 },
	{ itemName = "swamplair armor", clientId = 8052, buy = 5 },
	{ itemName = "lavos armor", clientId = 8049, buy = 8 },
	{ itemName = "crystalline armor", clientId = 8050, buy = 5 },
	{ itemName = "swan feather cloak", clientId = 25779, buy = 10 },
	{ itemName = "Zaoan robe", clientId = 10439, buy = 4 },
	{ itemName = "spellweaver's robe", clientId = 10438, buy = 4 },
	{ itemName = "dark lord's cape", clientId = 8037, buy = 100  },
	{ itemName = "molten plate", clientId = 8058, buy = 100 },
	{ itemName = "frozen plate", clientId = 8059, buy = 12 },
	{ itemName = "divine plate", clientId = 8057, buy = 12 },
	{ itemName = "velvet mantle", clientId = 8040, buy = 12 },
	{ itemName = "robe of the ice queen", clientId = 8038, buy = 100 },
	{ itemName = "greenwood coat", clientId = 8041, buy = 12 },
	{ itemName = "dragon robe", clientId = 8039, buy = 12 },
	{ itemName = "yalahari armor", clientId = 8862, buy = 15 },
	{ itemName = "calopteryx cape", clientId = 14086, buy = 8 },
	{ itemName = "skullcracker armor", clientId = 8061, buy = 8 },
	{ itemName = "royal draken mail", clientId = 11686, buy = 50 },
	{ itemName = "windborn colossus armor", clientId = 8055, buy = 20 },
	{ itemName = "oceanborn leviathan armor", clientId = 8056, buy = 100 },
	{ itemName = "demon armor", clientId = 3388, buy = 50 },
	{ itemName = "master archer's armor", clientId = 8060, buy = 50 },
	{ itemName = "fireborn giant armor", clientId = 8053, buy = 20 },
	{ itemName = "elite draken mail", clientId = 11651, buy = 20 },
	{ itemName = "earthborn titan armor", clientId = 8054, buy = 100 },
	{ itemName = "royal scale robe", clientId = 11687, buy = 50 },
	{ itemName = "robe of the underworld", clientId = 8062, buy = 20 },
	{ itemName = "dream shroud", clientId = 29423, buy = 60 },
	{ itemName = "living armor", clientId = 29418, buy = 30 },
	{ itemName = "depth lorica", clientId = 13994, buy = 40 },
	{ itemName = "gill coat", clientId = 16105, buy = 20 },
	{ itemName = "furious frock", clientId = 19391, buy = 100 },
	{ itemName = "prismatic armor", clientId = 16110, buy = 20 },
	{ itemName = "batwing hat", clientId = 9103, buy = 4 },
	{ itemName = "jade hat", clientId = 10451, buy = 6 },
	{ itemName = "rubber cap", clientId = 21165, buy = 5 },
	{ itemName = "yalahari mask", clientId = 8864, buy = 15 },
	{ itemName = "crest of the deep seas", clientId = 21892, buy = 10 },
	{ itemName = "tiara of power", clientId = 23474, buy = 1 },
	{ itemName = "elite draken helmet", clientId = 11689, buy = 50 },
	{ itemName = "dragon scale helmet", clientId = 3400, buy = 30 },
	{ itemName = "prismatic helmet", clientId = 16109, buy = 20 },
	{ itemName = "gill gugel", clientId = 16104, buy = 20 },
	{ itemName = "depth galea", clientId = 13995, buy = 70 },
	{ itemName = "dark whispers", clientId = 29427, buy = 80 },
	{ itemName = "alloy legs", clientId = 21168, buy = 1 },
	{ itemName = "grasshopper legs", clientId = 14087, buy = 5 },
	{ itemName = "yalahari leg piece", clientId = 8863, buy = 15 },
	{ itemName = "exotic legs", clientId = 35516, buy = 100 },
	{ itemName = "depth ocrea", clientId = 13996, buy = 70},
	{ itemName = "prismatic legs", clientId = 16111, buy = 20 },
	{ itemName = "gill legs", clientId = 16106, buy = 20 },
	{ itemName = "bast legs", clientId = 35517, buy = 100 },
	{ itemName = "dwarven legs", clientId = 3398, buy = 20 },
	{ itemName = "soulful legs", clientId = 32618, buy = 100 },
	{ itemName = "ornate legs", clientId = 13999, buy = 80 },
	{ itemName = "badger boots", clientId = 22086, buy = 1 },
	{ itemName = "guardian boots", clientId = 10323, buy = 15 },
	{ itemName = "dragon scale boots", clientId = 10201, buy = 50 },
	{ itemName = "crystal boots", clientId = 10200, buy = 50 },
	{ itemName = "oriental shoes", clientId = 21981, buy = 1 },
	{ itemName = "draken boots", clientId = 4033, buy = 7 },
	{ itemName = "firewalker boots", clientId = 9019, buy = 15 },
	{ itemName = "pair of nightmare boots", clientId = 32619, buy = 100 },
	{ itemName = "void boots", clientId = 23477, buy = 1 },
	{ itemName = "pair of soft boots", clientId = 6529, buy = 80 },
	{ itemName = "prismatic boots", clientId = 16112, buy = 20 },
	{ itemName = "makeshift boots", clientId = 35519, buy = 150 },
	{ itemName = "make-do boots", clientId = 35520, buy = 150 },
	{ itemName = "pair of dreamwalkers", clientId = 29424, buy = 200 },
	{ itemName = "depth calcei", clientId = 13997, buy = 70 },
	{ itemName = "steel boots", clientId = 3554, buy = 3},
	--meleewpns	
	{ itemName = "impaler of the igniter", clientId = 22760, buy = 200 },
	{ itemName = "plague bite", clientId = 22759, buy = 200 },
	{ itemName = "maimer", clientId = 22762, buy = 200 },
	{ itemName = "throwing axe", clientId = 35515, buy = 100 },
	{ itemName = "jungle flail", clientId = 35514, buy = 100 },
	{ itemName = "shiny blade", clientId = 16175, buy = 40 },
	{ itemName = "mycological mace", clientId = 16162, buy = 40 },
	{ itemName = "dark trinity mace", clientId = 8099, buy = 300 },
	{ itemName = "crystalline axe", clientId = 16161, buy = 40 },
	{ itemName = "umbral blade", clientId = 20065, buy = 220 },
	{ itemName = "crude umbral blade", clientId = 20064, buy = 25 },
	{ itemName = "umbral mace", clientId = 20076, buy = 220 },
	{ itemName = "crude umbral mace", clientId = 20077, buy = 25 },
	{ itemName = "crude umbral axe", clientId = 20070, buy = 25 },	
	{ itemName = "umbral axe", clientId = 20071, buy = 220 },
	{ itemName = "emerald sword", clientId = 8102, buy = 90 },
	{ itemName = "obsidian truncheon", clientId = 8100, buy = 50 },
	{ itemName = "ornate mace", clientId = 14001, buy = 20 },
	{ itemName = "hellforged axe", clientId = 8096, buy = 90 },
	{ itemName = "impaler", clientId = 7435, buy = 60 },
	{ itemName = "mythril axe", clientId = 7455, buy = 300 },
	{ itemName = "royal axe", clientId = 7434, buy = 10 },
	{ itemName = "ravenwing", clientId = 7433, buy = 100 },
	{ itemName = "hive scythe", clientId = 14089, buy = 8 },
	{ itemName = "blade of corruption", clientId = 11693, buy = 50 },
	{ itemName = "magic sword", clientId = 3288, buy = 30 },
	{ itemName = "stonecutter axe", clientId = 3319, buy = 30 },
	{ itemName = "demonbone", clientId = 7431, buy = 30 },
	{ itemName = "thunder hammer", clientId = 3309, buy = 300 },
	{ itemName = "the justice seeker", clientId = 7390, buy = 15 },
	{ itemName = "nightmare blade", clientId = 7418, buy = 6 },
	{ itemName = "runed sword", clientId = 7417, buy = 10 },
	{itemName = "crystalline sword", clientId = 16160, buy = 8 },
	{ itemName = "mystic blade", clientId = 7384, buy =  5 },
	{ itemName = "heroic axe", clientId = 7389, buy =  5 },
	{ itemName = "jade hammer", clientId = 7422, buy =  5 },
	{ itemName = "onyx flail", clientId = 7421, buy =  4 },
	{ itemName = "metal bat", clientId = 21171, buy = 21 },
	{ itemName = "northern star", clientId = 7409, buy =  1 },
	{ itemName = "bloody edge", clientId = 7416, buy = 3 },
	{ itemName = "vile axe", clientId = 7388, buy = 3 },
	{ itemName = "relic sword", clientId = 7383, buy = 2 },
	{ itemName = "ornamented axe", clientId = 7411, buy = 2 },	
	--2handed
	{ itemName = "bonebreaker", clientId = 7428, buy = 2 },
	{ itemName = "abyss hammer", clientId = 7414, buy = 4 },
	{ itemName = "hammer of wrath", clientId = 3332, buy = 7 },
	{ itemName = "arcane staff", clientId = 3341, buy = 9 },
	{ itemName = "heavy mace", clientId = 3340, buy = 11 },
	{ itemName = "crude umbral hammer", clientId = 7423, buy = 25 },
	{ itemName = "executioner", clientId = 7453, buy = 10 },
	{ itemName = "ruthless axe", clientId = 6553, buy = 5 },
	{ itemName = "ravager's axe", clientId = 3331, buy = 30 },
	{ itemName = "war axe", clientId = 3342, buy = 2 },
	{ itemName = "dragon lance", clientId = 3302, buy = 3 },
	{ itemName = "guardian halberd", clientId = 3315, buy = 1 },
	{ itemName = "guardian axe", clientId = 14043, buy = 1 },
	{ itemName = "sai", clientId = 10389, buy = 21 },
	{ itemName = "giant sword", clientId = 3281, buy = 21 },
	{ itemName = "twiceslicer", clientId = 11657, buy = 52 },
	{ itemName = "demonrage sword", clientId = 7382, buy = 10 },
	{ itemName = "berserker", clientId = 7403, buy = 9 },
	{ itemName = "havoc blade", clientId = 7405, buy = 30 },
	{ itemName = "the avenger", clientId = 6527, buy = 9 },
	{ itemName = "crude umbral slayer", clientId = 20067, buy = 25 },
	{ itemName = "umbral slayer", clientId = 20068, buy = 220 },
	{ itemName = "crude umbral chopper", clientId = 20073, buy = 25 },
	{ itemName = "umbral chopper", clientId = 20074, buy = 220 },
	{ itemName = "crude umbral hammer", clientId = 20079, buy = 25 },
	{ itemName = "umbral hammer", clientId = 20080, buy = 220 },
	{ itemName = "the calamity", clientId = 8104, buy = 50 },
	{ itemName = "the stomper", clientId = 8101, buy = 50 },
	{ itemName = "demonwing axe", clientId = 8098, buy = 300 },
	{ itemName = "magic longsword", clientId = 3278, buy = 300 },
	{ itemName = "phantasmal axe", clientId = 32616, buy = 400 },
	--shields
	{ itemName = "shield of corruption", clientId = 11688, buy = 100 },
	{ itemName = "rainbow shield", clientId = 8077, buy = 250 },
	{ itemName = "depth scutum", clientId = 13998, buy = 20 },
	{ itemName = "ornate shield", clientId = 14000, buy = 150 },
	{ itemName = "prismatic shield", clientId = 16116, buy = 20 },
	{ itemName = "ectoplasmic shield", clientId = 29430, buy = 200 },
	--Magic
	{ itemName = "spellscroll of prophecies", clientId = 8076, buy = 20 },
	{ itemName = "wooden spellbook", clientId = 25699, buy = 2 },
	{ itemName = "wand of everblazing", clientId = 16115, buy = 3 },
	{ itemName = "wand of defiance", clientId = 16096, buy = 3 },
	{ itemName = "glacial rod", clientId = 16118, buy = 3 },
	{ itemName = "muck rod", clientId = 16117, buy = 3 },
	{ itemName = "dream blossom staff", clientId = 25700, buy = 1 },
	{ itemName = "jungle wand", clientId = 35522, buy = 280 },
	{ itemName = "jungle rod", clientId = 35521, buy = 300 },
	{ itemName = "spellbook of dark mysteries", clientId = 8090, buy = 50 },
	{ itemName = "snake god wristguard", clientId = 11691, buy = 45 },
	{ itemName = "umbral spellbook", clientId = 20089, buy = 220 },
	{ itemName = "spellbook of ancient arcana", clientId = 14769, buy = 500 },
	{ itemName = "book of lies", clientId = 22755, buy = 120 },
	{ itemName = "spirit guide", clientId = 29431, buy = 200 },
	{ itemName = "shoulder plate", clientId = 29420, buy = 400 },
	{ itemName = "energized limb", clientId = 29425, buy = 180 },
	{ itemName = "deepling ceremonial dagger", clientId = 28825, buy = 200 },
	{ itemName = "brain in a jar", clientId = 29426, buy = 150 },
	{ itemName = "crude umbral spellbook", clientId = 20088, buy = 25 },
	{ itemName = "spellbook of vigilance", clientId = 16107, buy = 20 },	
	--distance
	{ itemName = "thorn spitter", clientId = 14768, buy = 600 },
	{ itemName = "jungle bow", clientId = 35518, buy = 300 },
	{ itemName = "the devileye", clientId = 8024, buy = 500 },
	{ itemName = "crude umbral bow", clientId = 20082, buy = 25 },
	{ itemName = "arbalest", clientId = 5803, buy = 10 },
	{ itemName = "crystal crossbow", clientId = 16163, buy = 7 },
	{ itemName = "the ironworker", clientId = 8025, buy = 20 },
	{ itemName = "umbral bow", clientId = 20083, buy = 220 },
	{ itemName = "crude umbral crossbow", clientId = 20085, buy = 25 },
	{ itemName = "umbral crossbow", clientId = 20086, buy = 220 },
	{ itemName = "composite hornbow", clientId = 8027, buy = 5 },
	{ itemName = "Yol's bow", clientId = 8028, buy = 300 },
	{ itemName = "hive bow", clientId = 14246, buy = 7 },
	{ itemName = "warsinger bow", clientId = 8026, buy = 80 },
	{ itemName = "rift crossbow", clientId = 22867, buy = 60 },
	{ itemName = "royal crossbow", clientId = 8023, buy = 150 },
	{ itemName = "rift bow", clientId = 22866, buy = 40 },
	{ itemName = "mycological bow", clientId = 16164, buy = 9 },
	{ itemName = "chain bolter", clientId = 8022, buy = 300 },
	{ itemName = "triple bolt crossbow", clientId = 19356, buy = 300 },
	{ itemName = "ornate crossbow", clientId = 14247, buy = 2 },
	--amulets/rings/Accessories
	{ itemName = "enchanted pendulet", clientId = 30344, buy = 180 },
	{ itemName = "enchanted sleep shawl", clientId = 30342, buy = 220 },
	{ itemName = "exotic amulet", clientId = 35523, buy = 200 },
	{ itemName = "collar of blue plasma", clientId = 23526, buy = 5 },
	{ itemName = "collar of red plasma", clientId = 23528, buy = 5 },
	{ itemName = "collar of green plasma", clientId = 23527, buy = 5 },
	{ itemName = "ring of blue plasma", clientId = 23529, buy = 2 },
	{ itemName = "collar of orange plasma", clientId = 50153, buy = 5 },
	{ itemName = "ring of orange plasma", clientId = 50151, buy = 2 },
	{ itemName = "ring of red plasma", clientId = 23533, buy = 2 },
	{ itemName = "ring of green plasma", clientId = 23531, buy = 2 },
	{ itemName = "gill necklace", clientId = 16108, buy = 2 },
	{ itemName = "prismatic necklace", clientId = 16113, buy = 4 },
	{ itemName = "shrunken head necklace", clientId = 19357, buy = 100 },
	{ itemName = "foxtail amulet", clientId = 27565, buy = 210 },
	{ itemName = "koshei's ancient amulet", clientId = 7532, buy = 9 },
	{ itemName = "enchanted werewolf amulet", clientId = 22061, buy = 1 },
	{ itemName = "prismatic ring", clientId = 16114, buy = 12 },
	{ itemName = "sun catcher", clientId = 25977, buy = 15 },
	{ itemName = "jungle quiver", clientId = 35524, buy = 100 },
	{ itemName = "ring of temptation", clientId = 45642, buy = 5 },
	{ itemName = "scarab ocarina", clientId = 43740, buy = 15 }
}

-- On buy npc shop message
npcType.onBuyItem = function(npc, player, itemId, subType, amount, ignore, inBackpacks, totalCost)
	npc:sellItem(player, itemId, amount, subType, 0, ignore, inBackpacks)
end
-- On sell npc shop message
npcType.onSellItem = function(npc, player, itemId, subtype, amount, ignore, name, totalCost)
	player:sendTextMessage(MESSAGE_TRADE, string.format("Sold %ix %s for %i gold.", amount, name, totalCost))
end
-- On check npc shop message (look item)
npcType.onCheckItem = function(npc, player, clientId, subType) end

npcConfig.voices = {
	interval = 15000,
	chance = 50,
	{ text = "Trading tokens! First-class bargains!" },
	{ text = "Bespoke armor for all vocations! For the cost of some tokens only!" },
	{ text = "Tokens! Bring your tokens!" },
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

local charge = {}

local chargePrice = {}

local chargeItem = {
	["pendulet"] = { noChargeID = 29429, ChargeID = 30344 },
	["sleep shawl"] = { noChargeID = 29428, ChargeID = 30342 },
	["blister ring"] = { noChargeID = 31621, ChargeID = 31557 },
	["theurgic amulet"] = { noChargeID = 30401, ChargeID = 30403 },
	["ring of souls"] = { noChargeID = 32636, ChargeID = 32621 },
	["spiritthorn ring"] = { noChargeID = 39179, ChargeID = 39177 },
	["alicorn ring"] = { noChargeID = 39182, ChargeID = 39180 },
	["arcanomancer sigil"] = { noChargeID = 39185, ChargeID = 39183 },
	["arboreal ring"] = { noChargeID = 39188, ChargeID = 39187 },
	["turtle amulet"] = { noChargeID = 39235, ChargeID = 39233 },
}

local function creatureSayCallback(npc, creature, type, message)
	local player = Player(creature)
	local playerId = player:getId()

	if not npcHandler:checkInteraction(npc, creature) then
		return false
	end

	if not player or not playerId then
		return false
	end

	if MsgContains(message, "token") or MsgContains(message, "tokens") then
		npcHandler:say("If you have any {silver} tokens with you, let's have a look! Maybe I can offer you something in exchange.", npc, creature)
	elseif MsgContains(message, "information") then
		npcHandler:say("With pleasure. <bows> I trade {token}s. There are several ways to obtain the {token}s I am interested in - killing certain bosses, for example. In exchange for a certain amount of tokens, I can offer you some first-class items.", npc, creature)
	elseif MsgContains(message, "talk") then
		npcHandler:say({ "Why, certainly! I'm always up for some small talk. ...", "The weather continues just fine here, don't you think? Just the day for a little walk around the town! ...", "Actually, I haven't been around much yet, but I'm looking forward to exploring the city once I've finished trading {token}s." }, npc, creature)
	elseif MsgContains(message, "silver") then
		npc:openShopWindow(creature)
		npcHandler:say({ "Here's the deal, " .. player:getName() .. "... I trade tokens for items for up to level 200. " }, npc, creature)
	elseif MsgContains(message, "enchant") then
		npcHandler:say({ "The following items can be enchanted: {pendulet}, {sleep shawl}, {blister ring}, {theurgic amulet}, {ring of souls}. ...", "For sufficient silver tokens you can also enchant: {spiritthorn ring}, {alicorn ring}, {arcanomancer sigil}, {arboreal ring}, {turtle amulet}. Make you choice! Remember you can also use {!refill} command to enchant your items during hunts." }, npc, creature)
		npcHandler:setTopic(playerId, 1)
	elseif table.contains({ "pendulet", "sleep shawl", "blister ring", "theurgic amulet", "ring of souls", "turtle amulet" }, message:lower()) and npcHandler:getTopic(playerId) == 1 then
		npcHandler:say("Should I enchant the item " .. message .. " for 2 " .. ItemType(npc:getCurrency()):getPluralName():lower() .. "?", npc, creature)
		charge = message:lower()
		chargePrice = 2
		npcHandler:setTopic(playerId, 2)
	elseif table.contains({ "spiritthorn ring", "alicorn ring", "arcanomancer sigil", "arboreal ring" }, message:lower()) and npcHandler:getTopic(playerId) == 1 then
		npcHandler:say("Should I enchant the item " .. message .. " for 5 " .. ItemType(npc:getCurrency()):getPluralName():lower() .. "?", npc, creature)
		charge = message:lower()
		chargePrice = 5
		npcHandler:setTopic(playerId, 2)
	elseif npcHandler:getTopic(playerId) == 2 then
		if MsgContains(message, "yes") then
			if not chargeItem[charge] then
				npcHandler:say("Sorry, you don't have an unenchanted " .. charge .. ".", npc, creature)
			else
				if (player:getItemCount(npc:getCurrency()) >= chargePrice) and (player:getItemCount(chargeItem[charge].noChargeID) >= 1) then
					player:removeItem(npc:getCurrency(), chargePrice)
					player:removeItem(chargeItem[charge].noChargeID, 1)
					local itemAdd = player:addItem(chargeItem[charge].ChargeID, 1)
					npcHandler:say("Ah, excellent. Here is your " .. itemAdd:getName():lower() .. ".", npc, creature)
				else
					npcHandler:say("Sorry, friend, but one good turn deserves another. Bring enough " .. ItemType(npc:getCurrency()):getPluralName():lower() .. " and it's a deal.", npc, creature)
				end
				npcHandler:setTopic(playerId, 0)
			end
		elseif MsgContains(message, "no") then
			npcHandler:say("Alright, come back if you have changed your mind.", npc, creature)
			npcHandler:setTopic(playerId, 0)
		end
	elseif MsgContains(message, "addon") then
		if player:hasOutfit(846, 0) or player:hasOutfit(845, 0) then
			npcHandler:say("Ah, very good. Now choose your addon: {first} or {second}.", npc, creature)
			npcHandler:setTopic(playerId, 3)
		else
			npcHandler:say("Sorry, friend, but one good turn deserves another. You need to obtain the rift warrior outfit first.", npc, creature)
		end
	elseif table.contains({ "first", "second" }, message:lower()) and npcHandler:getTopic(playerId) == 3 then
		if message:lower() == "first" then
			if not (player:hasOutfit(846, 1)) and not (player:hasOutfit(845, 1)) then
				if player:removeItem(22516, 100) then
					npcHandler:say("Ah, excellent. Obtain the first addon for your rift warrior outfit.", npc, creature)
					player:addOutfitAddon(846, 1)
					player:addOutfitAddon(845, 1)
					if (player:hasOutfit(846, 1) or player:hasOutfit(845, 1)) and (player:hasOutfit(846, 2) or player:hasOutfit(845, 2)) then
						player:addAchievement("Rift Warrior")
					end
				else
					npcHandler:say("Sorry, friend, but one good turn deserves another. Bring enough " .. ItemType(npc:getCurrency()):getPluralName():lower() .. " and it's a deal.", npc, creature)
				end
			else
				npcHandler:say("Sorry, friend, you already have the first Rift Warrior addon.", npc, creature)
			end
		elseif message:lower() == "second" then
			if not (player:hasOutfit(846, 2)) and not (player:hasOutfit(845, 2)) then
				if player:removeItem(22516, 100) then
					npcHandler:say("Ah, excellent. Obtain the second addon for your rift warrior outfit.", npc, creature)
					player:addOutfitAddon(846, 2)
					player:addOutfitAddon(845, 2)
					if (player:hasOutfit(846, 1) or player:hasOutfit(845, 1)) and (player:hasOutfit(846, 2) or player:hasOutfit(845, 2)) then
						player:addAchievement("Rift Warrior")
					end
				else
					npcHandler:say("Sorry, friend, but one good turn deserves another. Bring enough " .. ItemType(npc:getCurrency()):getPluralName():lower() .. " and it's a deal.", npc, creature)
				end
			else
				npcHandler:say("Sorry, friend, you already have the second Rift Warrior addon.", npc, creature)
			end
		end
		npcHandler:setTopic(playerId, 0)
	end
	return true
end

npcHandler:setMessage(MESSAGE_GREET, "Blessings, Player! How may I be of service? Do you wish to trade some {token}s, or would you like some {information} or {talk}? Should I {enchant} certain items for you?")
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

-- npcType registering the npcConfig table
npcType:register(npcConfig)
