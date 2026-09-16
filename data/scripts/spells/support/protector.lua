dofile(CORE_DIRECTORY .. "/scripts/spells/support/stances_lib.lua")

local spell = Spell("instant")

function spell.onCastSpell(creature, variant)
	local player = creature:getPlayer()
	if not player then return false end
	return StanceSystem.toggle(player, "protector", CONST_ME_MAGIC_GREEN)
end

spell:name("Protector")
spell:words("utamo tempo")
spell:group("support")
spell:vocation("knight;true", "elite knight;true")
spell:castSound(SOUND_EFFECT_TYPE_SPELL_PROTECTOR)
spell:id(132)
spell:cooldown(2 * 1000)
spell:groupCooldown(2 * 1000)
spell:level(55)
spell:mana(200)
spell:isSelfTarget(true)
spell:isAggressive(false)
spell:isPremium(true)
spell:register()
