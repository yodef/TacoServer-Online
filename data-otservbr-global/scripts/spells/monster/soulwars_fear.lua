local combat = Combat()
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_BLUE_GHOST)

local condition = Condition(CONDITION_FEARED)
condition:setParameter(CONDITION_PARAM_TICKS, 3000)
combat:addCondition(condition)

local spell = Spell("instant")

local function executeCombat(cid, var)
	local creature = Creature(cid)
	if not creature then
		return
	end
	local target = (var and var.getNumber and Creature(var:getNumber())) or creature:getTarget()
	if target and target:isPlayer() and target.hasBountyAmuletEquipped and target:hasBountyAmuletEquipped() then
		if target.getAmuletUpgrade and target:getAmuletUpgrade("fear") > 0 then
			target:getPosition():sendMagicEffect(CONST_ME_HOLYDAMAGE)
			return false
		end
	end
	return combat:execute(creature, var)
end

function spell.onCastSpell(creature, var)
	local target = (var and var.getNumber and Creature(var:getNumber())) or creature:getTarget()
	if target and target:isPlayer() and target.hasBountyAmuletEquipped and target:hasBountyAmuletEquipped() then
		if target.getAmuletUpgrade and target:getAmuletUpgrade("fear") > 0 then
			target:getPosition():sendMagicEffect(CONST_ME_HOLYDAMAGE)
			return false
		end
	end
	creature:getPosition():sendMagicEffect(CONST_ME_GHOST_SMOKE)
	addEvent(executeCombat, 2000, creature:getId(), var)
	return true
end

spell:name("soulwars fear")
spell:words("###611")
spell:blockWalls(true)
spell:needTarget(true)
spell:needLearn(true)
spell:register()
