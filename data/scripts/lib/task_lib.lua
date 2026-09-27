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
	[1] = { id = 1, name = "Tier 1: Beginner (Level 1+)", minLevel = 1 },
	[2] = { id = 2, name = "Tier 2: Intermediate (Level 80+)", minLevel = 80 },
	[3] = { id = 3, name = "Tier 3: Expert (Level 150+)", minLevel = 150 },
	[4] = { id = 4, name = "Tier 4: Veteran (Level 300+)", minLevel = 300 },
	[5] = { id = 5, name = "Tier 5: Warmaster (Level 500+)", minLevel = 500 },
}

TaskSystem.Tasks = {
	-- =========================================================================
	-- TIER 1: BEGINNER (Level 1+)
	-- =========================================================================
	[101] = {
		name = "Trolls",
		categoryId = 1,
		level = 1,
		count = 200,
		creatures = { "troll", "troll champion", "island troll", "swamp troll" },
		rewards = { points = 75 },
	},
	[102] = {
		name = "Goblins",
		categoryId = 1,
		level = 1,
		count = 200,
		creatures = { "goblin", "goblin scavenger", "goblin assassin" },
		rewards = { points = 75 },
	},
	[103] = {
		name = "Rotworms",
		categoryId = 1,
		level = 1,
		count = 300,
		creatures = { "rotworm", "carrion worm" },
		rewards = { points = 95 },
	},
	[104] = {
		name = "Minotaurs",
		categoryId = 1,
		level = 1,
		count = 300,
		creatures = { "minotaur", "minotaur archer", "minotaur mage", "minotaur guard" },
		rewards = { points = 95 },
	},
	[105] = {
		name = "Skeletons & Ghouls",
		categoryId = 1,
		level = 1,
		count = 300,
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
		level = 1,
		count = 280,
		creatures = { "larva" },
		rewards = { points = 85 },
	},
	[109] = {
		name = "Swamplings",
		categoryId = 1,
		level = 1,
		count = 240,
		creatures = { "swampling" },
		rewards = { points = 85 },
	},
	[110] = {
		name = "Crocodiles",
		categoryId = 1,
		level = 1,
		count = 240,
		creatures = { "crocodile" },
		rewards = { points = 85 },
	},
	[111] = {
		name = "Badgers",
		categoryId = 1,
		level = 1,
		count = 200,
		creatures = { "badger" },
		rewards = { points = 75 },
	},
	[112] = {
		name = "Cyclops",
		categoryId = 1,
		level = 20,
		count = 300,
		creatures = { "cyclops" },
		rewards = { points = 120 },
	},
	[201] = {
		name = "Cyclops Smith & Drones",
		categoryId = 1,
		level = 35,
		count = 350,
		creatures = { "cyclops smith", "cyclops drone", "cyclops" },
		rewards = { points = 170 },
	},
	[202] = {
		name = "Coryms",
		categoryId = 1,
		level = 30,
		count = 400,
		creatures = { "corym charlatan", "corym skirmisher", "corym vanguard" },
		rewards = { points = 200 },
	},
	[203] = {
		name = "Barbarians",
		categoryId = 1,
		level = 40,
		count = 400,
		creatures = { "barbarian headsplitter", "barbarian skullhunter", "barbarian brutetamer", "barbarian bloodwalker" },
		rewards = { points = 175 },
	},
	[204] = {
		name = "Pirates",
		categoryId = 1,
		level = 40,
		count = 400,
		creatures = { "pirate marauder", "pirate cutthroat", "pirate buccaneer", "pirate corsair" },
		rewards = { points = 185 },
	},
	[205] = {
		name = "Apes & Kongras",
		categoryId = 1,
		level = 40,
		count = 400,
		creatures = { "kongra", "merlkin", "sibang" },
		rewards = { points = 175 },
	},
	[206] = {
		name = "Mutated Humans",
		categoryId = 1,
		level = 40,
		count = 400,
		creatures = { "mutated human" },
		rewards = { points = 205 },
	},
	[207] = {
		name = "Mutated Rats & Bats",
		categoryId = 1,
		level = 50,
		count = 400,
		creatures = { "mutated rat", "mutated bat" },
		rewards = { points = 220 },
	},
	[208] = {
		name = "Mutated Tigers",
		categoryId = 1,
		level = 50,
		count = 320,
		creatures = { "mutated tiger" },
		rewards = { points = 215 },
	},
	[209] = {
		name = "Dragon Hatchlings",
		categoryId = 1,
		level = 40,
		count = 320,
		creatures = { "dragon hatchling", "dragon lord hatchling" },
		rewards = { points = 190 },
	},
	[210] = {
		name = "Killer Caimans",
		categoryId = 1,
		level = 50,
		count = 400,
		creatures = { "killer caiman" },
		rewards = { points = 200 },
	},
	[211] = {
		name = "Water & Earth Elementals",
		categoryId = 1,
		level = 50,
		count = 360,
		creatures = { "water elemental", "earth elemental", "massive earth elemental", "massive water elemental" },
		rewards = { points = 220 },
	},
	[212] = {
		name = "Roaring Lions",
		categoryId = 1,
		level = 50,
		count = 360,
		creatures = { "roaring lion" },
		rewards = { points = 220 },
	},
	[213] = {
		name = "Tortoises",
		categoryId = 1,
		level = 40,
		count = 320,
		creatures = { "tortoise", "thornback tortoise" },
		rewards = { points = 175 },
	},

	-- =========================================================================
	-- TIER 2: INTERMEDIATE (Level 80+)
	-- =========================================================================
	[301] = {
		name = "Dragons",
		categoryId = 2,
		level = 80,
		count = 400,
		creatures = { "dragon", "dragon hatchling" },
		rewards = { points = 300 },
	},
	[302] = {
		name = "Wyrms",
		categoryId = 2,
		level = 80,
		count = 400,
		creatures = { "wyrm" },
		rewards = { points = 320 },
	},
	[303] = {
		name = "Giant Spiders",
		categoryId = 2,
		level = 80,
		count = 320,
		creatures = { "giant spider" },
		rewards = { points = 280 },
	},
	[304] = {
		name = "Ancient Scarabs",
		categoryId = 2,
		level = 80,
		count = 360,
		creatures = { "ancient scarab" },
		rewards = { points = 290 },
	},
	[305] = {
		name = "Vampires",
		categoryId = 2,
		level = 80,
		count = 400,
		creatures = { "vampire", "vampire bride", "vampire viscount" },
		rewards = { points = 330 },
	},
	[306] = {
		name = "Necromancers & Priestesses",
		categoryId = 2,
		level = 80,
		count = 320,
		creatures = { "necromancer", "priestess", "blood priest" },
		rewards = { points = 300 },
	},
	[307] = {
		name = "Bonebeasts",
		categoryId = 2,
		level = 80,
		count = 360,
		creatures = { "bonebeast" },
		rewards = { points = 290 },
	},
	[308] = {
		name = "Bog Raiders",
		categoryId = 2,
		level = 80,
		count = 360,
		creatures = { "bog raider" },
		rewards = { points = 290 },
	},
	[309] = {
		name = "Sea Serpents",
		categoryId = 2,
		level = 90,
		count = 480,
		creatures = { "sea serpent", "young sea serpent" },
		rewards = { points = 420 },
	},
	[310] = {
		name = "Nightmares",
		categoryId = 2,
		level = 90,
		count = 400,
		creatures = { "nightmare", "nightmare scion" },
		rewards = { points = 350 },
	},
	[311] = {
		name = "Hellspawns",
		categoryId = 2,
		level = 90,
		count = 400,
		creatures = { "hellspawn" },
		rewards = { points = 350 },
	},
	[312] = {
		name = "Crystal Spiders",
		categoryId = 2,
		level = 80,
		count = 360,
		creatures = { "crystal spider", "ice golem" },
		rewards = { points = 290 },
	},
	[313] = {
		name = "Brimstone Bugs",
		categoryId = 2,
		level = 80,
		count = 360,
		creatures = { "brimstone bug" },
		rewards = { points = 290 },
	},
	[314] = {
		name = "Werewolves",
		categoryId = 2,
		level = 80,
		count = 360,
		creatures = { "werewolf" },
		rewards = { points = 320 },
	},
	[401] = {
		name = "Dragon Lords",
		categoryId = 2,
		level = 100,
		count = 500,
		creatures = { "dragon lord", "dragon lord hatchling" },
		rewards = { points = 550 },
	},
	[402] = {
		name = "Frost Dragons",
		categoryId = 2,
		level = 100,
		count = 500,
		creatures = { "frost dragon", "frost dragon hatchling" },
		rewards = { points = 550 },
	},
	[403] = {
		name = "Hydras",
		categoryId = 2,
		level = 100,
		count = 500,
		creatures = { "hydra" },
		rewards = { points = 520 },
	},
	[404] = {
		name = "Behemoths",
		categoryId = 2,
		level = 110,
		count = 500,
		creatures = { "behemoth" },
		rewards = { points = 550 },
	},
	[405] = {
		name = "Warlocks",
		categoryId = 2,
		level = 120,
		count = 400,
		creatures = { "warlock" },
		rewards = { points = 550 },
	},
	[406] = {
		name = "Medusas & Serpents",
		categoryId = 2,
		level = 130,
		count = 500,
		creatures = { "medusa", "serpent spawn" },
		rewards = { points = 580 },
	},
	[409] = {
		name = "Glooth Bandits",
		categoryId = 2,
		level = 130,
		count = 700,
		creatures = { "glooth bandit", "glooth brigand" },
		rewards = { points = 650 },
	},
	[410] = {
		name = "Glooth Golems",
		categoryId = 2,
		level = 130,
		count = 700,
		creatures = { "glooth golem", "rustheap golem" },
		rewards = { points = 650 },
	},
	[413] = {
		name = "Grimvale Werecreatures",
		categoryId = 2,
		level = 100,
		count = 600,
		creatures = { "werewolf", "werebadger", "werebear", "wereboar", "werefox" },
		rewards = { points = 550 },
	},
	[414] = {
		name = "Hero Cave Squad",
		categoryId = 2,
		level = 100,
		count = 600,
		creatures = { "hero", "vile grandmaster", "renegade knight", "blood priest" },
		rewards = { points = 550 },
	},

	-- =========================================================================
	-- TIER 3: EXPERT (Level 150+)
	-- =========================================================================
	[315] = {
		name = "Pirats (The Wreckoning)",
		categoryId = 3,
		level = 150,
		count = 800,
		creatures = { "pirat cutthroat", "pirat scoundrel", "pirat bombardier", "pirat artillerist", "elite pirat", "pirat mate" },
		rewards = { points = 1400 },
	},
	[407] = {
		name = "Grim Reapers",
		categoryId = 3,
		level = 150,
		count = 600,
		creatures = { "grim reaper" },
		rewards = { points = 950 },
	},
	[408] = {
		name = "Ghastly Dragons",
		categoryId = 3,
		level = 150,
		count = 500,
		creatures = { "ghastly dragon" },
		rewards = { points = 950 },
	},
	[411] = {
		name = "Draken Warmasters",
		categoryId = 3,
		level = 150,
		count = 700,
		creatures = { "draken warmaster", "draken spellweaver" },
		rewards = { points = 1050 },
	},
	[412] = {
		name = "Werehyaenas & Werecrocodiles",
		categoryId = 3,
		level = 150,
		count = 800,
		creatures = { "werehyaena", "werehyaena shaman", "werecrocodile" },
		rewards = { points = 1400 },
	},
	[501] = {
		name = "Barkless Cultists",
		categoryId = 3,
		level = 150,
		count = 800,
		creatures = { "barkless devotee", "barkless fanatic" },
		rewards = { points = 1400 },
	},
	[502] = {
		name = "Carnivors (Port Hope Rock)",
		categoryId = 3,
		level = 160,
		count = 800,
		creatures = { "spiky carnivor", "menacing carnivor", "lumbering carnivor" },
		rewards = { points = 1500 },
	},
	[511] = {
		name = "Deeper Banuta",
		categoryId = 3,
		level = 160,
		count = 800,
		creatures = { "medusa", "serpent spawn", "hydra", "eternal guardian" },
		rewards = { points = 1500 },
	},
	[503] = {
		name = "High Drakens",
		categoryId = 3,
		level = 180,
		count = 800,
		creatures = { "draken abomination", "draken elite" },
		rewards = { points = 1600 },
	},
	[504] = {
		name = "Spectres (Cathedral / Courts)",
		categoryId = 3,
		level = 180,
		count = 800,
		creatures = { "gazer spectre", "burster spectre", "ripper spectre" },
		rewards = { points = 1800 },
	},
	[505] = {
		name = "Asuras (Palace)",
		categoryId = 3,
		level = 180,
		count = 800,
		creatures = { "dawnfire asura", "midnight asura", "frost flower asura" },
		rewards = { points = 1900 },
	},
	[509] = {
		name = "Draken Walls",
		categoryId = 3,
		level = 180,
		count = 800,
		creatures = { "draken warmaster", "draken spellweaver", "draken abomination", "draken elite" },
		rewards = { points = 1700 },
	},
	[510] = {
		name = "Oramond Minotaurs",
		categoryId = 3,
		level = 180,
		count = 800,
		creatures = { "moohtant", "minotaur amazon", "minotaur hunter", "worm priestess" },
		rewards = { points = 1600 },
	},
	[517] = {
		name = "Werehyaenas & Weretigers",
		categoryId = 3,
		level = 180,
		count = 800,
		creatures = { "werehyaena", "werehyaena shaman", "werecrocodile", "feral werecrocodile", "weretiger", "white weretiger" },
		rewards = { points = 1800 },
	},
	[506] = {
		name = "Roshamuul Surface",
		categoryId = 3,
		level = 200,
		count = 800,
		creatures = { "frazzlemaw", "silencer", "guzzlemaw", "choking fear", "retching horror" },
		rewards = { points = 2100 },
	},
	[507] = {
		name = "Demons & Hellhounds (Goroma / Inq)",
		categoryId = 3,
		level = 200,
		count = 800,
		creatures = { "demon", "hellhound", "dark torturer", "juggernaut", "demon outcast" },
		rewards = { points = 2000 },
	},
	[508] = {
		name = "Drefia Skeleton Elites",
		categoryId = 3,
		level = 200,
		count = 800,
		creatures = { "skeleton elite warrior", "undead gladiator" },
		rewards = { points = 1800 },
	},
	[513] = {
		name = "Nightmare Isles",
		categoryId = 3,
		level = 200,
		count = 800,
		creatures = { "choking fear", "retching horror", "silencer" },
		rewards = { points = 1900 },
	},
	[601] = {
		name = "Werelions (Kilmaresh)",
		categoryId = 3,
		level = 200,
		count = 800,
		creatures = { "werelion", "werelioness" },
		rewards = { points = 2200 },
	},
	[512] = {
		name = "Prison -1 Squad",
		categoryId = 3,
		level = 220,
		count = 800,
		creatures = { "dark torturer", "demon outcast", "hellhound", "blightwalker", "defiler" },
		rewards = { points = 2200 },
	},
	[514] = {
		name = "Elves of Summer & Winter Courts",
		categoryId = 3,
		level = 220,
		count = 800,
		creatures = { "crazed summer vanguard", "crazed summer rearguard", "crazed winter vanguard", "crazed winter rearguard", "insane siren" },
		rewards = { points = 2200 },
	},
	[516] = {
		name = "Buried Cathedral",
		categoryId = 3,
		level = 220,
		count = 800,
		creatures = { "burster spectre", "gazer spectre", "ripper spectre", "arachnophobica" },
		rewards = { points = 2200 },
	},
	[515] = {
		name = "Oramond Catacombs",
		categoryId = 3,
		level = 230,
		count = 800,
		creatures = { "dark torturer", "demon outcast", "hellhound", "destroyer", "juggernaut", "grim reaper", "plaguesmith" },
		rewards = { points = 2300 },
	},
	[602] = {
		name = "Sphinxes & Goannas (Issavi Surface)",
		categoryId = 3,
		level = 250,
		count = 800,
		creatures = { "feral sphinx", "sphinx", "adult goanna", "young goanna" },
		rewards = { points = 2400 },
	},
	[605] = {
		name = "Deathlings",
		categoryId = 3,
		level = 250,
		count = 800,
		creatures = { "deathling spellsinger", "deathling scout" },
		rewards = { points = 2400 },
	},
	[607] = {
		name = "Marapur Nagas",
		categoryId = 3,
		level = 250,
		count = 800,
		creatures = { "naga archer", "naga warrior", "rogue naga", "corrupt naga" },
		rewards = { points = 2400 },
	},
	[614] = {
		name = "Otherworld (Heart of Destruction)",
		categoryId = 3,
		level = 250,
		count = 800,
		creatures = { "breach brood", "dread intruder", "reality reaver", "sparkion" },
		rewards = { points = 2400 },
	},

	-- =========================================================================
	-- TIER 4: VETERAN (Level 300+)
	-- =========================================================================
	[415] = {
		name = "Mitmah & Iks (Iksupan)",
		categoryId = 4,
		level = 300,
		count = 1000,
		creatures = { "mitmah seer", "mitmah scout", "iks yapunac", "iks pututu", "iks churrascan", "iks aucar", "iks chuka", "iks ahpututu" },
		rewards = { points = 3400 },
	},
	[603] = {
		name = "Falcon Bastion",
		categoryId = 4,
		level = 300,
		count = 1000,
		creatures = { "falcon knight", "falcon paladin" },
		rewards = { points = 3200 },
	},
	[604] = {
		name = "Cobra Bastion",
		categoryId = 4,
		level = 300,
		count = 1000,
		creatures = { "cobra assassin", "cobra vizier", "cobra scout" },
		rewards = { points = 3200 },
	},
	[608] = {
		name = "Crypt Wardens & Lamassu (Issavi Catacombs)",
		categoryId = 4,
		level = 300,
		count = 1000,
		creatures = { "crypt warden", "lamassu" },
		rewards = { points = 3200 },
	},
	[611] = {
		name = "Bulltaurs (Jaded Roots / Lair)",
		categoryId = 4,
		level = 300,
		count = 1000,
		creatures = { "bulltaur brute", "bulltaur alchemist", "bulltaur forgepriest" },
		rewards = { points = 3200 },
	},
	[613] = {
		name = "Prison Lower Floors (-2 / -3)",
		categoryId = 4,
		level = 300,
		count = 1000,
		creatures = { "demon outcast", "juggernaut", "plaguesmith", "dark torturer", "betrayed wraith", "hellhound" },
		rewards = { points = 3200 },
	},
	[606] = {
		name = "True Asuras (Vaults)",
		categoryId = 4,
		level = 320,
		count = 1000,
		creatures = { "true dawnfire asura", "true midnight asura", "true frost flower asura" },
		rewards = { points = 3600 },
	},
	[610] = {
		name = "Ferumbras Ascendant (Grounds of Destruction)",
		categoryId = 4,
		level = 320,
		count = 1000,
		creatures = { "grimeleech", "vexclaw", "hellflayer", "undead dragon" },
		rewards = { points = 3500 },
	},
	[416] = {
		name = "Lost Souls (Darashia & Port Hope)",
		categoryId = 4,
		level = 350,
		count = 1000,
		creatures = { "mean lost soul", "flimsy lost soul", "freakish lost soul", "lost soul" },
		rewards = { points = 4000 },
	},
	[609] = {
		name = "Secret Library",
		categoryId = 4,
		level = 350,
		count = 1000,
		creatures = { "rage squid", "brain squid", "squid warden", "guardian of tales", "energuardian of tales" },
		rewards = { points = 3800 },
	},
	[417] = {
		name = "Soul War - Rotten Wasteland & Ebb",
		categoryId = 4,
		level = 400,
		count = 1000,
		creatures = { "rotten golem", "turbulent elemental", "distorted phantom", "capricious phantom", "hateful soul", "branchy crawler" },
		rewards = { points = 4200 },
	},
	[418] = {
		name = "Gnomprona - Magma Depths",
		categoryId = 4,
		level = 400,
		count = 1000,
		creatures = { "magma crawler", "lava creature", "magma crystal", "magma bubble" },
		rewards = { points = 4400 },
	},
	[612] = {
		name = "Soul War (Crater & Infernos)",
		categoryId = 4,
		level = 400,
		count = 1000,
		creatures = { "infernal demon", "infernal phantom", "brachiodemon", "bony sea devil", "cloak of terror" },
		rewards = { points = 4200 },
	},

	-- =========================================================================
	-- TIER 5: WARMASTER (Level 500+)
	-- =========================================================================
	[701] = {
		name = "Inferniarchs (Infernal Domain)",
		categoryId = 5,
		level = 500,
		count = 1000,
		creatures = { "hellhunter inferniarch", "spellreaper inferniarch", "gorger inferniarch", "broodrider inferniarch", "brinebrute inferniarch", "sineater inferniarch" },
		rewards = { points = 6500 },
	},
	[702] = {
		name = "Rotten Blood - Darklight Constructs",
		categoryId = 5,
		level = 500,
		count = 1000,
		creatures = { "darklight construct", "darklight striker", "darklight matter", "darklight emitter", "darklight source" },
		rewards = { points = 6500 },
	},
	[703] = {
		name = "Rotten Blood - Putrid Vermin",
		categoryId = 5,
		level = 500,
		count = 1000,
		creatures = { "bloated man-maggot", "rotten man-maggot", "elder bloodjaw", "meandering mushroom", "mycobiontic beetle" },
		rewards = { points = 6500 },
	},
	[704] = {
		name = "Rotten Blood - Sanguine Pillars & Carcasses",
		categoryId = 5,
		level = 500,
		count = 1000,
		creatures = { "oozing carcass", "oozing corpus", "sopping carcass", "sopping corpus", "walking pillar", "wandering pillar" },
		rewards = { points = 6500 },
	},
	[705] = {
		name = "Gnomprona - Primal Ordeal Hazard",
		categoryId = 5,
		level = 500,
		count = 1000,
		creatures = { "magma crawler", "lava creature", "magma crystal", "magma bubble", "unchained fire" },
		rewards = { points = 6000 },
	},
	[706] = {
		name = "Soul War - Master Abyssal Horrors",
		categoryId = 5,
		level = 500,
		count = 1000,
		creatures = { "infernal demon", "infernal phantom", "brachiodemon", "bony sea devil", "cloak of terror", "rotten golem", "turbulent elemental", "distorted phantom", "hateful soul" },
		rewards = { points = 6000 },
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
			name = "Task Damage Bonus",
			description = "Increases all damage dealt against your active task monsters.",
			storage = 14021,
			maxLevel = 5,
			levels = {
				[1] = { cost = 100, value = 5, desc = "+5% Damage" },
				[2] = { cost = 250, value = 10, desc = "+10% Damage" },
				[3] = { cost = 500, value = 15, desc = "+15% Damage" },
				[4] = { cost = 1000, value = 20, desc = "+20% Damage" },
				[5] = { cost = 2000, value = 25, desc = "+25% Damage" },
			},
		},
		critical = {
			key = "critical",
			name = "Task Critical Chance",
			description = "Chance to deal a critical strike (+50% damage) on your active task monsters.",
			storage = 14025,
			maxLevel = 3,
			levels = {
				[1] = { cost = 200, value = 5, desc = "+5% Critical Chance" },
				[2] = { cost = 500, value = 10, desc = "+10% Critical Chance" },
				[3] = { cost = 1200, value = 15, desc = "+15% Critical Chance" },
			},
		},
		leech = {
			key = "leech",
			name = "Task Life Leech",
			description = "Heals you for a percentage of the damage dealt to your active task monsters.",
			storage = 14022,
			maxLevel = 5,
			levels = {
				[1] = { cost = 150, value = 3, desc = "+3% Life Leech" },
				[2] = { cost = 300, value = 6, desc = "+6% Life Leech" },
				[3] = { cost = 600, value = 10, desc = "+10% Life Leech" },
				[4] = { cost = 1200, value = 15, desc = "+15% Life Leech" },
				[5] = { cost = 2500, value = 20, desc = "+20% Life Leech" },
			},
		},
		loot = {
			key = "loot",
			name = "Task Loot Bonus",
			description = "Chance for extra loot drop rolls from your active task monsters.",
			storage = 14023,
			maxLevel = 3,
			levels = {
				[1] = { cost = 300, value = 5, desc = "+5% Extra Loot" },
				[2] = { cost = 800, value = 10, desc = "+10% Extra Loot" },
				[3] = { cost = 2000, value = 15, desc = "+15% Extra Loot" },
			},
		},
		bestiary = {
			key = "bestiary",
			name = "Task Double Kill",
			description = "Chance to count 2 kills instead of 1 towards Bestiary unlock for task monsters.",
			storage = 14024,
			maxLevel = 3,
			levels = {
				[1] = { cost = 250, value = 30, desc = "30% Double Bestiary Kill" },
				[2] = { cost = 600, value = 60, desc = "60% Double Bestiary Kill" },
				[3] = { cost = 1500, value = 100, desc = "100% Guaranteed Double Bestiary Kill" },
			},
		},
	},

	amuletItemId = 31268,
	amuletUpgrades = {
		defense = {
			key = "defense",
			name = "Task Physical Ward",
			description = "Reduces physical damage taken from your active task monsters.",
			storage = 14026,
			maxLevel = 5,
			levels = {
				[1] = { cost = 100, value = 4, desc = "+4% Physical Protection" },
				[2] = { cost = 250, value = 8, desc = "+8% Physical Protection" },
				[3] = { cost = 500, value = 12, desc = "+12% Physical Protection" },
				[4] = { cost = 1000, value = 16, desc = "+16% Physical Protection" },
				[5] = { cost = 2000, value = 20, desc = "+20% Physical Protection" },
			},
		},
		elemental = {
			key = "elemental",
			name = "Task Elemental Ward",
			description = "Reduces all elemental/magical damage taken from your active task monsters.",
			storage = 14027,
			maxLevel = 5,
			levels = {
				[1] = { cost = 150, value = 3, desc = "+3% All Elemental Protection" },
				[2] = { cost = 350, value = 6, desc = "+6% All Elemental Protection" },
				[3] = { cost = 700, value = 10, desc = "+10% All Elemental Protection" },
				[4] = { cost = 1400, value = 14, desc = "+14% All Elemental Protection" },
				[5] = { cost = 2500, value = 18, desc = "+18% All Elemental Protection" },
			},
		},
		speed = {
			key = "speed",
			name = "Haste Ward",
			description = "Increases your movement speed while wearing the Bounty Amulet.",
			storage = 14028,
			maxLevel = 5,
			levels = {
				[1] = { cost = 100, value = 10, desc = "+10 Speed" },
				[2] = { cost = 200, value = 20, desc = "+20 Speed" },
				[3] = { cost = 400, value = 30, desc = "+30 Speed" },
				[4] = { cost = 800, value = 40, desc = "+40 Speed" },
				[5] = { cost = 1500, value = 50, desc = "+50 Speed" },
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
