local blueSphere = Action()

function blueSphere.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	item:remove(1)
	player:getPosition():sendMagicEffect(CONST_ME_FIREWORK_BLUE)
for k, v in pairs(getmetatable(player)) do
    if string.find(k:lower(), "dust") or string.find(k:lower(), "forge") then
        print("Método encontrado:", k)
    end
end
	player:addForgeResource(ForgeResource_Dust, 100)
end

blueSphere:id(23541)
blueSphere:register()
