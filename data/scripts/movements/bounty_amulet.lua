if not TaskSystem or not TaskSystem.Config then
	if fileExists and fileExists(CORE_DIRECTORY .. "/scripts/lib/task_lib.lua") then
		dofile(CORE_DIRECTORY .. "/scripts/lib/task_lib.lua")
	elseif fileExists and fileExists("data/scripts/lib/task_lib.lua") then
		dofile("data/scripts/lib/task_lib.lua")
	end
end

local bountyAmuletEquip = MoveEvent()

function bountyAmuletEquip.onEquip(player, item, slot, isCheck)
	if not player or isCheck then
		return true
	end

	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You have equipped the Bounty Amulet. Its defensive wards will protect you against your current task targets.")
	player:getPosition():sendMagicEffect(CONST_ME_MAGIC_BLUE)

	-- Apply speed boost condition if upgraded
	if player.updateAmuletSpeedCondition then
		player:updateAmuletSpeedCondition()
	end
	return true
end

bountyAmuletEquip:type("equip")
bountyAmuletEquip:slot("necklace")
bountyAmuletEquip:id(31268)
bountyAmuletEquip:register()

local bountyAmuletDeEquip = MoveEvent()

function bountyAmuletDeEquip.onDeEquip(player, item, slot, isCheck)
	if not player or isCheck then
		return true
	end

	player:removeCondition(CONDITION_ATTRIBUTES, CONDITIONID_NECKLACE, 14030)
	return true
end

bountyAmuletDeEquip:type("deequip")
bountyAmuletDeEquip:slot("necklace")
bountyAmuletDeEquip:id(31268)
bountyAmuletDeEquip:register()
