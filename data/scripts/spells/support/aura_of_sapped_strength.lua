local function targetFunction(creature, target)
	local player = creature:getPlayer()

	if not target or target:isPlayer() then
		return false
	end
	if target:getMaster() then
		return true
	end

	local buff = 90
	if player then
		local grade = player:upgradeSpellsWOD("Sap Strength")
		if grade == WHEEL_GRADE_UPGRADED then
			buff = 80
		end
	end

	local condition = Condition(CONDITION_ATTRIBUTES)
	condition:setParameter(CONDITION_PARAM_TICKS, 16000)
	condition:setParameter(CONDITION_PARAM_BUFF_DAMAGEDEALT, buff)

	local gradeBuff = 0
	if player then
		gradeBuff = player:upgradeSpellsWOD("Drain_Body_Spells")
	end
	condition:setParameter(CONDITION_PARAM_DRAIN_BODY, gradeBuff)

	target:addCondition(condition)
	return true
end

function onTargetCreature(creature, target)
	return targetFunction(creature, target)
end

local combat = Combat()
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_MORTAREA)
combat:setArea(createCombatArea(AREA_CIRCLE3X3))
combat:setCallback(CALLBACK_PARAM_TARGETCREATURE, "onTargetCreature")

local spell = Spell("instant")

function spell.onCastSpell(creature, var)
	local player = creature:getPlayer()
	if not player then return false end

	local varNum = var:getNumber()
	local varPos = var:getPosition()
	local target = player:getTarget()
	local playerPos = player:getPosition()

	local targetCreature = nil
	local centerPos = nil

	if varNum and varNum > 0 and Creature(varNum) then
		targetCreature = Creature(varNum)
		centerPos = targetCreature:getPosition()
	elseif varPos and varPos.x and varPos.x > 0 and (varPos.x ~= playerPos.x or varPos.y ~= playerPos.y or varPos.z ~= playerPos.z) then
		centerPos = varPos
	elseif target and not target:isRemoved() and target:getHealth() > 0 then
		targetCreature = target
		centerPos = target:getPosition()
	else
		centerPos = playerPos
	end

	if playerPos:getDistance(centerPos) > 7 then
		player:sendCancelMessage("Destination is out of reach.")
		playerPos:sendMagicEffect(CONST_ME_POFF)
		return false
	end

	return combat:execute(player, Variant(centerPos))
end

spell:group("support", "crippling")
spell:id(324)
spell:name("Aura of Sapped Strength")
spell:words("exori kor tempo")
spell:castSound(SOUND_EFFECT_TYPE_SPELL_SAP_STRENGTH)
spell:level(80)
spell:mana(150)
spell:isSelfTarget(true)
spell:cooldown(12 * 1000)
spell:groupCooldown(2 * 1000, 12 * 1000)
spell:vocation("sorcerer;true", "master sorcerer;true")
spell:register()
