dofile(CORE_DIRECTORY .. "/scripts/spells/support/stances_lib.lua")

local stanceInfo = TalkAction("!stance", "/stance")

function stanceInfo.onSay(player, words, param)
	local current = player:kv():get("active-stance")
	if not current then
		player:sendTextMessage(MESSAGE_LOOK, "You currently have NO active stance (Neutral).")
		return false
	end

	local def = StanceSystem.Definitions[current]
	if def then
		player:sendTextMessage(MESSAGE_LOOK, string.format("Active Stance: %s (%s).", def.name, def.desc))
	else
		player:sendTextMessage(MESSAGE_LOOK, "You currently have NO active stance (Neutral).")
	end
	return false
end

stanceInfo:separator(" ")
stanceInfo:groupType("normal")
stanceInfo:register()
