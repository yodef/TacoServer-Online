local internalNpcName = "Yana"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookType = 471,
	lookHead = 0,
	lookBody = 57,
	lookLegs = 0,
	lookFeet = 68,
	lookAddons = 2
}

npcConfig.flags = {
	floorchange = false
}

npcConfig.voices = {
	interval = 15000,
	chance = 30,
	{text = 'Trading Gold tokens! First-class equipment available!'},
	{text = 'Trade equipment under level 400!'}
}

npcConfig.currency = 22721
--items less than LV400
npcConfig.shop = {--gold token price 100k ea
	-- Helmets
	{ itemName = "winged helmet", clientId = 3368, buy = 50 },	
	{ itemName = "werewolf helmet", clientId = 22062, buy = 90 },
	{ itemName = "gnome helmet", clientId = 27647, buy = 120 },
	{ itemName = "dwarven helmet", clientId = 3396, buy = 25 },
	{ itemName = "amazon helmet", clientId = 3393, buy = 200 },
	{ itemName = "galea mortis", clientId = 31582, buy = 50 },
	{ itemName = "terra helmet", clientId = 31577, buy = 50 },
	--{ itemName = "lion spangenhelm", clientId = 34156, buy = 150 },
	--{ itemName = "falcon coif", clientId = 28715, buy = 180 },
	--{ itemName = "falcon circlet", clientId = 28714, buy = 160 },
	--{ itemName = "eldritch hood", clientId = 36671, buy = 150 },
	{ itemName = "antler-horn helmet", clientId = 40588, buy = 150 },
	--{ itemName = "eldritch cowl", clientId = 36670, buy = 150 },
	--{ itemName = "cobra hood", clientId = 30397, buy = 160 },
	-- Armors
	{ itemName = "dwarven armor", clientId = 3397, buy = 50 },
	{ itemName = "amazon armor", clientId = 3394, buy = 200 },
	{ itemName = "mutated skin armor", clientId = 40591, buy = 160 },
	{ itemName = "midnight tunic", clientId = 39165, buy = 100},
	{ itemName = "dawnfire sherwani", clientId = 39164, buy = 100},
	{ itemName = "ornate chestplate", clientId = 13993, buy = 50},
	{ itemName = "gnome armor", clientId = 27648, buy = 80},
	{ itemName = "gnomish cuirass", clientId = 50276, buy = 80},
	--{ itemName = "falcon plate", clientId = 28719, buy = 150 },
	{ itemName = "toga mortis", clientId = 31583, buy = 70},
	{ itemName = "embrace of nature", clientId = 31579, buy = 30},
	{ itemName = "ghost chestplate", clientId = 32628, buy = 50},
	{ itemName = "bear skin", clientId = 31578, buy = 50},
	--{ itemName = "lion plate", clientId = 34157, buy = 150 },
	--{ itemName = "eldritch cuirass", clientId = 36663, buy = 150 },
	{ itemName = "earthheart cuirass", clientId = 22521, buy = 15},
	{ itemName = "earthheart hauberk", clientId = 22522, buy = 15 },
	{ itemName = "earthheart platemail", clientId = 22523, buy = 15 },
	{ itemName = "earthmind raiment", clientId = 22535, buy = 15 },
	{ itemName = "earthsoul tabard", clientId = 22531, buy = 15 },
	{ itemName = "fireheart cuirass", clientId = 22518, buy = 15 },
	{ itemName = "fireheart hauberk", clientId = 22519, buy = 15 },
	{ itemName = "fireheart platemail", clientId = 22520, buy = 15 },
	{ itemName = "firemind raiment", clientId = 22534, buy = 15 },
	{ itemName = "firesoul tabard", clientId = 22530, buy = 15},
	{ itemName = "frostheart cuirass", clientId = 22527, buy = 15},
	{ itemName = "frostheart hauberk", clientId = 22528, buy = 15 },
	{ itemName = "frostheart platemail", clientId = 22529, buy = 15 },
	{ itemName = "frostmind raiment", clientId = 22537, buy = 15 },
	{ itemName = "frostsoul tabard", clientId = 22533, buy = 15 },
	{ itemName = "thunderheart cuirass", clientId = 22524, buy = 15 },
	{ itemName = "thunderheart hauberk", clientId = 22525, buy = 15 },
	{ itemName = "thunderheart platemail", clientId = 22526, buy = 15 },
	{ itemName = "thundermind raiment", clientId = 22536, buy = 15 },
	{ itemName = "thundersoul tabard", clientId = 22532, buy = 15 },
	--LEGS
	{ itemName = "mutant bone kilt", clientId = 40595, buy = 160 },
	{ itemName = "mutated skin legs", clientId = 40590, buy = 180 },
	{ itemName = "stitched mutant skin legs", clientId = 40589, buy = 180 },
	{ itemName = "gnome legs", clientId = 27649, buy = 200 },
	{ itemName = "fabulous legs", clientId = 32617, buy = 150 },
	{ itemName = "midnight sarong", clientId = 39167, buy = 100 },
	{ itemName = "eldritch breeches", clientId = 36667, buy = 150 },
	{ itemName = "dawnfire pantaloons", clientId = 39166, buy = 100},
	--{ itemName = "falcon greaves", clientId = 28720, buy = 180},
	--BOOTS
	{ itemName = "golden boots", clientId = 3555, buy = 60 },
	{ itemName = "winged boots", clientId = 31617, buy = 50 },
	--{ itemName = "cobra boots", clientId = 30394, buy = 60 },
	{ itemName = "mutant bone boots", clientId = 40593, buy = 80},
	{ itemName = "alchemist's boots", clientId = 40592, buy = 80 },
	{ itemName = "frostflower boots", clientId = 39158, buy = 50 },
	{ itemName = "gnomish footwraps", clientId = 50290, buy = 80 },
	--SHIELDS
	{ itemName = "amazon shield", clientId = 3437, buy = 150 },
	{ itemName = "gnome shield", clientId = 27650, buy = 60 },
	{ itemName = "death gaze", clientId = 22758, buy = 80 },
	--{ itemName = "lion shield", clientId = 34154, buy = 120 },
	--{ itemName = "eldritch shield", clientId = 36656, buy = 150 },
	--{ itemName = "falcon shield", clientId = 28721, buy = 140 },
	--{ itemName = "lion spellbook", clientId = 34153, buy = 80 },
	{ itemName = "umbral master spellbook", clientId = 20090, buy = 150 },
	{ itemName = "alchemist's notepad", clientId = 40594, buy = 160 },
	--{ itemName = "eldritch tome", clientId = 36673, buy = 180 },
	--{ itemName = "eldritch folio", clientId = 36672, buy = 180 },	
	--WEAPONS
	--{ itemName = "eldritch warmace", clientId = 36659, buy = 150 },
	{ itemName = "reziser", clientId = 29419, buy = 60 },
	{ itemName = "mortal mace", clientId = 31580, buy = 50 },
	{ itemName = "gnome sword", clientId = 27651, buy = 80 },
	{ itemName = "depth claws", clientId = 50176, buy = 80 },
	{ itemName = "tagralt blade", clientId = 31614, buy = 140 },
	{ itemName = "naga axe", clientId = 39156, buy = 160 },
	{ itemName = "naga sword", clientId = 39155, buy = 160 },
	{ itemName = "winterblade", clientId = 29422, buy = 150 },
	{ itemName = "summerblade", clientId = 29421, buy = 150 },
	{ itemName = "naga club", clientId = 39157, buy = 150 },
	--{ itemName = "eldritch greataxe", clientId = 36661, buy = 160 },
	--{ itemName = "eldritch claymore", clientId = 36657, buy = 150 },	
	{ itemName = "umbral master blade", clientId = 20066, buy = 150 },
	{ itemName = "umbral master mace", clientId = 20078, buy = 150 },
	{ itemName = "umbral master axe", clientId = 20072, buy = 150 },
	{ itemName = "umbral master slayer", clientId = 20069, buy = 350 },
	{ itemName = "umbral master hammer", clientId = 20081, buy = 350 },
	{ itemName = "umbral master chopper", clientId = 20075, buy = 350 },
	--{ itemName = "falcon battleaxe", clientId = 28724, buy = 180 },
	--{ itemName = "falcon mace", clientId = 28725, buy = 160 },
	--{ itemName = "falcon longsword", clientId = 28723, buy = 180 },
	--{ itemName = "lion axe", clientId = 34253, buy = 150 },
	--{ itemName = "lion hammer", clientId = 34254, buy = 150 },
	--{ itemName = "lion longsword", clientId = 34155, buy = 150 },
	--{ itemName = "cobra axe", clientId = 30396, buy = 130 },
	--{ itemName = "cobra club", clientId = 30395, buy = 130 },
	--{ itemName = "cobra sword", clientId = 30398, buy = 120 },
	{ itemName = "axe of desctruction", clientId = 27451, buy = 25 },
	{ itemName = "blade of desctruction", clientId = 27449, buy = 25 },
	{ itemName = "chopper of desctruction", clientId = 27452, buy = 25 },
	{ itemName = "hammer of desctruction", clientId = 27454, buy = 25 },
	{ itemName = "mace of desctruction", clientId = 27453, buy = 25 },
	{ itemName = "rod of desctruction", clientId = 27458, buy = 25 },
	{ itemName = "slayer of desctruction", clientId = 27450, buy = 25 },
	{ itemName = "wand of desctruction", clientId = 27457, buy = 25 },
	--DISTANCE
	{ itemName = "naga crossbow", clientId = 39159, buy = 140 },
	--{ itemName = "lion longbow", clientId = 34150, buy = 140 },
	--{ itemName = "falcon bow", clientId = 28718, buy = 150 },
	{ itemName = "bow of cataclysm", clientId = 31581, buy = 100 },
	--{ itemName = "eldritch bow", clientId = 36664, buy = 150 },
	--{ itemName = "cobra crossbow", clientId = 30393, buy = 130 },
	{ itemName = "living vine bow", clientId = 29417, buy = 50 },
	{ itemName = "bow of desctruction", clientId = 27455, buy = 30 },
	{ itemName = "umbral master bow", clientId = 20084, buy = 350 },
	{ itemName = "umbral master crossbow", clientId = 20087, buy = 350 },
	{ itemName = "crossbow of desctruction", clientId = 27456, buy = 25 },	
	--MAGIC
	--{ itemName = "cobra rod", clientId = 30400, buy = 120 },
	--{ itemName = "cobra wand", clientId = 30399, buy = 120 },
	{ itemName = "deepling fork", clientId = 28826, buy = 80 },
	{ itemName = "naga rod", clientId = 39163, buy = 150 },
	{ itemName = "naga wand", clientId = 39162, buy = 150 },
	--{ itemName = "lion rod", clientId = 34151, buy = 150 },
	--{ itemName = "lion wand", clientId = 34152, buy = 150 },
	--{ itemName = "falcon rod", clientId = 28716, buy = 150 },
	--{ itemName = "falcon wand", clientId = 28717, buy = 150 },
	--{ itemName = "eldritch rod", clientId = 36674, buy = 150 },
	--{ itemName = "eldritch wand", clientId = 36668, buy = 150 },
	--Amulets/Rings/Accesories
	{ itemName = "platinum token", clientId = 22723, buy = 10 },
	{ itemName = "starlight vial", clientId = 25976, buy = 10 },
	{ itemName = "enchanted turtle amulet", clientId = 39233, buy = 60 },
	{ itemName = "rainbow necklace", clientId = 30323, buy = 80 },
	{ itemName = "enchanted theurgic amulet", clientId = 30403, buy = 50 },
	{ itemName = "lion amulet", clientId = 34158, buy = 80 },
	{ itemName = "cobra amulet", clientId = 31631, buy = 100 },
	{ itemName = "naga quiver", clientId = 39160, buy = 50 },
	{ itemName = "eldritch quiver", clientId = 36666, buy = 120 },
	{ itemName = "lit torch", clientId = 34016, buy = 8 },
	{ itemName = "bone fiddle", clientId = 28493, buy = 25 },
	{ itemName = "conch shell horn", clientId = 43863, buy = 25},
	{ itemName = "magical torch", clientId = 9042, buy = 10 },
	{ itemName = "ring of souls", clientId = 32621, buy = 30 },
	{ itemName = "enchanted blister ring", clientId = 31557, buy = 20 },
	{ itemName = "candy-coated quiver", clientId = 45644, buy = 60 },
	{ itemName = "candy necklace", clientId = 45641, buy = 100 },
	{ itemName = "moon mirror", clientId = 25975, buy = 5 },
	--monk fist weapons & armor (lv 151-399)
	{ itemName = "dark vision bandana", clientId = 50190, buy = 80 },
	{ itemName = "energy robe", clientId = 50279, buy = 150 },
	{ itemName = "ice robe", clientId = 50280, buy = 150 },
	{ itemName = "leaf robe", clientId = 50277, buy = 150 },
	{ itemName = "magma robe", clientId = 50278, buy = 150 },
	{ itemName = "nunchaku of destruction", clientId = 50168, buy = 160 },
	{ itemName = "jade legs", clientId = 50185, buy = 200 },
	{ itemName = "enchanted merudri brooch", clientId = 50155, buy = 120 },
	{ itemName = "death oyoroi", clientId = 50260, buy = 200 },
	{ itemName = "cobra bo", clientId = 50167, buy = 250 },
	{ itemName = "eldritch crescent moon spade", clientId = 50169, buy = 250 },
	{ itemName = "iks footwraps", clientId = 50291, buy = 200 },
	{ itemName = "stoic iks robe", clientId = 50255, buy = 200 },
	{ itemName = "umbral master katar", clientId = 50165, buy = 350 },
	{ itemName = "lion claws", clientId = 50162, buy = 300 },
	{ itemName = "naga tanko", clientId = 50262, buy = 250 },
	{ itemName = "eldritch monk boots", clientId = 50266, buy = 300 },
	{ itemName = "falcon sai", clientId = 50161, buy = 300 },
	{ itemName = "inferniarch claws", clientId = 50250, buy = 300 },
	{ itemName = "merudri battle mail", clientId = 50264, buy = 280 },
	{ itemName = "mutant hide trousers", clientId = 50184, buy = 250 },
	{ itemName = "naga katar", clientId = 50160, buy = 280 },
	{ itemName = "amber kusarigama", clientId = 50239, buy = 350 },
	-- Amber Weapons (lv 250)
	{ itemName = "amber axe", clientId = 47375, buy = 350 },
	{ itemName = "amber bludgeon", clientId = 47370, buy = 350 },
	{ itemName = "amber bow", clientId = 47371, buy = 350 },
	{ itemName = "amber crossbow", clientId = 47377, buy = 350 },
	{ itemName = "amber crusher", clientId = 46628, buy = 350 },
	{ itemName = "amber cudgel", clientId = 47376, buy = 350 },
	{ itemName = "amber greataxe", clientId = 47369, buy = 350 },
	{ itemName = "amber rod", clientId = 47373, buy = 350 },
	{ itemName = "amber sabre", clientId = 47374, buy = 350 },
	{ itemName = "amber sickle", clientId = 48413, buy = 350 },
	{ itemName = "amber slayer", clientId = 47368, buy = 350 },
	{ itemName = "amber wand", clientId = 47372, buy = 350 },
	-- Inferniarch Weapons (lv 300)
	{ itemName = "inferniarch arbalest", clientId = 49522, buy = 300 },
	{ itemName = "inferniarch battleaxe", clientId = 49523, buy = 300 },
	{ itemName = "inferniarch blade", clientId = 49527, buy = 300 },
	{ itemName = "inferniarch bow", clientId = 49520, buy = 300 },
	{ itemName = "inferniarch flail", clientId = 49525, buy = 300 },
	{ itemName = "inferniarch greataxe", clientId = 49524, buy = 300 },
	{ itemName = "inferniarch rod", clientId = 49529, buy = 300 },
	{ itemName = "inferniarch slayer", clientId = 49530, buy = 300 },
	{ itemName = "inferniarch wand", clientId = 49528, buy = 300 },
	{ itemName = "inferniarch warhammer", clientId = 49526, buy = 300 },
	-- Inferniarch / Azzilon Helmets (lv 300)
	{ itemName = "demonfang mask", clientId = 49534, buy = 180 },
	{ itemName = "dreadfire headpiece", clientId = 49533, buy = 180 },
	{ itemName = "hellstalker visor", clientId = 49532, buy = 180 },
	{ itemName = "maliceforged helmet", clientId = 49531, buy = 180 },
	-- Stoic Iks & Candy Equipment (lv 250)
	{ itemName = "stoic iks faulds", clientId = 44643, buy = 200 },
	{ itemName = "stoic iks boots", clientId = 44648, buy = 150 },
	{ itemName = "stoic iks chestplate", clientId = 44620, buy = 100 },
	{ itemName = "stoic iks cuirass", clientId = 44619, buy = 100 },
	{ itemName = "biscuit barrier", clientId = 45643, buy = 160 },
	{ itemName = "cocoa grimoire", clientId = 45639, buy = 160 },
	{ itemName = "creamy grimoire", clientId = 45640, buy = 160 },
	-- Charged Rings (lv 300)
	{ itemName = "charged spiritthorn ring", clientId = 39177, buy = 450 },
	{ itemName = "charged alicorn ring", clientId = 39180, buy = 450 },
	{ itemName = "charged arcanomancer sigil", clientId = 39183, buy = 450 },
	{ itemName = "charged arboreal ring", clientId = 39186, buy = 450 },
	{ itemName = "charged ethereal ring", clientId = 50147, buy = 450 },
}
-- On buy npc shop message
npcType.onBuyItem = function(npc, player, itemId, subType, amount, ignore, inBackpacks, totalCost)
	npc:sellItem(player, itemId, amount, subType, 0, ignore, inBackpacks)
end
-- On sell npc shop message
npcType.onSellItem = function(npc, player, itemId, subtype, amount, ignore, name, totalCost)
	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, string.format("Sold %ix %s for %i gold.", amount, name, totalCost))
end
-- On check npc shop message (look item)
npcType.onCheckItem = function(npc, player, clientId, subType)
end

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
npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

local function greetCallback(npc, creature)
	local playerId = creature:getId()
	npcHandler:setTopic(playerId, 0)
	return true
end

local function creatureSayCallback(npc, creature, type, message)
	local player = Player(creature)
	local playerId = player:getId()

	if not npcHandler:checkInteraction(npc, creature) then
		return false
	end

	if MsgContains(message, "information") then
		npcHandler:say({"{Tokens} are small objects made of metal or other materials. You can use them to buy superior equipment from token traders like me.",
						"There are several ways to obtain the tokens I'm interested in - killing certain bosses, for example. In exchange for a certain amount of tokens, I can offer you some first-class items."}, npc, creature)
	elseif MsgContains(message, "imbu") then
	npcHandler:say({"I am not trading imbuing items anymore, go with {Grizzly Addams} he is selling all imbuing items!"}, npc, creature)
	elseif MsgContains(message, "tokens") then
		npc:openShopWindow(creature)
		npcHandler:say("If you have any gold tokens with you, let's {trade}! Those are my offers.", npc, creature)	
		npcHandler:setTopic(playerId, 0)
	end
	return true
end

npcHandler:setCallback(CALLBACK_SET_INTERACTION, onAddFocus)
npcHandler:setCallback(CALLBACK_REMOVE_INTERACTION, onReleaseFocus)

npcHandler:setMessage(MESSAGE_GREET, "Good day! How may I be of service? Do you wish to {trade} some {tokens}, or would you like some {imbuing} items?")
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, false)

-- npcType registering the npcConfig table
npcType:register(npcConfig)
