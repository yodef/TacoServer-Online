local gloryElixir = Action()
function gloryElixir.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	local randomChoice = math.random(1,3)	

if player:getStorageValue(15054) == 1 then --DIFFICULTY MEDIUM
	player:addItem(20272, 1)
elseif player:getStorageValue(15054) == 2 then --DIFFICULTY HARD
	player:addItem(20270, 1)
elseif player:getStorageValue(15054) == 3 then --DIFFICULTY INFERNO
	player:addItem(20273, 1)
elseif player:getStorageValue(15054) == 4 then --DIFFICULTY NIGHTMARE
	player:addItem(20271, 1)
else
	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Select a bosswar difficulty between MEDIUM to NIGHTMARE to get an epic key from this elixir.")
	return true
end
	item:remove(1)
end

gloryElixir:id(11588)
gloryElixir:register()
