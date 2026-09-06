local figurineRefine = Action()

function figurineRefine.onUse(player, item, fromPosition, target, toPosition, isHotkey)
    local itemId = item:getId()

    local currentDescription = target:getAttribute(ITEM_ATTRIBUTE_DESCRIPTION)
    local tierCheck = tonumber(currentDescription:match("%((%d+)%)"))

    if tierCheck == nil or (tierCheck >= 0 and tierCheck <= 9) then --LEGENDARY
        if itemId == 673 and player:getItemById(29288, 1) and player:getItemById(24964, 1) and player:getItemById(39037, 1) and player:getItemById(29287, 1) and player:getItemById(29289, 1) then
            local targetItemId = target:getId()
            local allowedItemIds = {23489, 23490, 23491, 23492, 23493}

            if table.contains(allowedItemIds, targetItemId) then
                player:removeItem(673, 1)
				player:removeItem(39037, 1) 
				player:removeItem(24964, 1) 
				player:removeItem(29288, 1) 
				player:removeItem(29287, 1) 
				player:removeItem(29289, 1)
                player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "The hammer broke in the process, but your light source has absorbed the crystals!")
                player:getPosition():sendMagicEffect(CONST_ME_ORANGE_ENERGY_SPARK)

                if not currentDescription or not currentDescription:lower():find("legendary") then
                    target:setAttribute(ITEM_ATTRIBUTE_DESCRIPTION, "Legendary Tier (1).")
                else
                    local currentCount = tonumber(currentDescription:match("%((%d+)%).")) or 0
                    local newCount = currentCount + 1
                    local newDescription = "Legendary Tier (" .. newCount .. ")."
                    target:setAttribute(ITEM_ATTRIBUTE_DESCRIPTION, newDescription)
                end
            else
                player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "This item cannot be refined.")
            end
        else
            player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You need 1 crystal of each type to boost this item.")
        end
	elseif tierCheck == nil or (tierCheck >= 10 and tierCheck <= 24) then --ULTRA
        if itemId == 673 and player:getItemById(29288, 2) and player:getItemById(24964, 2) and player:getItemById(39037, 2) and player:getItemById(29287, 2) and player:getItemById(29289, 2) then
            local targetItemId = target:getId()
            local allowedItemIds = {23489, 23490, 23491, 23492, 23493}
            if table.contains(allowedItemIds, targetItemId) then
                player:removeItem(673, 1)
				player:removeItem(39037, 2) 
				player:removeItem(24964, 2) 
				player:removeItem(29288, 2) 
				player:removeItem(29287, 2) 
				player:removeItem(29289, 2)
                player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "The hammer broke in the process, but your light source has absorbed the crystals!")
                player:getPosition():sendMagicEffect(CONST_ME_ORANGE_ENERGY_SPARK)
               local currentCount = tonumber(currentDescription:match("%((%d+)%).")) or 0
               local newCount = currentCount + 1
               local newDescription = "Legendary Tier (" .. newCount .. ")."
               target:setAttribute(ITEM_ATTRIBUTE_DESCRIPTION, newDescription)

            else
                player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "This item cannot be refined.")
            end
        else
            player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You need 2 crystals of each type to boost this item.")
        end	
    else
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Your light source is already refined at maximum level.")
    end

    return true
end

figurineRefine:id(673)
figurineRefine:register()

local condition = Condition(CONDITION_ATTRIBUTES, CONDITIONID_AMMO)
local ArmorEquipOn = MoveEvent()

function ArmorEquipOn.onEquip(player, item, position, fromPosition)
    if not player or player:isInGhostMode() then
        return true
    end
    local currentDescription = item:getAttribute(ITEM_ATTRIBUTE_DESCRIPTION)
    if currentDescription and currentDescription:lower():find("legendary tier") then
	local tier = tonumber(currentDescription:match("%((%d+)%)"))		
		condition:setParameter(CONDITION_PARAM_SUBID, 1015)
        condition:setParameter(CONDITION_PARAM_STAT_MAXHITPOINTS, 50 * tier)
		condition:setParameter(CONDITION_PARAM_STAT_MAXMANAPOINTS, 50 * tier)
		condition:setParameter(CONDITION_PARAM_STAT_MAGICPOINTS, 0.5 * tier)
		condition:setParameter(CONDITION_PARAM_SKILL_MELEE, 0.5 * tier)
		condition:setParameter(CONDITION_PARAM_SKILL_DISTANCE, 0.5 * tier)
		condition:setParameter(CONDITION_PARAM_SKILL_SHIELD, 0.5 * tier)		
		condition:setParameter(CONDITION_PARAM_SPEED, 3 * tier)
        condition:setParameter(CONDITION_PARAM_SKILL_CRITICAL_HIT_CHANCE, 10 * tier)		
        condition:setParameter(CONDITION_PARAM_SKILL_CRITICAL_HIT_DAMAGE, 100 * tier)
		condition:setParameter(CONDITION_PARAM_SKILL_CRITICAL_HIT_DAMAGE, 100 * tier)
		condition:setParameter(CONDITION_PARAM_SKILL_MANA_LEECH_CHANCE, 20 * tier)
		condition:setParameter(CONDITION_PARAM_SKILL_LIFE_LEECH_CHANCE, 20 * tier)
		condition:setParameter(CONDITION_PARAM_SKILL_LIFE_LEECH_AMOUNT, 50 * tier)
		condition:setParameter(CONDITION_PARAM_SKILL_MANA_LEECH_AMOUNT, 50 * tier)		
		condition:setParameter(CONDITION_PARAM_TICKS, -1)	
        player:addCondition(condition)
    end
    return true
end

ArmorEquipOn:id(23489, 23490, 23491, 23492, 23493)
ArmorEquipOn:register()

local condition = Condition(CONDITION_ATTRIBUTES, CONDITIONID_AMMO)
local ArmorEquipOff = MoveEvent()

function ArmorEquipOff.onDeEquip(player, item, position, fromPosition)
    if not player or player:isInGhostMode() then
        return true
    end

    local currentDescription = item:getAttribute(ITEM_ATTRIBUTE_DESCRIPTION)
    if currentDescription and currentDescription:lower():find("legendary tier") then
        for i = 1015, 1015 do
            player:removeCondition(CONDITION_ATTRIBUTES, CONDITIONID_AMMO, i)
        end
    end

    return true
end

ArmorEquipOff:id(23489, 23490, 23491, 23492, 23493)
ArmorEquipOff:register()
