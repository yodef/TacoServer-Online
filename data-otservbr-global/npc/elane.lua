local internalNpcName = "Elane"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookType = 137,
	lookHead = 96,
	lookBody = 101,
	lookLegs = 120,
	lookFeet = 120,
	lookAddons = 3,
}

npcConfig.flags = {
	floorchange = false,
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

local function creatureSayCallback(npc, creature, type, message)
	local player = Player(creature)
	local playerId = player:getId()

	if not npcHandler:checkInteraction(npc, creature) then
		return false
	end

	if MsgContains(message, "addon") or MsgContains(message, "outfit") then
		if player:getStorageValue(Storage.Quest.U7_8.HunterOutfits.HunterHatAddon) < 1 then
			npcHandler:say("Oh, my winged tiara? Those are traditionally awarded after having completed a difficult {task} for our guild, only to female aspirants though. Male warriors will receive a hooded cloak.", npc, creature)
			npcHandler:setTopic(playerId, 1)
		end
	elseif MsgContains(message, "task") then
		if npcHandler:getTopic(playerId) == 1 then
			npcHandler:say("So you are saying that you would like to prove that you deserve to wear such a hooded cloak?", npc, creature)
			npcHandler:setTopic(playerId, 2)
		end
	elseif MsgContains(message, "crossbow") then
		if player:getStorageValue(Storage.Quest.U7_8.HunterOutfits.HunterHatAddon) == 1 then
			npcHandler:say("I'm so excited! Have you really found my crossbow?", npc, creature)
			npcHandler:setTopic(playerId, 4)
		end
	elseif MsgContains(message, "leather") then
		if player:getStorageValue(Storage.Quest.U7_8.HunterOutfits.HunterHatAddon) == 2 then
			npcHandler:say("Did you bring me 100 pieces of lizard leather and 100 pieces of red dragon leather?", npc, creature)
			npcHandler:setTopic(playerId, 5)
		end
	elseif MsgContains(message, "chicken wing") then
		if player:getStorageValue(Storage.Quest.U7_8.HunterOutfits.HunterHatAddon) == 3 then
			npcHandler:say("Were you able to get hold of 5 enchanted chicken wings?", npc, creature)
			npcHandler:setTopic(playerId, 6)
		end
	elseif MsgContains(message, "steel") then
		if player:getStorageValue(Storage.Quest.U7_8.HunterOutfits.HunterHatAddon) == 4 then
			npcHandler:say("Ah, have you brought one piece of royal steel, draconian steel and hell steel each?", npc, creature)
			npcHandler:setTopic(playerId, 7)
		end
	elseif MsgContains(message, "yes") then
		if npcHandler:getTopic(playerId) == 2 then
			npcHandler:say({
				"Alright, I will give you a chance. Pay close attention to what I'm going to tell you now. ...",
				"Recently, one of our members moved to Liberty Bay out of nowhere, talking about some strange cult. That is not the problem, but he took my favourite crossbow with him. ...",
				"Please find my crossbow. It has my name engraved on it and is very special to me. ...",
				"Secondly, we need a lot of leather for new quivers. 100 pieces of lizard leather and 100 pieces of red dragon leather should suffice. ...",
				"Third, since we are giving out tiaras, we are always in need of enchanted chicken wings. Please bring me 5, that would help us tremendously. ...",
				"Lastly, for our arrow heads we need a lot of steel. Best would be one piece of royal steel, one piece of draconian steel and one piece of hell steel. ...",
				"Did you understand everything I told you and are willing to handle this task?",
			}, npc, creature)
			npcHandler:setTopic(playerId, 3)
		elseif npcHandler:getTopic(playerId) == 3 then
			npcHandler:say("That's the spirit! I hope you will find my crossbow, |PLAYERNAME|!", npc, creature)
			player:setStorageValue(Storage.Quest.U7_8.HunterOutfits.HunterHatAddon, 1)
			player:setStorageValue(Storage.OutfitQuest.DefaultStart, 1) --this for default start of Outfit and Addon Quests
			npcHandler:setTopic(playerId, 0)
		elseif npcHandler:getTopic(playerId) == 4 then
			if player:removeItem(5947, 1) then
				npcHandler:say("Yeah! I could kiss you right here and there! Besides, you're a handsome one. <giggles> Please bring me 100 pieces of lizard leather and 100 pieces of red dragon leather now!", npc, creature)
				player:setStorageValue(Storage.Quest.U7_8.HunterOutfits.HunterHatAddon, 2)
				npcHandler:setTopic(playerId, 0)
			else
				npcHandler:say("You don't have it...", npc, creature)
			end
		elseif npcHandler:getTopic(playerId) == 5 then
			if player:getItemCount(5876) >= 100 and player:getItemCount(5948) >= 100 then
				npcHandler:say("Good work, |PLAYERNAME|! That is enough leather for a lot of sturdy quivers. Now, please bring me 5 enchanted chicken wings.", npc, creature)
				player:removeItem(5876, 100)
				player:removeItem(5948, 100)
				player:setStorageValue(Storage.Quest.U7_8.HunterOutfits.HunterHatAddon, 3)
				npcHandler:setTopic(playerId, 0)
			else
				npcHandler:say("You don't have it...", npc, creature)
			end
		elseif npcHandler:getTopic(playerId) == 6 then
			if player:removeItem(5891, 5) then
				npcHandler:say("Great! Now we can create a few more Tiaras. If only they weren't that expensive... Well anyway, please obtain one piece of royal steel, draconian steel and hell steel each.", npc, creature)
				player:setStorageValue(Storage.Quest.U7_8.HunterOutfits.HunterHatAddon, 4)
				npcHandler:setTopic(playerId, 0)
			else
				npcHandler:say("You don't have it...", npc, creature)
			end
		elseif npcHandler:getTopic(playerId) == 7 then
			if player:getItemCount(5887) >= 1 and player:getItemCount(5888) >= 1 and player:getItemCount(5889) >= 1 then
				npcHandler:say("Wow, I'm impressed, |PLAYERNAME|. Your really are a valuable member of our paladin guild. I shall grant you your reward now. Wear it proudly!", npc, creature)
				player:removeItem(5887, 1)
				player:removeItem(5888, 1)
				player:removeItem(5889, 1)
				player:setStorageValue(Storage.Quest.U7_8.HunterOutfits.HunterHatAddon, 5)
				player:addOutfitAddon(129, 1)
				player:addOutfitAddon(137, 2)
				player:getPosition():sendMagicEffect(CONST_ME_MAGIC_BLUE)
				npcHandler:setTopic(playerId, 0)
			else
				npcHandler:say("You don't have it...", npc, creature)
			end
		end
	elseif MsgContains(message, "no") then
		if npcHandler:getTopic(playerId) > 1 then
			npcHandler:say("Then no.", npc, creature)
			npcHandler:setTopic(playerId, 0)
		end
		return true
	end
end

-- Sniper Gloves
keywordHandler:addKeyword({ "sniper gloves" }, StdModule.say, { npcHandler = npcHandler, text = "We are always looking for sniper gloves. They are supposed to raise accuracy. If you find a pair, bring them here. Maybe I can offer you a nice trade." }, function(player)
	return player:getItemCount(5875) == 0
end)

local function addGloveKeyword(text, condition, action)
	local gloveKeyword = keywordHandler:addKeyword({ "sniper gloves" }, StdModule.say, { npcHandler = npcHandler, text = text[1] }, condition)
	gloveKeyword:addChildKeyword({ "yes" }, StdModule.say, { npcHandler = npcHandler, text = text[2], reset = true }, function(player)
		return player:getItemCount(5875) == 0
	end)
	gloveKeyword:addChildKeyword({ "yes" }, StdModule.say, { npcHandler = npcHandler, text = text[3], reset = true }, nil, action)
	gloveKeyword:addChildKeyword({ "no" }, StdModule.say, { npcHandler = npcHandler, text = text[2], reset = true })
end

-- Free Account
addGloveKeyword({
	"You found sniper gloves?! Incredible! I would love to grant you the sniper gloves accessory, but I can only do that for premium warriors. However, I would pay you 2000 gold pieces for them. How about it?",
	"Maybe another time.",
	"Alright! Here is your money, thank you very much.",
}, function(player)
	return not player:isPremium()
end, function(player)
	player:removeItem(5875, 1)
	player:addMoney(2000)
end)

-- Premium account with addon
addGloveKeyword({
	"Did you find sniper gloves AGAIN?! Incredible! I cannot grant you other accessories, but would you like to sell them to me for 2000 gold pieces?",
	"Maybe another time.",
	"Alright! Here is your money, thank you very much.",
}, function(player)
	return player:getStorageValue(Storage.Quest.U7_8.HunterOutfits.Hunter.AddonGlove) == 1
end, function(player)
	player:removeItem(5875, 1)
	player:addMoney(2000)
end)

-- If you don't have the addon
addGloveKeyword({
	"You found sniper gloves?! Incredible! Listen, if you give them to me, I will grant you the right to wear the sniper gloves accessory. How about it?",
	"No problem, maybe another time.",
	"Great! I hereby grant you the right to wear the sniper gloves as an accessory. Congratulations!",
}, function(player)
	return player:getStorageValue(Storage.Quest.U7_8.HunterOutfits.Hunter.AddonGlove) == -1
end, function(player)
	player:removeItem(5875, 1)
	player:setStorageValue(Storage.Quest.U7_8.HunterOutfits.Hunter.AddonGlove, 1)
	player:addOutfitAddon(129, 2)
	player:addOutfitAddon(137, 1)
	player:getPosition():sendMagicEffect(CONST_ME_MAGIC_BLUE)
end)

-- Basic
keywordHandler:addKeyword({ "help" }, StdModule.say, { npcHandler = npcHandler, text = "I am the leader of the Paladins. I help our members." })
keywordHandler:addKeyword({ "job" }, StdModule.say, { npcHandler = npcHandler, text = "I am the leader of the Paladins. I help our members." })
keywordHandler:addKeyword({ "paladins" }, StdModule.say, { npcHandler = npcHandler, text = "Paladins are great warriors and magicians. Besides that we are excellent missile fighters. Many people in Tibia want to join us." })
keywordHandler:addKeyword({ "warriors" }, StdModule.say, { npcHandler = npcHandler, text = "Of course, we aren't as strong as knights, but no druid or sorcerer will ever defeat a paladin with a sword." })
keywordHandler:addKeyword({ "magicians" }, StdModule.say, { npcHandler = npcHandler, text = "There are many magic spells and runes paladins can use." })
keywordHandler:addKeyword({ "missile" }, StdModule.say, { npcHandler = npcHandler, text = "Paladins are the best missile fighters in Tibia!" })
keywordHandler:addKeyword({ "news" }, StdModule.say, { npcHandler = npcHandler, text = "I am a paladin, not a storyteller." })
keywordHandler:addKeyword({ "members" }, StdModule.say, { npcHandler = npcHandler, text = "Every paladin profits from his vocation. It has many advantages to be a paladin." })
keywordHandler:addKeyword({ "advantages" }, StdModule.say, { npcHandler = npcHandler, text = "We will help you to improve your skills. Besides I offer spells for paladins." })
keywordHandler:addKeyword({ "general" }, StdModule.say, { npcHandler = npcHandler, text = "Harkath Bloodblade is the royal general." })
keywordHandler:addKeyword({ "army" }, StdModule.say, { npcHandler = npcHandler, text = "Some paladins serve in the kings army." })
keywordHandler:addKeyword({ "baxter" }, StdModule.say, { npcHandler = npcHandler, text = "He has some potential." })
keywordHandler:addKeyword({ "bozo" }, StdModule.say, { npcHandler = npcHandler, text = "How spineless do you have to be to become a jester?" })
keywordHandler:addKeyword({ "mcronald" }, StdModule.say, { npcHandler = npcHandler, text = "The McRonalds are simple farmers." })
keywordHandler:addKeyword({ "eclesius" }, StdModule.say, { npcHandler = npcHandler, text = "He must have been skilled before he became the way he is now. Such a pity." })
keywordHandler:addKeyword({ "elane" }, StdModule.say, { npcHandler = npcHandler, text = "Yes?" })
keywordHandler:addKeyword({ "frodo" }, StdModule.say, { npcHandler = npcHandler, text = "The alcohol he sells shrouds the mind and the eye." })
keywordHandler:addKeyword({ "galuna" }, StdModule.say, { npcHandler = npcHandler, text = "One of the most important members of our guild. She makes all the bows and arrows we need." })
keywordHandler:addKeyword({ "gorn" }, StdModule.say, { npcHandler = npcHandler, text = "He sells a lot of useful equipment." })
keywordHandler:addKeyword({ "gregor" }, StdModule.say, { npcHandler = npcHandler, text = "He and his guildfellows lack the grace of a true warrior." })
keywordHandler:addKeyword({ "harkath bloodblade" }, StdModule.say, { npcHandler = npcHandler, text = "A fine warrior and a skilled general." })
keywordHandler:addKeyword({ "king tibianus" }, StdModule.say, { npcHandler = npcHandler, text = "King Tibianus is a wise ruler." })
keywordHandler:addKeyword({ "lugri" }, StdModule.say, { npcHandler = npcHandler, text = "A follower of evil that will get what he deserves one day." })
keywordHandler:addKeyword({ "lynda" }, StdModule.say, { npcHandler = npcHandler, text = "Mhm, a little too nice for my taste. Still, it's amazing how she endures all those men stalking her, especially this creepy Oswald." })
keywordHandler:addKeyword({ "marvik" }, StdModule.say, { npcHandler = npcHandler, text = "A skilled healer, that's for sure." })
keywordHandler:addKeyword({ "muriel" }, StdModule.say, { npcHandler = npcHandler, text = "Just another arrogant sorcerer." })
keywordHandler:addKeyword({ "oswald" }, StdModule.say, { npcHandler = npcHandler, text = "If there wouldn't be higher powers to protect him..." })
keywordHandler:addKeyword({ "quentin" }, StdModule.say, { npcHandler = npcHandler, text = "A humble monk and a wise man." })
keywordHandler:addKeyword({ "sam" }, StdModule.say, { npcHandler = npcHandler, text = "Strong man. But a little shy." })

npcHandler:setMessage(MESSAGE_GREET, "Welcome to the paladins' guild, |PLAYERNAME|! How can I help you?")
npcHandler:setMessage(MESSAGE_FAREWELL, "Bye, |PLAYERNAME|.")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Bye, |PLAYERNAME|.")

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

npcConfig.shop = {
	{clientId = 10297, sell = 50, itemName = "antlers"},
	{clientId = 10281, buy = 1000, sell = 240, itemName = "tarantula egg"},
	{clientId = 11489, buy = 3000, sell = 1800, itemName = "mantassin tail"},
	{clientId = 40529, buy = 7500, sell = 3000, itemName = "gold-brocaded cloth"},
	{clientId = 9633, buy = 8000, sell = 2400, itemName = "bloody pincers"},
	{clientId = 9636, buy = 10000, sell = 3000, itemName = "fiery heart"},
	{clientId = 5920, buy = 6000, sell = 1800, itemName = "green dragon scale"},
	{clientId = 5954, buy = 10000, sell = 3000, itemName = "demon horn"},
	{clientId = 9686, buy = 1000, sell = 300, itemName = "swamp grass"},
	{clientId = 9640, buy = 2000, sell = 600, itemName = "poisonous slime"},
	{clientId = 21194, buy = 8000, sell = 2400, itemName = "slime heart"},
	{clientId = 9661, buy = 6000, sell = 1800, itemName = "frosty heart"},
	{clientId = 21801, buy = 3000, sell = 900, itemName = "seacrest hair"},
	{clientId = 9650, buy = 8000, sell = 2400, itemName = "polar bear paw"},
	{clientId = 21975, buy = 10000, sell = 3000, itemName = "peacock feather fan"},
	{clientId = 11484, buy = 2000, sell = 600, itemName = "pile of grave earth"},
	{clientId = 9647, buy = 4000, sell = 1200, itemName = "demonic skeletal hand"},
	{clientId = 10420, buy = 10000, sell = 3000, itemName = "petrified scream"},
	{clientId = 9685, buy = 3000, sell = 900, itemName = "vampire teeth"},
	{clientId = 9663, buy = 10000, sell = 3000, itemName = "piece of dead brain"},
	{clientId = 11444, buy = 6000, sell = 1800, itemName = "protective charm"},
	{clientId = 11466, buy = 4000, sell = 1200, itemName = "flask of embalming fluid"},
	{clientId = 22007, buy = 6000, sell = 1800, itemName = "gloom wolf fur"},
	{clientId = 9660, buy = 10000, sell = 3000, itemName = "mystical hourglass"},
	{clientId = 17823, buy = 2000, sell = 700, itemName = "piece of swampling wood"},
	{clientId = 11702, buy = 8000, sell = 2400, itemName = "brimstone fangs"},
	{clientId = 9694, buy = 10000, sell = 3000, itemName = "snake skin"},
	{clientId = 5877, buy = 6000, sell = 1800, itemName = "green dragon leather"},
	{clientId = 16131, buy = 10000, sell = 3000, itemName = "blazing bones"},
	{clientId = 11658, buy = 9000, sell = 2500, itemName = "draken sulphur"},
	{clientId = 10295, buy = 4000, sell = 1200, itemName = "winter wolf fur"},
	{clientId = 10307, buy = 6000, sell = 1800, itemName = "thick fur"},
	{clientId = 14012, buy = 10000, sell = 3000, itemName = "deepling warts"},
	{clientId = 9644, buy = 5000, sell = 1500, itemName = "wyvern talisman"},
	{clientId = 14079, buy = 6000, sell = 1800, itemName = "crawler head plating"},
	{clientId = 9665, buy = 8000, sell = 2400, itemName = "wyrm scales"},
	{clientId = 9639, buy = 4000, sell = 1200, itemName = "cultish robe"},
	{clientId = 9638, buy = 5000, sell = 1500, itemName = "cultish mask"},
	{clientId = 10304, buy = 6000, sell = 1800, itemName = "hellspawn tail"},
	{clientId = 22053, buy = 4000, sell = 1200, itemName = "wereboar hooves"},
	{clientId = 23507, buy = 8000, sell = 2400, itemName = "crystallized anger"},
	{clientId = 28567, buy = 10000, sell = 3000, itemName = "quill"},
	{clientId = 17458, buy = 3000, sell = 900, itemName = "damselfly wing"},
	{clientId = 10302, buy = 2000, sell = 600, itemName = "compass"},
	{clientId = 14081, buy = 6000, sell = 1800, itemName = "waspoid wing"},
	{clientId = 25694, buy = 3000, sell = 900, itemName = "fairy wings"},
	{clientId = 11492, buy = 6000, sell = 1800, itemName = "rope belt"},
	{clientId = 20200, buy = 10000, sell = 3000, itemName = "silencer claws"},
	{clientId = 22730, buy = 10000, sell = 3000, itemName = "some grimeleech wings"},
	{clientId = 25702, buy = 6000, sell = 1800, itemName = "little bowl of myrrh"},
	{clientId = 20205, buy = 10000, sell = 3000, itemName = "goosebump leather"},
	{clientId = 10196, buy = 5000, sell = 1500, itemName = "orc tooth"},
	{clientId = 11447, buy = 5000, sell = 1500, itemName = "battle stone"},
	{clientId = 21200, buy = 12000, sell = 4000, itemName = "moohtant horn"},
	{clientId = 9691, buy = 2500, sell = 700, itemName = "lion's mane"},
	{clientId = 21202, buy = 4000, sell = 1200, itemName = "mooh'tah shells"},
	{clientId = 9654, buy = 10000, sell = 3000, itemName = "war crystal"},
	{clientId = 9657, buy = 2000, sell = 600, itemName = "cyclops toe"},
	{clientId = 22189, buy = 8000, sell = 2400, itemName = "ogre nose ring"},
	{clientId = 10405, buy = 8000, sell = 2400, itemName = "warmaster's wristuard"},
	{clientId = 11464, buy = 2000, sell = 600, itemName = "elven scouting glass"},
	{clientId = 18994, buy = 6000, sell = 1800, itemName = "elven hoof"},
	{clientId = 10298, buy = 10000, sell = 3000, itemName = "metal spike"},
	{clientId = 9641, buy = 2000, sell = 600, itemName = "piece of scarab shell"},
	{clientId = 11703, buy = 5000, sell = 1500, itemName = "brimstone shell"},
	{clientId = 20199, buy = 8000, sell = 2400, itemName = "frazzle skin"},
	{clientId = 9635, buy = 2000, sell = 600, itemName = "elvish talisman"},
	{clientId = 11452, buy = 8000, sell = 2400, itemName = "broken shamanic staff"},
	{clientId = 10309, buy = 10000, sell = 3000, itemName = "strand of medusa hair"},
	{clientId = 10272, sell = 35, itemName = "crab pincers"},
	{clientId = 12316, sell = 550, itemName = "cavebear skull"},
	{clientId = 17818, sell = 150, itemName = "cheesy figurine"},
	{clientId = 11514, sell = 110, itemName = "colourful feather"},
	{clientId = 7398, sell = 1000, buy = 10000, itemName = "cyclops trophy"},
	{clientId = 10398, sell = 110000, buy = 150000, itemName = "draken trophy"},
	{clientId = 12309, sell = 800, itemName = "draptor scales"},
	{clientId = 9648, sell = 30, itemName = "frosty ear of a troll"},
	{clientId = 12317, sell = 950, itemName = "giant crab pincer"},
	{clientId = 11539, sell = 20, itemName = "goblin ear"},
	{clientId = 12314, sell = 400, itemName = "hollow stampor hoof"},
	{clientId = 10282, sell = 600, itemName = "hydra head"},
	{clientId = 10455, sell = 80, itemName = "lancer beetle shell"},
	{clientId = 10419, sell = 8000, buy = 80000, itemName = "lizard trophy"},
	{clientId = 11489, sell = 280, itemName = "mantassin tail"},
	{clientId = 17461, sell = 65, itemName = "marsh stalker beak"},
	{clientId = 17462, sell = 50, itemName = "marsh stalker feather"},
	{clientId = 12315, sell = 250, itemName = "maxilla"},
	{clientId = 7401, sell = 1000, buy = 10000, itemName = "minotaur trophy"},
	{clientId = 9662, sell = 420, itemName = "mutated bat ear"},
	{clientId = 12039, sell = 750, itemName = "panther head"},
	{clientId = 12040, sell = 300, itemName = "panther paw"},
	{clientId = 11491, sell = 1000, itemName = "quara bone"},
	{clientId = 11491, sell = 350, itemName = "quara eye"},
	{clientId = 11490, sell = 410, itemName = "quara pincers"},
	{clientId = 11487, sell = 140, itemName = "quara tentacle"},
	{clientId = 12172, sell = 50, itemName = "rabbit's foot"},
	{clientId = 23508, buy = 20000, sell = 270, itemName = "energy vein"},
	{clientId = 18993, buy = 3000, sell = 70, itemName = "rorc feather"},
	{clientId = 10311, buy = 10000, sell = 400, itemName = "sabretooth"},
	{clientId = 22728, buy = 10000, sell = 1100, itemName = "vexclaw talon"},
	{clientId = 10456, sell = 20, itemName = "sandcrawler shell"},
	{clientId = 9631, sell = 280, itemName = "scarab pincers"},
	{clientId = 12312, sell = 280, itemName = "stampor horn"},
	{clientId = 12313, sell = 150, itemName = "stampor talons"},
	{clientId = 10454, sell = 60, itemName = "terramite legs"},
	{clientId = 10452, sell = 170, itemName = "terramite shell"},
	{clientId = 10273, sell = 95, itemName = "terrorbird beak"},
	{clientId = 5907, buy = 40000, sell = 18000, itemName = "slingshot"},
	{clientId = 12547, buy = 50000, sell = 15000, itemName = "diapason"},
	{clientId = 12550, buy = 50000, sell = 16500, itemName = "golden fir cone"},
	{clientId = 12548, buy = 5000, sell = 800, itemName = "bag of apple slices"},
	{clientId = 12802, buy = 200, sell = 50, itemName = "sugar oat"},
	{clientId = 12308, buy = 90000, sell = 35000, itemName = "reins"},
	{clientId = 10244, sell = 6000, buy = 60000, itemName = "bonebeast trophy"},
	{clientId = 7397, sell = 3000, buy = 30000, itemName = "deer trophy"},
	{clientId = 7400, sell = 3000, buy = 30000, itemName = "lion trophy"},
	{clientId = 7395, sell = 1000, buy = 10000, itemName = "orc trophy"},
	{clientId = 7394, sell = 3000, buy = 30000, itemName = "wolf trophy"},
	{clientId = 7396, sell = 20000, buy = 200000, itemName = "behemoth trophy"},
	{clientId = 7393, sell = 40000, buy = 400000, itemName = "demon trophy"},
	{clientId = 7399, sell = 10000, buy = 100000, itemName = "dragon lord trophy"},
	{clientId = 10421, sell = 3000, buy = 30000, itemName = "disgusting trophy"},
	{clientId = 22101, sell = 9000, buy = 90000, itemName = "werebadger trophy"},
	{clientId = 22102, sell = 10000, buy = 100000, itemName = "wereboar trophy"},
	{clientId = 22103, sell = 11000, buy = 110000, itemName = "werebear trophy"},
	{clientId = 27706, sell = 9000, buy = 90000, itemName = "werefox trophy"},
	{clientId = 34219, sell = 12000, buy = 120000, itemName = "werehyaena trophy"},
	{clientId = 9601, buy = 1000, itemName = "demon backpack"},
	{clientId = 14249, buy = 800, itemName = "buggy backpack"},
	{clientId = 20347, buy = 100, itemName = "cake backpack"},
	{clientId = 28571, buy = 10000, itemName = "book backpack"},
	{clientId = 9605, buy = 800, itemName = "crown backpack"},
	{clientId = 16099, buy = 800, itemName = "mushroom backpack"},
	{clientId = 16100, buy = 800, itemName = "crystal backpack"},
	{clientId = 14248, buy = 800, itemName = "deepling backpack"},
	{clientId = 10326, buy = 200, itemName = "dragon backpack"},
	{clientId = 10324, buy = 100, itemName = "expedition backpack"},
	{clientId = 3253, buy = 30000, itemName = "backpack of holding"},
	{clientId = 23525, buy = 10000, itemName = "energetic backpack"},
	{clientId = 32620, buy = 300000, itemName = "ghost backpack"},
	{clientId = 5801, buy = 10000, itemName = "jeweled backpack"},
	{clientId = 39754, buy = 50000, itemName = "lilypad backpack"},
	{clientId = 10327, buy = 200, itemName = "minotaur backpack"},
	{clientId = 9604, buy = 10000, itemName = "moon backpack"},
	{clientId = 19159, buy = 800, itemName = "panier backpack"},
	{clientId = 24393, buy = 30000, itemName = "pillow backpack"},
	{clientId = 5926, buy = 1000, itemName = "pirate backpack"},
	{clientId = 35577, buy = 800, itemName = "racoon backpack"},
	{clientId = 31625, buy = 30000, itemName = "winged backpack"},
	{clientId = 22084, buy = 800, itemName = "wolf backpack"},	
	--{clientId = 21445, buy = 500000, itemName = "war backpack"},
	{clientId = 10346, buy = 3000, itemName = "santa backpack"},
	{ itemName = "sniper gloves", clientId = 5875, sell = 2000 }	
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

npcType:register(npcConfig)
