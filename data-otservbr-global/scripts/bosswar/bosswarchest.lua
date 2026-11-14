local bossWarChest = Action()

-- Agrega las recompensas directamente al Inbox del jugador en el depot.
-- FLAG_NOLIMIT evita que la capacidad o los espacios del inventario del jugador
-- provoquen que los objetos se intenten colocar en el suelo.
local function addRewardToInbox(player, itemId, count)
    if not count or count <= 0 then
        return true
    end

    local inbox = player:getInbox()
    if not inbox then
        print(string.format(
            "[BossWarChest] ERROR: no se pudo obtener el Inbox de %s para entregar item %d x%d.",
            player:getName(), itemId, count
        ))
        return false
    end

    -- Crear cada unidad individualmente. En Canary/OTBR, el segundo argumento
    -- de addItem puede representar la cantidad de un stack; para objetos no
    -- stackables no necesariamente crea varias unidades.
    for i = 1, count do
        local rewardItem = inbox:addItem(itemId, 1, INDEX_WHEREEVER, FLAG_NOLIMIT)
        if not rewardItem then
            print(string.format(
                "[BossWarChest] ERROR: fallo al agregar item %d (unidad %d de %d) al Inbox de %s.",
                itemId, i, count, player:getName()
            ))
            return false
        end
    end

    return true
end

function bossWarChest.onUse(player, item, fromPosition, target, toPosition, isHotkey)
    local bossWarPoints = player:getStorageValue(15052)

    if bossWarPoints >= 1 then
        local cubes = 0
		local boxes = 0
        -- SURPRISE CUBES and BOXES
        if bossWarPoints >= 3000 then
            cubes = 15
			boxes = 30
        elseif bossWarPoints >= 2700 then
            cubes = 12
			boxes = 27
        elseif bossWarPoints >= 2400 then
            cubes = 11
			boxes = 23
        elseif bossWarPoints >= 2100 then
            cubes = 9
			boxes = 20
        elseif bossWarPoints >= 1800 then
            cubes = 8
			boxes = 18
        elseif bossWarPoints >= 1500 then
            cubes = 7
			boxes = 13
        elseif bossWarPoints >= 1200 then
            cubes = 5
			boxes = 11
        elseif bossWarPoints >= 900 then
            cubes = 4
			boxes = 9
        elseif bossWarPoints >= 600 then
            cubes = 2
			boxes = 5
        elseif bossWarPoints >= 300 then
            cubes = 1
			boxes = 2
        end

        -- Entregar primero los objetos. Si falla la entrega, no consumir los puntos.
        if cubes > 0 and not addRewardToInbox(player, 23488, cubes) then
            player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Your rewards could not be delivered to your depot Inbox. Your Boss War points have not been spent; please contact an administrator.")
            return true
        end

        if not addRewardToInbox(player, 12045, boxes) then
            -- Si ya se entregaron cubes, no es posible retirarlos de forma segura aquí.
            -- El error se registra para que el administrador pueda revisarlo.
            player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Your surprise boxes could not be delivered to your depot Inbox. Your Boss War points have not been spent; please contact an administrator.")
            return true
        end

        -- EXPERIENCE REWARD
        local expReward = (bossWarPoints * 0.7) * (player:getLevel() * 40)
        player:addExperience(expReward)

        if bossWarPoints >= 3000 then
            player:sendTextMessage(MESSAGE_EVENT_ADVANCE,
                "You have spent 3000 Boss War points and received: " .. boxes ..
                " surprise boxes, " .. expReward / 1000 ..
                "k Experience points and surprise cubes. This is the maximum reward!")

            local maxReward = bossWarPoints - 3000
            player:setStorageValue(15052, maxReward)
            db.query("UPDATE `players` SET `bossWarPoints` = `bossWarPoints` + 3000 WHERE `id` = '" .. player:getGuid() .. "';")
        else
            player:sendTextMessage(MESSAGE_EVENT_ADVANCE,
                "You have spent " .. bossWarPoints .. " Boss War points and received: " .. boxes ..
                " surprise boxes, " .. expReward / 1000 ..
                "k Experience points" .. (cubes > 0 and " and surprise cubes." or ".") ..
                " Your items have been sent to your depot Inbox.")

            player:setStorageValue(15052, 0)
            db.query("UPDATE `players` SET `bossWarPoints` = `bossWarPoints` + " .. bossWarPoints .. " WHERE `id` = '" .. player:getGuid() .. "';")
        end
    else
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE,
            "You need to defeat bosses inside Boss War arena to earn points. Use command !bosswar for more details.")
    end

    return true
end

bossWarChest:uid(50200)
bossWarChest:register()
