local bosses = {
["scarlett etzel"] = {points = 20},
["duke krule"] = {points = 30},
["earl osam"] = {points = 30 },
["drume"] = {points = 20},
["orshabaal"] = {points = 20},
["morgaroth"] = {points = 30},
["zoralurk"] = {points = 40},
["ghazbaran"] = {points = 40},
["grand master oberon"] = {points = 30},
["lady tenebris"] = {points = 40},
["melting frozen horror"] = {points = 40},
["count vlarkorth"] = {points = 30},
["lord azaram"] = {points = 30},
["sir baeloc"] = {points = 20},
["sir nictros"] = {points = 20},
["the enraged thorn knight"] = {points = 50},
["lloyd"] = {points = 30},
["soul of dragonking zyrtarch"] = {points = 40},
["the time guardian"] = {points = 50},
["timira the many-headed"] = {points = 30},
["ravenous hunger"] = {points = 20},
["the unarmored voidborn"] = {points = 20},
["the souldespoiler"] = {points = 50},
["the false god"] = {points = 30},
["essence of malice"] = {points = 20},
["ratmiral blackwhiskers"] = {points = 40},
["gnomevil"] = {points = 50},
["deasthrike"] = {points = 50},
["deathstrike"] = {points = 50},
["abyssador"] = {points = 50},
["malofur mangrinder"] = {points = 40},
["the duke of the depths"] = {points = 50},
["the count of the core"] = {points = 50},
["the baron from below"] = {points = 50},
["the monster"] = {points = 80},
["brokul"] = {points = 20},
["the unwelcome"] = {points = 80},
["the dread maiden"] = {points = 80},
["the fear feaster"] = {points = 80},
["maxxenius"] = {points = 50},
["anomaly"] = {points = 30},
["realityquake"] = {points = 30},
["rupture"] = {points = 30},
["eradicator"] = {points = 40},
["outburst"] = {points = 40},
["izcandar the banished"] = {points = 40},
["alptramun"] = {points = 40},
["plagueroot"] = {points = 50},
["deep terror"] = {points = 30},
["apocalypse"] = {points = 30},
["king zelos"] = {points = 150},
["the source of corruption"] = {points = 100},
["ancient spawn of morgathla"] = {points = 100},
["the last lore keeper"] = {points = 180},
["urmahlullu the weakened"] = {points = 150},
["the brainstealer"] = {points = 120},
["magma bubble"] = {points = 150},
["the first dragon"] = {points = 100},
["ferumbras"] = {points = 100},
["lokathmor"] = {points = 120},
["mazzinor"] = {points = 120},
["ghulosh"] = {points = 120},
["gorzindel"] = {points = 120},
["the pale worm"] = {points = 160},
["world devourer"] = {points = 120},
["the nightmare beast"] = {points = 100},
["plagirath"] = {points = 120},
["mazoran"] = {points = 120},
["razzagorn"] = {points = 120},
["ragiaz"] = {points = 120},
["tarbaz"] = {points = 120},
["shulgrax"] = {points = 120},
}

local bossWarKills = CreatureEvent("bossWarDeath")
function bossWarKills.onDeath(creature)
	local bossName = creature:getName()
	local bossConfig = bosses[bossName:lower()]
	local bossPoints = bossConfig.points
	local earnPoints = bossPoints * 1.0
	if not bossConfig then
		return true
	end

	onDeathForDamagingPlayers(creature, function(creature, player)
		if player:getStorageValue(15053) >= 1 then --CONDITION
			if player:getStorageValue(15052) < 0 then
				player:setStorageValue(15052, 0)
				player:setStorageValue(15052, player:getStorageValue(15052) + earnPoints)
				player:say("You have slain " .. bossName .. " and received ".. earnPoints .." Boss War points!", TALKTYPE_MONSTER_SAY)
			else
				player:setStorageValue(15052, player:getStorageValue(15052) + earnPoints)
				player:say("You have slain " .. bossName .. " and received ".. earnPoints .." Boss War points.", TALKTYPE_MONSTER_SAY)	
			end
		end
	end)

	return true
end

bossWarKills:register()