local combat = Combat()
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_HOLYAREA)
combat:setParameter(COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_SMALLHOLY)
combat:setArea(createCombatArea(AREA_CIRCLE3X3))

function onTargetCreature_HolyFlash(creature, target)
	local player = creature:getPlayer()
	if not player or not target or target:isRemoved() or target:getHealth() <= 0 then
		return false
	end

	if target:isImmune(CONDITION_DAZZLED) then
		return false
	end

	local level = player:getLevel()
	local dist = player:getSkillLevel(SKILL_DISTANCE)
	local magLevel = player:getMagicLevel()

	-- Scaled continuous holy/dazzled damage based on Distance + Magic Level + Level (-55% adjusted)
	local minTick = math.max(1, math.floor(((level / 5) + (dist * 1.1) + (magLevel * 2.5)) * 0.45))
	local maxTick = math.max(minTick, math.floor(((level / 5) + (dist * 1.6) + (magLevel * 3.5)) * 0.45))

	local condition = Condition(CONDITION_DAZZLED)
	condition:setParameter(CONDITION_PARAM_OWNER, player:getId())
	condition:setParameter(CONDITION_PARAM_DELAYED, 0)

	-- 10 ticks every 2000 ms (20 seconds total)
	for i = 1, 10 do
		condition:addDamage(1, 2000, -math.random(minTick, maxTick))
	end

	target:addCondition(condition)
	return true
end

combat:setCallback(CALLBACK_PARAM_TARGETCREATURE, "onTargetCreature_HolyFlash")

local spell = Spell("instant")

function spell.onCastSpell(creature, var)
	local player = creature:getPlayer()
	if not player then
		return combat:execute(creature, var)
	end

	local maxRange = 5
	local targetCreature = nil
	local varNum = var:getNumber()
	if varNum and varNum > 0 and Creature(varNum) and varNum ~= player:getId() then
		targetCreature = Creature(varNum)
	elseif player:getTarget() and not player:getTarget():isRemoved() and player:getTarget():getHealth() > 0 then
		targetCreature = player:getTarget()
	end

	local centerPos = player:getPosition()
	if targetCreature then
		local targetPos = targetCreature:getPosition()
		if player:getPosition():getDistance(targetPos) > maxRange then
			player:sendCancelMessage("Destination is out of reach.")
			player:getPosition():sendMagicEffect(CONST_ME_POFF)
			return false
		end
		if not player:canSee(targetPos) then
			player:sendCancelMessage("Creature is not reachable.")
			player:getPosition():sendMagicEffect(CONST_ME_POFF)
			return false
		end
		centerPos = targetPos
	end

	return combat:execute(player, Variant(centerPos))
end

spell:group("attack")
spell:id(143)
spell:name("Holy Flash")
spell:words("utori san")
spell:castSound(SOUND_EFFECT_TYPE_SPELL_OR_RUNE)
spell:impactSound(SOUND_EFFECT_TYPE_SPELL_HOLY_FLASH)
spell:level(70)
spell:mana(30)
spell:isAggressive(true)
spell:range(5)
spell:needTarget(false)
spell:blockWalls(true)
spell:cooldown(20 * 1000)
spell:groupCooldown(2 * 1000)

spell:vocation("paladin;true", "royal paladin;true")
spell:register()