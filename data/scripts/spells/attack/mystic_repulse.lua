local SPELL_BASE_POWER = 72

local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_BLOW_WHITE)
combat:setParameter(COMBAT_PARAM_BLOCKARMOR, 1)
combat:setParameter(COMBAT_PARAM_USECHARGES, 1)

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
	local ret = combat:execute(creature, var)
	if ret and creature:isPlayer() then
		local grade = creature:upgradeSpellsWOD("Mystic Repulse")
		local cdMs = (grade >= 1) and 16000 or 20000
		local condition = Condition(CONDITION_SPELLCOOLDOWN, CONDITIONID_DEFAULT, 290)
		local rate = configManager.getFloat(configKeys.RATE_SPELL_COOLDOWN)
		if not rate or rate <= 0 then rate = 1.0 end
		condition:setTicks(cdMs / rate)
		creature:addCondition(condition)
	end
	return ret
end

spell:group("attack")
spell:id(290)
spell:name("Mystic Repulse")
spell:words("exori amp pug")
spell:castSound(SOUND_EFFECT_TYPE_SPELL_OR_RUNE)
spell:impactSound(SOUND_EFFECT_TYPE_SPELL_WHIRLWIND_THROW)
spell:level(30)
spell:mana(150)
spell:isPremium(true)
spell:range(7)
spell:needTarget(true)
spell:blockWalls(true)
spell:cooldown(1000) -- Dynamic cooldown: 16s at Grade 1+, 20s base
spell:groupCooldown(2 * 1000)
spell:needLearn(true)
spell:monkSpellType(MonkSpell_Builder)
spell:vocation("monk;true", "exalted monk;true")
spell:register()
