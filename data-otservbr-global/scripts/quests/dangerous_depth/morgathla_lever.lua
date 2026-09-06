local config = {
	boss = {
		name = "Ancient Spawn of Morgathla",
		position = Position(33732, 32342, 15),
	},
	requiredLevel = 300,
	playerPositions = {
		{ pos = Position(33681, 32383, 15), teleport = Position(33732, 32353, 15), effect = CONST_ME_TELEPORT },
		{ pos = Position(33681, 32384, 15), teleport = Position(33732, 32354, 15), effect = CONST_ME_TELEPORT },
		{ pos = Position(33681, 32385, 15), teleport = Position(33732, 32355, 15), effect = CONST_ME_TELEPORT },
		{ pos = Position(33681, 32386, 15), teleport = Position(33732, 32356, 15), effect = CONST_ME_TELEPORT },
		{ pos = Position(33680, 32384, 15), teleport = Position(33731, 32354, 15), effect = CONST_ME_TELEPORT },
		{ pos = Position(33680, 32385, 15), teleport = Position(33731, 32355, 15), effect = CONST_ME_TELEPORT },
		{ pos = Position(33680, 32386, 15), teleport = Position(33731, 32356, 15), effect = CONST_ME_TELEPORT },
		{ pos = Position(33682, 32384, 15), teleport = Position(33733, 32354, 15), effect = CONST_ME_TELEPORT },
		{ pos = Position(33682, 32385, 15), teleport = Position(33733, 32355, 15), effect = CONST_ME_TELEPORT },
		{ pos = Position(33682, 32386, 15), teleport = Position(33733, 32356, 15), effect = CONST_ME_TELEPORT },		
	},
	specPos = {
		from = Position(33718, 32333, 15),
		to = Position(33746, 32359, 15),
	},
	exit = Position(33733, 32359, 15),
}

local lever = BossLever(config)
lever:position({ x = 33681, y = 32382, z = 15 })
lever:register()
