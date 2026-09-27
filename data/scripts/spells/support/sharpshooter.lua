dofile(CORE_DIRECTORY .. "/scripts/spells/support/stances_lib.lua")

local spell = Spell("instant")

function spell.onCastSpell(creature, var)
	local player = creature:getPlayer()
	if not player then return false end
	return StanceSystem.toggle(player, "sharpshooter", CONST_ME_MAGIC_GREEN)
end

spell:name("Sharpshooter")
spell:words("utori con")
spell:group("support")
spell:vocation("paladin;true", "royal paladin;true")
spell:castSound(SOUND_EFFECT_TYPE_SPELL_SHARPSHOOTER)
spell:id(135)
spell:cooldown(2 * 1000)
spell:groupCooldown(2 * 1000)
spell:level(60)
spell:mana(150)
spell:isSelfTarget(true)
spell:isAggressive(false)
spell:isPremium(true)
spell:register()

local legacySpell = Spell("instant")

function legacySpell.onCastSpell(creature, var)
	local player = creature:getPlayer()
	if not player then return false end
	return StanceSystem.toggle(player, "sharpshooter", CONST_ME_MAGIC_GREEN)
end

legacySpell:name("Sharpshooter (Legacy)")
legacySpell:words("utito tempo san")
legacySpell:group("support")
legacySpell:vocation("paladin;true", "royal paladin;true")
legacySpell:castSound(SOUND_EFFECT_TYPE_SPELL_SHARPSHOOTER)
legacySpell:cooldown(2 * 1000)
legacySpell:groupCooldown(2 * 1000)
legacySpell:level(60)
legacySpell:mana(150)
legacySpell:isSelfTarget(true)
legacySpell:isAggressive(false)
legacySpell:isPremium(true)
legacySpell:register()
