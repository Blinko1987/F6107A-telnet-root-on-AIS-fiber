require "data_assemble.common_lua"
local FP_OBJNAME = "OBJ_HW_TELNET_ID"
local FP_IDENTITY = "IGD"
local t = {}
local urlName = cgilua.cgilua.servervariable("SCRIPT_NAME")
if urlName == "enable/CPE/ZeroTouch" then
t["TS_Enable"] = "1"
elseif urlName == "disable/CPE/ZeroTouch" then
t["TS_Enable"] = "0"
end
local tError = nil
tError = cmapi.nocsrf.setinst(FP_OBJNAME, FP_IDENTITY, t)
if tError.IF_ERRORID ~=0 then
g_logger:error(urlName .. " post Fail!")
end
