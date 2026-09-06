local tools = TalkAction("!protools")

function tools.onSay(player, words, param)

	local totalCost = 50000
	if player:removeMoneyBank(totalCost) then
		player:getPosition():sendMagicEffect(CONST_ME_MAGIC_BLUE)
		player:addItem(5710, 1)--light shovel
		player:addItem(646, 1)--elvenhair rope
		player:addItem(5908, 1)--obsidian knife
		player:addItem(5942, 1)--blessed wooden stake
		player:addItem(32711, 1)--managem pick
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, string.format("You have bought a set of the finest tools.", totalCost))
	else
		player:getPosition():sendMagicEffect(CONST_ME_POFF)
		player:sendCancelMessage(string.format("You do not have enough money. You need %i gold to buy these tools!", totalCost))
	end
	return true
end

tools:separator(" ")
tools:groupType("normal")
tools:register()
