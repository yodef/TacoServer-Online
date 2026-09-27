if not TaskSystem or not TaskSystem.Config then
	if fileExists and fileExists(CORE_DIRECTORY .. "/scripts/lib/task_lib.lua") then
		dofile(CORE_DIRECTORY .. "/scripts/lib/task_lib.lua")
	elseif fileExists and fileExists("data/scripts/lib/task_lib.lua") then
		dofile("data/scripts/lib/task_lib.lua")
	end
end

local callback = EventCallback("MonsterOnDropLootBountyRing")

function callback.monsterOnDropLoot(monster, corpse)
	if not monster or not corpse then
		return
	end

	local player = Player(corpse:getCorpseOwner())
	if not player or not player:canReceiveLoot() then
		return
	end

	if not player.hasBountyRingEquipped or not player:hasBountyRingEquipped() then
		return
	end

	local monsterName = monster:getName():lower()
	if not player.isTaskMonster or not player:isTaskMonster(monsterName) then
		return
	end

	local lootLevel = player:getBountyUpgrade("loot")
	if lootLevel <= 0 then
		return
	end

	local chance = lootLevel * 3 -- 3%, 6%, 9%, 12%, 15%
	if math.random(100) > chance then
		return
	end

	local mType = monster:getType()
	if not mType then
		return
	end

	local lootTable = mType:generateLootRoll({ factor = 1.0, gut = false }, {}, player)
	if lootTable and next(lootTable) then
		corpse:addLoot(lootTable)
		local existingSuffix = corpse:getAttribute(ITEM_ATTRIBUTE_LOOTMESSAGE_SUFFIX) or ""
		local msgSuffix = (string.len(existingSuffix) > 0 and ", " or "") .. "bounty ring bonus loot"
		corpse:setAttribute(ITEM_ATTRIBUTE_LOOTMESSAGE_SUFFIX, existingSuffix .. msgSuffix)
	end
end

callback:register()
