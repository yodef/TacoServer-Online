function onGetFormulaValues1(player, level, maglevel)
	local min = (level / 5) + (maglevel * 5.5)
	local max = (level / 5) + (maglevel * 9)
	return -min, -max
end

function onGetFormulaValues2(player, level, maglevel)
	local min = (level / 5) + (maglevel * 5.5)
	local max = (level / 5) + (maglevel * 9)
	return -min, -max
end

function onGetFormulaValues3(player, level, maglevel)
	local min = (level / 5) + (maglevel * 5.5)
	local max = (level / 5) + (maglevel * 9)
	return -min, -max
end

local function createCombat(area, callbackName)
	local cb = Combat()
	cb:setParameter(COMBAT_PARAM_TYPE, COMBAT_DEATHDAMAGE)
	cb:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_MORTAREA)
	cb:setArea(createCombatArea(area))
	cb:setCallback(CALLBACK_PARAM_LEVELMAGICVALUE, callbackName)
	return cb
end

local combat1 = createCombat(AREA_BEAM6, "onGetFormulaValues1")
local combat2 = createCombat(AREA_BEAM7, "onGetFormulaValues2")
local combat3 = createCombat(AREA_BEAM8, "onGetFormulaValues3")
local combat = { combat1, combat2, combat3 }

local spell = Spell("instant")

local exhaust = {}
function spell.onCastSpell(creature, var)
	if not creature or not creature:isPlayer() then
		return false
	end

	local player = creature:getPlayer()
	local grade = player and player:upgradeSpellsWOD("Great Death Beam") or WHEEL_GRADE_NONE
	if grade == WHEEL_GRADE_NONE then
		creature:sendCancelMessage("You need to learn this spell first")
		creature:getPosition():sendMagicEffect(CONST_ME_POFF)
		return false
	end

	return combat[grade]:execute(creature, var)
end

spell:group("attack", "greatbeams")
spell:id(260)
spell:name("Great Death Beam")
spell:words("exevo max mort")
spell:level(300)
spell:mana(140)
spell:isPremium(false)
spell:needDirection(true)
spell:blockWalls(true)
spell:cooldown(10 * 1000)
spell:groupCooldown(2 * 1000, 6 * 1000)
spell:needLearn(true)
spell:vocation("sorcerer;true", "master sorcerer;true")
spell:register()
