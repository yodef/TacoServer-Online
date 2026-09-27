local function getEtherealBarrageGrade(player)
	if not player then
		return 0
	end
	return math.max(player:upgradeSpellsWOD("Ethereal Barrage"), player:upgradeSpellsWOD("Sharpshooter"))
end

local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_HITAREA)
combat:setParameter(COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_ETHEREALSPEAR)
combat:setParameter(COMBAT_PARAM_BLOCKARMOR, 1)
combat:setArea(createCombatArea(AREA_CIRCLE3X3))

function onGetFormulaValues(player, skill, attack, factor)
	local grade = getEtherealBarrageGrade(player)
	local mult = (grade >= 2) and 1.10 or 1.0

	local levelTotal = player:getLevel() / 5
	local min = -(((2 * skill + attack / 2500) * 1.8) + levelTotal + 5) * mult
	local max = -(((2 * skill + attack / 1875) * 2.6) + levelTotal + 10) * mult
	return min, max
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

	local execVar = targetCreature and Variant(targetCreature:getId()) or Variant(centerPos)
	if not combat:execute(player, execVar) then
		return false
	end

	-- Stage I: 10% Life Leech
	local grade = getEtherealBarrageGrade(player)
	if grade >= 1 then
		local hpToHeal = math.floor(player:getMaxHealth() * 0.05)
		if hpToHeal > 0 and player:getHealth() < player:getMaxHealth() then
			player:addHealth(hpToHeal)
			player:getPosition():sendMagicEffect(CONST_ME_MAGIC_RED)
		end
	end

	return true
end

spell:group("attack")
spell:id(303)
spell:name("Ethereal Barrage")
spell:words("exori dir moe")
spell:castSound(SOUND_EFFECT_TYPE_SPELL_STRONG_ETHEREAL_SPEAR)
spell:level(60)
spell:mana(135)
spell:isPremium(true)
spell:cooldown(4 * 1000)
spell:groupCooldown(2 * 1000)
spell:vocation("paladin;true", "royal paladin;true")
spell:register()
