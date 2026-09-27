local function formulaFunction(player, level, maglevel, mult)
	mult = mult or 1.0
	local min = ((level / 5) + (maglevel * 4.5)) * mult
	local max = ((level / 5) + (maglevel * 9)) * mult
	return -min, -max
end

function onGetFormulaValues(player, level, maglevel)
	return formulaFunction(player, level, maglevel, 1.0)
end

function onGetFormulaValuesWOD(player, level, maglevel)
	local mult = 1.0
	if player then
		local grade = player:upgradeSpellsWOD("Energy Wave")
		if grade >= 2 then
			mult = 1.10
		elseif grade >= 1 then
			mult = 1.05
		end
	end
	return formulaFunction(player, level, maglevel, mult)
end

local function createCombat(area, areaDiagonal, combatFunc)
	local initCombat = Combat()
	initCombat:setCallback(CALLBACK_PARAM_LEVELMAGICVALUE, combatFunc)
	initCombat:setParameter(COMBAT_PARAM_TYPE, COMBAT_ENERGYDAMAGE)
	initCombat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_ENERGYAREA)
	initCombat:setParameter(COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_ENERGY)
	initCombat:setArea(createCombatArea(area, areaDiagonal))
	return initCombat
end

local combat = createCombat(AREA_SQUAREWAVE5, AREADIAGONAL_SQUAREWAVE5, "onGetFormulaValues")
local combatWOD = createCombat(AREA_WAVE7, AREADIAGONAL_WAVE7, "onGetFormulaValuesWOD")

local spell = Spell("instant")

function spell.onCastSpell(creature, var)
	local player = creature:getPlayer()
	if creature and player then
		if player:getWheelSpellAdditionalArea("Energy Wave") or player:upgradeSpellsWOD("Energy Wave") > 0 then
			return combatWOD:execute(creature, var)
		end
	end
	return combat:execute(creature, var)
end

spell:group("attack")
spell:id(13)
spell:name("Energy Wave")
spell:words("exevo vis hur")
spell:castSound(SOUND_EFFECT_TYPE_SPELL_ENERGY_WAVE)
spell:level(38)
spell:mana(170)
spell:needDirection(true)
spell:cooldown(8 * 1000)
spell:groupCooldown(2 * 1000)

spell:vocation("sorcerer;true", "master sorcerer;true")
spell:register()
