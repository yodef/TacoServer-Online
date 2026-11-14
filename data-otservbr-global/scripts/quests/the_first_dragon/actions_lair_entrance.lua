local lairEntrance = Action()

function lairEntrance.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	local access = player:getStorageValue(Storage.Quest.U11_02.TheFirstDragon.AccessCave)
	if access < 4 then
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You are not worthy to enter The First Dragon's Lair yet. You must sacrifice all four dragon relics at the lava pool.")
		return true
	end

	local pos = item:getPosition()
	if pos == Position(33047, 32712, 3) or (pos.z == 3 and pos.y == 32712 and pos.x >= 33044 and pos.x <= 33050) then
		player:teleportTo(Position(31994, 32391, 9))
		player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
		return true
	elseif pos.z == 9 and pos.x >= 31990 and pos.x <= 31996 and pos.y >= 32388 and pos.y <= 32393 then
		player:teleportTo(Position(33047, 32713, 3))
		player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
		return true
	end
	return false
end

lairEntrance:id(25160)
lairEntrance:register()

-- MoveEvent to also allow entering/leaving by stepping on the pool / portal
local lairEntranceMove = MoveEvent()
function lairEntranceMove.onStepIn(creature, item, position, fromPosition)
	local player = creature:getPlayer()
	if not player then
		return true
	end

	-- Center of lava altar (outside entrance)
	if position == Position(33047, 32712, 3) then
		local access = player:getStorageValue(Storage.Quest.U11_02.TheFirstDragon.AccessCave)
		if access >= 4 then
			player:teleportTo(Position(31994, 32391, 9))
			player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
		else
			player:teleportTo(fromPosition)
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You are not worthy to enter The First Dragon's Lair yet. You must sacrifice all four dragon relics at the lava pool.")
		end
		return true
	end

	-- Exit portal inside lair (Z=9)
	if position == Position(31994, 32390, 9) or position == Position(31993, 32390, 9) then
		player:teleportTo(Position(33047, 32713, 3))
		player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
		return true
	end

	return true
end

lairEntranceMove:position(Position(33047, 32712, 3))
lairEntranceMove:position(Position(31994, 32390, 9))
lairEntranceMove:position(Position(31993, 32390, 9))
lairEntranceMove:register()
