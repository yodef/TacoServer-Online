local foods = {
	3577, -- meat
	3582, -- ham
	3592, -- grape
	3585, -- apple
	3600, -- bread
	3601, -- roll
	3607, -- cheese
	3725, -- bmush
	3583, -- dham
	3731, --fire mush
	6574, --chocolate bar
	5096, --mango
	3578, --fish
}

local spell = Spell("instant")

function spell.onCastSpell(creature, variant)
	if math.random(0, 1) == 1 then
		creature:addItem(foods[math.random(#foods)])
	end

	creature:addItem(foods[math.random(#foods)])
	creature:addItem(foods[math.random(#foods)])
	creature:addItem(foods[math.random(#foods)])
	creature:getPosition():sendMagicEffect(CONST_ME_MAGIC_GREEN)
	return true
end

spell:name("Food")
spell:words("exevo pan")
spell:group("support")
spell:vocation("druid;true", "elder druid;true", "knight;true", "elite knight;true", "paladin;true", "royal paladin;true", "sorcerer;true", "master sorcerer;true", "monk;true", "exalted monk;true")
spell:castSound(SOUND_EFFECT_TYPE_SPELL_FOOD)
spell:id(42)
spell:cooldown(2 * 1000)
spell:groupCooldown(2 * 1000)
spell:level(14)
spell:mana(20)
spell:soul(3)
spell:isAggressive(false)
spell:needLearn(false)
spell:register()
