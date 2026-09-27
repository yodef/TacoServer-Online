local rewards = {
	{ id = 36729, name = "fire resilience" },
	{ id = 36730, name = "ice resilience" },
	{ id = 36731, name = "earth resilience" },
	{ id = 36732, name = "energy resilience" },
	{ id = 36733, name = "holy resilience" },
	{ id = 36734, name = "death resilience" },
	{ id = 36735, name = "physical resilience" },
	{ id = 36736, name = "fire amplification" },
	{ id = 36737, name = "ice amplification" },
	{ id = 36738, name = "earth amplification" },
	{ id = 36739, name = "energy amplification" },
	{ id = 36740, name = "holy amplification" },
	{ id = 36741, name = "death amplification" },
	{ id = 36742, name = "physical amplification" },
	{ id = 23489, name = "brightlight figurine" },
	{ id = 23490, name = "gemlight figurine" },
	{ id = 23491, name = "manalight figurine" },
	{ id = 23492, name = "blacklight figurine" },
	{ id = 23493, name = "bloodlight figurine" },
	{ id = 673, name = "opticorder hammer" },
	{ id = 23489, name = "brightlight figurine" },
	{ id = 23490, name = "gemlight figurine" },
	{ id = 23491, name = "manalight figurine" },
	{ id = 23492, name = "blacklight figurine" },
	{ id = 23493, name = "bloodlight figurine" },
	{ id = 11372, name = "interdimensional potion" },
	{ id = 11588, name = "glory elixir" },
}


local surpriseCube = Action()

function surpriseCube.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if not player then
		return false
	end
	local randId = math.random(1, #rewards)
	local rewardItem = rewards[randId]
	local coinamount = math.random(1, 100)

	player:addItem(rewardItem.id, 1)
	player:addItem(3043, coinamount)
	item:remove(1)

	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You received " .. rewardItem.name .. " and " .. coinamount .. " crystal coins.")
	return true
end

surpriseCube:id(23488)
surpriseCube:register()
