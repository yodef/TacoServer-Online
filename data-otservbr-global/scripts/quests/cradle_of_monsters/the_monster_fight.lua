local bossZone = Zone("boss.the-monster")
local puddleId = 42075

local encounter = Encounter("The Monster", {
	zone = bossZone,
	timeToSpawnMonsters = "10ms",
})

function encounter:onReset(position)
	encounter:removeMonsters()
end

encounter:addRemoveMonsters():autoAdvance()

-- Invocación directa del boss final con sus 20 escudos
encounter:addSpawnMonsters({
	{
		name = "The Monster",
		event = { "fight.the-monster.TheMonsterHealth", "fight.the-monster.TheMonsterDeath" },
		positions = {
			Position(33845, 32591, 12),
		},
		spawn = function(monster)
			monster:setIcon("the-monster", CreatureIconCategory_Quests, CreatureIconQuests_PurpleShield, 10)
		end,
	},
})

encounter:register()

-- Mecánica de Alchemist Containers (necesaria para remover escudos con charcos)
local alchemistContainerDeath = CreatureEvent("fight.the-monster.AlchemistContainerDeath")
function alchemistContainerDeath.onDeath(creature)
	local directions = { DIRECTION_NORTH, DIRECTION_EAST, DIRECTION_SOUTH, DIRECTION_WEST }
	for _, direction in ipairs(directions) do
		local position = creature:getPosition()
		position:getNextPosition(direction)
		local tile = Tile(position)
		if tile:isWalkable(false, false, false, true, true) then
			local item = Game.createItem(puddleId, 1, position)
			item:decay()
			break
		end
	end
end

alchemistContainerDeath:register()

local alchemistContainerSpawns = GlobalEvent("fight.the-monster.containers.alchemist.onThink")
local alchemistContainerPositions = {
	{ x = 33834, y = 32585, z = 12 },
	{ x = 33840, y = 32585, z = 12 },
	{ x = 33845, y = 32587, z = 12 },
	{ x = 33845, y = 32595, z = 12 },
	{ x = 33840, y = 32597, z = 12 },
	{ x = 33834, y = 32597, z = 12 },
	{ x = 33829, y = 32595, z = 12 },
	{ x = 33829, y = 32592, z = 12 },
	{ x = 33829, y = 32590, z = 12 },
	{ x = 33829, y = 32587, z = 12 },
}

function alchemistContainerSpawns.onThink()
	for _, position in ipairs(alchemistContainerPositions) do
		local tile = Tile(position)
		if tile and tile:getCreatureCount() == 0 then
			local corpse = tile:getItemById(39949)
			if corpse then
				corpse:remove()
			end
			local monster = Game.createMonster("alchemist container", position)
			if monster then
				monster:registerEvent("fight.the-monster.AlchemistContainerDeath")
			end
		end
	end
	return true
end

alchemistContainerSpawns:interval(10000)
alchemistContainerSpawns:register()

-- Lógica de Escudos y Daño de The Monster
local function getShields(creature)
	local currentIcon = creature:getIcon("the-monster")
	if not currentIcon or currentIcon.category ~= CreatureIconCategory_Quests or currentIcon.icon ~= CreatureIconQuests_PurpleShield then
		return 0
	end
	if currentIcon.count <= 0 then
		creature:removeIcon("the-monster")
		return 0
	end
	return currentIcon.count
end

local function setShields(creature, count)
	if count <= 0 then
		creature:removeIcon("the-monster")
		return
	end
	creature:setIcon("the-monster", CreatureIconCategory_Quests, CreatureIconQuests_PurpleShield, count)
end

local monsterHealth = CreatureEvent("fight.the-monster.TheMonsterHealth")
function monsterHealth.onHealthChange(creature, attacker, primaryDamage, primaryType, secondaryDamage, secondaryType)
	if not creature then
		return primaryDamage, primaryType, secondaryDamage, secondaryType
	end
	local shields = getShields(creature)
	local multiplier = 1 - shields * 0.05
	return primaryDamage * multiplier, primaryType, secondaryDamage * multiplier, secondaryType
end

monsterHealth:register()

local monsterDeath = CreatureEvent("fight.the-monster.TheMonsterDeath")
function monsterDeath.onDeath(creature)
	encounter:nextStage()
end

monsterDeath:register()

-- Romper escudos al pisar los charcos (Puddles)
local puddleStepIn = MoveEvent("fight.the-monster.PuddleStepIn")
function puddleStepIn.onStepIn(creature, item, position, fromPosition)
	if not creature or creature:getName() ~= "The Monster" then
		return true
	end
	item:remove()
	local current = getShields(creature)
	if current <= 0 then
		return true
	end
	setShields(creature, current - 1)
	creature:getPosition():sendMagicEffect(CONST_ME_ORANGE_ENERGY_SPARK)
	return true
end

puddleStepIn:type("stepin")
puddleStepIn:id(puddleId)
puddleStepIn:register()