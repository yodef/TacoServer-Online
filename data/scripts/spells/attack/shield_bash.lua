local function getEquippedShield(player)
	if not player then return nil, nil end
	for _, slot in ipairs({ CONST_SLOT_LEFT, CONST_SLOT_RIGHT }) do
		local item = player:getSlotItem(slot)
		if item then
			local it = item:getType()
			if it and it:getWeaponType() == WEAPON_SHIELD then
				return item, it
			end
		end
	end
	return nil, nil
end

local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_BLOCKHIT)
combat:setParameter(COMBAT_PARAM_BLOCKARMOR, 1)

function onTargetCreature(creature, target)
	if not target or target:isPlayer() then
		return true
	end
	local condition = Condition(CONDITION_ATTRIBUTES)
	condition:setParameter(CONDITION_PARAM_TICKS, 10000)
	condition:setParameter(CONDITION_PARAM_BUFF_DAMAGEDEALT, 50)
	target:addCondition(condition)
	return true
end

combat:setCallback(CALLBACK_PARAM_TARGETCREATURE, "onTargetCreature")

function onGetFormulaValues(player, skill, attack, factor)
	local shield, it = getEquippedShield(player)
	local defense = 30
	if it then
		local d = it:getDefense()
		local ed = it:getExtraDefense() or 0
		if d and d > 0 then
			defense = d + ed
		end
	end

	local shieldSkill = player:getSkillLevel(SKILL_SHIELD)
	local level = player:getLevel()
	local skillTotal = shieldSkill * defense
	local levelTotal = level / 5

	local min = (skillTotal * 0.05) + 20 + levelTotal
	local max = (skillTotal * 0.09) + 40 + levelTotal

	return -min, -max
end

combat:setCallback(CALLBACK_PARAM_SKILLVALUE, "onGetFormulaValues")

local spell = Spell("instant")

function spell.onCastSpell(creature, var)
	local player = creature:getPlayer()
	if not player then return false end

	local shield, it = getEquippedShield(player)
	if not shield then
		player:sendCancelMessage("You need to equip a shield to cast this spell.")
		player:getPosition():sendMagicEffect(CONST_ME_POFF)
		return false
	end

	local varNum = var:getNumber()
	local target = player:getTarget()
	local targetCreature = nil

	if varNum and varNum > 0 and Creature(varNum) then
		targetCreature = Creature(varNum)
	elseif target and not target:isRemoved() and target:getHealth() > 0 then
		targetCreature = target
	end

	if not targetCreature then
		player:sendCancelMessage("You need to select a target first.")
		player:getPosition():sendMagicEffect(CONST_ME_POFF)
		return false
	end

	if player:getPosition():getDistance(targetCreature:getPosition()) > 1 then
		player:sendCancelMessage("Target is too far away.")
		player:getPosition():sendMagicEffect(CONST_ME_POFF)
		return false
	end

	return combat:execute(player, Variant(targetCreature:getId()))
end

spell:group("attack")
spell:id(321)
spell:name("Shield Bash")
spell:words("exori ico scu")
spell:level(18)
spell:mana(30)
spell:range(1)
spell:needTarget(true)
spell:needWeapon(false)
spell:cooldown(4 * 1000)
spell:groupCooldown(2 * 1000)
spell:isPremium(true)
spell:vocation("knight;true", "elite knight;true")
spell:register()
