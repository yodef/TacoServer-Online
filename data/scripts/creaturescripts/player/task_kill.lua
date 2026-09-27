-- TacoServer Custom Task Kill Tracking Event
if not TaskSystem or not TaskSystem.Config then
	if fileExists and fileExists(CORE_DIRECTORY .. "/scripts/lib/task_lib.lua") then
		dofile(CORE_DIRECTORY .. "/scripts/lib/task_lib.lua")
	elseif fileExists and fileExists("data/scripts/lib/task_lib.lua") then
		dofile("data/scripts/lib/task_lib.lua")
	end
end

-- Fallback index builder if not present
if TaskSystem and (not TaskSystem.MonsterToTasks or not next(TaskSystem.MonsterToTasks)) then
	TaskSystem.MonsterToTasks = {}
	if TaskSystem.Tasks then
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
	end
end

local taskKill = CreatureEvent("CustomTaskKill")
taskKill:type("kill")

function taskKill.onKill(player, target, lastHit)
	if not player or not target or not target:isMonster() then
		return true
	end

	-- Ignore summons / familiars
	if target:getMaster() ~= nil then
		return true
	end

	local monsterName = target:getName():lower()
	local matchingTaskIds = TaskSystem.MonsterToTasks and TaskSystem.MonsterToTasks[monsterName]
	if not matchingTaskIds or #matchingTaskIds == 0 then
		return true
	end

	local killers = {}
	local addedGuids = {}
	local targetPos = target:getPosition()

	if TaskSystem.Config and TaskSystem.Config.partySharedExpRequired then
		local party = player:getParty()
		if party and party:isSharedExperienceActive() then
			local leader = party:getLeader()
			if leader then
				local lpos = leader:getPosition()
				if lpos.z == targetPos.z and lpos:getDistance(targetPos) <= TaskSystem.Config.partySharedDistance then
					table.insert(killers, leader)
					addedGuids[leader:getGuid()] = true
				end
			end
			local members = party:getMembers()
			if members then
				for _, member in pairs(members) do
					if not addedGuids[member:getGuid()] then
						local mpos = member:getPosition()
						if mpos.z == targetPos.z and mpos:getDistance(targetPos) <= TaskSystem.Config.partySharedDistance then
							table.insert(killers, member)
							addedGuids[member:getGuid()] = true
						end
					end
				end
			end
		end
	end

	if not addedGuids[player:getGuid()] then
		table.insert(killers, player)
		addedGuids[player:getGuid()] = true
	end

	for _, p in ipairs(killers) do
		local matchedAnyTask = false
		for slotId, slot in ipairs(TaskSystem.Storages.slots) do
			local taskId = p:getStorageValue(slot.task)
			if taskId and taskId > 0 and TaskSystem.Tasks[taskId] then
				local task = TaskSystem.Tasks[taskId]
				local isMatch = false
				for _, mid in ipairs(matchingTaskIds) do
					if mid == taskId then
						isMatch = true
						break
					end
				end

				if isMatch then
					matchedAnyTask = true
					local current = math.max(0, p:getStorageValue(slot.count))
					if current < task.count then
						current = current + 1
						p:setStorageValue(slot.count, current)
						if current == task.count then
							p:sendTextMessage(MESSAGE_LOOK, string.format("[Tasks] You have completed your task of %s [%d/%d]! Use !task in a protection zone to claim your reward.", task.name, current, task.count))
							p:getPosition():sendMagicEffect(CONST_ME_FIREWORK_YELLOW)
						else
							p:sendTextMessage(MESSAGE_STATUS, string.format("[Tasks] %s: [%d/%d kills]", task.name, current, task.count))
						end
					end
				end
			end
		end

		-- Bounty Ring Bestiary boost (double kill credit x2)
		if matchedAnyTask and p.hasBountyRingEquipped and p:hasBountyRingEquipped() then
			local bestiaryLevel = p:getBountyUpgrade("bestiary")
			if bestiaryLevel > 0 then
				local chances = { [1] = 30, [2] = 60, [3] = 100 }
				local chance = chances[bestiaryLevel] or 0
				if math.random(100) <= chance then
					p:addBestiaryKill(target:getName(), 1)
					p:sendTextMessage(MESSAGE_STATUS_SMALL, "[Bounty Ring] Bestiary double kill credit (+1)!")
					p:getPosition():sendMagicEffect(CONST_ME_MAGIC_BLUE)
				end
			end
		end
	end

	return true
end

taskKill:register()

local taskLogin = CreatureEvent("CustomTaskLogin")
taskLogin:type("login")

function taskLogin.onLogin(player)
	player:registerEvent("CustomTaskKill")
	return true
end

taskLogin:register()

-- Immediately register event for any players already online
if Game and Game.getPlayers then
	for _, onlinePlayer in ipairs(Game.getPlayers()) do
		onlinePlayer:registerEvent("CustomTaskKill")
	end
end
