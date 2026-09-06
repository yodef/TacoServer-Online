local internalNpcName = "Xodet"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookType = 130,
	lookHead = 19,
	lookBody = 86,
	lookLegs = 87,
	lookFeet = 95,
	lookAddons = 0,
}

npcConfig.flags = {
	floorchange = false,
}

local itemsTable = {
	["potions"] = {
		{ itemName = "empty potion flask", clientId = 283, sell = 5 },
		{ itemName = "empty potion flask", clientId = 284, sell = 5 },
		{ itemName = "empty potion flask", clientId = 285, sell = 5 },
		{ itemName = "great health potion", clientId = 239, buy = 225 },
		{ itemName = "great mana potion", clientId = 238, buy = 158 },
		{ itemName = "great spirit potion", clientId = 7642, buy = 254 },
		{ itemName = "health potion", clientId = 266, buy = 50 },
		{ itemName = "mana potion", clientId = 268, buy = 56 },
		{ itemName = "strong health potion", clientId = 236, buy = 115 },
		{ itemName = "strong mana potion", clientId = 237, buy = 108 },
		{ itemName = "vial", clientId = 2874, sell = 5 },
		{ itemName = "mastermind potion", clientId = 7440, sell = 3000, buy = 5000 },
		{ itemName = "bullseye potion", clientId = 7443, sell = 3000, buy = 5000 },
		{ itemName = "transcendence potion", clientId = 49271, sell = 3000, buy = 5000 },
		{ itemName = "berserk potion", clientId = 7439, sell = 3000, buy = 5000 },	
		{ itemName = "supreme health potion", clientId = 23375, buy = 625 },
		{ itemName = "ultimate health potion", clientId = 7643, buy = 379 },
		{ itemName = "ultimate mana potion", clientId = 23373, buy = 488 },
		{ itemName = "ultimate spirit potion", clientId = 23374, buy = 488 },
	},
	["runes"] = {
		{ itemName = "avalanche rune", clientId = 3161, buy = 64 },
		{ itemName = "blank rune", clientId = 3147, buy = 10 },
		{ itemName = "chameleon rune", clientId = 3178, buy = 210 },
		{ itemName = "convince creature rune", clientId = 3177, buy = 80 },
		{ itemName = "cure poison rune", clientId = 3153, buy = 65 },
		{ itemName = "destroy field rune", clientId = 3148, buy = 15 },
		{ itemName = "energy field rune", clientId = 3164, buy = 38 },
		{ itemName = "energy wall rune", clientId = 3166, buy = 85 },
		{ itemName = "explosion rune", clientId = 3200, buy = 31 },
		{ itemName = "fire bomb rune", clientId = 3192, buy = 147 },
		{ itemName = "fire field rune", clientId = 3188, buy = 28 },
		{ itemName = "fire wall rune", clientId = 3190, buy = 61 },
		{ itemName = "great fireball rune", clientId = 3191, buy = 64 },
		{ itemName = "heavy magic missile rune", clientId = 3198, buy = 12 },
		{ itemName = "intense healing rune", clientId = 3152, buy = 95 },
		{ itemName = "light magic missile rune", clientId = 3174, buy = 4 },
		{ itemName = "poison field rune", clientId = 3172, buy = 21 },
		{ itemName = "poison wall rune", clientId = 3176, buy = 52 },
		{ itemName = "stalagmite rune", clientId = 3179, buy = 12 },
		{ itemName = "sudden death rune", clientId = 3155, buy = 162 },
		{ itemName = "ultimate healing rune", clientId = 3160, buy = 175 },	
	{ itemName = "magic wall rune", clientId = 3180, buy = 116 },		
	{ itemName = "holy missile rune", clientId = 3182, buy = 16 },		
	{ itemName = "disintegrate rune", clientId = 3197, buy = 26 },	
	{ itemName = "animate dead rune", clientId = 3203, buy = 375 },	
	{ itemName = "energy bomb rune", clientId = 3149, buy = 203 },
	{ itemName = "fireball rune", clientId = 3189, buy = 30 },	
	{ itemName = "icicle rune", clientId = 3158, buy = 30 },	
	{ itemName = "paralyse rune", clientId = 3165, buy = 700 },	
	{ itemName = "poison bomb rune", clientId = 3173, buy = 85 },	
	{ itemName = "soulfire rune", clientId = 3195, buy = 46 },	
	{ itemName = "stone shower rune", clientId = 3175, buy = 37 },
	{ itemName = "wild growth rune", clientId = 3156, buy = 160 },
	{ itemName = "thunderstorm rune", clientId = 3202, buy = 47 },
	},
	["wands"] = {	
	{ itemName = "dream blossom staff", clientId = 25700, sell = 15000 },		
	{ itemName = "snakebite rod", clientId = 3066, buy = 500 },
	{ itemName = "underworld rod", clientId = 8082, buy = 22000 },
	{ itemName = "moonlight rod", clientId = 3070, buy = 1000 },
	{ itemName = "wand of vortex", clientId = 3074, buy = 500 },
	{ itemName = "necrotic rod", clientId = 3069, buy = 5000 },
	{ itemName = "northwind rod", clientId = 8083, buy = 7500 },
	{ itemName = "hailstorm rod", clientId = 3067, buy = 15000 },
	{ itemName = "terra rod", clientId = 3065, buy = 10000 },
	{ itemName = "wand of cosmic energy", clientId = 3073, buy = 10000 },
	{ itemName = "wand of decay", clientId = 3072, buy = 5000 },
	{ itemName = "wand of draconia", clientId = 8093, buy = 7500 },
	{ itemName = "wand of dragonbreath", clientId = 3075, buy = 1000 },
	{ itemName = "wand of inferno", clientId = 3071, buy = 15000 },
	{ itemName = "wand of starstorm", clientId = 8092, buy = 18000 },
	{ itemName = "wand of voodoo", clientId = 8094, buy = 22000 },
	{ itemName = "springsprout rod", clientId = 8084, buy = 18000 },
	},
	["exercise weapons"] = {
	{ itemName = "durable exercise rod", clientId = 35283, buy = 1250000, count = 1800 },
	{ itemName = "durable exercise wand", clientId = 35284, buy = 1250000, count = 1800 },
	{ itemName = "exercise rod", clientId = 28556, buy = 347222, count = 500 },
	{ itemName = "exercise wand", clientId = 28557, buy = 347222, count = 500 },
	{ itemName = "lasting exercise rod", clientId = 35289, buy = 10000000, count = 14400 },
	{ itemName = "lasting exercise wand", clientId = 35290, buy = 10000000, count = 14400 },
	},
	["others"] = {
	{ itemName = "spellwand", clientId = 651, sell = 299 },
	{ itemName = "temple teleport scroll", clientId = 25718, buy = 5000 },
	{ itemName = "batwing hat", clientId = 9103, sell = 8000 },
	{ itemName = "ethno coat", clientId = 8064, buy = 750, sell = 200 },
	{ itemName = "focus cape", clientId = 8043, sell = 6000 },
	{ itemName = "jade hat", clientId = 10451, sell = 9000 },
	{ itemName = "magicians robe", clientId = 7991, buy = 450 },
	{ itemName = "spellweavers rob", clientId = 10438, sell = 12000 },
	{ itemName = "spirit cloak", clientId = 8042, buy = 1000, sell = 350 },
	{ itemName = "zaoan robe", clientId = 10439, sell = 12000 },
	},
	["shields"] = {
	{ itemName = "spellbook", clientId = 3059, buy = 150, sell = 50 },
	{ itemName = "spellbook of enlightenment", clientId = 8072, buy = 10000, sell = 4000 },
	{ itemName = "spellbook of lost souls", clientId = 8075, buy = 40000, sell = 19000 },
	{ itemName = "spellbook of mind control", clientId = 8074, buy = 28000,  sell = 13000 },
	{ itemName = "spellbook of warding", clientId = 8073, buy = 18000, sell = 8000 },
	},
	["valuables"] = {
	{ itemName = "amber", clientId = 32626, sell = 20000 },
	{ itemName = "lesser guardian gem", clientId = 44602, buy = 11000, sell = 2500 },
	{ itemName = "lesser marksman gem", clientId = 44605, buy = 11000, sell = 2500 },
	{ itemName = "lesser sage gem", clientId = 44608, buy = 11000, sell = 2500 },
	{ itemName = "lesser spiritualist gem", clientId = 49371, buy = 11000, sell = 2500 },
	{ itemName = "lesser mystic gem", clientId = 44611, buy = 11000, sell = 2500 },
	{ itemName = "guardian gem", clientId = 44603, sell = 10000 },
	{ itemName = "marksman gem", clientId = 44606, sell = 10000 },
	{ itemName = "sage gem", clientId = 44609, sell = 10000 },
	{ itemName = "spiritualist gem", clientId = 49372, sell = 10000 },
	{ itemName = "mystic gem", clientId = 44612, sell = 10000 },
	{ itemName = "greater guardian gem", clientId = 44604, sell = 25000 },
	{ itemName = "greater marksman gem", clientId = 44607, sell = 25000 },
	{ itemName = "greater sage gem", clientId = 44610, sell = 25000 },
	{ itemName = "greater mystic gem", clientId = 44613, sell = 25000 },
	{ itemName = "greater spiritualist gem", clientId = 49373, sell = 25000 },	
	{ itemName = "life crystal", clientId = 3061, sell = 85 },
	{ itemName = "amber with a bug", clientId = 32624, sell = 41000 },
	{ itemName = "amber with a dragonfly", clientId = 32625, sell = 56000 },
	{ itemName = "ancient coin", clientId = 24390, sell = 350 },
	{ itemName = "bar of gold", clientId = 14112, sell = 10000 },
	{ itemName = "black pearl", clientId = 3027, buy = 560, sell = 280 },
	{ itemName = "blue crystal shard", clientId = 16119, sell = 1500 },
	{ itemName = "blue crystal splinter", clientId = 16124, sell = 400 },
	{ itemName = "blue rose", clientId = 3659, sell = 200 },
	{ itemName = "bronze goblet", clientId = 5807, buy = 2000 },
	{ itemName = "brown crystal splinter", clientId = 16123, sell = 400 },
	{ itemName = "brown giant shimmering pearl", clientId = 282, sell = 3000 },
	{ itemName = "butterfly ring", clientId = 25698, buy = 8000 , sell = 2000 },
	{ itemName = "colourful snail shell", clientId = 25696, sell = 250 },
	{ itemName = "coral brooch", clientId = 24391, sell = 750 },
	{ itemName = "crunor idol", clientId = 30055, sell = 30000 },
	{ itemName = "crystal ball", clientId = 3076, buy = 530, sell = 190 },
	{ itemName = "cyan crystal fragment", clientId = 16125, sell = 800 },
	{ itemName = "dandelion seeds", clientId = 25695, sell = 200 },	
	{ itemName = "diamond", clientId = 32770, sell = 15000 },
	{ itemName = "dragon figurine", clientId = 30053, sell = 45000 },
	{ itemName = "fairy wings", clientId = 25694, sell = 200 },
	{ itemName = "fern", clientId = 3737, sell = 20 },
	{ itemName = "gemmed figurine", clientId = 24392, sell = 3500 },
	{ itemName = "giant amethyst", clientId = 32622, sell = 60000 },
	{ itemName = "giant emerald", clientId = 30060, sell = 90000 },
	{ itemName = "giant ruby", clientId = 30059, sell = 70000 },
	{ itemName = "giant sapphire", clientId = 30061, sell = 50000 },
	{ itemName = "giant topaz", clientId = 32623, sell = 80000 },
	{ itemName = "goat grass", clientId = 3674, sell = 50 },
	{ itemName = "gold ingot", clientId = 9058, sell = 5000 },
	{ itemName = "gold nugget", clientId = 3040, sell = 850 },
	{ itemName = "golden amulet", clientId = 3013, buy = 6600 },
	{ itemName = "golden figurine", clientId = 5799, sell = 3000 },
	{ itemName = "golden goblet", clientId = 5805, buy = 5000 },
	{ itemName = "green crystal fragment", clientId = 16127, sell = 800 },
	{ itemName = "green crystal shard", clientId = 16121, sell = 1500 },
	{ itemName = "green crystal splinter", clientId = 16122, sell = 400 },
	{ itemName = "green giant shimmering pearl", clientId = 281, sell = 3000 },
	{ itemName = "hexagonal ruby", clientId = 30180, sell = 30000 },
	{ itemName = "hibiscus dress", clientId = 8045, sell = 3000 },	
	{ itemName = "lion figurine", clientId = 33781, sell = 10000 },
	{ itemName = "mandrake", clientId = 5014, sell = 5000 },
	{ itemName = "moonstone", clientId = 32771, sell = 13000 },
	{ itemName = "onyx chip", clientId = 22193, sell = 500 },
	{ itemName = "opal", clientId = 22194, sell = 500 },
	{ itemName = "ornate locket", clientId = 30056, sell = 18000 },
	{ itemName = "panpipes", clientId = 2953, sell = 150 },
	{ itemName = "powder herb", clientId = 3739, sell = 10 },
	{ itemName = "prismatic quartz", clientId = 24962, sell = 450 },
	{ itemName = "rainbow quartz", clientId = 25737, sell = 500 },
	{ itemName = "red crystal fragment", clientId = 16126, sell = 800 },
	{ itemName = "red rose", clientId = 3658, sell = 10 },
	{ itemName = "ruby necklace", clientId = 3016, buy = 3560 },
	{ itemName = "shimmering beatles", clientId = 25693, sell = 150 },
	{ itemName = "silver goblet", clientId = 5806, buy = 3000 },
	{ itemName = "skull coin", clientId = 32583, sell = 12000 },
	{ itemName = "sling herb", clientId = 3738, sell = 10 },
	{ itemName = "watering can", clientId = 650, buy = 50 },
	{ itemName = "raw watermelon tourmaline", clientId = 33778, sell = 10000 },
	{ itemName = "watermelon tourmaline slice", clientId = 33779, sell = 30000 },
	{ itemName = "watermelon tourmaline pear", clientId = 33780, sell = 240000 },
	{ itemName = "wedding ring", clientId = 3004, buy = 990, sell = 100 },
	{ itemName = "white Gem", clientId = 32769, sell = 12000 },
	{ itemName = "white pearl", clientId = 3026, buy = 320, sell = 160 },
	{ itemName = "white silk flower", clientId = 34008, sell = 9000 },
	{ itemName = "wild flowers", clientId = 25691, sell = 120 },
	{ itemName = "wood cape", clientId = 3575, sell = 5000 },
	{ itemName = "wooden spellbook", clientId = 25699, sell = 12000 },
	{ itemName = "basalt fetish", clientId = 17856, sell = 210 },
	{ itemName = "basalt figurine", clientId = 17857, sell = 160 },
	{ itemName = "bat wing", clientId = 5894, sell = 50 },
	{ itemName = "behemoth claw", clientId = 5930, sell = 2000 },
	{ itemName = "blazing bone", clientId = 16131, sell = 610 },
	{ itemName = "blood tincture in a vial", clientId = 18928, sell = 360 },
	{ itemName = "bloody dwarven beard", clientId = 17827, sell = 110 },
	{ itemName = "bola", clientId = 17809, sell = 35 },
	{ itemName = "bone fetish", clientId = 17831, sell = 150 },
	{ itemName = "bonelord eye", clientId = 5898, sell = 80 },
	{ itemName = "bony tail", clientId = 10277, sell = 210 },
	{ itemName = "brimstone fangs", clientId = 11702, sell = 380 },
	{ itemName = "brimstone shell", clientId = 11703, sell = 210 },
	{ itemName = "broken throwing axe", clientId = 17851, sell = 230 },
	{ itemName = "carrion worm fang", clientId = 10275, sell = 35 },
	{ itemName = "cheese cutter", clientId = 17817, sell = 50 },
	{ itemName = "chicken feather", clientId = 5890, sell = 30 },
	{ itemName = "deeptags", clientId = 14013, sell = 290 },
	{ itemName = "demon dust", clientId = 5906, sell = 300 },
	{ itemName = "demon horn", clientId = 5954, sell = 1000 },
	{ itemName = "demonic skeletal hand", clientId = 9647, sell = 80 },
	{ itemName = "dragon priests wandtip", clientId = 10444, sell = 175 },
	{ itemName = "dragons tail", clientId = 11457, sell = 100 },
	{ itemName = "draken sulphur", clientId = 11658, sell = 550 },
	{ itemName = "elder bonelord tentacle", clientId = 10276, sell = 150 },
	{ itemName = "elven astral observer", clientId = 11465, sell = 90 },
	{ itemName = "elven scouting glass", clientId = 11464, sell = 50 },
	{ itemName = "enchanted chicken wing", clientId = 5891, sell = 20000 },
	{ itemName = "fiery heart", clientId = 9636, sell = 375 },
	{ itemName = "fish fin", clientId = 5895, sell = 150 },
	{ itemName = "flask of warriors sweat", clientId = 5885, sell = 10000 },
	{ itemName = "frosty heart", clientId = 9661, sell = 280 },
	{ itemName = "gauze bandage", clientId = 9649, sell = 90 },
	{ itemName = "geomancers staff", clientId = 11463, sell = 120 },
	{ itemName = "giant eye", clientId = 10280, sell = 380 },
	{ itemName = "glob of acid slime", clientId = 9054, sell = 25 },
	{ itemName = "glob of mercury", clientId = 9053, sell = 20 },
	{ itemName = "glob of tar", clientId = 9055, sell = 30 },
	{ itemName = "green dragon scale", clientId = 5920, sell = 100 },
	{ itemName = "hardened bone", clientId = 5925, sell = 70 },
	{ itemName = "heaven blossom", clientId = 5921, sell = 50 },
	{ itemName = "hellspawn tail", clientId = 10304, sell = 475 },
	{ itemName = "hideous chunk", clientId = 16140, sell = 510 },
	{ itemName = "holy ash", clientId = 17850, sell = 160 },
	{ itemName = "holy orchid", clientId = 5922, sell = 90 },
	{ itemName = "honeycomb", clientId = 5902, sell = 40 },
	{ itemName = "humongous chunk", clientId = 16139, sell = 540 },
	{ itemName = "key to the drowned library", clientId = 14009, sell = 330 },
	{ itemName = "lizard scale", clientId = 5881, sell = 120 },
	{ itemName = "lost basher's spike", clientId = 17826, sell = 280 },
	{ itemName = "lost bracers", clientId = 17853, sell = 140 },
	{ itemName = "lost husher's staff", clientId = 17848, sell = 250 },
	{ itemName = "luminous orb", clientId = 11454, sell = 1000 },
	{ itemName = "mad froth", clientId = 17854, sell = 80 },
	{ itemName = "magic sulphur", clientId = 5904, sell = 8000 },
	{ itemName = "miraculum", clientId = 11474, sell = 60 },
	{ itemName = "mystical hourglass", clientId = 9660, sell = 700 },
	{ itemName = "pair of hellflayer horns", clientId = 22729, sell = 1300 },
	{ itemName = "perfect behemoth fang", clientId = 5893, sell = 250 },
	{ itemName = "red dragon scale", clientId = 5882, sell = 200 },
	{ itemName = "red hair dye", clientId = 17855, sell = 40 },
	{ itemName = "scythe leg", clientId = 10312, sell = 450 },
	{ itemName = "sea serpent scale", clientId = 9666, sell = 520 },
	{ itemName = "skull shatterer", clientId = 17849, sell = 170 },
	{ itemName = "small flask of eyedrops", clientId = 11512, sell = 95 },
	{ itemName = "some grimeleech wings", clientId = 22730, sell = 1200 },
	{ itemName = "spellsinger's seal", clientId = 14008, sell = 280 },
	{ itemName = "spider silk", clientId = 5879, sell = 100 },
	{ itemName = "spirit container", clientId = 5884, sell = 40000 },
	{ itemName = "spooky blue eye", clientId = 9642, sell = 95 },
	{ itemName = "stone wing", clientId = 10278, sell = 120 },
	{ itemName = "turtle shell", clientId = 5899, sell = 90 },
	{ itemName = "vampire dust", clientId = 5905, sell = 100 },
	{ itemName = "vexclaw talon", clientId = 22728, sell = 1100 },
	{ itemName = "weaver's wandtip", clientId = 10397, sell = 250 },
	{ itemName = "wimp tooth chain", clientId = 17847, sell = 120 },
	{ itemName = "wyrm scale", clientId = 9665, sell = 400 },
	{ itemName = "wyvern talisman", clientId = 9644, sell = 265 },
	{itemName = "ancient stone",		clientId = 9632,		sell = 200		}, 
	{		itemName = "battle stone",		clientId = 11447,		sell = 290		}, 
	{		itemName = "broken gladiator shield",		clientId = 9656,		sell = 190		}, 
	{		itemName = "coal",		clientId = 12600,		sell = 20		}, 
	{		itemName = "crystal of balance",		clientId = 9028,		sell = 1000		}, 
	{		itemName = "crystal of focus",		clientId = 9027,		sell = 2000		}, 
	{		itemName = "crystal of power",		clientId = 9067,		sell = 3000		}, 
	{		itemName = "crystal pedestal",		clientId = 9063,		sell = 500		}, 
	{		itemName = "crystalline spikes",		clientId = 16138,		sell = 440		}, 
	{		itemName = "flintstone",		clientId = 12806,		sell = 800		}, 
	{		itemName = "gear crystal",
		clientId = 9655,
		sell = 200
		}, {		itemName = "gear wheel",
		clientId = 8775,
		sell = 500
		}, {		itemName = "huge chunk of crude iron",
		clientId = 5892,
		sell = 15000
		}, {		itemName = "magma clump",
		clientId = 16130,
		sell = 570
		}, {		itemName = "metal spike",
		clientId = 10298,
		sell = 320
		}, {		itemName = "piece of draconian steel",
		clientId = 5889,
		sell = 3000
		}, {		itemName = "piece of hell steel",
		clientId = 5888,
		sell = 500
		}, {		itemName = "piece of hellfire armor",
		clientId = 9664,
		sell = 550
		}, {		itemName = "piece of royal steel",
		clientId = 5887,
		sell = 10000
		}, {		itemName = "pulverized ore",
		clientId = 16133,
		sell = 400}, 
		{itemName = "shiny stone", clientId = 10310, sell = 500}, 
		{itemName = "stone nose", clientId = 16137, sell = 590}, 
		{itemName = "sulphurous stone",		clientId = 10315,		sell = 100}, 
		{itemName = "vein of ore",		clientId = 16135,		sell = 330}, 
		{itemName = "war crystal",		clientId = 9654,		sell = 460},
		{ itemName = "life ring", clientId = 3052, buy = 900 },
	{ itemName = "small amethyst", clientId = 3033, buy = 400, sell = 200 },
	{ itemName = "small diamond", clientId = 3028, buy = 600, sell = 300 },
	{ itemName = "small emerald", clientId = 3032, buy = 500, sell = 250 },
	{ itemName = "small enchanted amethyst", clientId = 678, sell = 200 },
	{ itemName = "small enchanted emerald", clientId = 677, sell = 250 },
	{ itemName = "small enchanted ruby", clientId = 676, sell = 250 },
	{ itemName = "small enchanted sapphire", clientId = 675, sell = 250 },
	{ itemName = "small ruby", clientId = 3030, buy = 500, sell = 250 },
	{ itemName = "small sapphire", clientId = 3029, buy = 500, sell = 250 },
	{ itemName = "small topaz", clientId = 9057, sell = 200 },
	{ itemName = "star herb", clientId = 3736, sell = 15 },
	{ itemName = "stone herb", clientId = 3735, sell = 20 },	
	{ itemName = "summer dress", clientId = 8046, sell = 1500 },
	{ itemName = "tiger eye", clientId = 24961, sell = 350 },
	{ itemName = "unicorn figurine", clientId = 30054, sell = 50000 },
	{ itemName = "violet crystal shard", clientId = 16120, sell = 1500 },
	{ itemName = "moonlight crystal", clientId = 22083, buy = 5000 },
	{ itemName = "blue gem", clientId = 3041, sell = 5000 },
	{ itemName = "golden mug", clientId = 2903, sell = 1000 },
	{ itemName = "green gem", clientId = 3038, sell = 5000 },
	{ itemName = "red gem", clientId = 3039, sell = 1500 },
	{ itemName = "violet gem", clientId = 3036, sell = 10000 },
	{ itemName = "talon", clientId = 3034, sell = 320 },
	{ itemName = "black skull", clientId = 9056, sell = 4000 },
	{ itemName = "collar of blue plasma", clientId = 23542, sell = 6000 },
	{ itemName = "collar of green plasma", clientId = 23543, sell = 6000 },
	{ itemName = "collar of red plasma", clientId = 23544, sell = 6000 },
	{ itemName = "ring of blue plasma", clientId = 23529, sell = 8000 },
	{ itemName = "ring of green plasma", clientId = 23531, sell = 8000 },
	{ itemName = "ring of red plasma", clientId = 23533, sell = 8000 },
	{ itemName = "yellow gem", clientId = 3037, sell = 1500 },
	},
}

npcConfig.shop = {}
for _, categoryTable in pairs(itemsTable) do
	for _, itemTable in ipairs(categoryTable) do
		table.insert(npcConfig.shop, itemTable)
	end
end

local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)

npcType.onThink = function(npc, interval)
	npcHandler:onThink(npc, interval)
end

npcType.onAppear = function(npc, creature)
	npcHandler:onAppear(npc, creature)
end

npcType.onDisappear = function(npc, creature)
	npcHandler:onDisappear(npc, creature)
end

npcType.onMove = function(npc, creature, fromPosition, toPosition)
	npcHandler:onMove(npc, creature, fromPosition, toPosition)
end

npcType.onSay = function(npc, creature, type, message)
	npcHandler:onSay(npc, creature, type, message)
end

npcType.onCloseChannel = function(npc, creature)
	npcHandler:onCloseChannel(npc, creature)
end

local items = {
	[VOCATION.BASE_ID.SORCERER] = 3074,
	[VOCATION.BASE_ID.DRUID] = 3066,
}

local function creatureSayCallback(npc, creature, type, message)
	local player = Player(creature)
	local playerId = player:getId()

	if not npcHandler:checkInteraction(npc, creature) then
		return false
	end

	local categoryTable = itemsTable[message:lower()]
	local itemId = items[player:getVocation():getBaseId()]
	if MsgContains(message, "first rod") or MsgContains(message, "first wand") then
		if player:isMage() then
			if player:getStorageValue(Storage.FirstMageWeapon) == -1 then
				npcHandler:say("So you ask me for a {" .. ItemType(itemId):getName() .. "} to begin your adventure?", npc, creature)
				npcHandler:setTopic(playerId, 1)
			else
				npcHandler:say("What? I have already gave you one {" .. ItemType(itemId):getName() .. "}!", npc, creature)
			end
		else
			npcHandler:say("Sorry, you aren't a druid either a sorcerer.", npc, creature)
		end
	elseif MsgContains(message, "yes") then
		if npcHandler:getTopic(playerId) == 1 then
			player:addItem(itemId, 1)
			npcHandler:say("Here you are young adept, take care yourself.", npc, creature)
			player:setStorageValue(Storage.FirstMageWeapon, 1)
		end
		npcHandler:setTopic(playerId, 0)
	elseif MsgContains(message, "no") and npcHandler:getTopic(playerId) == 1 then
		npcHandler:say("Ok then.", npc, creature)
		npcHandler:setTopic(playerId, 0)
	elseif categoryTable then
		local remainingCategories = npc:getRemainingShopCategories(message:lower(), itemsTable)
		npcHandler:say("Of course, just browse through my wares. You can also look at " .. remainingCategories .. ".", npc, player)
		npc:openShopWindowTable(player, categoryTable)
	end
	return true
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:setMessage(
	MESSAGE_GREET,
	"Oh, please come in, |PLAYERNAME| \z
	If you need magical equipment such as {runes} or {wands}, just ask me for a {trade}."
)
npcHandler:setMessage(MESSAGE_SENDTRADE, "Of course, just browse through my wares. Or do you want to look only at " .. GetFormattedShopCategoryNames(itemsTable) .. ".")
npcHandler:setMessage(MESSAGE_FAREWELL, "Good bye and come again.")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Good bye and come again.")
npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

-- On buy npc shop message
npcType.onBuyItem = function(npc, player, itemId, subType, amount, ignore, inBackpacks, totalCost)
	npc:sellItem(player, itemId, amount, subType, 0, ignore, inBackpacks)
end

-- On sell npc shop message
npcType.onSellItem = function(npc, player, itemId, subtype, amount, ignore, name, totalCost)
	player:sendTextMessage(MESSAGE_TRADE, string.format("Sold %ix %s for %i gold.", amount, name, totalCost))
end
-- On check npc shop message (look item)
npcType.onCheckItem = function(npc, player, clientId, subType) end

npcType:register(npcConfig)
