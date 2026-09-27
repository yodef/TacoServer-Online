local bountyRingEquip = MoveEvent()

function bountyRingEquip.onEquip(player, item, slot, isCheck)
	if not player or isCheck then
		return true
	end

	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You have equipped the Bounty Ring. Its active upgrades will empower you against your current task targets.")
	player:getPosition():sendMagicEffect(CONST_ME_MAGIC_BLUE)
	return true
end

bountyRingEquip:type("equip")
bountyRingEquip:slot("ring")
bountyRingEquip:id(34080)
bountyRingEquip:register()

local bountyRingDeEquip = MoveEvent()

function bountyRingDeEquip.onDeEquip(player, item, slot, isCheck)
	if not player or isCheck then
		return true
	end
	return true
end

bountyRingDeEquip:type("deequip")
bountyRingDeEquip:slot("ring")
bountyRingDeEquip:id(34080)
bountyRingDeEquip:register()
