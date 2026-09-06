local treasureDelivery = Action()

local treasureDeliver = {
	[2850] = {itemName = "blue tome", points = 10 },
	[2993] = {itemName = "teddy bear", points = 50 },
	[3422] = {itemName = "great shield", points = 50 },
	[5808] = {itemName = "Orshabaal's brain", points = 10 },
	[5809] = {itemName = "soul stone", points = 10 },
	[5903] = {itemName = "Ferumbras' hat", points = 100 }, 
	[5943] = {itemName = "Morgaroth's heart", points = 10 },
	[9388] = {itemName = "holy icon", points = 50 },
	[10227] = {itemName = "nightmare doll", points = 60 },
	[16206] = {itemName = "Abyssador's lash", points = 10 },
	[16205] = {itemName = "Gnomevil's hat", points = 10 },
	[16136] = {itemName = "Deathstrike's snippet", points = 10 },
	[16232] = {itemName = "statue of Abyssador", points = 50 }, 
	[16236] = {itemName = "statue of Deathstrike", points = 50 }, 
	[16240] = {itemName = "statue of Gnomevil", points = 50 }, 
	[23509] = {itemName = "mysterious remains", points = 5 },
	[24971] = {itemName = "forbidden tome", points = 20 },
	[24975] = {itemName = "astral source", points = 30 }, 
	[25088] = {itemName = "porcelain mask", points = 10 }, 
	[27618] = {itemName = "pristine worm head", points = 5 }, 
	[27619] = {itemName = "giant tentacle", points = 5 }, 
	[27621] = {itemName = "huge shell", points = 5 }, 
	[27622] = {itemName = "chitinous mouth (baron)", points = 5 },
	[27625] = {itemName = "harpoon of a giant snail", points = 5 },	
	[27626] = {itemName = "chitinous mouth (count)", points = 5 },	
	[27932] = {itemName = "sinister book", points = 40 }, 
	[27933] = {itemName = "ominous book", points = 30 }, 
	[27934] = {itemName = "knowledgeable book", points = 30 }, 
	[28702] = {itemName = "True Book of Death", points = 5 },
	[28824] = {itemName = "grant of arms", points = 5 },
	[29942] = {itemName = "Maxxenius head", points = 20 },
	[29943] = {itemName = "Alptramun's toothbrush", points = 20 },
	[29944] = {itemName = "Izcandar's snow globe", points = 20 },
	[29945] = {itemName = "Izcandar's sundial", points = 20 },
	[29946] = {itemName = "beast's nightmare-cushion", points = 30 },	
	[30055] = {itemName = "crunor idol", points = 5 }, 	
	[30087] = {itemName = "Plagueroot offshoot", points = 20 }, 
	[30088] = {itemName = "Malofur's lunchbox", points = 20 },	
	[35578] = {itemName = "tiara", points = 5 },
	[32589] = {itemName = "angel figurine", points = 5 },
	[32595] = {itemName = "jagged sickle", points = 10 }, 
	[32596] = {itemName = "dark bell", points = 20 }, 	
	[32593] = {itemName = "grimace", points = 15 }, 
	[32594] = {itemName = "bloody tears", points = 5 }, 
	[32597] = {itemName = "ravenous circlet", points = 20 },	
	[32598] = {itemName = "pale worm's scalp", points = 30 }, 
	[32599] = {itemName = "writhing heart", points = 15 }, 
	[32600] = {itemName = "writhing brain", points = 20 }, 
	[35610] = {itemName = "Tentugly's eye", points = 5 },
	[35611] = {itemName = "tentacle of Tentugly", points = 5 },
	[35612] = {itemName = "Tentugly's jaws", points = 10 },	
	[35613] = {itemName = "Ratmiral's hat", points = 20 },	
	[35614] = {itemName = "cheesy membership card", points = 20 },
	[39399] = {itemName = "piece of Timira's sensors", points = 10 },
	[39400] = {itemName = "one of Timira's many heads", points = 30 },
	[31589] = {itemName = "rotten heart", points = 10 },
	[31590] = {itemName = "young lich worm", points = 5 }, 
	[31591] = {itemName = "medal of valiance", points = 20 },
	[31592] = {itemName = "signet ring", points = 20 },	
	[31593] = {itemName = "noble cape", points = 20 },
	[31594] = {itemName = "token of love", points = 20 },
	[31595] = {itemName = "noble amulet", points = 20 },
	[31622] = {itemName = "Urmahlullu's tail", points = 20 }, 
	[31623] = {itemName = "Urmahlullu's mane", points = 30 }, 
	[31624] = {itemName = "Urmahlullu's paw", points = 10 },
	[32591] = {itemName = "soulforged lantern", points = 15 },
	[33779] = {itemName = "watermelon tourmaline (slice)", points = 5 }, 
	[33780] = {itemName = "watermelon tourmaline (pear)", points = 20 }, 
	[36794] = {itemName = "Brainstealer's tissue", points = 15 }, 
	[36795] = {itemName = "Brainstealer's brain", points = 20 }, 
	[36796] = {itemName = "Brainstealer's brainwave", points = 30 }, 
	[39040] = {itemName = "fiery tear", points = 50 }, 
	[39543] = {itemName = "smoldering eye", points = 25 }, 
	--[] = {itemName = "", points = 5 }, 
}

function treasureDelivery.onUse(player, item, fromPosition, itemEx, toPosition)

local bossWarPoints = player:getStorageValue(15052)	
local delivery = treasureDeliver[item.itemid]
		player:say("You have delivered ".. delivery.itemName .." to the MoTA and received ".. delivery.points .." Boss War points.", TALKTYPE_MONSTER_SAY)
		player:getPosition():sendMagicEffect(201)
		player:setStorageValue(15052, bossWarPoints + delivery.points)
		item:remove(1)
	return true
end

for index, value in pairs(treasureDeliver) do
	treasureDelivery:id(index)
end

treasureDelivery:register()
