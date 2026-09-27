local function getThousandFistBlowsGrade(player)
	if not player then
		return 0
	end
	return math.max(player:upgradeSpellsWOD("Thousand Fist Blows"), player:upgradeSpellsWOD("Flurry of Blows"))
end

local SPELL_BASE_POWER = 110

local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_BLOW_WHITE)
combat:setParameter(COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_SMALLHOLY)
combat:setParameter(COMBAT_PARAM_BLOCKARMOR, 1)
combat:setArea(createCombatArea(AREA_CIRCLE3X3))

function onGetFormulaValues(player, skill, attack, factor)
	local damageHealing = player:calculateFlatDamageHealing()
	local grade = getThousandFistBlowsGrade(player)
	local mult = (grade >= 2) and 1.12 or 1.0

	local damage = (SPELL_BASE_POWER * (skill / 100) * (attack / 10) + damageHealing) * mult
	local min = damage - (damage / 10)
	local max = damage + (damage / 10)
	return -min, -max
end

combat:setCallback(CALLBACK_PARAM_SKILLVALUE, "onGetFormulaValues")

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

	local grade = getThousandFistBlowsGrade(player)
	local cdMs = (grade >= 1) and 6000 or 8000
	local condition = Condition(CONDITION_SPELLCOOLDOWN, CONDITIONID_DEFAULT, 301)
	local rate = configManager.getFloat(configKeys.RATE_SPELL_COOLDOWN)
	if not rate or rate <= 0 then
		rate = 1.0
	end
	condition:setTicks(cdMs / rate)
	player:addCondition(condition)

	local execVar = targetCreature and Variant(targetCreature:getId()) or Variant(centerPos)
	return combat:execute(player, execVar)
end

spell:group("attack")
spell:id(301)
spell:name("Thousand Fist Blows")
spell:words("exori mas amp pug")
spell:castSound(SOUND_EFFECT_TYPE_SPELL_DIVINE_CALDERA)
spell:level(120)
spell:mana(145)
spell:isPremium(true)
spell:cooldown(1000) -- Dynamic cooldown calculated on cast (6s or 8s)
spell:groupCooldown(2 * 1000)

spell:monkSpellType(MonkSpell_Builder)
spell:vocation("monk;true", "exalted monk;true")
spell:register()
