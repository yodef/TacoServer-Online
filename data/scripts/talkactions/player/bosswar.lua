local bWPts = TalkAction("!bosswar")

function bWPts.onSay(player, words, param)
local bossWarPts = player:getStorageValue(15052)
	--SET DIFFICULTY LEVEL
	if param == "easy" then
	player:say("Boss War Arena difficulty level set to: EASY", TALKTYPE_MONSTER_SAY)
	player:setStorageValue(15054, 0)
	elseif param == "medium" then
	player:say("Boss War Arena difficulty level set to: MEDIUM", TALKTYPE_MONSTER_SAY)
	player:setStorageValue(15054, 1)	
	elseif param == "hard" then
	player:say("Boss War Arena difficulty level set to: HARD", TALKTYPE_MONSTER_SAY)	
	player:setStorageValue(15054, 2)	
	elseif param == "inferno" then
	player:say("Boss War Arena difficulty level set to: INFERNO", TALKTYPE_MONSTER_SAY)
	player:setStorageValue(15054, 3)	
	elseif param == "nightmare" then
	player:say("Boss War Arena difficulty level set to: NIGHTMARE", TALKTYPE_MONSTER_SAY)
	player:setStorageValue(15054, 4)
	elseif param == "deathmatch" then
	player:say("Boss War Arena mode set to: DEATHMATCH", TALKTYPE_MONSTER_SAY)
	player:setStorageValue(15054, 5)
	--CHECK POINTS
	elseif param == "points" then		
		if bossWarPts >= 300 then
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, string.format("You have ".. bossWarPts .." Boss War points. You can now receive surprise cubes from the chest!"))
		elseif bossWarPts >= 1 then
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, string.format("You have ".. bossWarPts .." Boss War points."))	
		else
			player:getPosition():sendMagicEffect(CONST_ME_POFF)
			player:sendCancelMessage(string.format("You do not have Boss War points. Go to the Arena and fight some Bosses to earn points. You can change the arena difficulty, check command '!bosswar'."))
		end
	elseif param == "levels" then
	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, string.format("EASY: Fight 4 minor bosses, each one will spawn every 2 minutes. Cost: 5 platinum tokens.\n"..
	"MEDIUM: Fight 3 minor bosses, each one will spawn every 2 minutes and at minute 5 a major boss will spawn. Cost: 10 platinum tokens.\n"..
	"HARD:Fight 2 waves, the first with 2 minor bosses and after 3 minutes, the second with 2 minor and 1 major bosses. Cost: 20 platinum tokens.\n"..
	"INFERNO: Fight 3 minor and 2 major bosses at once. Cost: 25 platinum tokens.\n".. 
	"NIGHTMARE: Fight 4 minor and 3 major bosses at once. Cost: 30 platinum tokens.\n"..
	"DEATHMATCH Mode: Fight minor bosses every 2 minutes and only 1 major boss at minute 5. Cost: 20 platinum tokens."
	))
	else
	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, string.format(
		"How to use BOSS WAR COMMAND?\n"..
		"- Check your Boss War points: '!bosswar points'.\n"..
		"- Check available difficulty levels: '!bosswar levels'.\n"..
		"- Change difficulty level: Easy is set by default. Examples: '!bosswar medium', '!bosswar hard', etc..." 		
		))
	end
	

	return true
end

bWPts:separator(" ")
bWPts:groupType("normal")
bWPts:register()
