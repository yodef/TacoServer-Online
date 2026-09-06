--local ThreatenedDreams = Storage.Quest.U11_40.ThreatenedDreams

local config = {
	[30000] = {
		bossName = "Sugar Daddy",
		bossPos = Position(33371, 32221, 9),
		centerPos = Position(33371, 32225, 9),
		newPos = Position(33378, 32234, 9),
		exitPos = Position(33372, 32235, 9),
		rangeX = 10,
		rangeY = 10,
		time = 10, -- minutos
	},
}

local sugarDaddyRoom = MoveEvent()

function sugarDaddyRoom.onStepIn(creature, item, position, fromPosition)
	local player = creature:getPlayer()
	if not player then
		return
	end

	local room = config[item.actionid]
	if not room then
		return
	end

	-- Salida del cuarto
	if player:getPosition() == Position(33372, 32236, 9) then
		position:sendMagicEffect(CONST_ME_TELEPORT)
		player:teleportTo(room.exitPos)
		player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
		return true
	end

	-- Cooldown
	if not player:canFightBoss(room.bossName) then
		position:sendMagicEffect(CONST_ME_TELEPORT)
		player:teleportTo(fromPosition, true)
		player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
		player:say("You have to wait to challenge this enemy again!", TALKTYPE_MONSTER_SAY)
		return true
	end

	-- Revisión de sala ocupada (Buscando SOLO jugadores usando Game.getSpectators)
	local players = Game.getSpectators(room.centerPos, false, true, room.rangeX, room.rangeX, room.rangeY, room.rangeY)
	if #players > 0 then
		position:sendMagicEffect(CONST_ME_TELEPORT)
		player:teleportTo(fromPosition, true)
		player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
		player:say("Someone is fighting against the boss! You need wait awhile.", TALKTYPE_MONSTER_SAY)
		return true
	end

	-- Limpieza de sala (Buscando y eliminando SOLO monstruos)
	local creatures = Game.getSpectators(room.centerPos, false, false, room.rangeX, room.rangeX, room.rangeY, room.rangeY)
	for _, c in ipairs(creatures) do
		if c:isMonster() then
			c:remove()
		end
	end

	local spawnPositions = {
		room.bossPos, -- Sugar Daddy
		Position(room.bossPos.x + 1, room.bossPos.y, room.bossPos.z), -- Sugar Mommy
		Position(room.bossPos.x - 1, room.bossPos.y, room.bossPos.z), -- Sugar Cube 1
		Position(room.bossPos.x, room.bossPos.y + 1, room.bossPos.z), -- Sugar Cube 2
		Position(room.bossPos.x, room.bossPos.y - 1, room.bossPos.z), -- Sugar Cube 3
		Position(room.bossPos.x + 2, room.bossPos.y + 2, room.bossPos.z) -- Sugar Cube 4
	}

	local monsters = {
		"Sugar Daddy",
		"Sugar Mommy",
		"Sugar Cube",
		"Sugar Cube",
		"Sugar Cube",
		"Sugar Cube"
	}

	for i = 1, #monsters do
		Game.createMonster(monsters[i], spawnPositions[i], true, true)
	end

	-- Teleportar al jugador
	position:sendMagicEffect(CONST_ME_TELEPORT)
	player:teleportTo(room.newPos)
	player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)

	player:say("You have ten minutes to kill and loot this boss, else you will lose that chance and will be kicked out.", TALKTYPE_MONSTER_SAY)
	
	-- Mantuvimos el evento global clearBossRoom ya que suele manejar otras cosas en tu servidor (como expulsar al jugador)
	addEvent(clearBossRoom, 60 * room.time * 1000, player.uid, room.centerPos, false, room.rangeX, room.rangeY, room.exitPos)
	
	player:setBossCooldown(room.bossName, os.time() + 2 * 3600)

	return true
end

sugarDaddyRoom:type("stepin")
sugarDaddyRoom:aid(30000)
sugarDaddyRoom:register()