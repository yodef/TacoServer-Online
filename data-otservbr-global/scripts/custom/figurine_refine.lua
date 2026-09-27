local figurineRefine = Action()

local allowedFigurines = {
	[23489] = "brightlight figurine",
	[23490] = "gemlight figurine",
	[23491] = "manalight figurine",
	[23492] = "blacklight figurine",
	[23493] = "bloodlight figurine",
}

-- Crystals: Shining (29288), Bloody (24964), Void (39037), Managem (29287), Spirit (29289)
local requiredCrystals = { 29288, 24964, 39037, 29287, 29289 }

function figurineRefine.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if not player then
		return false
	end

	if not target or not target:isItem() then
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You must use this hammer on a figurine.")
		return true
	end

	local targetItemId = target:getId()
	if not allowedFigurines[targetItemId] then
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "This item cannot be refined.")
		return true
	end

	local currentDescription = target:getAttribute(ITEM_ATTRIBUTE_DESCRIPTION) or ""
	local tierCheck = tonumber(currentDescription:match("%((%d+)%)")) or 0

	if tierCheck >= 25 then
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Your light source is already refined at maximum level (Tier 25).")
		return true
	end

	-- 1 crystal of each type for Tiers 0-9; 2 crystals of each type for Tiers 10-24
	local reqCount = (tierCheck < 10) and 1 or 2

	-- Check if player has all required crystals
	for _, crystalId in ipairs(requiredCrystals) do
		if player:getItemCount(crystalId) < reqCount then
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, string.format("You need %d crystal%s of each type to boost this item.", reqCount, reqCount > 1 and "s" or ""))
			return true
		end
	end

	-- Consume the hammer
	item:remove(1)

	-- Consume the crystals
	for _, crystalId in ipairs(requiredCrystals) do
		player:removeItem(crystalId, reqCount)
	end

	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "The hammer broke in the process, but your light source has absorbed the crystals!")
	player:getPosition():sendMagicEffect(CONST_ME_ORANGE_ENERGY_SPARK)

	local newTier = tierCheck + 1
	target:setAttribute(ITEM_ATTRIBUTE_DESCRIPTION, "Legendary Tier (" .. newTier .. ").")
	return true
end

figurineRefine:id(673)
figurineRefine:register()

local ArmorEquipOn = MoveEvent()

function ArmorEquipOn.onEquip(player, item, position, fromPosition)
	if not player or player:isInGhostMode() then
		return true
	end

	local currentDescription = item:getAttribute(ITEM_ATTRIBUTE_DESCRIPTION) or ""
	if currentDescription:lower():find("legendary tier") then
		local tier = tonumber(currentDescription:match("%((%d+)%)")) or 1
		local condition = Condition(CONDITION_ATTRIBUTES, CONDITIONID_AMMO)
		condition:setParameter(CONDITION_PARAM_SUBID, 1015)
		condition:setParameter(CONDITION_PARAM_STAT_MAXHITPOINTS, 50 * tier)
		condition:setParameter(CONDITION_PARAM_STAT_MAXMANAPOINTS, 50 * tier)
		condition:setParameter(CONDITION_PARAM_STAT_MAGICPOINTS, math.floor(0.5 * tier))
		condition:setParameter(CONDITION_PARAM_SKILL_MELEE, math.floor(0.5 * tier))
		condition:setParameter(CONDITION_PARAM_SKILL_DISTANCE, math.floor(0.5 * tier))
		condition:setParameter(CONDITION_PARAM_SKILL_SHIELD, math.floor(0.5 * tier))
		condition:setParameter(CONDITION_PARAM_SPEED, 3 * tier)
		condition:setParameter(CONDITION_PARAM_SKILL_CRITICAL_HIT_CHANCE, 10 * tier)
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

local ArmorEquipOff = MoveEvent()

function ArmorEquipOff.onDeEquip(player, item, position, fromPosition)
	if not player or player:isInGhostMode() then
		return true
	end

	local currentDescription = item:getAttribute(ITEM_ATTRIBUTE_DESCRIPTION) or ""
	if currentDescription:lower():find("legendary tier") then
		player:removeCondition(CONDITION_ATTRIBUTES, CONDITIONID_AMMO, 1015)
	end
	return true
end

ArmorEquipOff:id(23489, 23490, 23491, 23492, 23493)
ArmorEquipOff:register()
