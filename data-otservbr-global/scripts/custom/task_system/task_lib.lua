-- TacoServer Custom Task System Library
-- Native integration with Canary and Walter Jaeger Hunting Task Points (HTP)

TaskSystem = TaskSystem or {}

TaskSystem.Config = {
	maxActiveTasks = 3,
	partySharedDistance = 10, -- max distance for party kill sharing (screen distance)
	partySharedExpRequired = true,
}

TaskSystem.Storages = {
	ranking = 14009, -- Total completed tasks
	slots = {
		[1] = { task = 14010, count = 14011 },
		[2] = { task = 14012, count = 14013 },
		[3] = { task = 14014, count = 14015 },
	},
	bountyPoints = 14020,
	bountyDamage = 14021,
	bountyLeech = 14022,
	bountyLoot = 14023,
	bountyBestiary = 14024,
	bountyCritical = 14025,
	amuletDefense = 14026,
	amuletElemental = 14027,
	amuletSpeed = 14028,
	amuletParalysis = 14029,
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
	-- =========================================================================
	-- TIER 1: BEGINNER (Level 8+)
	-- =========================================================================
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

	-- =========================================================================
	-- TIER 2: INTERMEDIATE (Level 40+)
	-- =========================================================================
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

	-- =========================================================================
	-- TIER 3: ADVANCED (Level 80+)
	-- =========================================================================
	[301] = {
		name = "Dragons",
		categoryId = 3,
		level = 80,
		count = 400,
		creatures = { "dragon", "dragon hatchling" },
		rewards = { points = 300 },
	},
	[302] = {
		name = "Wyrms",
		categoryId = 3,
		level = 80,
		count = 400,
		creatures = { "wyrm" },
		rewards = { points = 320 },
	},
	[303] = {
		name = "Giant Spiders",
		categoryId = 3,
		level = 80,
		count = 320,
		creatures = { "giant spider" },
		rewards = { points = 280 },
	},
	[304] = {
		name = "Ancient Scarabs",
		categoryId = 3,
		level = 80,
		count = 360,
		creatures = { "ancient scarab" },
		rewards = { points = 290 },
	},
	[305] = {
		name = "Vampires",
		categoryId = 3,
		level = 80,
		count = 400,
		creatures = { "vampire", "vampire bride", "vampire viscount" },
		rewards = { points = 330 },
	},
	[306] = {
		name = "Necromancers & Priestesses",
		categoryId = 3,
		level = 80,
		count = 320,
		creatures = { "necromancer", "priestess", "blood priest" },
		rewards = { points = 300 },
	},
	[307] = {
		name = "Bonebeasts",
		categoryId = 3,
		level = 80,
		count = 360,
		creatures = { "bonebeast" },
		rewards = { points = 290 },
	},
	[308] = {
		name = "Bog Raiders",
		categoryId = 3,
		level = 80,
		count = 360,
		creatures = { "bog raider" },
		rewards = { points = 290 },
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
		rewards = { points = 350 },
	},
	[311] = {
		name = "Hellspawns",
		categoryId = 3,
		level = 90,
		count = 400,
		creatures = { "hellspawn" },
		rewards = { points = 350 },
	},
	[312] = {
		name = "Crystal Spiders",
		categoryId = 3,
		level = 80,
		count = 360,
		creatures = { "crystal spider", "ice golem" },
		rewards = { points = 290 },
	},
	[313] = {
		name = "Brimstone Bugs",
		categoryId = 3,
		level = 80,
		count = 360,
		creatures = { "brimstone bug" },
		rewards = { points = 290 },
	},
	[314] = {
		name = "Werewolves",
		categoryId = 3,
		level = 80,
		count = 360,
		creatures = { "werewolf" },
		rewards = { points = 320 },
	},

	-- =========================================================================
	-- TIER 4: EXPERT (Level 130+)
	-- =========================================================================
	[401] = {
		name = "Dragon Lords",
		categoryId = 4,
		level = 130,
		count = 600,
		creatures = { "dragon lord", "dragon lord hatchling" },
		rewards = { points = 600 },
	},
	[402] = {
		name = "Frost Dragons",
		categoryId = 4,
		level = 130,
		count = 600,
		creatures = { "frost dragon", "frost dragon hatchling" },
		rewards = { points = 600 },
	},
	[403] = {
		name = "Hydras",
		categoryId = 4,
		level = 130,
		count = 600,
		creatures = { "hydra" },
		rewards = { points = 580 },
	},
	[404] = {
		name = "Behemoths",
		categoryId = 4,
		level = 130,
		count = 600,
		creatures = { "behemoth" },
		rewards = { points = 600 },
	},
	[405] = {
		name = "Warlocks",
		categoryId = 4,
		level = 130,
		count = 480,
		creatures = { "warlock" },
		rewards = { points = 620 },
	},
	[406] = {
		name = "Medusas & Serpents",
		categoryId = 4,
		level = 130,
		count = 600,
		creatures = { "medusa", "serpent spawn" },
		rewards = { points = 650 },
	},
	[407] = {
		name = "Grim Reapers",
		categoryId = 4,
		level = 130,
		count = 600,
		creatures = { "grim reaper" },
		rewards = { points = 720 },
	},
	[408] = {
		name = "Ghastly Dragons",
		categoryId = 4,
		level = 140,
		count = 480,
		creatures = { "ghastly dragon" },
		rewards = { points = 720 },
	},
	[409] = {
		name = "Glooth Bandits",
		categoryId = 4,
		level = 130,
		count = 800,
		creatures = { "glooth bandit", "glooth brigand" },
		rewards = { points = 680 },
	},
	[410] = {
		name = "Glooth Golems",
		categoryId = 4,
		level = 130,
		count = 800,
		creatures = { "glooth golem", "rustheap golem" },
		rewards = { points = 680 },
	},
	[411] = {
		name = "Draken Warmasters",
		categoryId = 4,
		level = 140,
		count = 720,
		creatures = { "draken warmaster", "draken spellweaver" },
		rewards = { points = 700 },
	},
	[412] = {
		name = "Werehyaenas",
		categoryId = 4,
		level = 140,
		count = 720,
		creatures = { "werehyaena", "werehyaena shaman", "werecrocodile" },
		rewards = { points = 700 },
	},
	[413] = {
		name = "Grimvale Werecreatures",
		categoryId = 4,
		level = 130,
		count = 720,
		creatures = { "werewolf", "werebadger", "werebear", "wereboar", "werefox" },
		rewards = { points = 680 },
	},
	[414] = {
		name = "Hero Cave Squad",
		categoryId = 4,
		level = 130,
		count = 720,
		creatures = { "hero", "vile grandmaster", "renegade knight", "blood priest" },
		rewards = { points = 700 },
	},

	-- =========================================================================
	-- TIER 5: MASTER (Level 200+) - High End Rebalanced Rewards (~2.0-2.5 pts/kill)
	-- =========================================================================
	[501] = {
		name = "Barkless Cultists",
		categoryId = 5,
		level = 200,
		count = 800,
		creatures = { "barkless devotee", "barkless fanatic" },
		rewards = { points = 1600 },
	},
	[502] = {
		name = "Carnivors (Port Hope Rock)",
		categoryId = 5,
		level = 200,
		count = 800,
		creatures = { "spiky carnivor", "menacing carnivor", "lumbering carnivor" },
		rewards = { points = 1700 },
	},
	[503] = {
		name = "High Drakens",
		categoryId = 5,
		level = 200,
		count = 800,
		creatures = { "draken abomination", "draken elite" },
		rewards = { points = 1800 },
	},
	[504] = {
		name = "Spectres (Cathedral / Courts)",
		categoryId = 5,
		level = 200,
		count = 800,
		creatures = { "gazer spectre", "burster spectre", "ripper spectre" },
		rewards = { points = 1900 },
	},
	[505] = {
		name = "Asuras (Palace)",
		categoryId = 5,
		level = 200,
		count = 1000,
		creatures = { "dawnfire asura", "midnight asura", "frost flower asura" },
		rewards = { points = 2400 },
	},
	[506] = {
		name = "Roshamuul Surface",
		categoryId = 5,
		level = 220,
		count = 1000,
		creatures = { "frazzlemaw", "silencer", "guzzlemaw", "choking fear", "retching horror" },
		rewards = { points = 2500 },
	},
	[507] = {
		name = "Demons & Hellhounds (Goroma / Inq)",
		categoryId = 5,
		level = 250,
		count = 1000,
		creatures = { "demon", "hellhound", "dark torturer", "juggernaut", "demon outcast" },
		rewards = { points = 2400 },
	},
	[508] = {
		name = "Drefia Skeleton Elites",
		categoryId = 5,
		level = 220,
		count = 800,
		creatures = { "skeleton elite warrior", "undead gladiator" },
		rewards = { points = 1900 },
	},
	[509] = {
		name = "Draken Walls",
		categoryId = 5,
		level = 200,
		count = 1000,
		creatures = { "draken warmaster", "draken spellweaver", "draken abomination", "draken elite" },
		rewards = { points = 2100 },
	},
	[510] = {
		name = "Oramond Minotaurs",
		categoryId = 5,
		level = 200,
		count = 800,
		creatures = { "moohtant", "minotaur amazon", "minotaur hunter", "worm priestess" },
		rewards = { points = 1700 },
	},
	[511] = {
		name = "Deeper Banuta",
		categoryId = 5,
		level = 200,
		count = 1000,
		creatures = { "medusa", "serpent spawn", "hydra", "eternal guardian" },
		rewards = { points = 2000 },
	},
	[512] = {
		name = "Prison -1 Squad",
		categoryId = 5,
		level = 230,
		count = 1000,
		creatures = { "dark torturer", "demon outcast", "hellhound", "blightwalker", "defiler" },
		rewards = { points = 2400 },
	},
	[513] = {
		name = "Nightmare Isles",
		categoryId = 5,
		level = 220,
		count = 1000,
		creatures = { "choking fear", "retching horror", "silencer" },
		rewards = { points = 2200 },
	},
	[514] = {
		name = "Elves of Summer & Winter Courts",
		categoryId = 5,
		level = 220,
		count = 800,
		creatures = { "crazed summer vanguard", "crazed summer rearguard", "crazed winter vanguard", "crazed winter rearguard", "insane siren" },
		rewards = { points = 2000 },
	},
	[515] = {
		name = "Oramond Catacombs",
		categoryId = 5,
		level = 230,
		count = 1000,
		creatures = { "dark torturer", "demon outcast", "hellhound", "destroyer", "juggernaut", "grim reaper", "plaguesmith" },
		rewards = { points = 2500 },
	},
	[516] = {
		name = "Buried Cathedral",
		categoryId = 5,
		level = 220,
		count = 1000,
		creatures = { "burster spectre", "gazer spectre", "ripper spectre", "arachnophobica" },
		rewards = { points = 2300 },
	},
	[517] = {
		name = "Werehyaenas & Weretigers",
		categoryId = 5,
		level = 200,
		count = 800,
		creatures = { "werehyaena", "werehyaena shaman", "werecrocodile", "feral werecrocodile", "weretiger", "white weretiger" },
		rewards = { points = 1800 },
	},

	-- =========================================================================
	-- TIER 6: GRANDMASTER (Level 280+) - End Game Rebalanced Rewards (~3.4-4.0 pts/kill)
	-- =========================================================================
	[601] = {
		name = "Werelions (Kilmaresh)",
		categoryId = 6,
		level = 280,
		count = 1000,
		creatures = { "werelion", "werelioness" },
		rewards = { points = 3400 },
	},
	[602] = {
		name = "Sphinxes & Goannas (Issavi Surface)",
		categoryId = 6,
		level = 280,
		count = 1000,
		creatures = { "feral sphinx", "sphinx", "adult goanna", "young goanna" },
		rewards = { points = 3400 },
	},
	[603] = {
		name = "Falcon Bastion",
		categoryId = 6,
		level = 280,
		count = 1000,
		creatures = { "falcon knight", "falcon paladin" },
		rewards = { points = 3600 },
	},
	[604] = {
		name = "Cobra Bastion",
		categoryId = 6,
		level = 280,
		count = 1000,
		creatures = { "cobra assassin", "cobra vizier", "cobra scout" },
		rewards = { points = 3600 },
	},
	[605] = {
		name = "Deathlings",
		categoryId = 6,
		level = 280,
		count = 1000,
		creatures = { "deathling spellsinger", "deathling scout" },
		rewards = { points = 3500 },
	},
	[606] = {
		name = "True Asuras (Vaults)",
		categoryId = 6,
		level = 300,
		count = 1000,
		creatures = { "true dawnfire asura", "true midnight asura", "true frost flower asura" },
		rewards = { points = 3800 },
	},
	[607] = {
		name = "Marapur Nagas",
		categoryId = 6,
		level = 280,
		count = 1000,
		creatures = { "naga archer", "naga warrior", "rogue naga", "corrupt naga" },
		rewards = { points = 3400 },
	},
	[608] = {
		name = "Crypt Wardens & Lamassu (Issavi Catacombs)",
		categoryId = 6,
		level = 280,
		count = 1000,
		creatures = { "crypt warden", "lamassu" },
		rewards = { points = 3500 },
	},
	[609] = {
		name = "Secret Library",
		categoryId = 6,
		level = 350,
		count = 1000,
		creatures = { "rage squid", "brain squid", "squid warden", "guardian of tales", "energuardian of tales" },
		rewards = { points = 3800 },
	},
	[610] = {
		name = "Ferumbras Ascendant (Grounds of Destruction)",
		categoryId = 6,
		level = 300,
		count = 1000,
		creatures = { "grimeleech", "vexclaw", "hellflayer", "undead dragon" },
		rewards = { points = 3600 },
	},
	[611] = {
		name = "Bulltaurs (Jaded Roots / Lair)",
		categoryId = 6,
		level = 300,
		count = 1000,
		creatures = { "bulltaur brute", "bulltaur alchemist", "bulltaur forgepriest" },
		rewards = { points = 3500 },
	},
	[612] = {
		name = "Soul War (Crater & Infernos)",
		categoryId = 6,
		level = 400,
		count = 800,
		creatures = { "infernal demon", "infernal phantom", "brachiodemon", "bony sea devil", "cloak of terror" },
		rewards = { points = 3800 },
	},
	[613] = {
		name = "Prison Lower Floors (-2 / -3)",
		categoryId = 6,
		level = 300,
		count = 1000,
		creatures = { "demon outcast", "juggernaut", "plaguesmith", "dark torturer", "betrayed wraith", "hellhound" },
		rewards = { points = 3500 },
	},
	[614] = {
		name = "Otherworld (Heart of Destruction)",
		categoryId = 6,
		level = 280,
		count = 1000,
		creatures = { "breach brood", "dread intruder", "reality reaver", "sparkion" },
		rewards = { points = 3400 },
	},
}

-- Build quick creature -> task list lookup
TaskSystem.MonsterToTasks = {}
for taskId, task in pairs(TaskSystem.Tasks) do
	if task.creatures then
		for _, creatureName in ipairs(task.creatures) do
			local lower = creatureName:lower()
			TaskSystem.MonsterToTasks[lower] = TaskSystem.MonsterToTasks[lower] or {}
			table.insert(TaskSystem.MonsterToTasks[lower], taskId)
		end
	end
end

-- Backward compatibility alias
TaskSystem.CreatureToTasks = TaskSystem.MonsterToTasks

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
				count = count,
				current = count,
				completed = count >= TaskSystem.Tasks[taskId].count,
				isCompleted = count >= TaskSystem.Tasks[taskId].count,
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
-- BOUNTY RING & BOUNTY TASKS UPGRADE CONFIGURATION
-- =============================================================================

TaskSystem.BountyConfig = {
	ringItemId = 34080,
	upgrades = {
		damage = {
			key = "damage",
			name = "Damage Boost",
			description = "Deals +2% more damage per level against your active task monsters.",
			storage = 14021,
			maxLevel = 5,
			levels = {
				[1] = { cost = 250, value = 2, desc = "+2% Damage" },
				[2] = { cost = 500, value = 4, desc = "+4% Damage" },
				[3] = { cost = 1000, value = 6, desc = "+6% Damage" },
				[4] = { cost = 1500, value = 8, desc = "+8% Damage" },
				[5] = { cost = 2500, value = 10, desc = "+10% Damage" },
			},
		},
		leech = {
			key = "leech",
			name = "Life Leech",
			description = "Leeches +1.5% life per level from damage dealt to your active task monsters.",
			storage = 14022,
			maxLevel = 5,
			levels = {
				[1] = { cost = 250, value = 1.5, desc = "+1.5% Life Leech" },
				[2] = { cost = 500, value = 3.0, desc = "+3.0% Life Leech" },
				[3] = { cost = 1000, value = 4.5, desc = "+4.5% Life Leech" },
				[4] = { cost = 1500, value = 6.0, desc = "+6.0% Life Leech" },
				[5] = { cost = 2500, value = 7.5, desc = "+7.5% Life Leech" },
			},
		},
		loot = {
			key = "loot",
			name = "Extra Loot Roll",
			description = "+3% chance per level of an extra loot roll from your active task monsters.",
			storage = 14023,
			maxLevel = 5,
			levels = {
				[1] = { cost = 300, value = 3, desc = "+3% Extra Loot Chance" },
				[2] = { cost = 600, value = 6, desc = "+6% Extra Loot Chance" },
				[3] = { cost = 1200, value = 9, desc = "+9% Extra Loot Chance" },
				[4] = { cost = 2000, value = 12, desc = "+12% Extra Loot Chance" },
				[5] = { cost = 3000, value = 15, desc = "+15% Extra Loot Chance" },
			},
		},
		bestiary = {
			key = "bestiary",
			name = "Bestiary Double Kill",
			description = "Grants a chance for double kill credit (x2) in Bestiary for active task monsters.",
			storage = 14024,
			maxLevel = 3,
			levels = {
				[1] = { cost = 500, value = 30, desc = "30% Double Kill Chance" },
				[2] = { cost = 1200, value = 60, desc = "60% Double Kill Chance" },
				[3] = { cost = 2500, value = 100, desc = "100% Double Kill Chance" },
			},
		},
		critical = {
			key = "critical",
			name = "Critical Damage Boost",
			description = "+3% critical hit damage per level (up to +15%) against active task monsters.",
			storage = 14025,
			maxLevel = 5,
			levels = {
				[1] = { cost = 300, value = 3, desc = "+3% Critical Damage" },
				[2] = { cost = 600, value = 6, desc = "+6% Critical Damage" },
				[3] = { cost = 1200, value = 9, desc = "+9% Critical Damage" },
				[4] = { cost = 2000, value = 12, desc = "+12% Critical Damage" },
				[5] = { cost = 3000, value = 15, desc = "+15% Critical Damage" },
			},
		},
	},
	amuletItemId = 31268,
	amuletUpgrades = {
		defense = {
			key = "defense",
			name = "Physical Protection",
			description = "Reduces physical damage taken from active task monsters by +2% per level (up to 10%).",
			storage = 14026,
			maxLevel = 5,
			levels = {
				[1] = { cost = 250, value = 2, desc = "-2% Physical Damage" },
				[2] = { cost = 500, value = 4, desc = "-4% Physical Damage" },
				[3] = { cost = 1000, value = 6, desc = "-6% Physical Damage" },
				[4] = { cost = 1500, value = 8, desc = "-8% Physical Damage" },
				[5] = { cost = 2500, value = 10, desc = "-10% Physical Damage" },
			},
		},
		elemental = {
			key = "elemental",
			name = "Elemental Protection",
			description = "Reduces elemental damage taken from active task monsters by +2% per level (up to 10%).",
			storage = 14027,
			maxLevel = 5,
			levels = {
				[1] = { cost = 250, value = 2, desc = "-2% Elemental Damage" },
				[2] = { cost = 500, value = 4, desc = "-4% Elemental Damage" },
				[3] = { cost = 1000, value = 6, desc = "-6% Elemental Damage" },
				[4] = { cost = 1500, value = 8, desc = "-8% Elemental Damage" },
				[5] = { cost = 2500, value = 10, desc = "-10% Elemental Damage" },
			},
		},
		speed = {
			key = "speed",
			name = "Movement Speed Boost",
			description = "Increases movement speed by +10 per level (up to +50 speed) while equipped.",
			storage = 14028,
			maxLevel = 5,
			levels = {
				[1] = { cost = 200, value = 10, desc = "+10 Speed" },
				[2] = { cost = 400, value = 20, desc = "+20 Speed" },
				[3] = { cost = 800, value = 30, desc = "+30 Speed" },
				[4] = { cost = 1400, value = 40, desc = "+40 Speed" },
				[5] = { cost = 2200, value = 50, desc = "+50 Speed" },
			},
		},
		paralysis = {
			key = "paralysis",
			name = "Paralysis Immunity",
			description = "Grants 100% immunity to paralysis effects while wearing the Bounty Amulet.",
			storage = 14029,
			maxLevel = 1,
			levels = {
				[1] = { cost = 1500, value = 100, desc = "100% Immunity to Paralysis" },
			},
		},
	},
}

-- Bounty Ring Player Helpers
function Player.getBountyPoints(self)
	local storage = (TaskSystem and TaskSystem.Storages and TaskSystem.Storages.bountyPoints) or 14020
	return math.max(0, self:getStorageValue(storage))
end

function Player.addBountyPoints(self, amount)
	if amount <= 0 then
		return false
	end
	local storage = (TaskSystem and TaskSystem.Storages and TaskSystem.Storages.bountyPoints) or 14020
	local current = self:getBountyPoints()
	self:setStorageValue(storage, current + amount)
	return true
end

function Player.removeBountyPoints(self, amount)
	if amount <= 0 then
		return false
	end
	local storage = (TaskSystem and TaskSystem.Storages and TaskSystem.Storages.bountyPoints) or 14020
	local current = self:getBountyPoints()
	if current < amount then
		return false
	end
	self:setStorageValue(storage, current - amount)
	return true
end

function Player.hasBountyRingEquipped(self)
	local ring = self:getSlotItem(CONST_SLOT_RING)
	return ring ~= nil and ring:getId() == (TaskSystem.BountyConfig.ringItemId or 34080)
end

function Player.getBountyUpgrade(self, upgradeKey)
	local u = TaskSystem.BountyConfig.upgrades[upgradeKey]
	if not u then
		return 0
	end
	return math.max(0, self:getStorageValue(u.storage))
end

function Player.setBountyUpgrade(self, upgradeKey, level)
	local u = TaskSystem.BountyConfig.upgrades[upgradeKey]
	if not u then
		return false
	end
	self:setStorageValue(u.storage, level)
	return true
end

function Player.isTaskMonster(self, monsterName)
	if not monsterName then
		return false
	end
	local lower = monsterName:lower()
	local activeTasks = self:getActiveTasks()
	for _, a in ipairs(activeTasks) do
		if a.task and a.task.creatures then
			for _, c in ipairs(a.task.creatures) do
				if c:lower() == lower then
					return true
				end
			end
		end
	end
	return false
end


function Player.hasBountyAmuletEquipped(self)
	local amulet = self:getSlotItem(CONST_SLOT_NECKLACE)
	return amulet ~= nil and amulet:getId() == (TaskSystem.BountyConfig.amuletItemId or 31268)
end

function Player.getAmuletUpgrade(self, upgradeKey)
	local u = TaskSystem.BountyConfig.amuletUpgrades and TaskSystem.BountyConfig.amuletUpgrades[upgradeKey]
	if not u then
		return 0
	end
	return math.max(0, self:getStorageValue(u.storage))
end

function Player.setAmuletUpgrade(self, upgradeKey, level)
	local u = TaskSystem.BountyConfig.amuletUpgrades and TaskSystem.BountyConfig.amuletUpgrades[upgradeKey]
	if not u then
		return false
	end
	self:setStorageValue(u.storage, level)
	return true
end

function Player.updateAmuletSpeedCondition(self)
	self:removeCondition(CONDITION_ATTRIBUTES, CONDITIONID_NECKLACE, 14030)
	if not self:hasBountyAmuletEquipped() then
		return
	end
	local speedLvl = self:getAmuletUpgrade("speed")
	if speedLvl > 0 then
		local condition = Condition(CONDITION_ATTRIBUTES, CONDITIONID_NECKLACE)
		condition:setParameter(CONDITION_PARAM_SUBID, 14030)
		condition:setParameter(CONDITION_PARAM_SPEED, speedLvl * 10)
		condition:setParameter(CONDITION_PARAM_TICKS, -1)
		self:addCondition(condition)
	end
end
