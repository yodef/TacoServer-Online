local mType = Game.createMonsterType("Hellhunter Inferniarch")
local monster = {}

monster.description = "a hellhunter inferniarch"
monster.experience = 8100
monster.outfit = {
	lookType = 1793,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}

monster.raceId = 2600
monster.Bestiary = {
	class = "Demon",
	race = BESTY_RACE_DEMON,
	toKill = 2500,
	FirstUnlock = 50,
	SecondUnlock = 500,
	CharmsPoints = 50,
	Stars = 4,
	Occurrence = 1,
	Locations = "Azzilon Castle Catacombs.",
}

monster.health = 11300
monster.maxHealth = 11300
monster.race = "fire"
monster.corpse = 49994
monster.speed = 175
monster.manaCost = 0

monster.changeTarget = {
	interval = 4000,
	chance = 10,
}

monster.strategiesTarget = {
	nearest = 70,
	health = 10,
	damage = 10,
	random = 10,
}

monster.flags = {
	summonable = false,
	attackable = true,
	hostile = true,
	convinceable = false,
	pushable = false,
	rewardBoss = false,
	illusionable = false,
	canPushItems = true,
	canPushCreatures = true,
	staticAttackChance = 80,
	targetDistance = 4,
	runHealth = 0,
	healthHidden = false,
	isBlockable = false,
	canWalkOnEnergy = true,
	canWalkOnFire = true,
	canWalkOnPoison = true,
	isPreyExclusive = true,
}

monster.light = {
	level = 0,
	color = 0,
}

monster.voices = {
	interval = 5000,
	chance = 10,
	{ text = "Ardash... El...!", yell = true },
	{ text = "Urrrglll!", yell = true },
}

monster.loot = {
	{ name = "platinum coin", chance = 5000, maxCount = 35 },
	{ name = "assassin star", chance = 3000, maxCount = 10 },
	{ name = "demonic core essence", chance = 100 },
	{ name = "hellhunter eye", chance = 1500 },
	{ name = "small amethyst", chance = 3000, maxCount = 4 },
	{ name = "dark helmet", chance = 1500 },
	{ name = "sniper arrow", chance = 1500, maxCount = 5 },
	{ name = "demonic matter", chance = 4761 },
	{ name = "onyx arrow", chance = 1000, maxCount = 5 },
	{ id = 6299, chance = 900 }, -- death ring
	{ name = "cyan crystal fragment", chance = 900 },
	{ name = "demonic finger", chance = 155 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -400 },
	{ name = "combat", interval = 2000, chance = 35, type = COMBAT_PHYSICALDAMAGE, minDamage = -350, maxDamage = -580, range = 6, shootEffect = CONST_ANI_SNIPERARROW, effect = CONST_ME_HITAREA, target = true },
	{ name = "combat", interval = 2000, chance = 20, type = COMBAT_DEATHDAMAGE, minDamage = -300, maxDamage = -520, range = 6, shootEffect = CONST_ANI_BOLT, effect = CONST_ME_MORTAREA, target = true },
	{ name = "combat", interval = 2500, chance = 15, type = COMBAT_FIREDAMAGE, minDamage = -280, maxDamage = -480, range = 5, radius = 2, shootEffect = CONST_ANI_BURSTARROW, effect = CONST_ME_FIREAREA, target = true },
}

monster.defenses = {
	defense = 15,
	armor = 73,
	mitigation = 2.19,
}

monster.elements = {
	{ type = COMBAT_DEATHDAMAGE, percent = -15 },
	{ type = COMBAT_EARTHDAMAGE, percent = -15 },
	{ type = COMBAT_HOLYDAMAGE, percent = 0 },
	{ type = COMBAT_FIREDAMAGE, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = 5 },
	{ type = COMBAT_PHYSICALDAMAGE, percent = 10 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 15 },
	{ type = COMBAT_LIFEDRAIN, percent = 100 },
	{ type = COMBAT_MANADRAIN, percent = 100 },
}

monster.immunities = {
	{ type = "paralyze", condition = true },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)
