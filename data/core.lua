DATA_DIRECTORY = configManager.getString(configKeys.DATA_DIRECTORY)
CORE_DIRECTORY = configManager.getString(configKeys.CORE_DIRECTORY)

dofile(CORE_DIRECTORY .. "/global.lua")
dofile(CORE_DIRECTORY .. "/libs/libs.lua")
dofile(CORE_DIRECTORY .. "/stages.lua")

local triggerFile = "/tmp/trigger_reload_scripts"
local f = io.open(triggerFile, "r")
if f then
	f:close()
	os.remove(triggerFile)
	if Game and Game.reload and RELOAD_TYPE_SCRIPTS then
		if logger and logger.info then
			logger.info("[HOTRELOAD] Triggering Game.reload(RELOAD_TYPE_SCRIPTS)...")
		end
		Game.reload(RELOAD_TYPE_SCRIPTS)
	end
end
