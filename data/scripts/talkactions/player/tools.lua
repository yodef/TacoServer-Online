local tools = TalkAction("!tools")

function tools.onSay(player, words, param)

	local totalCost = 250
	if player:removeMoneyBank(totalCost) then
		player:getPosition():sendMagicEffect(CONST_ME_MAGIC_BLUE)
		player:addItem(3457, 1)--shovel
		player:addItem(3456, 1)--pick
		player:addItem(3453, 1)--scythe
		player:addItem(3308, 1)--machete
		player:addItem(3003, 1)--rope
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, string.format("You have bought a set of most common tools.", totalCost))
	else
		player:getPosition():sendMagicEffect(CONST_ME_POFF)
		player:sendCancelMessage(string.format("You do not have enough money. You need %i gold to buy these tools!", totalCost))
	end
	return true
end

tools:separator(" ")
tools:groupType("normal")
tools:register()
