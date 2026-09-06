local config = {
	boss = {
		name = "Maxxenius",
		position = Position(32191, 32073, 13),
	},
	requiredLevel = 250,
	timeToDefeat = 15 * 60,
	playerPositions = {
		{ pos = Position(32203, 32073, 13), teleport = Position(32200, 32073, 13), effect = CONST_ME_TELEPORT },
		{ pos = Position(32203, 32074, 13), teleport = Position(32200, 32073, 13), effect = CONST_ME_TELEPORT },
		{ pos = Position(32203, 32072, 13), teleport = Position(32200, 32073, 13), effect = CONST_ME_TELEPORT },
		{ pos = Position(32204, 32073, 13), teleport = Position(32200, 32073, 13), effect = CONST_ME_TELEPORT },
	},
	specPos = {
		from = Position(32201, 32018, 13),
		to = Position(32213, 32030, 13),
	},
	exit = Position(32202, 32029, 13),
}

local lever = BossLever(config)
lever:position(Position(32202, 32073, 13))
lever:register()
