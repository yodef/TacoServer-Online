local outfits = {
    [0] = {
        ["citizen"] = 136,
        ["hunter"] = 137,
        ["mage"] = 138,
        ["knight"] = 139,
        ["nobleman"] = 140,
        ["summoner"] = 141,
        ["warrior"] = 142,
        ["barbarian"] = 147,
        ["druid"] = 148,
        ["wizard"] = 149,
        ["oriental"] = 150,
        ["pirate"] = 155,
        ["assassin"] = 156,
        ["beggar"] = 157,
        ["shaman"] = 158,
        ["norsewoman"] = 252,
        ["nightmare"] = 269,
        ["jester"] = 270,
        ["brotherhood"] = 279,
        ["demonhunter"] = 288,
        ["yalaharian"] = 324
    },
    [1] = {
        ["citizen"] = 128,
        ["hunter"] = 129,
        ["mage"] = 130,
        ["knight"] = 131,
        ["nobleman"] = 132,
        ["summoner"] = 133,
        ["warrior"] = 134,
        ["barbarian"] = 143,
        ["druid"] = 144,
        ["wizard"] = 145,
        ["oriental"] = 146,
        ["pirate"] = 151,
        ["assassin"] = 152,
        ["beggar"] = 153,
        ["shaman"] = 154,
        ["norsewoman"] = 251,
        ["nightmare"] = 268,
        ["jester"] = 273,
        ["brotherhood"] = 278,
        ["demonhunter"] = 289,
        ["yalaharian"] = 325
    }
}

local AddonDoll = TalkAction("!addon")

local msg = {
    success = "Full addon set successfully added!",
    invalidParam = "You need to include the outfit name you want. EX: !addon citizen",
    hasAddons = "You already have the addons for this outfit.",
    needDoll = "You do not have an addon doll.",
    invalidOutfit = "You must put a valid outfit name."
}

function AddonDoll.onSay(player, words, param, type)
    local param = string.lower(param)

    if (param == "") then
        return player:sendTextMessage(MESSAGE_INFO_DESCR, msg.invalidParam)
    end

    if (player:getItemCount(8778) == 0) then
        return player:sendTextMessage(MESSAGE_INFO_DESCR, msg.needDoll)
    end

    local outfit = outfits[player:getSex()][param]
    if not outfit then
        return player:sendTextMessage(MESSAGE_INFO_DESCR, msg.invalidOutfit)
    end

    if (player:hasOutfit(outfit, 3)) then
        return player:sendTextMessage(MESSAGE_INFO_DESCR, msg.hasAddons)
    end

    player:removeItem(8778, 1)
    player:sendTextMessage(MESSAGE_INFO_DESCR, msg.success)
    player:getPosition():sendMagicEffect(CONST_ME_GIFT_WRAPS)
    player:addOutfitAddon(outfit, 3)
    return true
end

AddonDoll:separator(" ")
AddonDoll:groupType("normal")
AddonDoll:register()

