local function formulaFunction(player, level, maglevel)
	local min = (level / 5) + (maglevel * 4)
	local max = (level / 5) + (maglevel * 7)
	return -min, -max
end

function onGetFormulaValues(player, level, maglevel)
	return formulaFunction(player, level, maglevel)
end

function onGetFormulaValuesWOD(player, level, maglevel)
	return formulaFunction(player, level, maglevel)
end

local AREA_BEAM8_WIDE = {
	{ 1, 1, 1 },
	{ 1, 1, 1 },
	{ 1, 1, 1 },
	{ 1, 1, 1 },
	{ 1, 1, 1 },
	{ 1, 1, 1 },
	{ 1, 1, 1 },
	{ 1, 3, 1 },
}

local AREADIAGONAL_BEAM8_WIDE = {
	{ 1, 1, 0, 0, 0, 0, 0, 0 },
	{ 1, 1, 1, 0, 0, 0, 0, 0 },
	{ 0, 1, 1, 1, 0, 0, 0, 0 },
	{ 0, 0, 1, 1, 1, 0, 0, 0 },
	{ 0, 0, 0, 1, 1, 1, 0, 0 },
	{ 0, 0, 0, 0, 1, 1, 1, 0 },
	{ 0, 0, 0, 0, 0, 1, 1, 1 },
	{ 0, 0, 0, 0, 0, 0, 1, 3 },
}

local function createCombat(area, areaDiagonal, combatFunc)
	local initCombat = Combat()
	initCombat:setCallback(CALLBACK_PARAM_LEVELMAGICVALUE, combatFunc)
	initCombat:setParameter(COMBAT_PARAM_TYPE, COMBAT_ENERGYDAMAGE)
	initCombat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_ENERGYAREA)
	if areaDiagonal then
		initCombat:setArea(createCombatArea(area, areaDiagonal))
	else
		initCombat:setArea(createCombatArea(area))
	end
	return initCombat
end

local combat = createCombat(AREA_BEAM8, nil, "onGetFormulaValues")
local combatWOD = createCombat(AREA_BEAM8_WIDE, AREADIAGONAL_BEAM8_WIDE, "onGetFormulaValuesWOD")

local function hasBeamMastery(player)
	if not player then
		return false
	end
	if player:instantSkillWOD("Beam Mastery") then
		return true
	end
	if player:upgradeSpellsWOD("Great Energy Beam") > 0 or player:upgradeSpellsWOD("Beam Mastery") > 0 then
		return true
	end
	return false
end

local spell = Spell("instant")

function spell.onCastSpell(creature, var)
	local player = creature:getPlayer()
	if not creature or not player then
		return false
	end
	if hasBeamMastery(player) then
		return combatWOD:execute(creature, var)
	end
	return combat:execute(creature, var)
end

spell:group("attack", "greatbeams")
spell:id(23)
spell:name("Great Energy Beam")
spell:words("exevo gran vis lux")
spell:castSound(SOUND_EFFECT_TYPE_SPELL_GREAT_ENERGY_BEAM)
spell:level(29)
spell:mana(110)
spell:isPremium(false)
spell:needDirection(true)
spell:blockWalls(true)
spell:cooldown(6 * 1000)
spell:groupCooldown(2 * 1000, 6 * 1000)

spell:vocation("sorcerer;true", "master sorcerer;true")
spell:register()
