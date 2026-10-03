local repack = TalkAction("!repack")

local LOCKER_IDS = {
	[2449] = true, [2450] = true, [2451] = true, [2452] = true,
	[3497] = true, [3498] = true, [3499] = true, [3500] = true,
}

local function findLockerOnTile(tile)
	if not tile then
		return nil
	end
	local items = tile:getItems()
	if not items then
		return nil
	end
	for _, item in ipairs(items) do
		if LOCKER_IDS[item:getId()] then
			return item
		end
	end
	return nil
end

function repack.onSay(player, words, param)
	local pPos = player:getPosition()

	-- 1. Check tile in front of player
	local forwardPos = Position(pPos.x, pPos.y, pPos.z)
	forwardPos:getNextPosition(player:getDirection())
	local locker = findLockerOnTile(Tile(forwardPos))

	-- 2. Check current tile under player
	if not locker then
		locker = findLockerOnTile(Tile(pPos))
	end

	-- 3. Check adjacent tiles (all 8 surrounding tiles)
	if not locker then
		for dx = -1, 1 do
			for dy = -1, 1 do
				if dx ~= 0 or dy ~= 0 then
					local adjTile = Tile(Position(pPos.x + dx, pPos.y + dy, pPos.z))
					locker = findLockerOnTile(adjTile)
					if locker then
						break
					end
				end
			end
			if locker then
				break
			end
		end
	end

	if not locker then
		player:sendCancelMessage("No depot locker found nearby to repack.")
		return false
	end

	local tile = locker:getTile()
	if not tile or not tile:getHouse() then
		player:sendCancelMessage("You can only repack a depot locker inside a house.")
		return false
	end

	local house = tile:getHouse()
	if house:getOwnerGuid() ~= player:getGuid() and not house:canEditAccessList(SUBOWNER_LIST, player) then
		player:sendCancelMessage("You do not have permission to repack furniture in this house.")
		return false
	end

	local pos = locker:getPosition()
	locker:transform(2791, 1)
	pos:sendMagicEffect(CONST_ME_POFF)
	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You have packed the depot locker back into a locker kit.")
	return false
end

repack:separator(" ")
repack:groupType("normal")
repack:register()
