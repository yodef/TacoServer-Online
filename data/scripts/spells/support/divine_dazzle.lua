local combat = Combat()
combat:setParameter(COMBAT_PARAM_CHAIN_EFFECT, CONST_ME_DIVINE_DAZZLE)

function canChain(creature, target)
	if target:isMonster() then
		if target:getType():isRewardBoss() then
			return false
		elseif target:getMaster() == nil and target:getType():getTargetDistance() > 1 then
			return true
		end
	end
	return false
end

combat:setCallback(CALLBACK_PARAM_CHAINPICKER, "canChain")

function getChainValue(creature)
	local targets = 3
	local player = creature:getPlayer()
	if creature and player then
		local extra = player:getWheelSpellAdditionalTarget("Divine Dazzle")
		if (not extra or extra == 0) and player:upgradeSpellsWOD("Divine Dazzle") >= 1 then
			extra = 1
		end
		targets = targets + (extra or 0)
	end
	return targets, 6, false
end

combat:setCallback(CALLBACK_PARAM_CHAINVALUE, "getChainValue")

function onChain(creature, target)
	local duration = 12000
	local player = creature:getPlayer()
	if creature and player then
		local extraDur = player:getWheelSpellAdditionalDuration("Divine Dazzle")
		if (not extraDur or extraDur == 0) and player:upgradeSpellsWOD("Divine Dazzle") >= 2 then
			extraDur = 4
		end
		duration = duration + ((extraDur or 0) * 1000)
	end
	if target and target:isMonster() then
		target:changeTargetDistance(1, duration)
	end
	return true
end

combat:setCallback(CALLBACK_PARAM_TARGETCREATURE, "onChain")

local spell = Spell("instant")

function spell.onCastSpell(creature, variant)
	local spectators = Game.getSpectators(creature:getPosition(), false, false)
	for _, spectator in pairs(spectators) do
		if spectator:isMonster() then
			if spectator:getType():isRewardBoss() then
				creature:sendCancelMessage("You can't use this spell if there's a boss.")
				creature:getPosition():sendMagicEffect(CONST_ME_POFF)
				return false
			end
		end
	end

	local ret = combat:execute(creature, variant)
	if not ret then
		creature:sendCancelMessage("There are no ranged monsters.")
		creature:getPosition():sendMagicEffect(CONST_ME_POFF)
		return false
	end

	if creature:isPlayer() then
		local grade = creature:upgradeSpellsWOD("Divine Dazzle")
		local cdMs = (grade >= 2) and 12000 or 16000
		local condition = Condition(CONDITION_SPELLCOOLDOWN, CONDITIONID_DEFAULT, 238)
		local rate = configManager.getFloat(configKeys.RATE_SPELL_COOLDOWN)
		if not rate or rate <= 0 then rate = 1.0 end
		condition:setTicks(cdMs / rate)
		creature:addCondition(condition)
	end
	return true
end

spell:group("support")
spell:id(238)
spell:name("Divine Dazzle")
spell:words("exana amp res")
spell:castSound(SOUND_EFFECT_TYPE_SPELL_DIVINE_DAZZLE)
spell:level(250)
spell:mana(80)
spell:isAggressive(false)
spell:isPremium(true)
spell:cooldown(1000) -- Dynamic cooldown: 12s at Grade 2, 16s base
spell:groupCooldown(2 * 1000)
spell:vocation("paladin;true", "royal paladin;true")

spell:register()
