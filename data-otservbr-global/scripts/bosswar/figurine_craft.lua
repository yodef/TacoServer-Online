local config = {
-- Window Config
	mainTitleMsg = "Opticorder Forge", -- Main window title
	mainMsg = "Please choose an action to do:", -- Main window message
 
	craftTitle = "Recipes: ", -- Title of the crafting screen after player picks of vocation
	craftMsg = "Here is the list of items you can get if you ", -- Message on the crafting screen after player picks of vocation
-- End Window Config
 
-- Player Notifications Config
	needItems = "You do not have all the required items to make a ", -- This is the message the player recieves if he does not have all required items
 
-- Crafting Config
	system = {
	[1] = {vocation = "Recycle", -- This is the category can be anything.
			items = {
				[1] = {item = "Managem Crystal", -- item name (THIS MUST BE EXACT OR IT WILL NOT WORK!)
						itemID = 29287, -- item to be made
						reqItems = { -- items and the amounts in order to craft.
								[1] = {item = 23491, count = 3}, -- manalight figurine
								[2] = {item = 22723, count = 50}, -- Platinum token
							},
						}, 
				[2] = {item = "Spirit Crystal",
						itemID = 29289,
						reqItems = {
								[1] = {item = 23489, count = 3}, -- Brightligh figurine
								[2] = {item = 22723, count = 50}, -- Platinum token
							},
						}, 
				[3] = {item = "Shining Crystal",
						itemID = 29288,
						reqItems = {
								[1] = {item = 23490, count = 3}, -- Gemlight figurine
								[2] = {item = 22723, count = 50}, -- Platinum token
						},
					}, 
				[4] = {item = "Bloody Crystal",
						itemID = 24964,
						reqItems = {
								[1] = {item = 23493, count = 3}, -- Bloodlight figurine
								[2] = {item = 22723, count = 50}, -- Platinum token
						},
					}, 
				[5] = {item = "Void Crystal",
						itemID = 39037,
						reqItems = {
								[1] = {item = 23492, count = 3}, -- Blacklight figurine
								[2] = {item = 22723, count = 50}, -- Platinum token
						},
					},

				},
			},
		[2] = {vocation = "Refine", -- This is the category can be anything.
			items = {
				[1] = {item = "Rainbow Crystal",
						itemID = 39036,
						reqItems = {
								[1] = {item = 22723, count = 100}, -- Platinum token
								[2] = {item = 39037, count = 1}, -- Blacklight figurine
								[3] = {item = 29288, count = 1}, -- Bloodlight figurine
								[4] = {item = 24964, count = 1}, -- Gemlight figurine
								[5] = {item = 29289, count = 1}, -- Brightligh figurine
								[6] = {item = 29287, count = 1}, -- manalight figurine
						},
					},
				},
			},
		}
 }
local simpleCraftingSystem = Action()
function simpleCraftingSystem.onUse(player, item, fromPosition, itemEx, toPosition, isHotkey)
    player:sendMainCraftWindow(config)
    return true
end

simpleCraftingSystem:id(19388)
simpleCraftingSystem:register()