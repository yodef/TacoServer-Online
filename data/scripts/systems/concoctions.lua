local configs = {
	-- Walter Jaeger Concoctions (10 hours cooldown)
	[Concoction.Ids.StaminaExtension] = {
		cooldownOverride = 10 * 60 * 60, -- 10 hours
		amount = 60, -- minutes
		callback = function(player, config)
			player:setStamina(player:getStamina() + config.amount)
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You have been granted " .. config.amount .. " minutes of stamina.")
		end,
	},
	[Concoction.Ids.KooldownAid] = {
		cooldownOverride = 10 * 60 * 60, -- 10 hours
		callback = function(player)
			player:clearSpellCooldowns()
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Your spells are no longer on cooldown.")
		end,
	},
	[Concoction.Ids.StrikeEnhancement] = {
		cooldownOverride = 10 * 60 * 60, -- 10 hours
		condition = { CONDITION_PARAM_SKILL_CRITICAL_HIT_CHANCE, 500 },
	},
	[Concoction.Ids.CharmUpgrade] = {
		cooldownOverride = 10 * 60 * 60, -- 10 hours
		condition = { CONDITION_PARAM_CHARM_CHANCE_MODIFIER, 5 },
	},
	[Concoction.Ids.WealthDuplex] = {
		cooldownOverride = 10 * 60 * 60, -- 10 hours
		rate = 100,
	},
	[Concoction.Ids.BestiaryBetterment] = {
		cooldownOverride = 10 * 60 * 60, -- 10 hours
		multiplier = 2.0,
	},

	-- Elemental Concoctions from Surprise Cubes (1.5 hours cooldown, 1 hour duration, tick on experience)
	[Concoction.Ids.FireResilience] = {
		cooldownOverride = 90 * 60,
		durationOverride = 60 * 60,
		tickTypeOverride = ConcoctionTickType.Experience,
		condition = { CONDITION_PARAM_ABSORB_FIREPERCENT, 8 },
	},
	[Concoction.Ids.IceResilience] = {
		cooldownOverride = 90 * 60,
		durationOverride = 60 * 60,
		tickTypeOverride = ConcoctionTickType.Experience,
		condition = { CONDITION_PARAM_ABSORB_ICEPERCENT, 8 },
	},
	[Concoction.Ids.EarthResilience] = {
		cooldownOverride = 90 * 60,
		durationOverride = 60 * 60,
		tickTypeOverride = ConcoctionTickType.Experience,
		condition = { CONDITION_PARAM_ABSORB_EARTHPERCENT, 8 },
	},
	[Concoction.Ids.EnergyResilience] = {
		cooldownOverride = 90 * 60,
		durationOverride = 60 * 60,
		tickTypeOverride = ConcoctionTickType.Experience,
		condition = { CONDITION_PARAM_ABSORB_ENERGYPERCENT, 8 },
	},
	[Concoction.Ids.HolyResilience] = {
		cooldownOverride = 90 * 60,
		durationOverride = 60 * 60,
		tickTypeOverride = ConcoctionTickType.Experience,
		condition = { CONDITION_PARAM_ABSORB_HOLYPERCENT, 8 },
	},
	[Concoction.Ids.DeathResilience] = {
		cooldownOverride = 90 * 60,
		durationOverride = 60 * 60,
		tickTypeOverride = ConcoctionTickType.Experience,
		condition = { CONDITION_PARAM_ABSORB_DEATHPERCENT, 8 },
	},
	[Concoction.Ids.PhysicalResilience] = {
		cooldownOverride = 90 * 60,
		durationOverride = 60 * 60,
		tickTypeOverride = ConcoctionTickType.Experience,
		condition = { CONDITION_PARAM_ABSORB_PHYSICALPERCENT, 8 },
	},
	[Concoction.Ids.FireAmplification] = {
		cooldownOverride = 90 * 60,
		durationOverride = 60 * 60,
		tickTypeOverride = ConcoctionTickType.Experience,
		condition = { CONDITION_PARAM_INCREASE_FIREPERCENT, 8 },
	},
	[Concoction.Ids.IceAmplification] = {
		cooldownOverride = 90 * 60,
		durationOverride = 60 * 60,
		tickTypeOverride = ConcoctionTickType.Experience,
		condition = { CONDITION_PARAM_INCREASE_ICEPERCENT, 8 },
	},
	[Concoction.Ids.EarthAmplification] = {
		cooldownOverride = 90 * 60,
		durationOverride = 60 * 60,
		tickTypeOverride = ConcoctionTickType.Experience,
		condition = { CONDITION_PARAM_INCREASE_EARTHPERCENT, 8 },
	},
	[Concoction.Ids.EnergyAmplification] = {
		cooldownOverride = 90 * 60,
		durationOverride = 60 * 60,
		tickTypeOverride = ConcoctionTickType.Experience,
		condition = { CONDITION_PARAM_INCREASE_ENERGYPERCENT, 8 },
	},
	[Concoction.Ids.HolyAmplification] = {
		cooldownOverride = 90 * 60,
		durationOverride = 60 * 60,
		tickTypeOverride = ConcoctionTickType.Experience,
		condition = { CONDITION_PARAM_INCREASE_HOLYPERCENT, 8 },
	},
	[Concoction.Ids.DeathAmplification] = {
		cooldownOverride = 90 * 60,
		durationOverride = 60 * 60,
		tickTypeOverride = ConcoctionTickType.Experience,
		condition = { CONDITION_PARAM_INCREASE_DEATHPERCENT, 8 },
	},
	[Concoction.Ids.PhysicalAmplification] = {
		cooldownOverride = 90 * 60,
		durationOverride = 60 * 60,
		tickTypeOverride = ConcoctionTickType.Experience,
		condition = { CONDITION_PARAM_INCREASE_PHYSICALPERCENT, 8 },
	},
}

for concoctionKey, concoctionId in pairs(Concoction.Ids) do
	Concoction.new({
		id = concoctionId,
		timeLeftStorage = Global.Storage.TibiaDrome[concoctionKey].TimeLeft,
		lastActivatedAtStorage = Global.Storage.TibiaDrome[concoctionKey].LastActivatedAt,
		config = configs[concoctionId] or {},
	}):register()
end

local concoctionsOnLogin = CreatureEvent("ConcoctionsOnLogin")

function concoctionsOnLogin.onLogin(player)
	Concoction.initAll(player, true)
	return true
end

concoctionsOnLogin:register()