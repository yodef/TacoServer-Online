-- Minlevel and multiplier are MANDATORY
-- Maxlevel is OPTIONAL, but is considered infinite by default
-- Create a stage with minlevel 1 and no maxlevel to disable stages
experienceStages = {
	{
		minlevel = 1,
		maxlevel = 99,
		multiplier = 100,
	},
	{
		minlevel = 100,
		maxlevel = 249,
		multiplier = 75,
	},
	{
		minlevel = 250,
		maxlevel = 499,
		multiplier = 50,
	},
	{
		minlevel = 50,
		maxlevel = 999,
		multiplier = 30,
	},
	{
		minlevel = 1000,
		multiplier = 20,
	},
}

skillsStages = {
	{
		minlevel = 10,
		maxlevel = 60,
		multiplier = 30,
	},
	{
		minlevel = 61,
		maxlevel = 80,
		multiplier = 20,
	},
	{
		minlevel = 81,
		maxlevel = 110,
		multiplier = 15,
	},
	{
		minlevel = 111,
		maxlevel = 125,
		multiplier = 10,
	},
	{
		minlevel = 126,
		multiplier = 5,
	},
}

magicLevelStages = {
	{
		minlevel = 0,
		maxlevel = 60,
		multiplier = 28,
	},
	{
		minlevel = 61,
		maxlevel = 80,
		multiplier = 18,
	},
	{
		minlevel = 81,
		maxlevel = 100,
		multiplier = 13,
	},
	{
		minlevel = 101,
		maxlevel = 110,
		multiplier = 8,
	},
	{
		minlevel = 111,
		multiplier = 5,
	},
}
