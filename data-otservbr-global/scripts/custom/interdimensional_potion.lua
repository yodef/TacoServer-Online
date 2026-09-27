local buffPotions = Action()

function buffPotions.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	local cooldown = 1 * 60 * 60 -- 1 HOUR (3600 seconds)
	local currentTime = os.time()
	local expiresAt = player:getStorageValue(20002)

	if expiresAt and expiresAt > currentTime then
		local remaining = expiresAt - currentTime
		local mins = math.floor(remaining / 60)
		local secs = remaining % 60
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, string.format("You still have an active Interdimensional Potion buff. Remaining cooldown: %d min %d sec.", mins, secs))
		player:getPosition():sendMagicEffect(CONST_ME_POFF)
		return true
	end

	player:setStorageValue(20002, currentTime + cooldown)
	player:setStorageValue(20001, 20) -- 20% buff

	-- Preserve quest completion for Wrath of the Emperor mission 9
	if Storage and Storage.Quest and Storage.Quest.U8_6 and Storage.Quest.U8_6.WrathOfTheEmperor and Storage.Quest.U8_6.WrathOfTheEmperor.InterdimensionalPotion then
		player:setStorageValue(Storage.Quest.U8_6.WrathOfTheEmperor.InterdimensionalPotion, 1)
	end

	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Your recovery potions have been buffed for 1 hour! All potions will recover +20% HP and MP.")
	player:say("Gulp!", TALKTYPE_MONSTER_SAY)
	player:getPosition():sendMagicEffect(CONST_ME_MAGIC_GREEN)
	item:remove(1)
	return true
end

buffPotions:id(11372)
buffPotions:register()
