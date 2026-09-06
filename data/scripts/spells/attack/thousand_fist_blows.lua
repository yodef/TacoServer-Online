local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_BLOW_WHITE)
combat:setParameter(COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_SMALLHOLY)
combat:setParameter(COMBAT_PARAM_BLOCKARMOR, 1)
combat:setArea(createCombatArea(AREA_CIRCLE3X3))

function onGetFormulaValues(player, skill, attack, factor)
	local damageHealing = player:calculateFlatDamageHealing()
	local damage = SPELL_BASE_POWER * (skill / 100) * (attack / 10) + damageHealing
	local min = damage - (damage / 10)
	local max = damage + (damage / 10)
	return min, max
end

combat:setCallback(CALLBACK_PARAM_SKILLVALUE, "onGetFormulaValues")

local spell = Spell("instant")

function spell.onCastSpell(creature, var)
	return combat:execute(creature, var)
end

spell:group("attack")
spell:id(124)
spell:name("Thousand Fist Blows")
spell:words("exori mas amp pug")
spell:castSound(SOUND_EFFECT_TYPE_SPELL_DIVINE_CALDERA)
spell:level(120)
spell:mana(145)
spell:isPremium(true)
spell:range(5)
spell:needCasterTargetOrDirection(true)
spell:blockWalls(true)
spell:isSelfTarget(false)
spell:cooldown(12 * 1000)
spell:groupCooldown(2 * 1000)

spell:monkSpellType(MonkSpell_Builder)
spell:vocation("monk;true", "exalted monk;true")
spell:register()
