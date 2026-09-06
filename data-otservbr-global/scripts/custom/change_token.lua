local tokens = {
	[22722] = { changeTo = 22516 }, --copper to silver
	[22516] = { changeBack = 22722, changeTo = 22721 }, --silver to gold
	[22721] = { changeBack = 22516, changeTo = 22723 }, -- gold to platinum
	[22723] = { changeBack = 22721 }, -- platinum to gold
}

local changeTokens = Action()

function changeTokens.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	local coin = tokens[item:getId()]
	if coin.changeTo and item.type == 100 then
		item:remove()
		player:getPosition():sendMagicEffect(CONST_ME_FIREWORK_BLUE)
		player:addItem(coin.changeTo, 10)
	elseif coin.changeBack and item.type >= 10 then
		item:remove(10)
		player:getPosition():sendMagicEffect(CONST_ME_FIREWORK_BLUE)
		player:addItem(coin.changeBack, 100)
	else
		return false
	end
	return true
end

for index, value in pairs(tokens) do
	changeTokens:id(index)
end

changeTokens:register()
