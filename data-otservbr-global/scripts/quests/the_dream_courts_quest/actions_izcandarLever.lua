local config = {
	boss = {
		name = "Izcandar The Banished",
		position = Position(32240, 32047, 13),
	},
	requiredLevel = 250,
	timeToDefeat = 15 * 60,
	playerPositions = {
		{ pos = Position(32228, 32047, 13), teleport = Position(32231, 32047, 13), effect = CONST_ME_TELEPORT },
		{ pos = Position(32228, 32046, 13), teleport = Position(32231, 32047, 13), effect = CONST_ME_TELEPORT },
		{ pos = Position(32228, 32048, 13), teleport = Position(32231, 32047, 13), effect = CONST_ME_TELEPORT },
		{ pos = Position(32227, 32047, 13), teleport = Position(32231, 32047, 13), effect = CONST_ME_TELEPORT },
	},
	specPos = {
		from = Position(32231, 32040, 13),
		to = Position(32244, 32056, 13),
	},
	exit = Position(32231, 32050, 13),
}

local lever = BossLever(config)
lever:position(Position(32229, 32047, 13))
lever:register()
