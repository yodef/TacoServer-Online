local tcScroll = Action()

function tcScroll.onUse(player, item, fromPosition, target, toPosition, isHotkey)
		db.query("UPDATE `accounts` SET `coins_transferable` = `coins_transferable` + " .. 10000 .. " WHERE `id` = " .. player:getAccountId() .. ";")
		player:sendCancelMessage("Scroll was used: +10,000 Tibia Coins.")
		item:remove()
		player:getPosition():sendMagicEffect(CONST_ME_HEARTS)
	return true
end

tcScroll:id(14758)
tcScroll:register()
