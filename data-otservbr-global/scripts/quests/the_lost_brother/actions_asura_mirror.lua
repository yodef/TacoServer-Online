local theLostAsura = Action()
function theLostAsura.onUse(player, item, fromPosition, itemEx, toPosition)
	player:teleportTo({ x = 32812, y = 32753, z = 9 }) -- Where to tp to 33672, 31884, 5
	player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
	return true
end

theLostAsura:aid(12441)
theLostAsura:register()
