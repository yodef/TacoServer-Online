dofile(CORE_DIRECTORY .. "/scripts/spells/support/stances_lib.lua")

local stancesLogin = CreatureEvent("StancesLogin")

function stancesLogin.onLogin(player)
	StanceSystem.onLogin(player)
	return true
end

stancesLogin:register()
