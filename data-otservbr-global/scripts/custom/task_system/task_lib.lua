-- TacoServer Custom Task System Library
-- Native integration with Canary and Walter Jaeger Hunting Task Points (HTP)

TaskSystem = TaskSystem or {}

TaskSystem.Config = {
	maxActiveTasks = 3,
	partySharedDistance = 7, -- max distance for party kill sharing
	partySharedExpRequired = true,
}

TaskSystem.Storages = {
	ranking = 14009, -- Total completed tasks
	slots = {
		[1] = { task = 14010, count = 14011 },
		[2] = { task = 14012, count = 14013 },
		[3] = { task = 14014, count = 14015 },
	},
}

TaskSystem.Categories = {
	[1] = { id = 1, name = "Tier 1: Beginner (Level 8+)", minLevel = 8 },
	[2] = { id = 2, name = "Tier 2: Intermediate (Level 40+)", minLevel = 40 },
	[3] = { id = 3, name = "Tier 3: Advanced (Level 80+)", minLevel = 80 },
	[4] = { id = 4, name = "Tier 4: Expert (Level 130+)", minLevel = 130 },
	[5] = { id = 5, name = "Tier 5: Master (Level 200+)", minLevel = 200 },
	[6] = { id = 6, name = "Tier 6: Grandmaster (Level 280+)", minLevel = 280 },
}

TaskSystem.Tasks = {
	[101] = {
		name = "Trolls",
		categoryId = 1,
		level = 8,
		count = 200,
		creatures = { "troll", "troll champion", "island troll", "swamp troll" },
		rewards = { points = 75 },
	},
	[102] = {
		name = "Goblins",
		categoryId = 1,
		level = 8,
		count = 200,
		creatures = { "goblin", "goblin scavenger", "goblin assassin" },
		rewards = { points = 75 },
	},
	[103] = {
		name = "Rotworms",
		categoryId = 1,
		level = 8,
		count = 320,
		creatures = { "rotworm", "carrion worm" },
		rewards = { points = 95 },
	},
	[104] = {
		name = "Minotaurs",
		categoryId = 1,
		level = 8,
		count = 320,
		creatures = { "minotaur", "minotaur archer", "minotaur mage", "minotaur guard" },
		rewards = { points = 95 },
	},
	[105] = {
		name = "Skeletons & Ghouls",
		categoryId = 1,
		level = 8,
		count = 320,
		creatures = { "skeleton", "skeleton warrior", "ghoul" },
		rewards = { points = 95 },
	},
	[106] = {
		name = "Amazons & Valkyries",
		categoryId = 1,
		level = 10,
		count = 240,
		creatures = { "amazon", "valkyrie" },
		rewards = { points = 85 },
	},
	[107] = {
		name = "Orcs",
		categoryId = 1,
		level = 10,
		count = 280,
		creatures = { "orc", "orc spearman", "orc warrior", "orc rider", "orc berserker", "orc shaman", "orc leader", "orc warlord" },
		rewards = { points = 90 },
	},
	[108] = {
		name = "Larvae",
		categoryId = 1,
		level = 8,
		count = 280,
		creatures = { "larva" },
		rewards = { points = 85 },
	},
	[109] = {
		name = "Swamplings",
		categoryId = 1,
		level = 8,
		count = 240,
		creatures = { "swampling" },
		rewards = { points = 85 },
	},
	[110] = {
		name = "Crocodiles",
		categoryId = 1,
		level = 8,
		count = 240,
		creatures = { "crocodile" },
		rewards = { points = 85 },
	},
	[111] = {
		name = "Badgers",
		categoryId = 1,
		level = 8,
		count = 200,
		creatures = { "badger" },
		rewards = { points = 75 },
	},
	[112] = {
		name = "Cyclops",
		categoryId = 1,
		level = 20,
		count = 320,
		creatures = { "cyclops" },
		rewards = { points = 120 },
	},
	[201] = {
		name = "Cyclops Smith & Drones",
		categoryId = 2,
		level = 40,
		count = 400,
		creatures = { "cyclops smith", "cyclops drone", "cyclops" },
		rewards = { points = 170 },
	},
	[202] = {
		name = "Coryms",
		categoryId = 2,
		level = 40,
		count = 480,
		creatures = { "corym charlatan", "corym skirmisher", "corym vanguard" },
		rewards = { points = 200 },
	},
	[203] = {
		name = "Barbarians",
		categoryId = 2,
		level = 40,
		count = 400,
		creatures = { "barbarian headsplitter", "barbarian skullhunter", "barbarian brutetamer", "barbarian bloodwalker" },
		rewards = { points = 175 },
	},
	[204] = {
		name = "Pirates",
		categoryId = 2,
		level = 40,
		count = 400,
		creatures = { "pirate marauder", "pirate cutthroat", "pirate buccaneer", "pirate corsair" },
		rewards = { points = 185 },
	},
	[205] = {
		name = "Apes & Kongras",
		categoryId = 2,
		level = 40,
		count = 400,
		creatures = { "kongra", "merlkin", "sibang" },
		rewards = { points = 175 },
	},
	[206] = {
		name = "Mutated Humans",
		categoryId = 2,
		level = 40,
		count = 400,
		creatures = { "mutated human" },
		rewards = { points = 205 },
	},
	[207] = {
		name = "Mutated Rats & Bats",
		categoryId = 2,
		level = 50,
		count = 400,
		creatures = { "mutated rat", "mutated bat" },
		rewards = { points = 220 },
	},
	[208] = {
		name = "Mutated Tigers",
		categoryId = 2,
		level = 50,
		count = 320,
		creatures = { "mutated tiger" },
		rewards = { points = 215 },
	},
	[209] = {
		name = "Dragon Hatchlings",
		categoryId = 2,
		level = 40,
		count = 320,
		creatures = { "dragon hatchling", "dragon lord hatchling" },
		rewards = { points = 190 },
	},
	[210] = {
		name = "Killer Caimans",
		categoryId = 2,
		level = 50,
		count = 400,
		creatures = { "killer caiman" },
		rewards = { points = 200 },
	},
	[211] = {
		name = "Water & Earth Elementals",
		categoryId = 2,
		level = 50,
		count = 360,
		creatures = { "water elemental", "earth elemental", "massive earth elemental", "massive water elemental" },
		rewards = { points = 220 },
	},
	[212] = {
		name = "Roaring Lions",
		categoryId = 2,
		level = 50,
		count = 360,
		creatures = { "roaring lion" },
		rewards = { points = 220 },
	},
	[213] = {
		name = "Tortoises",
		categoryId = 2,
		level = 40,
		count = 320,
		creatures = { "tortoise", "thornback tortoise" },
		rewards = { points = 175 },
	},
	[301] = {
		name = "Dragons",
		categoryId = 3,
		level = 80,
		count = 400,
		creatures = { "dragon", "dragon hatchling" },
		rewards = { points = 320 },
	},
	[302] = {
		name = "Wyrms",
		categoryId = 3,
		level = 80,
		count = 400,
		creatures = { "wyrm" },
		rewards = { points = 360 },
	},
	[303] = {
		name = "Giant Spiders",
		categoryId = 3,
		level = 80,
		count = 320,
		creatures = { "giant spider" },
		rewards = { points = 340 },
	},
	[304] = {
		name = "Ancient Scarabs",
		categoryId = 3,
		level = 80,
		count = 360,
		creatures = { "ancient scarab" },
		rewards = { points = 320 },
	},
	[305] = {
		name = "Vampires",
		categoryId = 3,
		level = 80,
		count = 400,
		creatures = { "vampire", "vampire bride", "vampire viscount" },
		rewards = { points = 360 },
	},
	[306] = {
		name = "Necromancers",
		categoryId = 3,
		level = 80,
		count = 320,
		creatures = { "necromancer", "priestess" },
		rewards = { points = 340 },
	},
	[307] = {
		name = "Bonebeasts",
		categoryId = 3,
		level = 80,
		count = 360,
		creatures = { "bonebeast" },
		rewards = { points = 320 },
	},
	[308] = {
		name = "Bog Raiders",
		categoryId = 3,
		level = 80,
		count = 360,
		creatures = { "bog raider" },
		rewards = { points = 320 },
	},
	[309] = {
		name = "Sea Serpents",
		categoryId = 3,
		level = 90,
		count = 480,
		creatures = { "sea serpent", "young sea serpent" },
		rewards = { points = 420 },
	},
	[310] = {
		name = "Nightmares",
		categoryId = 3,
		level = 90,
		count = 400,
		creatures = { "nightmare", "nightmare scion" },
		rewards = { points = 390 },
	},
	[311] = {
		name = "Hellspawns",
		categoryId = 3,
		level = 90,
		count = 400,
		creatures = { "hellspawn" },
		rewards = { points = 410 },
	},
	[312] = {
		name = "Crystal Spiders",
		categoryId = 3,
		level = 80,
		count = 360,
		creatures = { "crystal spider", "ice golem" },
		rewards = { points = 340 },
	},
	[313] = {
		name = "Brimstone Bugs",
		categoryId = 3,
		level = 80,
		count = 360,
		creatures = { "brimstone bug" },
		rewards = { points = 340 },
	},
	[314] = {
		name = "Werewolves",
		categoryId = 3,
		level = 80,
		count = 360,
		creatures = { "werewolf" },
		rewards = { points = 360 },
	},
	[401] = {
		name = "Dragon Lords",
		categoryId = 4,
		level = 130,
		count = 600,
		creatures = { "dragon lord", "dragon lord hatchling" },
		rewards = { points = 550 },
	},
	[402] = {
		name = "Frost Dragons",
		categoryId = 4,
		level = 130,
		count = 600,
		creatures = { "frost dragon", "frost dragon hatchling" },
		rewards = { points = 550 },
	},
	[403] = {
		name = "Hydras",
		categoryId = 4,
		level = 130,
		count = 600,
		creatures = { "hydra" },
		rewards = { points = 570 },
	},
	[404] = {
		name = "Behemoths",
		categoryId = 4,
		level = 130,
		count = 600,
		creatures = { "behemoth" },
		rewards = { points = 590 },
	},
	[405] = {
		name = "Warlocks",
		categoryId = 4,
		level = 130,
		count = 480,
		creatures = { "warlock" },
		rewards = { points = 610 },
	},
	[406] = {
		name = "Medusas & Serpents",
		categoryId = 4,
		level = 130,
		count = 600,
		creatures = { "medusa", "serpent spawn" },
		rewards = { points = 630 },
	},
	[407] = {
		name = "Grim Reapers",
		categoryId = 4,
		level = 130,
		count = 600,
		creatures = { "grim reaper" },
		rewards = { points = 690 },
	},
	[408] = {
		name = "Ghastly Dragons",
		categoryId = 4,
		level = 140,
		count = 480,
		creatures = { "ghastly dragon" },
		rewards = { points = 690 },
	},
	[409] = {
		name = "Glooth Bandits",
		categoryId = 4,
		level = 130,
		count = 800,
		creatures = { "glooth bandit", "glooth brigand" },
		rewards = { points = 640 },
	},
	[410] = {
		name = "Glooth Golems",
		categoryId = 4,
		level = 130,
		count = 800,
		creatures = { "glooth golem", "rustheap golem" },
		rewards = { points = 640 },
	},
	[411] = {
		name = "Draken Warmasters",
		categoryId = 4,
		level = 140,
		count = 720,
		creatures = { "draken warmaster", "draken spellweaver" },
		rewards = { points = 660 },
	},
	[412] = {
		name = "Werehyaenas",
		categoryId = 4,
		level = 140,
		count = 720,
		creatures = { "werehyaena", "werehyaena shaman", "werecrocodile" },
		rewards = { points = 660 },
	},
	[413] = {
		name = "Grimvale Werecreatures",
		categoryId = 4,
		level = 130,
		count = 720,
		creatures = { "werewolf", "werebadger", "werebear", "wereboar" },
		rewards = { points = 620 },
	},
	[414] = {
		name = "Hero Cave Squad",
		categoryId = 4,
		level = 130,
		count = 720,
		creatures = { "hero", "vile grandmaster", "renegade knight", "blood priest" },
		rewards = { points = 640 },
	},
	[501] = {
		name = "Barkless Cultists",
		categoryId = 5,
		level = 200,
		count = 800,
		creatures = { "barkless devotee", "barkless fanatic" },
		rewards = { points = 800 },
	},
	[502] = {
		name = "Carnivors",
		categoryId = 5,
		level = 200,
		count = 800,
		creatures = { "spiky carnivor", "menacing carnivor", "lumbering carnivor" },
		rewards = { points = 850 },
	},
	[503] = {
		name = "High Drakens",
		categoryId = 5,
		level = 200,
		count = 800,
		creatures = { "draken abomination", "draken elite" },
		rewards = { points = 900 },
	},
	[504] = {
		name = "Spectres (Cathedral / Courts)",
		categoryId = 5,
		level = 200,
		count = 800,
		creatures = { "gazer spectre", "burster spectre", "ripper spectre" },
		rewards = { points = 950 },
	},
	[505] = {
		name = "Asuras",
		categoryId = 5,
		level = 200,
		count = 1000,
		creatures = { "dawnfire asura", "midnight asura", "frost flower asura" },
		rewards = { points = 1050 },
	},
	[506] = {
		name = "Roshamuul Surface",
		categoryId = 5,
		level = 220,
		count = 1000,
		creatures = { "frazzlemaw", "silencer", "guzzlemaw", "choking fear", "retching horror" },
		rewards = { points = 1100 },
	},
	[507] = {
		name = "Demons & Infernals",
		categoryId = 5,
		level = 250,
		count = 1000,
		creatures = { "demon", "hellhound", "dark torturer", "juggernaut", "demon outcast" },
		rewards = { points = 1150 },
	},
	[508] = {
		name = "Drefia Skeleton Elites",
		categoryId = 5,
		level = 220,
		count = 800,
		creatures = { "skeleton elite warrior", "undead gladiator" },
		rewards = { points = 1000 },
	},
	[509] = {
		name = "Draken Walls",
		categoryId = 5,
		level = 200,
		count = 1000,
		creatures = { "draken warmaster", "draken spellweaver", "draken abomination", "draken elite" },
		rewards = { points = 950 },
	},
	[510] = {
		name = "Oramond Minotaurs",
		categoryId = 5,
		level = 200,
		count = 1000,
		creatures = { "moohtant", "minotaur amazon", "minotaur hunter", "worm priestess" },
		rewards = { points = 1000 },
	},
	[511] = {
		name = "Deeper Banuta",
		categoryId = 5,
		level = 200,
		count = 1000,
		creatures = { "medusa", "serpent spawn", "hydra", "eternal guardian" },
		rewards = { points = 950 },
	},
	[512] = {
		name = "Prison -1 Squad",
		categoryId = 5,
		level = 230,
		count = 1000,
		creatures = { "dark torturer", "demon outcast", "hellhound", "blightwalker", "defiler" },
		rewards = { points = 1100 },
	},
	[513] = {
		name = "Nightmare Isles",
		categoryId = 5,
		level = 220,
		count = 1000,
		creatures = { "choking fear", "retching horror", "silencer" },
		rewards = { points = 1050 },
	},
	[601] = {
		name = "Werelions (Kilmaresh)",
		categoryId = 6,
		level = 280,
		count = 1200,
		creatures = { "werelion", "werelioness" },
		rewards = { points = 1350 },
	},
	[602] = {
		name = "Sphinxes & Goannas (Issavi)",
		categoryId = 6,
		level = 280,
		count = 1200,
		creatures = { "feral sphinx", "sphinx", "adult goanna", "young goanna" },
		rewards = { points = 1450 },
	},
	[603] = {
		name = "Falcon Bastion",
		categoryId = 6,
		level = 280,
		count = 1000,
		creatures = { "falcon knight", "falcon paladin" },
		rewards = { points = 1500 },
	},
	[604] = {
		name = "Cobra Bastion",
		categoryId = 6,
		level = 280,
		count = 1000,
		creatures = { "cobra assassin", "cobra vizier", "cobra scout" },
		rewards = { points = 1500 },
	},
	[605] = {
		name = "Deathlings",
		categoryId = 6,
		level = 280,
		count = 1000,
		creatures = { "deathling spellsinger", "deathling scout" },
		rewards = { points = 1550 },
	},
	[606] = {
		name = "True Asuras (Vaults)",
		categoryId = 6,
		level = 300,
		count = 1200,
		creatures = { "true dawnfire asura", "true midnight asura", "true frost flower asura" },
		rewards = { points = 1700 },
	},
	[607] = {
		name = "Marapur Nagas",
		categoryId = 6,
		level = 280,
		count = 1200,
		creatures = { "naga archer", "naga warrior", "rogue naga", "corrupt naga" },
		rewards = { points = 1600 },
	},
}

-- Build quick creature -> task list lookup
TaskSystem.CreatureToTasks = {}
for taskId, task in pairs(TaskSystem.Tasks) do
	for _, creatureName in ipairs(task.creatures) do
		local lower = creatureName:lower()
		TaskSystem.CreatureToTasks[lower] = TaskSystem.CreatureToTasks[lower] or {}
		table.insert(TaskSystem.CreatureToTasks[lower], taskId)
	end
end

-- Helper functions
function TaskSystem.getCategoryTasks(categoryId)
	local list = {}
	for id, task in pairs(TaskSystem.Tasks) do
		if task.categoryId == categoryId then
			table.insert(list, { id = id, task = task })
		end
	end
	table.sort(list, function(a, b)
		if a.task.level ~= b.task.level then
			return a.task.level < b.task.level
		end
		return a.task.name < b.task.name
	end)
	return list
end

function Player.getActiveTasks(self)
	local active = {}
	for slotId, slot in ipairs(TaskSystem.Storages.slots) do
		local taskId = self:getStorageValue(slot.task)
		if taskId and taskId > 0 and TaskSystem.Tasks[taskId] then
			local count = math.max(0, self:getStorageValue(slot.count))
			table.insert(active, {
				slotId = slotId,
				taskId = taskId,
				task = TaskSystem.Tasks[taskId],
				count = count, current = count, completed = count >= TaskSystem.Tasks[taskId].count, isCompleted = count >= TaskSystem.Tasks[taskId].count,
			})
		end
	end
	return active
end

function Player.getFreeTaskSlot(self)
	for slotId, slot in ipairs(TaskSystem.Storages.slots) do
		local taskId = self:getStorageValue(slot.task)
		if not taskId or taskId <= 0 then
			return slotId
		end
	end
	return nil
end

function Player.isTaskActive(self, taskId)
	for _, slot in ipairs(TaskSystem.Storages.slots) do
		if self:getStorageValue(slot.task) == taskId then
			return true
		end
	end
	return false
end

function Player.canStartTask(self, taskId)
	local task = TaskSystem.Tasks[taskId]
	if not task then
		return false, "Task does not exist."
	end

	if self:getLevel() < task.level then
		return false, string.format("You need at least level %d to start this task.", task.level)
	end

	if self:isTaskActive(taskId) then
		return false, "You already have this task active in one of your slots!"
	end

	local freeSlot = self:getFreeTaskSlot()
	if not freeSlot then
		return false, string.format("You already have %d tasks active. Cancel or complete one first.", TaskSystem.Config.maxActiveTasks)
	end

	return true
end

function Player.startTask(self, taskId)
	local canStart, reason = self:canStartTask(taskId)
	if not canStart then
		return false, reason
	end

	local freeSlot = self:getFreeTaskSlot()
	local slot = TaskSystem.Storages.slots[freeSlot]
	local task = TaskSystem.Tasks[taskId]

	self:setStorageValue(slot.task, taskId)
	self:setStorageValue(slot.count, 0)
	return true, freeSlot, task
end

function Player.cancelTask(self, slotId)
	local slot = TaskSystem.Storages.slots[slotId]
	if not slot then
		return false, "Invalid slot."
	end

	local taskId = self:getStorageValue(slot.task)
	if not taskId or taskId <= 0 then
		return false, "There is no active task in this slot."
	end

	local task = TaskSystem.Tasks[taskId]
	self:setStorageValue(slot.task, -1)
	self:setStorageValue(slot.count, 0)
	return true, task
end

function Player.claimTask(self, slotId)
	local slot = TaskSystem.Storages.slots[slotId]
	if not slot then
		return false, "Invalid slot."
	end

	local taskId = self:getStorageValue(slot.task)
	if not taskId or taskId <= 0 or not TaskSystem.Tasks[taskId] then
		return false, "No valid task in this slot."
	end

	local task = TaskSystem.Tasks[taskId]
	local count = math.max(0, self:getStorageValue(slot.count))
	if count < task.count then
		return false, string.format("You haven't completed this task yet! [%d/%d kills]", count, task.count)
	end

	-- Award Hunting Task Points (HTP) for Walter Jaeger
	if task.rewards.points and task.rewards.points > 0 then
		self:addTaskHuntingPoints(task.rewards.points)
	end

	-- Update ranking storage
	local currentTotal = math.max(0, self:getStorageValue(TaskSystem.Storages.ranking))
	self:setStorageValue(TaskSystem.Storages.ranking, currentTotal + 1)

	-- Reset slot (repeatable task!)
	self:setStorageValue(slot.task, -1)
	self:setStorageValue(slot.count, 0)

	return true, task
end


-- =============================================================================
-- BUILD REVERSE INDEX FOR O(1) MONSTER KILL LOOKUP
-- =============================================================================
TaskSystem.MonsterToTasks = {}
for taskId, task in pairs(TaskSystem.Tasks) do
	if task.creatures then
		for _, creatureName in ipairs(task.creatures) do
			local lowerName = creatureName:lower()
			if not TaskSystem.MonsterToTasks[lowerName] then
				TaskSystem.MonsterToTasks[lowerName] = {}
			end
			table.insert(TaskSystem.MonsterToTasks[lowerName], taskId)
		end
	end
end
