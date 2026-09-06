local config = {
	boss = {
		name = "Alptramun",
		position = Position(32207, 32022, 13),
	},
	requiredLevel = 250,
	timeToDefeat = 15 * 60,
	playerPositions = {
		{ pos = Position(32208, 32033, 13), teleport = Position(32207, 32029, 13), effect = CONST_ME_TELEPORT },
		{ pos = Position(32207, 32033, 13), teleport = Position(32207, 32029, 13), effect = CONST_ME_TELEPORT },
		{ pos = Position(32209, 32033, 13), teleport = Position(32207, 32029, 13), effect = CONST_ME_TELEPORT },
		{ pos = Position(32208, 32034, 13), teleport = Position(32207, 32029, 13), effect = CONST_ME_TELEPORT },
	},
	specPos = {
		from = Position(32201, 32018, 13),
		to = Position(32213, 32030, 13),
	},
	exit = Position(32202, 32029, 13),
}

local lever = BossLever(config)
lever:position(Position(32208, 32032, 13))
lever:register()
