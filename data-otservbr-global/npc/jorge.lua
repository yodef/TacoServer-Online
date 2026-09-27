local internalNpcName = "Jorge"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookType = 130,
	lookHead = 115,
	lookBody = 39,
	lookLegs = 96,
	lookFeet = 118,
	lookAddons = 3
}
npcConfig.flags = {
	floorchange = false
}

npcConfig.voices = {
	interval = 15000,
	chance = 30,
	{text = 'Trading Platinum tokens! Buy lucky bags for best equipment!'},
	{text = 'Trade equipment over level 400!'}
}

npcConfig.currency = 22723
--items over LV400
npcConfig.shop = {
	-- Helmets & Lucky Bags
	{ itemName = "bag you desire", clientId = 34109, buy = 90 },	
	{ itemName = "primal bag", clientId = 39546, buy = 60 },
	{ itemName = "bag you covet", clientId = 43895, buy = 200 },
	{ itemName = "golden helmet", clientId = 3365, buy = 25 },

	-- Elemental Concoctions (Surprise Cube)
	-- Resilience (Defensive)
	{ itemName = "fire resilience", clientId = 36729, buy = 10, sell = 5 },
	{ itemName = "ice resilience", clientId = 36730, buy = 10, sell = 5 },
	{ itemName = "earth resilience", clientId = 36731, buy = 10, sell = 5 },
	{ itemName = "energy resilience", clientId = 36732, buy = 10, sell = 5 },
	{ itemName = "holy resilience", clientId = 36733, buy = 10, sell = 5 },
	{ itemName = "death resilience", clientId = 36734, buy = 10, sell = 5 },
	{ itemName = "physical resilience", clientId = 36735, buy = 10, sell = 5 },

	-- Amplification (Offensive)
	{ itemName = "fire amplification", clientId = 36736, buy = 10, sell = 5 },
	{ itemName = "ice amplification", clientId = 36737, buy = 10, sell = 5 },
	{ itemName = "earth amplification", clientId = 36738, buy = 10, sell = 5 },
	{ itemName = "energy amplification", clientId = 36739, buy = 10, sell = 5 },
	{ itemName = "holy amplification", clientId = 36740, buy = 10, sell = 5 },
	{ itemName = "death amplification", clientId = 36741, buy = 10, sell = 5 },
	{ itemName = "physical amplification", clientId = 36742, buy = 10, sell = 5 },
}
-- On buy npc shop message
npcType.onBuyItem = function(npc, player, itemId, subType, amount, ignore, inBackpacks, totalCost)
	npc:sellItem(player, itemId, amount, subType, 0, ignore, inBackpacks)
end
-- On sell npc shop message
npcType.onSellItem = function(npc, player, itemId, subtype, amount, ignore, name, totalCost)
	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, string.format("Sold %ix %s for %i platinum tokens.", amount, name, totalCost))
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
		npcHandler:say("If you have any platinum tokens with you, let's {trade}! Those are my offers.", npc, creature)	
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