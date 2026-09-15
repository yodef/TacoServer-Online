local blueSphere = Action()

local DUST_AMOUNT = 100

function blueSphere.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	local currentDust = player:getForgeDusts()
	local maxDust = player:getForgeDustLevel()

	if currentDust >= maxDust then
		player:sendCancelMessage("You cannot use this because you have already reached your maximum limit of " .. maxDust .. " dust for the Exaltation Forge.")
		player:getPosition():sendMagicEffect(CONST_ME_POFF)
		return true
	end

	item:remove(1)
	player:addForgeDusts(DUST_AMOUNT)
	player:getPosition():sendMagicEffect(CONST_ME_FIREWORK_BLUE)
	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, string.format("You used a blue sphere and received %d exalted dust for the Exaltation Forge. Current balance: %d dusts (limit: %d).", DUST_AMOUNT, player:getForgeDusts(), maxDust))
	return true
end

blueSphere:id(23541)
blueSphere:register()