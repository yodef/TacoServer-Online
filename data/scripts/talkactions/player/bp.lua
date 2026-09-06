local bpTypes = {
    {word = "brown", itemId = 2854, name = "brown"},
    {word = "red", itemId = 2867, name = "red"},
    {word = "blue", itemId = 2869, name = "blue"},
    {word = "green", itemId = 2865, name = "green"},
    {word = "yellow", itemId = 2866, name = "yellow"},
    {word = "orange", itemId = 9602, name = "orange"},
    {word = "grey", itemId = 2870, name = "grey"},
    {word = "beach", itemId = 5949, name = "beach"},
    {word = "brocade", itemId = 8860, name = "brocade"},
    {word = "camouflage", itemId = 2872, name = "camouflage"},
    {word = "fur", itemId = 7342, name = "fur"},
    {word = "glooth", itemId = 21295, name = "glooth"},
    {word = "golden", itemId = 2871, name = "golden"},
    {word = "heart", itemId = 10202, name = "heart"},
    {word = "purple", itemId = 2868, name = "purple"},
}

local buybp = TalkAction("!bp")
function buybp.onSay(player, words, param)
    param = param:lower()
    -- Help
    if param == "" then
        local available = {}
        for i = 1, #bpTypes do
            table.insert(available, bpTypes[i].name)
        end
        local message = "Available backpacks: " .. table.concat(available, ", ") .. ".\nUse !bp <color> to buy one (e.g., !bp red)."
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, message)
        return false
    end
    -- Find bp type
    local chosenBp = nil
    for i = 1, #bpTypes do
        if param == bpTypes[i].word then
            chosenBp = bpTypes[i]
            break
        end
    end
    -- If bp type is not valid
    if not chosenBp then
        player:sendCancelMessage("That is not a type of backpack available in this command. Use plain !bp to see the list.")
        return false
    end
    -- Purchase bp
    local totalCost = 25
    if player:removeMoneyBank(totalCost) then
        player:getPosition():sendMagicEffect(CONST_ME_MAGIC_BLUE)
        player:addItem(chosenBp.itemId, 1)
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, string.format("You have bought a %s backpack for %i gold!", chosenBp.name, totalCost))
    else
        player:getPosition():sendMagicEffect(CONST_ME_POFF)
        player:sendCancelMessage(string.format("You do not have enough money. You need %i gold to buy a backpack!", totalCost))
    end
    return true
end

buybp:separator(" ")
buybp:groupType("normal")
buybp:register()
