local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
combat:setParameter(COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_WEAPONTYPE)
combat:setParameter(COMBAT_PARAM_BLOCKARMOR, 1)

function onGetFormulaValues(player, skill, attack, factor)
	local skillTotal = skill * attack
	local levelTotal = player:getLevel() / 5
	return -(((skillTotal * 0.17) + 17) + levelTotal) * 1.28, -(((skillTotal * 0.20) + 40) + levelTotal) * 1.28
end

combat:setCallback(CALLBACK_PARAM_SKILLVALUE, "onGetFormulaValues")

function getChainValue(creature)
	local grade = creature:revelationStageWOD("Executioner's Throw")
	if grade == 0 then
		return false
	end

	local bounces = 0
	if grade >= 3 then
		bounces = 4
	elseif grade >= 2 then
		bounces = 3
	elseif grade >= 1 then
		bounces = 2
	end

	return bounces + 1, 3, false
end

combat:setCallback(CALLBACK_PARAM_CHAINVALUE, "getChainValue")

local spell = Spell("instant")

function spell.onCastSpell(creature, var)
	if not creature or not creature:isPlayer() then
		return false
	end

	local grade = creature:revelationStageWOD("Executioner's Throw")
	if grade == 0 then
		creature:sendCancelMessage("You need to learn this spell first")
		creature:getPosition():sendMagicEffect(CONST_ME_POFF)
		return false
	end

	local ret = combat:execute(creature, var)
	if ret then
		-- Cooldown scaling: Stage 1 = 18s, Stage 2 = 14s, Stage 3 = 10s
		local cooldowns = { [1] = 18000, [2] = 14000, [3] = 10000 }
		local cdMs = cooldowns[grade] or 18000
		local condition = Condition(CONDITION_SPELLCOOLDOWN, CONDITIONID_DEFAULT, 261)
		local rate = configManager.getFloat(configKeys.RATE_SPELL_COOLDOWN)
		if not rate or rate <= 0 then
			rate = 1.0
		end
		condition:setTicks(cdMs / rate)
		creature:addCondition(condition)
	end
	return ret
end

spell:group("attack")
spell:id(261)
spell:name("Executioner's Throw")
spell:words("exori amp kor")
spell:level(300)
spell:mana(225)
spell:isPremium(true)
spell:range(5)
spell:needTarget(true)
spell:blockWalls(true)
spell:needWeapon(true)
spell:cooldown(1000) -- Dynamic cooldown calculated on cast based on Revelation Stage (18s, 14s, 10s)
spell:groupCooldown(2 * 1000)
spell:needLearn(true)
spell:vocation("knight;true", "elite knight;true")
spell:register()
