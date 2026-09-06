local shared = TalkAction("!shared")

function shared.onSay(player, words, param)

local min = math.ceil(player:getLevel() * 0.6666666666)
local max = math.floor(player:getLevel() / 0.6666666666)

	player:sendTextMessage(MESSAGE_LOOK, "You are level " .. player:getLevel() .. ".\n You share experience with players level " .. min .. " to " .. max .. ".")
	return true
end

shared:groupType("normal")
shared:register()
