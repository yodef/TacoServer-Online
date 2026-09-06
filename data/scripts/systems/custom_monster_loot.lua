-- CONFIGURACIÓN POR UMBRALES OPTIMIZADA PARA TIBIA / CANARY

-- 1. LOOT GLOBAL: Protege cadáveres pequeños. 40 EXP evita trolls/bugs, pero incluye Rotworms.
local globalLootMinExp = 40 
local allLootConfig = {
	--{ id = 22722, chance = 20000, maxCount = 3 }, -- Iron Token (20% de probabilidad real según tu config)
}

-- 2. LOOT POR CATEGORÍAS DE FUERZA (Ajustado a la EXP real de Tibia)
local TierLootConfig = {
	{
		-- Criaturas Medianas (Ej: Rotworms, Orc Warriors, Cyclops, Tarantulas, Bonebeast)
		minExp = 40,
		maxExp = 899,
		items = {
			{ id = 22720, chance = 9000, maxCount = 10 }, -- Iron Token
			{ id = 22722, chance = 3000, maxCount = 5 }, -- Copper token
		}
	},
	{
		-- Criaturas Fuertes (Ej: Dragones, Giant Spiders, Hero, Hydra, Dragon Lord)
		minExp = 900,
		maxExp = 2500,
		items = {
			{ id = 22722, chance = 10000, maxCount = 7 }, -- Copper token
			{ id = 22516, chance = 3500, maxCount = 2 },   -- Silver Token
			{ id = 44605, chance = 1000, maxCount = 1 },   -- lesser gems
			{ id = 44611, chance = 1000, maxCount = 1 },
			{ id = 44608, chance = 1000, maxCount = 1 },
			{ id = 44602, chance = 1000, maxCount = 1 },
			{ id = 49371, chance = 1000, maxCount = 1 },
		}
	},
	{
		-- Jefes menores o Criaturas End-Game (Ej: Demons, Behemoths, Grim Reapers, Juggernaut)
		minExp = 2501,
		maxExp = 14999,
		items = {
			{ id = 22516, chance = 11000, maxCount = 5 }, -- Silver Token
			{ id = 22721, chance = 4000, maxCount = 2 },  -- Gold Token
			{ id = 44609, chance = 1000, maxCount = 1 },  -- gems
			{ id = 49372, chance = 1000, maxCount = 1 },
			{ id = 44603, chance = 1000, maxCount = 1 },
			{ id = 44612, chance = 1000, maxCount = 1 },
			{ id = 44606, chance = 1000, maxCount = 1 },
		}
	},
	{
		-- Jefes mayores (Ej: Ferumbras, Ghazbaran, Morgaroth, Orshabaal y Bosses de Quests)
		minExp = 15000,
		maxExp = 9999999,
		items = {
			{ id = 22721, chance = 12000, maxCount = 5 },   -- Gold Token
			{ id = 22723, chance = 5000, maxCount = 1 },   -- Platinum Token
			{ id = 49373, chance = 1000, maxCount = 1 },  -- greater gems
			{ id = 44604, chance = 1000, maxCount = 1 },
			{ id = 44613, chance = 1000, maxCount = 1 },
			{ id = 44610, chance = 1000, maxCount = 1 },
			{ id = 44607, chance = 1000, maxCount = 1 },
		}
	}
}

local customMonsterLoot = GlobalEvent("CreateCustomMonsterLoot")

function customMonsterLoot.onStartup()
	local totalCustom = 0
	local totalGlobal = 0

	for _, mtype in pairs(Game.getMonsterTypes()) do
		if mtype:raceId() > 0 then
			
			local exp = 0
			if type(mtype.getExperience) == "function" then exp = mtype:getExperience()
			elseif type(mtype.experience) == "function" then exp = mtype:experience()
			elseif type(mtype.getExperienceReward) == "function" then exp = mtype:getExperienceReward() end

			-- REGLA 1: Aplicar Loot Global seguro
			if #allLootConfig > 0 and exp >= globalLootMinExp then
				mtype:createLoot(allLootConfig)
				totalGlobal = totalGlobal + 1
			end

			-- REGLA 2: Aplicar Loot por Tiers sin dejar huecos
			for _, tier in ipairs(TierLootConfig) do
				if exp >= tier.minExp and exp <= tier.maxExp then
					if tier.items and #tier.items > 0 then
						mtype:createLoot(tier.items)
						totalCustom = totalCustom + 1
					end
					break
				end
			end

		end
	end

	-- Corregidas las variables del log para evitar caídas en la consola
	logger.info("[customMonsterLoot.onStartup] - Global loot added to {} mid/high tier monsters.", totalGlobal)
	logger.info("[customMonsterLoot.onStartup] - Tier loot distributed among {} strong monsters.", totalCustom)
	return true
end

customMonsterLoot:register()