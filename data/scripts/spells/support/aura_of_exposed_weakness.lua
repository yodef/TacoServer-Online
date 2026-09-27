local function targetFunction(creature, target)
	local player = creature:getPlayer()

	if not target or target:isPlayer() then
		return false
	end
	if target:getMaster() then
		return true
	end

	local condition = Condition(CONDITION_ATTRIBUTES)
	condition:setParameter(CONDITION_PARAM_TICKS, 16000)
	condition:setParameter(CONDITION_PARAM_BUFF_DAMAGERECEIVED, 108)

	local grade = 0
	if player then
		grade = player:upgradeSpellsWOD("Drain_Body_Spells")
	end
	condition:setParameter(CONDITION_PARAM_DRAIN_BODY, grade)

	target:addCondition(condition)
	return true
end

function onTargetCreature(creature, target)
	return targetFunction(creature, target)
end

local combat = Combat()
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_MORTAREA)
combat:setParameter(COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_DEATH)
combat:setArea(createCombatArea(AREA_CIRCLE3X3))
combat:setCallback(CALLBACK_PARAM_TARGETCREATURE, "onTargetCreature")

local spell = Spell("instant")

function spell.onCastSpell(creature, var)
	local player = creature:getPlayer()
	if not player then
		return false
	end

	local varNum = var:getNumber()
	local target = player:getTarget()
	local playerPos = player:getPosition()

	local targetCreature = nil

	if varNum and varNum > 0 and Creature(varNum) and varNum ~= player:getId() then
		targetCreature = Creature(varNum)
	elseif target and not target:isRemoved() and target:getHealth() > 0 then
		targetCreature = target
	end

	local centerPos = nil
	if targetCreature then
		centerPos = targetCreature:getPosition()
		if playerPos.z ~= centerPos.z or playerPos:getDistance(centerPos) > 7 then
			player:sendCancelMessage("Destination is out of reach.")
			playerPos:sendMagicEffect(CONST_ME_POFF)
			return false
		end
		if not player:canSee(centerPos) then
			player:sendCancelMessage("Creature is not reachable.")
			playerPos:sendMagicEffect(CONST_ME_POFF)
			return false
		end
	else
		centerPos = playerPos
	end

	return combat:execute(player, Variant(centerPos))
end

spell:group("support", "crippling")
spell:id(323)
spell:name("Aura of Exposed Weakness")
spell:words("exori moe tempo")
spell:castSound(SOUND_EFFECT_TYPE_SPELL_EXPOSE_WEAKNESS)
spell:level(80)
spell:mana(150)
spell:isPremium(true)
spell:range(7)
spell:isBlockingWalls(true)
spell:isAggressive(true)
spell:allowOnSelf(true)
spell:cooldown(12 * 1000)
spell:groupCooldown(2 * 1000, 12 * 1000)
spell:vocation("sorcerer;true", "master sorcerer;true")
spell:register()