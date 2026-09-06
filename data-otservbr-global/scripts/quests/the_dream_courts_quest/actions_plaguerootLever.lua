local config = {
	boss = {
		name = "Plagueroot",
		position = Position(32180, 32047, 13),
	},
	requiredLevel = 250,
	timeToDefeat = 15 * 60,
	playerPositions = {
		{ pos = Position(32188, 32048, 13), teleport = Position(32185, 32048, 13), effect = CONST_ME_TELEPORT },
		{ pos = Position(32188, 32047, 13), teleport = Position(32185, 32048, 13), effect = CONST_ME_TELEPORT },
		{ pos = Position(32188, 32049, 13), teleport = Position(32185, 32048, 13), effect = CONST_ME_TELEPORT },
		{ pos = Position(32189, 32048, 13), teleport = Position(32185, 32048, 13), effect = CONST_ME_TELEPORT },
	},
	specPos = {
		from = Position(32173, 32039, 13),
		to = Position(32186, 32056, 13),
	},
	exit = Position(32185, 32052, 13),
}

local lever = BossLever(config)
lever:position(Position(32187, 32048, 13))
lever:register()
