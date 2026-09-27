-- Bulltaur Lair Hunt Access & Teleports
local config = {
	entrance = Position(32799, 32365, 8),
	destination = Position(32872, 32371, 8),
	exitPortal = Position(32872, 32370, 8),
	exitDestination = Position(32799, 32366, 8),
}

-- Entrance Action (Right click on trashcan / entrance tile)
local bulltaurEntranceAction = Action()
function bulltaurEntranceAction.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if not player then
		return false
	end
	player:teleportTo(config.destination)
	player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You entered the Bulltaurs Lair.")
	return true
end
bulltaurEntranceAction:position(config.entrance)
bulltaurEntranceAction:register()

-- Entrance Step-in (Walking onto trashcan / entrance tile)
local bulltaurEntranceStep = MoveEvent()
function bulltaurEntranceStep.onStepIn(creature, item, position, fromPosition)
	local player = creature:getPlayer()
	if not player then
		return false
	end
	player:teleportTo(config.destination)
	player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You entered the Bulltaurs Lair.")
	return true
end
bulltaurEntranceStep:type("stepin")
bulltaurEntranceStep:position(config.entrance)
bulltaurEntranceStep:register()

-- Exit Step-in (Stepping into the return portal in Bulltaurs Lair)
local bulltaurExitStep = MoveEvent()
function bulltaurExitStep.onStepIn(creature, item, position, fromPosition)
	local player = creature:getPlayer()
	if not player then
		return false
	end
	player:teleportTo(config.exitDestination)
	player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You returned to the Plains of Havoc.")
	return true
end
bulltaurExitStep:type("stepin")
bulltaurExitStep:position(config.exitPortal)
bulltaurExitStep:register()

-- Exit Action (Using the return portal in Bulltaurs Lair)
local bulltaurExitAction = Action()
function bulltaurExitAction.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if not player then
		return false
	end
	player:teleportTo(config.exitDestination)
	player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You returned to the Plains of Havoc.")
	return true
end
bulltaurExitAction:position(config.exitPortal)
bulltaurExitAction:register()

-- Spawn visual portal items if missing
local function setupBulltaurPortals()
	local exitTile = Tile(config.exitPortal)
	if exitTile and not exitTile:getItemById(1949) then
		Game.createItem(1949, 1, config.exitPortal)
	end

	local entranceTile = Tile(config.entrance)
	if entranceTile and entranceTile:getItemCount() == 0 then
		Game.createItem(1949, 1, config.entrance)
	end
end

local bulltaurInit = GlobalEvent("BulltaurPortalsStartup")
function bulltaurInit.onStartup()
	setupBulltaurPortals()
	return true
end
bulltaurInit:register()

-- Also schedule for live script reloads
addEvent(setupBulltaurPortals, 200)
