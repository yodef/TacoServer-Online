if not TaskSystem or not TaskSystem.Config then
	if fileExists and fileExists(CORE_DIRECTORY .. "/scripts/lib/task_lib.lua") then
		dofile(CORE_DIRECTORY .. "/scripts/lib/task_lib.lua")
	elseif fileExists and fileExists("data/scripts/lib/task_lib.lua") then
		dofile("data/scripts/lib/task_lib.lua")
	end
end

function Creature:onTargetCombat(target)
	if not self then
		return true
	end

	if (target:isMonster() and self:isPlayer() and target:getMaster() == self) or (self:isMonster() and target:isPlayer() and self:getMaster() == target) then
		return RETURNVALUE_YOUMAYNOTATTACKTHISCREATURE
	end

	if not IsRetroPVP() or PARTY_PROTECTION ~= 0 then
		if self:isPlayer() and target:isPlayer() then
			local party = self:getParty()
			if party then
				local targetParty = target:getParty()
				if targetParty and targetParty == party then
					return RETURNVALUE_YOUMAYNOTATTACKTHISPLAYER
				end
			end
		end
	end

	if not IsRetroPVP() or ADVANCED_SECURE_MODE ~= 0 then
		if self:isPlayer() and target:isPlayer() then
			if self:hasSecureMode() then
				return RETURNVALUE_YOUMAYNOTATTACKTHISPLAYER
			end
		end
	end

	-- Bounty Amulet paralysis immunity check
	if target and target:isPlayer() and target.hasBountyAmuletEquipped and target:hasBountyAmuletEquipped() then
		if target:getAmuletUpgrade("paralysis") > 0 and target:hasCondition(CONDITION_PARALYZE) then
			target:removeCondition(CONDITION_PARALYZE)
			target:getPosition():sendMagicEffect(CONST_ME_MAGIC_BLUE)
		end
	end

	self:addEventStamina(target)
	return true
end

function Creature:onChangeOutfit(outfit)
	if self:isPlayer() then
		local familiarLookType = self:getFamiliarLooktype()
		if familiarLookType ~= 0 then
			for _, summon in pairs(self:getSummons()) do
				if summon:getType():familiar() then
					if summon:getOutfit().lookType ~= familiarLookType then
						summon:setOutfit({ lookType = familiarLookType })
					end
					break
				end
			end
		end
	end
	return true
end

function Creature:onDrainHealth(attacker, typePrimary, damagePrimary, typeSecondary, damageSecondary, colorPrimary, colorSecondary)
	if not self or not attacker then
		return typePrimary, damagePrimary, typeSecondary, damageSecondary, colorPrimary, colorSecondary
	end

	-- Bounty Ring logic: boosts damage, critical damage, and life leech when attacking active task monsters
	if self:isMonster() then
		local player = attacker:getPlayer()
		if not player and attacker:getMaster() then
			player = attacker:getMaster():getPlayer()
		end

		if player and player.hasBountyRingEquipped and player:hasBountyRingEquipped() then
			local monsterName = self:getName()
			if player.isTaskMonster and player:isTaskMonster(monsterName) then
				-- 1. Damage Boost (+2% per level up to +10%)
				local dmgLevel = player:getBountyUpgrade("damage")
				if dmgLevel > 0 then
					local boost = 1 + (dmgLevel * 0.02)
					if damagePrimary and damagePrimary > 0 then
						damagePrimary = math.floor(damagePrimary * boost)
					end
					if damageSecondary and damageSecondary > 0 then
						damageSecondary = math.floor(damageSecondary * boost)
					end
				end

				-- 2. Critical Damage Boost (+3% per level up to +15%)
				local critLevel = player:getBountyUpgrade("critical")
				if critLevel > 0 then
					if math.random(100) <= 12 then
						local critBoost = 1 + (critLevel * 0.03)
						if damagePrimary and damagePrimary > 0 then
							damagePrimary = math.floor(damagePrimary * critBoost)
						end
						if damageSecondary and damageSecondary > 0 then
							damageSecondary = math.floor(damageSecondary * critBoost)
						end
						self:getPosition():sendMagicEffect(CONST_ME_CRITICAL_DAMAGE)
					end
				end

				-- 3. Life Leech (+1.5% per level up to +7.5%)
				local leechLevel = player:getBountyUpgrade("leech")
				if leechLevel > 0 then
					local totalDmg = (damagePrimary or 0) + (damageSecondary or 0)
					if totalDmg > 0 then
						local heal = math.floor(totalDmg * (leechLevel * 0.015))
						if heal > 0 then
							player:addHealth(heal)
							if math.random(100) <= 20 then
								player:getPosition():sendMagicEffect(CONST_ME_MAGIC_RED)
							end
						end
					end
				end
			end
		end
	end

	-- Bounty Amulet logic: defense, elemental protection, and paralysis immunity against active task monsters
	if self:isPlayer() and self.hasBountyAmuletEquipped and self:hasBountyAmuletEquipped() then
		local monster = attacker:isMonster() and attacker or (attacker:getMaster() and attacker:getMaster():isMonster() and attacker:getMaster())
		if monster then
			local monsterName = monster:getName()
			if self.isTaskMonster and self:isTaskMonster(monsterName) then
				-- 1. Physical Protection (-2% per level up to -10%)
				local defLevel = self:getAmuletUpgrade("defense")
				if defLevel > 0 then
					local reduction = 1 - (defLevel * 0.02)
					if typePrimary == COMBAT_PHYSICALDAMAGE and damagePrimary and damagePrimary > 0 then
						damagePrimary = math.max(0, math.floor(damagePrimary * reduction))
					end
					if typeSecondary == COMBAT_PHYSICALDAMAGE and damageSecondary and damageSecondary > 0 then
						damageSecondary = math.max(0, math.floor(damageSecondary * reduction))
					end
				end

				-- 2. Elemental Protection (-2% per level up to -10%)
				local elemLevel = self:getAmuletUpgrade("elemental")
				if elemLevel > 0 then
					local reduction = 1 - (elemLevel * 0.02)
					if typePrimary ~= COMBAT_PHYSICALDAMAGE and typePrimary ~= COMBAT_HEALING and damagePrimary and damagePrimary > 0 then
						damagePrimary = math.max(0, math.floor(damagePrimary * reduction))
					end
					if typeSecondary ~= COMBAT_PHYSICALDAMAGE and typeSecondary ~= COMBAT_HEALING and damageSecondary and damageSecondary > 0 then
						damageSecondary = math.max(0, math.floor(damageSecondary * reduction))
					end
				end
			end
		end

		-- 3. Paralysis Immunity (dispel paralysis if upgraded)
		if self:getAmuletUpgrade("paralysis") > 0 then
			if self:hasCondition(CONDITION_PARALYZE) then
				self:removeCondition(CONDITION_PARALYZE)
				self:getPosition():sendMagicEffect(CONST_ME_MAGIC_BLUE)
			end
			addEvent(function(pid)
				local p = Player(pid)
				if p and p:hasCondition(CONDITION_PARALYZE) and p:hasBountyAmuletEquipped() and p:getAmuletUpgrade("paralysis") > 0 then
					p:removeCondition(CONDITION_PARALYZE)
					p:getPosition():sendMagicEffect(CONST_ME_MAGIC_BLUE)
				end
			end, 50, self:getId())
		end
	end

	return typePrimary, damagePrimary, typeSecondary, damageSecondary, colorPrimary, colorSecondary
end
