local combatInitial = Combat()
combatInitial:setParameter(COMBAT_PARAM_TYPE, COMBAT_DEATHDAMAGE)
combatInitial:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_MORTAREA)
combatInitial:setArea(createCombatArea(AREA_CIRCLE3X3))

function onGetFormulaValues(player, level, maglevel)
	local min = (level / 5) + (maglevel * 5.0) + 30
	local max = (level / 5) + (maglevel * 7.5) + 50
	return -min, -max
end

combatInitial:setCallback(CALLBACK_PARAM_LEVELMAGICVALUE, "onGetFormulaValues")

local combatEcho = Combat()
combatEcho:setParameter(COMBAT_PARAM_TYPE, COMBAT_DEATHDAMAGE)
combatEcho:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_SMALLCLOUDS)
combatEcho:setArea(createCombatArea(AREA_CIRCLE3X3))

function onGetEchoFormulaValues(player, level, maglevel)
	local min = ((level / 5) + (maglevel * 5.0) + 30) * 0.50
	local max = ((level / 5) + (maglevel * 7.5) + 50) * 0.50
	return -min, -max
end

combatEcho:setCallback(CALLBACK_PARAM_LEVELMAGICVALUE, "onGetEchoFormulaValues")

local function triggerEcho(playerId, pos)
	local player = Player(playerId)
	if not player then
		return
	end

	local var = Variant(pos)
	combatEcho:execute(player, var)
	pos:sendMagicEffect(CONST_ME_MORTAREA)
end

local spell = Spell("instant")

function spell.onCastSpell(creature, var)
	local player = creature:getPlayer()
	if not player then
		return false
	end

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

	if centerPos then
		if player:getPosition():getDistance(centerPos) > 7 then
			player:sendCancelMessage("Destination is out of reach.")
			player:getPosition():sendMagicEffect(CONST_ME_POFF)
			return false
		end
		if not player:canSee(centerPos) then
			player:sendCancelMessage("Creature is not reachable.")
			player:getPosition():sendMagicEffect(CONST_ME_POFF)
			return false
		end
	end

	var = Variant(centerPos)
	if not combatInitial:execute(player, var) then
		return false
	end

	addEvent(triggerEcho, 1000, player:getId(), centerPos)
	return true
end

spell:group("attack")
spell:id(310)
spell:name("Death Echo")
spell:words("exevo mort ora")
spell:castSound(SOUND_EFFECT_TYPE_SPELL_OR_RUNE)
spell:level(120)
spell:mana(150)
spell:isPremium(true)
spell:cooldown(6 * 1000)
spell:groupCooldown(2 * 1000)
spell:vocation("sorcerer;true", "master sorcerer;true")
spell:register()
