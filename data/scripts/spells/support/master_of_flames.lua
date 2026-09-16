dofile(CORE_DIRECTORY .. "/scripts/spells/support/stances_lib.lua")

local spell = Spell("instant")

function spell.onCastSpell(creature, var)
	local player = creature:getPlayer()
	if not player then return false end
	return StanceSystem.toggle(player, "flames", CONST_ME_FIREAREA)
end

spell:name("Master of Flames")
spell:words("uteta flam")
spell:group("support")
spell:vocation("sorcerer;true", "master sorcerer;true")
spell:castSound(SOUND_EFFECT_TYPE_SPELL_FIRE_WAVE)
spell:id(304)
spell:cooldown(2 * 1000)
spell:groupCooldown(2 * 1000)
spell:level(60)
spell:mana(150)
spell:isSelfTarget(true)
spell:isAggressive(false)
spell:isPremium(true)
spell:register()
