local ITEM_DOLL_ID = 8778

local outfits = {
	{ female = 136, male = 128, name = "Citizen" },
	{ female = 137, male = 129, name = "Hunter" },
	{ female = 138, male = 130, name = "Mage" },
	{ female = 139, male = 131, name = "Knight" },
	{ female = 140, male = 132, name = "Nobleman" },
	{ female = 141, male = 133, name = "Summoner" },
	{ female = 142, male = 134, name = "Warrior" },
	{ female = 147, male = 143, name = "Barbarian" },
	{ female = 148, male = 144, name = "Druid" },
	{ female = 149, male = 145, name = "Wizard" },
	{ female = 150, male = 146, name = "Oriental" },
	{ female = 155, male = 151, name = "Pirate" },
	{ female = 156, male = 152, name = "Assassin" },
	{ female = 157, male = 153, name = "Beggar" },
	{ female = 158, male = 154, name = "Shaman" },
}

local jesterDoll = Action()

function jesterDoll.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if item.itemid ~= ITEM_DOLL_ID then
		return false
	end

	local window = ModalWindow({
		title = "Addon Doll",
		message = "Choose an outfit to unlock with both addons full:",
	})

	local isFemale = player:getSex() == PLAYERSEX_FEMALE

	for _, outfit in ipairs(outfits) do
		local lookType = isFemale and outfit.female or outfit.male
		local status = ""
		if player:hasOutfit(lookType, 3) then
			status = " [Owned]"
		elseif player:hasOutfit(lookType, 1) or player:hasOutfit(lookType, 2) then
			status = " [1 Addon]"
		elseif player:hasOutfit(lookType, 0) then
			status = " [No Addons]"
		end

		window:addChoice(outfit.name .. status, function(player, button, choice)
			if button.name ~= "Select" then
				return true
			end

			if player:getItemCount(ITEM_DOLL_ID) < 1 then
				player:sendCancelMessage("You need a Jester Doll to claim an outfit.")
				return true
			end

			local currentLookType = (player:getSex() == PLAYERSEX_FEMALE) and outfit.female or outfit.male
			if player:hasOutfit(currentLookType, 3) then
				player:sendCancelMessage("You already have both addons for the " .. outfit.name .. " outfit.")
				return true
			end

			if not player:removeItem(ITEM_DOLL_ID, 1) then
				player:sendCancelMessage("You need a Jester Doll to claim an outfit.")
				return true
			end

			-- Grant base outfit and full addons for both genders
			player:addOutfit(outfit.female, 3)
			player:addOutfit(outfit.male, 3)

			player:getPosition():sendMagicEffect(CONST_ME_MAGIC_BLUE)
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Congratulations! You have unlocked the full " .. outfit.name .. " outfit with both addons!")
			return true
		end)
	end

	window:addButton("Select")
	window:addButton("Cancel")
	window:setDefaultEnterButton(0)
	window:setDefaultEscapeButton(1)
	window:sendToPlayer(player)
	return true
end

jesterDoll:id(ITEM_DOLL_ID)
jesterDoll:register()
