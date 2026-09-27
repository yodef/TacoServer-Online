local tcScroll = Action()

function tcScroll.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	local count = 1000
	player:addTransferableCoins(count)
	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You have added " .. count .. " tibia coins to your balance. Your total is now " .. player:getTransferableCoins() .. ".")
	player:getPosition():sendMagicEffect(CONST_ME_HEARTS)
	item:remove(1)
	return true
end

tcScroll:id(14758)
tcScroll:register()