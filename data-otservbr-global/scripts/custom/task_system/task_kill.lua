-- TacoServer Custom Task Kill Tracking Event
if not TaskSystem or not TaskSystem.MonsterToTasks then
	if fileExists and fileExists(CORE_DIRECTORY .. "/scripts/lib/task_lib.lua") then
		dofile(CORE_DIRECTORY .. "/scripts/lib/task_lib.lua")
	elseif fileExists and fileExists("data/scripts/lib/task_lib.lua") then
		dofile("data/scripts/lib/task_lib.lua")
	else
		dofile("data-otservbr-global/scripts/custom/task_system/task_lib.lua")
	end
end

-- Fallback index builder if not present
if not TaskSystem.MonsterToTasks then
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
end

local taskKill = CreatureEvent("CustomTaskKill")

function taskKill.onKill(player, target, lastHit)
	if not player or not target or not target:isMonster() then
		return true
	end

	-- Ignore summons / familiars
	if target:getMaster() ~= nil then
		return true
	end

	local monsterName = target:getName():lower()
	local matchingTaskIds = TaskSystem.MonsterToTasks[monsterName]
	if not matchingTaskIds or #matchingTaskIds == 0 then
		return true
	end

	local killers = {}
	local targetPos = target:getPosition()

	if TaskSystem.Config.partySharedExpRequired then
		local party = player:getParty()
		if party and party:isSharedExperienceActive() then
			local leader = party:getLeader()
			if leader then
				local lpos = leader:getPosition()
				if lpos.z == targetPos.z and lpos:getDistance(targetPos) <= TaskSystem.Config.partySharedDistance then
					table.insert(killers, leader)
				end
			end
			local members = party:getMembers()
			if members then
				for _, member in pairs(members) do
					local mpos = member:getPosition()
					if mpos.z == targetPos.z and mpos:getDistance(targetPos) <= TaskSystem.Config.partySharedDistance then
						table.insert(killers, member)
					end
				end
			end
		else
			table.insert(killers, player)
		end
	else
		table.insert(killers, player)
	end

	for _, p in ipairs(killers) do
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
	end

	return true
end

taskKill:register()

local taskLogin = CreatureEvent("CustomTaskLogin")
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
