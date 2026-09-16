dofile(CORE_DIRECTORY .. "/scripts/spells/support/stances_lib.lua")

local spell = Spell("instant")

function spell.onCastSpell(creature, var)
	local player = creature:getPlayer()
	if not player then return false end
	return StanceSystem.toggle(player, "sniper", CONST_ME_CRITICAL_DAMAGE)
end

spell:name("Sniper Stance")
spell:words("utito con")
spell:group("support")
spell:vocation("paladin;true", "royal paladin;true")
spell:castSound(SOUND_EFFECT_TYPE_SPELL_SHARPSHOOTER)
spell:id(307)
spell:cooldown(2 * 1000)
spell:groupCooldown(2 * 1000)
spell:level(60)
spell:mana(150)
spell:isSelfTarget(true)
spell:isAggressive(false)
spell:isPremium(true)
spell:register()
