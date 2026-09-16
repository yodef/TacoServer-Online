local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_ICEDAMAGE)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_ICEATTACK)
combat:setParameter(COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_ICE)
combat:setArea(createCombatArea(AREA_CIRCLE3X3))

function onGetFormulaValues(player, level, maglevel)
	local min = (level / 5) + (maglevel * 4.5) + 25
	local max = (level / 5) + (maglevel * 6.5) + 35
	return -min, -max
end

combat:setCallback(CALLBACK_PARAM_LEVELMAGICVALUE, "onGetFormulaValues")

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
	elseif varPos and varPos.x and varPos.x > 0 then
		centerPos = varPos
	else
		centerPos = playerPos
	end

	if not centerPos then
		player:sendCancelMessage("You need to select a target first.")
		player:getPosition():sendMagicEffect(CONST_ME_POFF)
		return false
	end

	if player:getPosition():getDistance(centerPos) > 6 then
		player:sendCancelMessage("Destination is out of reach.")
		player:getPosition():sendMagicEffect(CONST_ME_POFF)
		return false
	end

	if not player:canSee(centerPos) then
		player:sendCancelMessage("Creature is not reachable.")
		player:getPosition():sendMagicEffect(CONST_ME_POFF)
		return false
	end

	local execVar = targetCreature and Variant(targetCreature:getId()) or Variant(centerPos)
	return combat:execute(player, execVar)
end

spell:group("attack")
spell:id(317)
spell:name("Forked Glacier")
spell:words("exevo fur frigo")
spell:castSound(SOUND_EFFECT_TYPE_SPELL_OR_RUNE)
spell:level(90)
spell:mana(180)
spell:isPremium(true)
spell:cooldown(6 * 1000)
spell:groupCooldown(2 * 1000)
spell:vocation("druid;true", "elder druid;true")
spell:register()
