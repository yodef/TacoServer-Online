local config = {
	["gaffir"] = {
		stor = Storage.Quest.U12_20.GraveDanger.GaffirKilled,
	},
	["custodian"] = {
		stor = Storage.Quest.U12_20.GraveDanger.CustodianKilled,
	},
	["guard captain quaid"] = {
		stor = Storage.Quest.U12_20.GraveDanger.QuaidKilled,
	},
	["scarlett etzel"] = {
		stor = Storage.Quest.U12_20.GraveDanger.ScarlettKilled,
	},
	["earl osam"] = {
		stor = Storage.Quest.U12_20.GraveDanger.Bosses.EarlOsam.Killed,
		extra = {
			stor = Storage.Quest.U12_20.GraveDanger.Graves.Cormaya,
			value = 1,
		},
	},
	["count vlarkorth"] = {
		stor = Storage.Quest.U12_20.GraveDanger.Bosses.CountVlarkorth.Killed,
		extra = {
			stor = Storage.Quest.U12_20.GraveDanger.Graves.Edron,
			value = 1,
		},
	},
	["sir baeloc"] = {
		stor = Storage.Quest.U12_20.GraveDanger.Bosses.BaelocNictros.Killed,
		extra = {
			stor = Storage.Quest.U12_20.GraveDanger.Graves.Darashia,
			value = 1,
		},
	},
	["duke krule"] = {
		stor = Storage.Quest.U12_20.GraveDanger.Bosses.DukeKrule.Killed,
		extra = {
			stor = Storage.Quest.U12_20.GraveDanger.Graves.Thais,
			value = 1,
		},
	},
	["lord azaram"] = {
		stor = Storage.Quest.U12_20.GraveDanger.Bosses.LordAzaram.Killed,
		extra = {
			stor = Storage.Quest.U12_20.GraveDanger.Graves.Ghostlands,
			value = 1,
		},
	},
	["king zelos"] = {
		stor = Storage.Quest.U12_20.GraveDanger.Bosses.KingZelos.Killed,
	},
}

local grave_danger_death = CreatureEvent("grave_danger_death")

function grave_danger_death.onDeath(creature, corpse, killer, mostDamageKiller)
	local bossConfig = config[creature:getName():lower()]

	if not bossConfig then
		return true
	end

	local bossName = creature:getName():lower()
	local attackers = creature:getDamageMap()
	for attackerId, _ in pairs(attackers) do
		local player = Player(attackerId)
		if player then
			if bossName == "king zelos" and (not player:hasOutfit(1243) or not player:hasOutfit(1244)) then
				player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Congratulations you received the Hand of the Inquisition Outfit.")
				player:addOutfit(1243, 0)
				player:addOutfit(1244, 0)
				player:addAchievement("Inquisition's Hand")
				player:setStorageValue(Storage.Quest.U12_20.HandOfTheInquisitionOutfits.Outfits, 1)
			end

			if player:getStorageValue(bossConfig.stor) < 1 then
				player:setStorageValue(bossConfig.stor, 1)

				if bossName == "scarlett etzel" then
					player:addAchievement("A Study in Scarlett")
				end

				if bossConfig.extra then
					player:setStorageValue(bossConfig.extra.stor, bossConfig.extra.value)
					local graves = player:getStorageValue(Storage.Quest.U12_20.GraveDanger.Graves.Progress)
					player:setStorageValue(Storage.Quest.U12_20.GraveDanger.Graves.Progress, graves + 1)
				end
			end
		end
	end

	return true
end

grave_danger_death:register()
