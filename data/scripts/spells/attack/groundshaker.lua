local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_GROUNDSHAKER)
combat:setParameter(COMBAT_PARAM_BLOCKARMOR, 1)
combat:setParameter(COMBAT_PARAM_USECHARGES, 1)
combat:setArea(createCombatArea(AREA_CIRCLE3X3))

function onGetFormulaValues(player, skill, attack, factor)
	local level = player:getLevel()
	local min = (level / 5) + (skill + attack) * 0.5
	local max = (level / 5) + (skill + attack) * 1.1
	return -min * 1.28, -max * 1.28 -- TODO : Use New Real Formula instead of an %
end

combat:setCallback(CALLBACK_PARAM_SKILLVALUE, "onGetFormulaValues")

local spell = Spell("instant")

function spell.onCastSpell(creature, var)
	local player = creature:getPlayer()
	if not player then
		return false
	end

	local ret = combat:execute(player, var)
	if ret then
		-- Wheel of Destiny: Grade 1 & 2 reduces cooldown by 2 seconds (from 8s to 6s)
		local grade = player:upgradeSpellsWOD("Groundshaker")
		local cdMs = (grade >= 1) and 6000 or 8000
		local condition = Condition(CONDITION_SPELLCOOLDOWN, CONDITIONID_DEFAULT, 106)
		local rate = configManager.getFloat(configKeys.RATE_SPELL_COOLDOWN)
		if not rate or rate <= 0 then
			rate = 1.0
		end
		condition:setTicks(cdMs / rate)
		player:addCondition(condition)
	end
	return ret
end

spell:group("attack")
spell:id(106)
spell:name("Groundshaker")
spell:words("exori mas")
spell:castSound(SOUND_EFFECT_TYPE_SPELL_GROUNDSHAKER)
spell:level(33)
spell:mana(160)
spell:isPremium(true)
spell:needWeapon(true)
spell:cooldown(1000) -- Dynamic cooldown calculated on cast (6s at Grade 1+, 8s base)
spell:groupCooldown(2 * 1000)

spell:vocation("knight;true", "elite knight;true")
spell:register()
