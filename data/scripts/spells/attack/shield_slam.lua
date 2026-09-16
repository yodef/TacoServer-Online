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
combat:setArea(createCombatArea(AREA_SQUARE1X1))

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

	local min = (skillTotal * 0.06) + 30 + levelTotal
	local max = (skillTotal * 0.11) + 60 + levelTotal

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

	return combat:execute(player, Variant(player:getPosition()))
end

spell:group("attack")
spell:id(322)
spell:name("Shield Slam")
spell:words("exori scu")
spell:level(30)
spell:mana(110)
spell:isSelfTarget(true)
spell:needWeapon(false)
spell:cooldown(6 * 1000)
spell:groupCooldown(2 * 1000)
spell:isPremium(true)
spell:vocation("knight;true", "elite knight;true")
spell:register()
