local config = {
	[24939] = { name = "scale of Gelidrazah", storage = Storage.Quest.U11_02.TheFirstDragon.Scale },
	[24940] = { name = "tooth of Tazhadur", storage = Storage.Quest.U11_02.TheFirstDragon.Tooth },
	[24941] = { name = "horn of Kalyassa", storage = Storage.Quest.U11_02.TheFirstDragon.Horn },
	[24942] = { name = "bones of Zorvorax", storage = Storage.Quest.U11_02.TheFirstDragon.Bones },
}

local sacrificeItems = Action()

local function isLavaAltar(pos, target)
	if not pos then return false end
	-- Lava pool / altar range at First Dragon shrine
	if pos.z == 3 and pos.y == 32712 and pos.x >= 33044 and pos.x <= 33050 then
		return true
	end
	if target and target:isItem() then
		local tid = target:getId()
		if tid >= 25156 and tid <= 25163 then
			return true
		end
	end
	return false
end

function sacrificeItems.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	local setting = config[item.itemid]
	if not setting then
		return false
	end

	if not isLavaAltar(toPosition, target) then
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You must plunge this draconic relic into the sacred lava pool.")
		return true
	end

	if player:getStorageValue(setting.storage) >= 1 then
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You already sacrificed this relic to the lava pool.")
		return true
	end

	-- Mark this relic as sacrificed
	player:setStorageValue(setting.storage, 1)
	item:remove(1)

	-- Recalculate total sacrifices directly from the 4 storages
	local count = 0
	for _, relic in pairs(config) do
		if player:getStorageValue(relic.storage) >= 1 then
			count = count + 1
		end
	end
	player:setStorageValue(Storage.Quest.U11_02.TheFirstDragon.AccessCave, count)

	toPosition:sendMagicEffect(CONST_ME_FIREAREA)

	if count >= 4 then
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You plunge the " .. setting.name .. " into the bubbling lava. All four draconic relics have been accepted! You are now worthy to enter The First Dragon's Lair. Step into or touch the lava pool.")
	else
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You plunge the " .. setting.name .. " into the bubbling lava. (" .. count .. "/4 relics sacrificed)")
	end

	return true
end

for itemId in pairs(config) do
	sacrificeItems:id(itemId)
end

sacrificeItems:register()
