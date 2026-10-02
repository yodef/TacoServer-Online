if not TaskSystem or not TaskSystem.Config then
	if fileExists and fileExists(CORE_DIRECTORY .. "/scripts/lib/task_lib.lua") then
		dofile(CORE_DIRECTORY .. "/scripts/lib/task_lib.lua")
	elseif fileExists and fileExists("data/scripts/lib/task_lib.lua") then
		dofile("data/scripts/lib/task_lib.lua")
	end
end

local callback = EventCallback("CreatureOnCombatBounty")

function callback.creatureOnCombat(caster, target, damage)
	if not caster or not target then
		return
	end

	-- 1. Attacker is Player and Target is Monster (Bounty Ring bonuses)
	local attackerPlayer = caster:getPlayer()
	if attackerPlayer and target:isMonster() then
		if attackerPlayer.hasBountyRingEquipped and attackerPlayer:hasBountyRingEquipped() then
			local monsterName = target:getName():lower()
			if attackerPlayer.isTaskMonster and attackerPlayer:isTaskMonster(monsterName) then
				-- Task Damage bonus (+5% to +25%)
				local dmgLvl = attackerPlayer:getBountyUpgrade("damage")
				if dmgLvl > 0 then
					local dmgBonusPercent = dmgLvl * 5
					local mult = 1 + (dmgBonusPercent / 100)
					if damage.primary and damage.primary.value and damage.primary.value > 0 then
						damage.primary.value = math.floor(damage.primary.value * mult)
					end
					if damage.secondary and damage.secondary.value and damage.secondary.value > 0 then
						damage.secondary.value = math.floor(damage.secondary.value * mult)
					end
				end

				-- Task Critical Chance bonus (+5% to +15%)
				local critLvl = attackerPlayer:getBountyUpgrade("critical")
				if critLvl > 0 and not damage.critical then
					local critChance = critLvl * 5
					if math.random(100) <= critChance then
						damage.critical = true
						if damage.primary and damage.primary.value and damage.primary.value > 0 then
							damage.primary.value = math.floor(damage.primary.value * 1.5)
						end
						if damage.secondary and damage.secondary.value and damage.secondary.value > 0 then
							damage.secondary.value = math.floor(damage.secondary.value * 1.5)
						end
						target:getPosition():sendMagicEffect(CONST_ME_CRITICAL_DAMAGE)
					end
				end

				-- Task Life Leech bonus (+3% to +20%)
				local leechLvl = attackerPlayer:getBountyUpgrade("leech")
				if leechLvl > 0 then
					local leechPercents = { [1] = 3, [2] = 6, [3] = 10, [4] = 15, [5] = 20 }
					local leechPct = leechPercents[leechLvl] or 0
					local primVal = (damage.primary and damage.primary.value) or 0
					local secVal = (damage.secondary and damage.secondary.value) or 0
					local totalDmg = primVal + secVal
					if totalDmg > 0 and leechPct > 0 then
						local heal = math.floor(totalDmg * (leechPct / 100))
						if heal > 0 then
							attackerPlayer:addHealth(heal)
							attackerPlayer:getPosition():sendMagicEffect(CONST_ME_MAGIC_RED)
						end
					end
				end
			end
		end
	end

	-- 2. Attacker is Monster and Target is Player (Bounty Amulet defensive wards)
	local targetPlayer = target:getPlayer()
	if targetPlayer and caster:isMonster() then
		if targetPlayer.hasBountyAmuletEquipped and targetPlayer:hasBountyAmuletEquipped() then
			local monsterName = caster:getName():lower()
			if targetPlayer.isTaskMonster and targetPlayer:isTaskMonster(monsterName) then
				-- Task Physical Ward (reduces physical damage by 4% to 20%)
				local defLvl = targetPlayer:getAmuletUpgrade("defense")
				if defLvl > 0 then
					local redPct = defLvl * 4
					local mult = 1 - (redPct / 100)
					if damage.primary and damage.primary.type == COMBAT_PHYSICALDAMAGE and damage.primary.value and damage.primary.value > 0 then
						damage.primary.value = math.floor(damage.primary.value * mult)
					end
					if damage.secondary and damage.secondary.type == COMBAT_PHYSICALDAMAGE and damage.secondary.value and damage.secondary.value > 0 then
						damage.secondary.value = math.floor(damage.secondary.value * mult)
					end
				end

				-- Task Elemental Ward (reduces elemental/magical damage by 3% to 18%)
				local elemLvl = targetPlayer:getAmuletUpgrade("elemental")
				if elemLvl > 0 then
					local elemPercents = { [1] = 3, [2] = 6, [3] = 10, [4] = 14, [5] = 18 }
					local redPct = elemPercents[elemLvl] or 0
					local mult = 1 - (redPct / 100)
					if damage.primary and damage.primary.type ~= COMBAT_PHYSICALDAMAGE and damage.primary.value and damage.primary.value > 0 then
						damage.primary.value = math.floor(damage.primary.value * mult)
					end
					if damage.secondary and damage.secondary.type ~= COMBAT_PHYSICALDAMAGE and damage.secondary.value and damage.secondary.value > 0 then
						damage.secondary.value = math.floor(damage.secondary.value * mult)
					end
				end

				-- Paralysis immunity check
				local paraLvl = targetPlayer:getAmuletUpgrade("paralysis")
				if paraLvl > 0 and targetPlayer:hasCondition(CONDITION_PARALYZE) then
					targetPlayer:removeCondition(CONDITION_PARALYZE)
				end
			end
		end
	end
end

callback:register()
