local templeScroll = Action()

function templeScroll.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	local inPz = player:getTile():hasFlag(TILESTATE_PROTECTIONZONE)
	local inFight = player:isPzLocked() or player:getCondition(CONDITION_INFIGHT, CONDITIONID_DEFAULT)

	if getTileInfo(player:getPosition()).nologout then --Using in a nologout zone
		supremeCubeMessage(player, CONST_ME_POFF, "You can't use this when you are inside a boss room.")
		return true 
	end

	if inPz or not inFight then
		fromPosition:sendMagicEffect(CONST_ME_TELEPORT)
		player:teleportTo(player:getTown():getTemplePosition())
		player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
		item:remove()
	else
		player:sendCancelMessage("You can't use this when you're in a fight.")
		fromPosition:sendMagicEffect(CONST_ME_POFF)
	end
	return true
end

templeScroll:id(25718)
templeScroll:register()
