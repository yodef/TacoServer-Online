local bossWarChest = Action()
function bossWarChest.onUse(player, item, fromPosition, target, toPosition, isHotkey)

local bossWarPoints = player:getStorageValue(15052)
	if player:getStorageValue(15052) >= 1 then --Check if boss points				
		
		if bossWarPoints >= 3000 then--SURPRISE CUBES	
			player:addItem(23488, 15) --+5 CUBES
		elseif bossWarPoints >= 2700 then
			player:addItem(23488, 12) 
		elseif bossWarPoints >= 2400 then
			player:addItem(23488, 11) --+3 CUBES
		elseif bossWarPoints >= 2100 then
			player:addItem(23488, 9) 
		elseif bossWarPoints >= 1800 then
			player:addItem(23488, 8) 
		elseif bossWarPoints >= 1500 then
			player:addItem(23488, 7)--+2 CUBES
		elseif bossWarPoints >= 1200 then
			player:addItem(23488, 5) 
		elseif bossWarPoints >= 900 then
			player:addItem(23488, 4) --+1 CUBE 
		elseif bossWarPoints >= 600 then
			player:addItem(23488, 2) 		
		elseif bossWarPoints >= 300 then
			player:addItem(23488, 1) 
		end				
		
		local boxes = math.ceil(bossWarPoints / 150)
		player:addItem(12045, boxes) --SURPRISE BOXES
		
		local expReward = bossWarPoints * (80 * player:getLevel())
		player:addExperience(expReward) --GIVE EXP
		
		if bossWarPoints >= 3000 then			
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You have spent 3000 Boss War points and received: ".. boxes .." surprise box, ".. expReward / 1000 .."k Experience points and surprise cubes. This is the maximum reward!")
			local maxReward = bossWarPoints - 3000
			player:setStorageValue(15052, maxReward) --MAX REWARD
			db.query("UPDATE `players` SET `bossWarPoints` = `bossWarPoints` + " .. 3000 .. " WHERE `id` = '" .. player:getGuid() .. "';")
		elseif bossWarPoints < 3000 then			
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You have spent ".. bossWarPoints .." Boss War points and received: ".. boxes .." surprise box, ".. expReward / 1000 .."k Experience points and surprise cubes.")
			player:setStorageValue(15052, 0) --RESET POINTS
			db.query("UPDATE `players` SET `bossWarPoints` = `bossWarPoints` + " .. bossWarPoints .. " WHERE `id` = '" .. player:getGuid() .. "';")
		elseif bossWarPoints < 300 then
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You have spent ".. bossWarPoints .." Boss War points and received: ".. boxes .." surprise box and ".. expReward / 1000 .."k Experience points.")
			player:setStorageValue(15052, 0) --RESET POINTS
			db.query("UPDATE `players` SET `bossWarPoints` = `bossWarPoints` + " .. bossWarPoints .. " WHERE `id` = '" .. player:getGuid() .. "';")
		end

	else
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You need to defeat bosses inside Boss War arena to earn points. Use command !bosswar for more details.")
		--player:setStorageValue(15052, 4000) --CHEAT BUG FOR TEST
	end
	return true
end

bossWarChest:uid(50200)
bossWarChest:register()
