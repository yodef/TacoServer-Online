local gloryElixir = Action()

function gloryElixir.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	local difficulty = player:getStorageValue(15054)
	local keyId = nil
	local diffName = ""

	if difficulty == 1 then -- DIFFICULTY MEDIUM
		keyId = 20272
		diffName = "Medium"
	elseif difficulty == 2 then -- DIFFICULTY HARD
		keyId = 20270
		diffName = "Hard"
	elseif difficulty == 3 then -- DIFFICULTY INFERNO
		keyId = 20273
		diffName = "Inferno"
	elseif difficulty == 4 then -- DIFFICULTY NIGHTMARE
		keyId = 20271
		diffName = "Nightmare"
	else
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Select a Boss War difficulty between MEDIUM and NIGHTMARE to get an epic key from this elixir.")
		player:getPosition():sendMagicEffect(CONST_ME_POFF)
		return true
	end

	player:addItem(keyId, 1)
	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, string.format("You used a Glory Elixir and received an epic Boss War key for %s difficulty!", diffName))
	player:say("Glory!", TALKTYPE_MONSTER_SAY)
	player:getPosition():sendMagicEffect(CONST_ME_MAGIC_GREEN)
	item:remove(1)
	return true
end

gloryElixir:id(11588)
gloryElixir:register()
