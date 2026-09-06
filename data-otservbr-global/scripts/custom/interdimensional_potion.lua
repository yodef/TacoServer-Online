local buffPotions = Action()
function buffPotions.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	local cooldown = 1 * 60 * 60 -- 1 HOUR
    if player:getStorageValue(20002) > os.time() then -- Is player cooldown locked?
        local remainingCooldown = player:getStorageValue(20002) - os.time()
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You still have an active interdimensional potion. Duration: " .. os.date("!%X", remainingCooldown) .. "." )
        return true
    end

	player:setStorageValue(20002, os.time() + cooldown)
	player:setStorageValue(20001, 5) -- THIS WILL BE CALCULATED IN potions.lua AS +50%, local multiplier = (1 + (5 / 10)) equal to 1.5
	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Your recovery potions will be buffed during 1 hour. Every potion will recover +50% HP/MP.")
	player:getPosition():sendMagicEffect(CONST_ME_MAGIC_BLUE)
	item:remove()
	return true
end

buffPotions:id(11372)
buffPotions:register()
