local supremeCube = Action()

local config = {
    price = 100,
    storage = 15002,
    cooldown = 3,
    towns = {
	{ name = "Thais", teleport = Position(32369, 32241, 7) },
        { name = "Ab'Dendriel", teleport = Position(32732, 31634, 7) },
        { name = "Adventurer's Guild", teleport = Position(32208, 32294, 7) },--***
        { name = "Ankrahmun", teleport = Position(33194, 32853, 8) },
        { name = "Carlin", teleport = Position(32360, 31782, 7) },
        { name = "Darashia", teleport = Position(33213, 32454, 1) },
        { name = "Edron", teleport = Position(33217, 31814, 8) },
        { name = "Farmine", teleport = Position(33023, 31521, 11) },
        { name = "Feyrist", teleport = Position(33490, 32221, 7) },--***
        { name = "Gray Beach", teleport = Position(33447, 31323, 9) },--***
        { name = "Issavi", teleport = Position(33921, 31477, 5) },
        { name = "Kazordoon", teleport = Position(32649, 31925, 11) },
        { name = "Krailos", teleport = Position(33657, 31665, 8) },
        { name = "Liberty Bay", teleport = Position(32317, 32826, 7) },
        { name = "Marapur", teleport = Position(33797, 32755, 5) },
        { name = "Port Hope", teleport = Position(32594, 32745, 7) },
        { name = "Rathleton", teleport = Position(33594, 31899, 6) },
        { name = "Roshamuul", teleport = Position(33513, 32363, 6) },
        { name = "Svargrond", teleport = Position(32212, 31132, 7) },        
        { name = "Venore", teleport = Position(32957, 32076, 7) },
        { name = "Yalahar", teleport = Position(32787, 31276, 7) },
        { name = "Boss Hub", teleport = Position(32160, 32302, 7) },

    }
}

local function supremeCubeMessage(player, effect, message)
    player:sendTextMessage(MESSAGE_EVENT_ADVANCE, message)
    player:getPosition():sendMagicEffect(effect)
end

function supremeCube.onUse(player, item, fromPosition, target, toPosition, isHotkey)
    local inPz = player:getTile():hasFlag(TILESTATE_PROTECTIONZONE)
    local inFight = player:isPzLocked() or player:getCondition(CONDITION_INFIGHT, CONDITIONID_DEFAULT)

    if not inPz and inFight then
        supremeCubeMessage(player, CONST_ME_POFF, "You can't use this when you're in a fight.")
        return false
    end

    if player:getMoney() + player:getBankBalance() < config.price then --price
        supremeCubeMessage(player, CONST_ME_POFF, "You don't have enough money.")
        return false
    end
	
	if getTileInfo(player:getPosition()).nologout then --Using in a nologout zone
		supremeCubeMessage(player, CONST_ME_POFF, "You can't use this when you are inside a boss room.")
		return true 
	end
	
	if not player:isPremium() then --check if premium time
		supremeCubeMessage(player, CONST_ME_POFF, "You need active premium time to use this item.")
		return true
	end	

    if player:getStorageValue(config.storage) > os.time() then
        local remainingTime = player:getStorageValue(config.storage) - os.time()
        supremeCubeMessage(player, CONST_ME_POFF, "Supreme cube is in cooldown: " .. remainingTime .. " seconds.")
        return false
    end

    local window = ModalWindow({
        title = "Supreme Cube",
        message = "Select a City - Price: " .. config.price .. " gold.",
    })

    for _, town in pairs(config.towns) do
        if town.name then
            window:addChoice(town.name, function(player, button, choice)
                if button.name == "Select" then
					player:getPosition():sendMagicEffect(201)
                    player:teleportTo(town.teleport, true)
					player:removeMoneyBank(config.price)
                    supremeCubeMessage(player, CONST_ME_TELEPORT, "Welcome to " .. town.name)
                    player:setStorageValue(config.storage, os.time() + config.cooldown)
                end
                return true
            end)
        end
    end

    -- Opção de teleportar para a casa do jogador
    window:addChoice("House", function(player, button, choice)
        if button.name == "Select" then
            local house = player:getHouse()
            if house then
				player:getPosition():sendMagicEffect(201)
                player:teleportTo(house:getExitPosition(), true)
                player:removeMoneyBank(config.price)
                supremeCubeMessage(player, CONST_ME_TELEPORT, "Welcome to your house.")
                player:setStorageValue(config.storage, os.time() + config.cooldown)
            else
                supremeCubeMessage(player, CONST_ME_POFF, "You don't have a house.")
            end
        end
        return true
    end)

    window:addButton("Select")
    window:addButton("Close")
    window:setDefaultEnterButton(0)
    window:setDefaultEscapeButton(1)
    window:sendToPlayer(player)

    return true
end

supremeCube:id(31633)
supremeCube:register()