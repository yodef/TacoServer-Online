local potOfBlackjack = Action()

function potOfBlackjack.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if player:hasExhaustion("special-foods-cooldown") then
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You need to wait before using it again.")
		return true
	end

	local remainingGulps = player:kv():get("pot-of-blackjack") or math.random(2, 4)
	remainingGulps = remainingGulps - 1

	if remainingGulps > 0 then
		player:kv():set("pot-of-blackjack", remainingGulps)
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You take a gulp from the large bowl, but there's still some blackjack in it.")
	else
		player:kv():remove("pot-of-blackjack")
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You take the last gulp from the large bowl. No leftovers!")
		item:remove(1)
	end

	player:addHealth(5000)
	player:say("Gulp.", TALKTYPE_MONSTER_SAY)
	player:getPosition():sendMagicEffect(CONST_ME_MAGIC_RED)
	player:setExhaustion("special-foods-cooldown", 10 * 60)
	return true
end

potOfBlackjack:id(11586)
potOfBlackjack:register()
