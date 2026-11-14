local secretPlaces = {
	{
		actionIds = { 25002, 24894 },
		pos = Position(33135, 32652, 7),
		storage = Storage.Quest.U11_02.TheFirstDragon.DesertTile,
		msg = "You enter the beautiful oasis. By visiting this sacred site you're infused with the power of water bringing life to the desert.",
	},
	{
		actionIds = { 25003, 24895 },
		pos = Position(32348, 31691, 7),
		storage = Storage.Quest.U11_02.TheFirstDragon.StoneSculptureTile,
		msg = "You enter the circle of trees and flowers. By visiting this sacred site you're infused with the power of nature and plants.",
	},
	{
		actionIds = { 25004, 24896 },
		pos = Position(32692, 31724, 7),
		storage = Storage.Quest.U11_02.TheFirstDragon.SuntowerTile,
		msg = "You entered the suntower of Ab'dendriel. By visiting this sacred site you're infused with the power of the life-giving sun.",
	},
}

local zorvoraxSecrets = MoveEvent()

function zorvoraxSecrets.onStepIn(creature, item, position, fromPosition)
	local player = creature:getPlayer()
	if not player then
		return true
	end

	local setting = nil
	for _, entry in ipairs(secretPlaces) do
		if item then
			for _, aid in ipairs(entry.actionIds) do
				if item.actionid == aid or item.uid == aid then
					setting = entry
					break
				end
			end
		end
		if not setting and position == entry.pos then
			setting = entry
		end
		if setting then
			break
		end
	end

	if not setting then
		return true
	end

	if player:getStorageValue(setting.storage) < 1 then
		player:setStorageValue(setting.storage, 1)

		-- Recalculate SecretsCounter directly from the 3 site storages
		local count = 0
		for _, entry in ipairs(secretPlaces) do
			if player:getStorageValue(entry.storage) >= 1 then
				count = count + 1
			end
		end
		player:setStorageValue(Storage.Quest.U11_02.TheFirstDragon.SecretsCounter, count)
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, setting.msg .. string.format(" (%d/3 sites visited)", count))
		position:sendMagicEffect(CONST_ME_MAGIC_BLUE)
	end

	return true
end

for _, entry in ipairs(secretPlaces) do
	for _, aid in ipairs(entry.actionIds) do
		zorvoraxSecrets:aid(aid)
	end
	zorvoraxSecrets:position(entry.pos)
end

zorvoraxSecrets:register()
