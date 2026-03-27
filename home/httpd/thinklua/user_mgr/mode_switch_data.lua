local json = require("common_lib.json")
local cgilua = require("cgilua.cgilua")
local ModeSwitchEnv = cgilua.POST.IF_ModeSwitch
if ModeSwitchEnv == "Basic" or ModeSwitchEnv == "Advanced" then
require("user_mgr.session_mgr").SetCurrentSessAttr("ModeSwitchEnv", ModeSwitchEnv)
g_logger:debug("ModeSwitchEnv is set to  " .. ModeSwitchEnv)
cgilua.put( json.encode({need_refresh=true}) )
end
cgilua.contentheader ("application", "json; charset="..lang.CHARSET)
