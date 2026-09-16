-- TacoServer Task System - Talkaction (!task / /task in PZ) & Modal Window Interface
if not TaskSystem or not TaskSystem.Config then
	dofile(CORE_DIRECTORY .. "/scripts/lib/task_lib.lua")
end

-- =============================================================================
-- MODAL WINDOW MENUS
-- =============================================================================

local function openMainWindow(player)
	local tile = player:getTile()
	if not tile or not tile:hasFlag(TILESTATE_PROTECTIONZONE) then
		player:sendTextMessage(MESSAGE_STATUS, "You can only open the Task Board inside a protection zone.")
		player:getPosition():sendMagicEffect(CONST_ME_POFF)
		return true
	end

	local activeTasks = player:getActiveTasks()
	local activeCount = #activeTasks
	local htp = player:getTaskHuntingPoints()
	local completedTotal = math.max(0, player:getStorageValue(TaskSystem.Storages.ranking))

	local msg = string.format(
		"Welcome to TacoServer Task System!\n\n" ..
		"- Active Tasks: %d / %d\n" ..
		"- Total Completed: %d\n" ..
		"- Hunting Task Points (HTP): %d\n\n" ..
		"Hunting Task Points can be exchanged with NPC Walter Jaeger for custom rewards!\n\n" ..
		"Choose an action below:",
		activeCount, TaskSystem.Config.maxActiveTasks, completedTotal, htp
	)

	local window = ModalWindow({
		title = "Task System - Main Menu",
		message = msg,
	})

	-- Option 1: Start a New Task
	window:addChoice("Start a New Task", function(p, btn, c)
		if btn.name == "Select" then
			if #p:getActiveTasks() >= TaskSystem.Config.maxActiveTasks then
				p:sendTextMessage(MESSAGE_STATUS, string.format("You already have %d/%d active tasks! Complete or cancel one first.", #p:getActiveTasks(), TaskSystem.Config.maxActiveTasks))
				return true
			end
			TaskSystem.openCategoriesWindow(p)
		end
		return true
	end)

	-- Option 2: View Active Tasks
	window:addChoice("View My Active Tasks", function(p, btn, c)
		if btn.name == "Select" then
			TaskSystem.openActiveTasksWindow(p)
		end
		return true
	end)

	-- Option 3: Complete Tasks (as requested)
	window:addChoice("Complete Tasks", function(p, btn, c)
		if btn.name == "Select" then
			TaskSystem.openClaimWindow(p)
		end
		return true
	end)

	-- Option 4: Cancel a Task
	window:addChoice("Cancel an Active Task", function(p, btn, c)
		if btn.name == "Select" then
			TaskSystem.openCancelWindow(p)
		end
		return true
	end)

	window:addButton("Select")
	window:addButton("Close")
	window:setDefaultEnterButton(0)
	window:setDefaultEscapeButton(1)
	window:sendToPlayer(player)
	return true
end

function TaskSystem.openCategoriesWindow(player)
	local window = ModalWindow({
		title = "Task System - Categories",
		message = "Select a task category based on your level:",
	})

	for catId, cat in ipairs(TaskSystem.Categories) do
		local status = (player:getLevel() >= cat.minLevel) and "" or " [Locked]"
		window:addChoice(string.format("%s%s", cat.name, status), function(p, btn, c)
			if btn.name == "Select" then
				if p:getLevel() < cat.minLevel then
					p:sendTextMessage(MESSAGE_STATUS, string.format("You need at least level %d to access %s.", cat.minLevel, cat.name))
					TaskSystem.openCategoriesWindow(p)
					return true
				end
				TaskSystem.openTasksWindow(p, catId)
			elseif btn.name == "Back" then
				TaskSystem.openMainWindow(p)
			end
			return true
		end)
	end

	window:addButton("Select")
	window:addButton("Back", function(p) TaskSystem.openMainWindow(p) end)
	window:addButton("Close")
	window:setDefaultEnterButton(0)
	window:setDefaultEscapeButton(2)
	window:sendToPlayer(player)
	return true
end

function TaskSystem.openTasksWindow(player, categoryId)
	local cat = TaskSystem.Categories[categoryId]
	local window = ModalWindow({
		title = "Tasks - " .. cat.name,
		message = "Choose a task to accept:\n(HTP = Hunting Task Points for Walter Jaeger)",
	})

	local taskList = {}
	for taskId, task in pairs(TaskSystem.Tasks) do
		if task.categoryId == categoryId then
			table.insert(taskList, { id = taskId, task = task })
		end
	end

	table.sort(taskList, function(a, b)
		if a.task.level == b.task.level then
			return a.task.name < b.task.name
		end
		return a.task.level < b.task.level
	end)

	for _, entry in ipairs(taskList) do
		local t = entry.task
		local tid = entry.id
		local status = ""
		if player:isTaskActive(tid) then
			status = " [ACTIVE]"
		elseif player:getLevel() < t.level then
			status = string.format(" [Lvl %d]", t.level)
		end

		local label = string.format("%s (%d kills | +%d HTP)%s", t.name, t.count, t.rewards.points or 0, status)
		window:addChoice(label, function(p, btn, c)
			if btn.name == "Accept" then
				local success, freeSlotOrReason, taskObj = p:startTask(tid)
				if success then
					p:sendTextMessage(MESSAGE_LOOK, string.format("[Tasks] Accepted task: %s! Kill %d %s to claim %d HTP.", taskObj.name, taskObj.count, taskObj.name, taskObj.rewards.points or 0))
					p:getPosition():sendMagicEffect(CONST_ME_MAGIC_BLUE)
					TaskSystem.openActiveTasksWindow(p)
				else
					p:sendTextMessage(MESSAGE_STATUS, freeSlotOrReason)
					TaskSystem.openTasksWindow(p, categoryId)
				end
			elseif btn.name == "Back" then
				TaskSystem.openCategoriesWindow(p)
			end
			return true
		end)
	end

	window:addButton("Accept")
	window:addButton("Back", function(p) TaskSystem.openCategoriesWindow(p) end)
	window:addButton("Close")
	window:setDefaultEnterButton(0)
	window:setDefaultEscapeButton(2)
	window:sendToPlayer(player)
	return true
end

function TaskSystem.openActiveTasksWindow(player)
	local active = player:getActiveTasks()
	local msg = ""
	if #active == 0 then
		msg = "You do not have any active tasks right now.\n\nUse 'Start a New Task' to begin hunting!"
	else
		msg = string.format("You have %d/%d tasks in progress:\n\n", #active, TaskSystem.Config.maxActiveTasks)
		for _, a in ipairs(active) do
			local current = a.count or a.current or 0
			local isComp = a.completed or a.isCompleted
			local status = isComp and "[READY TO COMPLETE!]" or string.format("%d / %d kills", current, a.task.count)
			msg = msg .. string.format("- [Slot %d] %s: %s\n  Reward: %d HTP\n\n",
				a.slotId, a.task.name, status, a.task.rewards.points or 0)
		end
	end

	local window = ModalWindow({
		title = "Task System - Active Tasks",
		message = msg,
	})

	if #active > 0 then
		for _, a in ipairs(active) do
			local current = a.count or a.current or 0
			local isComp = a.completed or a.isCompleted
			local tag = isComp and " [COMPLETED]" or ""
			window:addChoice(string.format("Slot %d: %s [%d/%d]%s", a.slotId, a.task.name, current, a.task.count, tag))
		end
	else
		window:addChoice("No active tasks.")
	end

	window:addButton("Back", function(p) TaskSystem.openMainWindow(p) end)
	window:addButton("Close")
	window:setDefaultEnterButton(0)
	window:setDefaultEscapeButton(1)
	window:sendToPlayer(player)
	return true
end

function TaskSystem.openClaimWindow(player)
	local active = player:getActiveTasks()
	local completed = {}
	for _, a in ipairs(active) do
		if a.completed or a.isCompleted then
			table.insert(completed, a)
		end
	end

	if #completed == 0 then
		local window = ModalWindow({
			title = "Task System - Claim Rewards",
			message = "You don't have any completed tasks ready to claim yet!\n\nKeep hunting and check back once you reach the required kill count.",
		})
		window:addButton("Back", function(p) TaskSystem.openMainWindow(p) end)
		window:addButton("Close")
		window:setDefaultEnterButton(0)
		window:setDefaultEscapeButton(1)
		window:sendToPlayer(player)
		return true
	end

	local window = ModalWindow({
		title = "Task System - Claim Rewards",
		message = "Select a completed task to claim your rewards:",
	})

	for _, c in ipairs(completed) do
		local label = string.format("%s (+%d HTP)", c.task.name, c.task.rewards.points or 0)
		window:addChoice(label, function(p, btn, choice)
			if btn.name == "Claim" then
				local success, taskOrErr = p:claimTask(c.slotId)
				if success then
					p:sendTextMessage(MESSAGE_LOOK, string.format("[Tasks] Completed %s! You received %d Hunting Task Points.", taskOrErr.name, taskOrErr.rewards.points or 0))
					p:getPosition():sendMagicEffect(CONST_ME_FIREWORK_YELLOW)
					TaskSystem.openClaimWindow(p)
				else
					p:sendTextMessage(MESSAGE_STATUS, taskOrErr)
					TaskSystem.openMainWindow(p)
				end
			elseif btn.name == "Back" then
				TaskSystem.openMainWindow(p)
			end
			return true
		end)
	end

	window:addButton("Claim")
	window:addButton("Back", function(p) TaskSystem.openMainWindow(p) end)
	window:addButton("Close")
	window:setDefaultEnterButton(0)
	window:setDefaultEscapeButton(2)
	window:sendToPlayer(player)
	return true
end

function TaskSystem.openCancelWindow(player)
	local active = player:getActiveTasks()
	if #active == 0 then
		player:sendTextMessage(MESSAGE_STATUS, "You don't have any active tasks to cancel.")
		TaskSystem.openMainWindow(player)
		return true
	end

	local window = ModalWindow({
		title = "Task System - Cancel Task",
		message = "Select a task you wish to abandon (this will free up the slot for a new task):",
	})

	for _, a in ipairs(active) do
		local current = a.count or a.current or 0
		local label = string.format("Slot %d: %s [%d/%d kills]", a.slotId, a.task.name, current, a.task.count)
		window:addChoice(label, function(p, btn, choice)
			if btn.name == "Abandon" then
				local success, taskOrErr = p:cancelTask(a.slotId)
				if success then
					p:sendTextMessage(MESSAGE_LOOK, string.format("[Tasks] You canceled the %s task. The slot is now free.", taskOrErr.name))
					p:getPosition():sendMagicEffect(CONST_ME_POFF)
					TaskSystem.openActiveTasksWindow(p)
				else
					p:sendTextMessage(MESSAGE_STATUS, taskOrErr)
					TaskSystem.openMainWindow(p)
				end
			elseif btn.name == "Back" then
				TaskSystem.openMainWindow(p)
			end
			return true
		end)
	end

	window:addButton("Abandon")
	window:addButton("Back", function(p) TaskSystem.openMainWindow(p) end)
	window:addButton("Close")
	window:setDefaultEnterButton(0)
	window:setDefaultEscapeButton(2)
	window:sendToPlayer(player)
	return true
end

-- Export to TaskSystem table for external access if needed
TaskSystem.openMainWindow = openMainWindow

-- =============================================================================
-- TALKACTION (!task and /task) - ONLY IN PROTECTION ZONE
-- =============================================================================

local taskTalk = TalkAction("!task", "/task")

function taskTalk.onSay(player, words, param)
	local tile = player:getTile()
	if not tile or not tile:hasFlag(TILESTATE_PROTECTIONZONE) then
		player:sendTextMessage(MESSAGE_STATUS, "You can only open the Task Board inside a protection zone.")
		player:getPosition():sendMagicEffect(CONST_ME_POFF)
		return true
	end

	openMainWindow(player)
	return true
end

taskTalk:separator(" ")
taskTalk:groupType("normal")
taskTalk:register()

