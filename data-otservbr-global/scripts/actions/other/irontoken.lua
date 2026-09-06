local ironToken = Action()

function ironToken.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if player:getItemCount(22720) >= 100 then
		player:removeItem(22720, 100)
		player:addItem(22722, 10)
		player:getPosition():sendMagicEffect(CONST_ME_POFF)
	else
		player:sendTextMessage(MESSAGE_FAILURE, "You need 100 iron tokens to create 10 copper tokens.")
	end
	return true
end

ironToken:id(22720)
ironToken:register()
