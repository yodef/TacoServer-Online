local config = {
	boss = {
		name = "Malofur Mangrinder",
		position = Position(32207, 32047, 14),
	},
	requiredLevel = 250,
	timeToDefeat = 15 * 60,
	playerPositions = {
		{ pos = Position(32208, 32058, 13), teleport = Position(32207, 32055, 14), effect = CONST_ME_TELEPORT },
		{ pos = Position(32207, 32058, 13), teleport = Position(32207, 32055, 14), effect = CONST_ME_TELEPORT },
		{ pos = Position(32209, 32058, 13), teleport = Position(32207, 32055, 14), effect = CONST_ME_TELEPORT },
		{ pos = Position(32208, 32059, 13), teleport = Position(32207, 32055, 14), effect = CONST_ME_TELEPORT },
	},
	specPos = {
		from = Position(32200, 32040, 14),
		to = Position(32215, 32055, 14),
	},
	exit = Position(32203, 32054, 14),
}

local lever = BossLever(config)
lever:position(Position(32208, 32057, 13))
lever:register()
