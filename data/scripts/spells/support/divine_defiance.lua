dofile(CORE_DIRECTORY .. "/scripts/spells/support/stances_lib.lua")

local spell = Spell("instant")

function spell.onCastSpell(creature, var)
	local player = creature:getPlayer()
	if not player then return false end
	return StanceSystem.toggle(player, "divine-defiance", CONST_ME_HOLYDAMAGE)
end

spell:name("Divine Defiance")
spell:words("utori hur")
spell:group("support")
spell:vocation("paladin;true", "royal paladin;true")
spell:castSound(SOUND_EFFECT_TYPE_SPELL_PROTECTOR)
spell:id(308)
spell:cooldown(2 * 1000)
spell:groupCooldown(2 * 1000)
spell:level(55)
spell:mana(150)
spell:isSelfTarget(true)
spell:isAggressive(false)
spell:isPremium(true)
spell:register()

local legacyDefiance = Spell("instant")

function legacyDefiance.onCastSpell(creature, var)
	local player = creature:getPlayer()
	if not player then return false end
	return StanceSystem.toggle(player, "divine-defiance", CONST_ME_HOLYDAMAGE)
end

legacyDefiance:name("Divine Defiance (Legacy)")
legacyDefiance:words("utamo con")
legacyDefiance:group("support")
legacyDefiance:vocation("paladin;true", "royal paladin;true")
legacyDefiance:castSound(SOUND_EFFECT_TYPE_SPELL_PROTECTOR)
legacyDefiance:cooldown(2 * 1000)
legacyDefiance:groupCooldown(2 * 1000)
legacyDefiance:level(55)
legacyDefiance:mana(150)
legacyDefiance:isSelfTarget(true)
legacyDefiance:isAggressive(false)
legacyDefiance:isPremium(true)
legacyDefiance:register()
