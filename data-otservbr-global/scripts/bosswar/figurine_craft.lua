local config = {
	-- Window Config
	mainTitleMsg = "Opticorder Forge",
	mainMsg = "Please choose an action to perform:",

	craftTitle = "Recipes: ",
	craftMsg = "Here is the list of items you can craft for ",
	needItems = "You do not have all the required items to craft a ",

	-- Crafting Config
	system = {
		[1] = {
			vocation = "Recycle",
			items = {
				[1] = {
					item = "Managem Crystal",
					itemID = 29287,
					reqItems = {
						[1] = { item = 23491, count = 3 }, -- manalight figurine
						[2] = { item = 22723, count = 50 }, -- Platinum token
					},
				},
				[2] = {
					item = "Spirit Crystal",
					itemID = 29289,
					reqItems = {
						[1] = { item = 23489, count = 3 }, -- brightlight figurine
						[2] = { item = 22723, count = 50 }, -- Platinum token
					},
				},
				[3] = {
					item = "Shining Crystal",
					itemID = 29288,
					reqItems = {
						[1] = { item = 23490, count = 3 }, -- gemlight figurine
						[2] = { item = 22723, count = 50 }, -- Platinum token
					},
				},
				[4] = {
					item = "Bloody Crystal",
					itemID = 24964,
					reqItems = {
						[1] = { item = 23493, count = 3 }, -- bloodlight figurine
						[2] = { item = 22723, count = 50 }, -- Platinum token
					},
				},
				[5] = {
					item = "Void Crystal",
					itemID = 39037,
					reqItems = {
						[1] = { item = 23492, count = 3 }, -- blacklight figurine
						[2] = { item = 22723, count = 50 }, -- Platinum token
					},
				},
			},
		},
		[2] = {
			vocation = "Refine",
			items = {
				[1] = {
					item = "Rainbow Crystal",
					itemID = 39036,
					reqItems = {
						[1] = { item = 22723, count = 100 }, -- Platinum token
						[2] = { item = 39037, count = 1 }, -- Void crystal (cobalt ridge)
						[3] = { item = 29288, count = 1 }, -- Shining crystal (green crystal)
						[4] = { item = 24964, count = 1 }, -- Bloody crystal (imbuing crystal)
						[5] = { item = 29289, count = 1 }, -- Spirit crystal (violet crystal)
						[6] = { item = 29287, count = 1 }, -- Managem crystal (blue crystal)
					},
				},
			},
		},
	},
}

-- Main Crafting Window
function Player.sendMainCraftWindow(self, conf)
	local window = ModalWindow {
		title = conf.mainTitleMsg,
		message = conf.mainMsg .. "\n\n",
	}

	local function buttonCallback(player, button, choice)
		local btnName = button.name or button.text
		if btnName == "Select" then
			if not choice or not choice.id or choice.id == 0 or choice.id > #conf.system then
				player:sendTextMessage(MESSAGE_STATUS_SMALL, "Please choose an action first.")
				player:sendMainCraftWindow(conf)
				return true
			end
			player:sendVocCraftWindow(conf, choice.id)
		end
		return true
	end

	window:addButton("Select", buttonCallback)
	window:addButton("Exit")

	for i = 1, #conf.system do
		window:addChoice(conf.system[i].vocation)
	end

	window:setDefaultEnterButton("Select")
	window:setDefaultEscapeButton("Exit")
	window:sendToPlayer(self)
end

-- Sub Crafting Window (Recycle / Refine)
function Player.sendVocCraftWindow(self, conf, lastChoice)
	local category = conf.system[lastChoice]
	if not category then
		return false
	end

	local window = ModalWindow {
		title = conf.craftTitle .. category.vocation,
		message = conf.craftMsg .. category.vocation .. ":\nSelect an item to view requirements or craft.\n\n",
	}

	local function buttonCallback(player, button, choice)
		local btnName = button.name or button.text
		if btnName == "Back" then
			player:sendMainCraftWindow(conf)
			return true
		end

		if not choice or not choice.id or choice.id == 0 or choice.id > #category.items then
			if btnName == "Craft" or btnName == "Details" then
				player:sendTextMessage(MESSAGE_STATUS_SMALL, "Please select an item from the list.")
				player:sendVocCraftWindow(conf, lastChoice)
			end
			return true
		end

		local itemData = category.items[choice.id]

		if btnName == "Details" then
			player:sendCraftDetailsWindow(conf, lastChoice, choice.id)
			return true
		end

		if btnName == "Craft" then
			-- Verify all required items
			for i = 1, #itemData.reqItems do
				local reqId = itemData.reqItems[i].item
				local reqCount = itemData.reqItems[i].count
				if player:getItemCount(reqId) < reqCount then
					player:sendTextMessage(MESSAGE_EVENT_ADVANCE, conf.needItems .. itemData.item .. ".")
					player:sendVocCraftWindow(conf, lastChoice)
					return false
				end
			end

			-- Remove required items
			for i = 1, #itemData.reqItems do
				local reqId = itemData.reqItems[i].item
				local reqCount = itemData.reqItems[i].count
				player:removeItem(reqId, reqCount)
			end

			-- Add crafted item
			player:addItem(itemData.itemID, 1)
			player:getPosition():sendMagicEffect(CONST_ME_FIREATTACK)
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You have successfully crafted a " .. itemData.item .. "!")
			player:sendVocCraftWindow(conf, lastChoice)
			return true
		end

		return true
	end

	window:addButton("Back", buttonCallback)
	window:addButton("Exit")
	window:addButton("Details", buttonCallback)
	window:addButton("Craft", buttonCallback)

	window:setDefaultEnterButton("Craft")
	window:setDefaultEscapeButton("Exit")

	for i = 1, #category.items do
		window:addChoice(category.items[i].item)
	end

	window:sendToPlayer(self)
end

-- Details Window for specific recipe
function Player.sendCraftDetailsWindow(self, conf, lastChoice, itemIndex)
	local category = conf.system[lastChoice]
	if not category then
		return false
	end

	local itemData = category.items[itemIndex]
	if not itemData then
		return false
	end

	local details = "Requirements to craft " .. itemData.item .. ":\n\n"
	local canCraft = true
	for i = 1, #itemData.reqItems do
		local reqId = itemData.reqItems[i].item
		local reqCount = itemData.reqItems[i].count
		local reqOnPlayer = self:getItemCount(reqId)
		local itemName = ItemType(reqId):getName()
		local status = (reqOnPlayer >= reqCount) and "[OK]" or "[MISSING]"
		if reqOnPlayer < reqCount then
			canCraft = false
		end
		details = details .. string.format("- %s: %d/%d %s\n", itemName, reqOnPlayer, reqCount, status)
	end

	if canCraft then
		details = details .. "\nYou have all the required items!"
	else
		details = details .. "\nYou are missing some required items."
	end

	local window = ModalWindow {
		title = itemData.item .. " (Recipe)",
		message = details,
	}

	local function buttonCallback(player, button, choice)
		local btnName = button.name or button.text
		if btnName == "Craft" then
			if not canCraft then
				player:sendTextMessage(MESSAGE_EVENT_ADVANCE, conf.needItems .. itemData.item .. ".")
				player:sendCraftDetailsWindow(conf, lastChoice, itemIndex)
				return true
			end

			-- Remove required items
			for i = 1, #itemData.reqItems do
				local reqId = itemData.reqItems[i].item
				local reqCount = itemData.reqItems[i].count
				player:removeItem(reqId, reqCount)
			end

			-- Add crafted item
			player:addItem(itemData.itemID, 1)
			player:getPosition():sendMagicEffect(CONST_ME_FIREATTACK)
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You have successfully crafted a " .. itemData.item .. "!")
			player:sendVocCraftWindow(conf, lastChoice)
			return true
		elseif btnName == "Back" then
			player:sendVocCraftWindow(conf, lastChoice)
			return true
		end
		return true
	end

	window:addButton("Back", buttonCallback)
	window:addButton("Exit")
	window:addButton("Craft", buttonCallback)

	if canCraft then
		window:setDefaultEnterButton("Craft")
	else
		window:setDefaultEnterButton("Back")
	end
	window:setDefaultEscapeButton("Exit")

	window:sendToPlayer(self)
end

local simpleCraftingSystem = Action()
function simpleCraftingSystem.onUse(player, item, fromPosition, itemEx, toPosition, isHotkey)
	player:sendMainCraftWindow(config)
	return true
end

simpleCraftingSystem:id(19388, 19389)
simpleCraftingSystem:register()
