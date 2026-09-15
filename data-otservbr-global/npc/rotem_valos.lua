local internalNpcName = "Rotem Valos"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 0
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookType = 335,
	lookHead = 79,
	lookBody = 77,
	lookLegs = 79,
	lookFeet = 94,
	lookAddons = 2,
}

npcConfig.flags = {
	floorchange = false,
}

npcConfig.voices = {
	interval = 30000,
	chance = 20,
	{text = 'Trade your copper tokens for useful equipment!'}
}

-- Items less than LV50
npcConfig.currency = 22722
npcConfig.shop = { --copper token price 1k ea
	--helmets
	{ itemName = "silver token", clientId = 22516, buy = 10},
	{ itemName = "bonelord helmet", clientId = 3408, buy = 6},
	{ itemName = "cobra crown", clientId = 11674, buy = 15},
	{ itemName = "crown helmet", clientId = 3385, buy = 4},
	{ itemName = "crusader helmet", clientId = 3391, buy = 10},
	{ itemName = "demon helmet", clientId = 3387, buy = 66},
	{ itemName = "hat of the mad", clientId = 3210, buy = 7},
	{ itemName = "royal helmet", clientId = 3392, buy = 35},
	{ itemName = "skull helmet", clientId = 5741, buy = 45},
	{ itemName = "warrior helmet", clientId = 3369, buy = 7},
	{ itemName = "wood cape", clientId = 3575, buy = 7},
	--armors
	{ itemName = "blue robe", clientId = 3567, buy = 11},
	{ itemName = "crown armor", clientId = 3381, buy = 13},
	{ itemName = "dragon scale mail", clientId = 3386, buy = 50},
	{ itemName = "focus cape", clientId = 8043, buy = 8},
	{ itemName = "golden armor", clientId = 3360, buy = 25},
	{ itemName = "knight armor", clientId = 3370, buy = 5},
	{ itemName = "paladin armor", clientId = 8063, buy = 25},
	--legs
	{ itemName = "blue legs", clientId = 645, buy = 20},
	{ itemName = "crown legs", clientId = 3382, buy = 15},	
	{ itemName = "golden legs", clientId = 3364, buy = 45},
	{ itemName = "knight legs", clientId = 3371, buy = 6},
	{ itemName = "zaoan legs", clientId = 10387, buy = 50},
	--shields	
	{ itemName = "crown shield", clientId = 3419, buy = 10},
	{ itemName = "medusa shield", clientId = 3436, buy = 15},
	{ itemName = "vampire shield", clientId = 3434, buy = 20},
	{ itemName = "demon shield", clientId = 3420, buy = 30},
	{ itemName = "carapace shield", clientId = 14088, buy = 35},
	{ itemName = "mastermind shield", clientId = 3414, buy = 65},
	{ itemName = "rift shield", clientId = 22726, buy = 70},
	--meleewpns		
	{ itemName = "steel axe", clientId = 7773, buy = 1},
	{ itemName = "dwarven axe", clientId = 3323, buy = 2},
	{ itemName = "knight axe", clientId = 3318, buy = 4},
	{ itemName = "beastslayer axe", clientId = 3344, buy = 6},
	{ itemName = "noble axe", clientId = 7456, buy = 15},
	{ itemName = "warrior axe", clientId = 14040, buy = 10},
	{ itemName = "butcher axe", clientId = 7412, buy = 25},
	{ itemName = "furry club", clientId = 7432, buy = 1},
	{ itemName = "diamond sceptre", clientId = 7387, buy = 5},
	{ itemName = "skull staff", clientId = 3324, buy = 8},
	{ itemName = "shadow sceptre", clientId = 7451, buy = 13},
	{ itemName = "silver mace", clientId = 3312, buy = 25},
	{ itemName = "crimson sword", clientId = 7385, buy = 2},
	{ itemName = "cowtana", clientId = 21177, buy = 4},
	{ itemName = "bright sword", clientId = 3295, buy = 8},
	{ itemName = "djinn blade", clientId = 3339, buy = 15},
	{ itemName = "assassin dagger", clientId = 7404, buy = 25},
	--2handed
	{ itemName = "crystal sword", clientId = 7449, buy = 3},
	{ itemName = "haunted blade", clientId = 7407, buy = 6},
	{ itemName = "blacksteel sword", clientId = 7406, buy = 8},
	{ itemName = "mercenary sword", clientId = 7386, buy = 12},
	{ itemName = "dragon slayer", clientId = 7402, buy = 15},
	{ itemName = "headchopper", clientId = 7380, buy = 6},
	{ itemName = "titan axe", clientId = 7413, buy = 8},
	{ itemName = "angelic axe", clientId = 7436, buy = 8},
	{ itemName = "spiked squelcher", clientId = 7452, buy = 6},
	{ itemName = "orcish maul", clientId = 7392, buy = 8},
	{ itemName = "amber staff", clientId = 7426, buy = 10},
	{ itemName = "chaos mace", clientId = 7427, buy = 10},
	--distance
	{ itemName = "icicle bow", clientId = 19362, buy = 12},
	{ itemName = "silkweaver bow", clientId = 8029, buy = 15},
	{ itemName = "modified crossbow", clientId = 8021, buy = 20},
	--amulets
	--{ itemName = "onyx pendant", clientId = 22195, buy = 7},
	--boots
	{ itemName = "boh", clientId = 3079, buy = 31},
	{ itemName = "fur boots", clientId = 7457, buy = 3},
	{ itemName = "pirate boots", clientId = 5461, buy = 10},
	{ itemName = "steel boots", clientId = 3554, buy = 40},
	{ itemName = "zaoan shoes", clientId = 10386, buy = 6},
	--monk fist weapons & armor (lv<=50)
	{ itemName = "simple jo staff", clientId = 50166, buy = 1 },
	{ itemName = "jo staff", clientId = 50171, buy = 2 },
	{ itemName = "plain monk robe", clientId = 50257, buy = 1 },
	{ itemName = "monk robe", clientId = 50258, buy = 3 },
	{ itemName = "light bandana", clientId = 50194, buy = 1 },
	{ itemName = "boots of enlightenment", clientId = 50267, buy = 2 },
	{ itemName = "harmony amulet", clientId = 50195, buy = 2 },
	{ itemName = "pair of monk fists", clientId = 50181, buy = 4 },
	{ itemName = "fists of enlightenment", clientId = 50271, buy = 8 },
	{ itemName = "jade conical hat", clientId = 50193, buy = 12 },
	{ itemName = "drachaku", clientId = 10391, buy = 15 },
	{ itemName = "nunchaku", clientId = 50182, buy = 15 },
	{ itemName = "legs of enlightenment", clientId = 50269, buy = 10 },
	{ itemName = "nunchaku of enlightenment", clientId = 50273, buy = 25 },
	{ itemName = "zaoan monk robe", clientId = 50259, buy = 20 },
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

-- npcType registering the npcConfig table
npcType:register(npcConfig)
