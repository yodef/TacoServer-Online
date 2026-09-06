local spell = Spell("instant")

function spell.onCastSpell(creature, variant)
	return creature:conjureItem(3147, 3197, 10)
end

spell:name("Disintegrate Rune")
spell:words("adito tera")
spell:group("support")
spell:vocation("druid;true", "elder druid;true", "paladin;true", "royal paladin;true", "sorcerer;true", "master sorcerer;true")
spell:cooldown(2 * 1000)
spell:groupCooldown(2 * 1000)
spell:level(21)
spell:mana(200)
spell:soul(1)
spell:isAggressive(false)
spell:isPremium(true)
spell:needLearn(false)
spell:register()
