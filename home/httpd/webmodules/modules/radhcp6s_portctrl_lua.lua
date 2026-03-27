require "data_assemble.common_lua"
local ErrorXML = ""
local InstXML = ""
local OutXML = ""
local need2Get = 1
local tError = nil
local FP_OBJNAME = "OBJ_IPV6BANPORT_ID"
local PARA =
{
"PortID",
"PortName",
"AllowRA",
"AllowDHCP6S"
}
local FP_ACTION = cgilua.cgilua.POST.IF_ACTION
if FP_ACTION == "Apply" then
need2Get = 0
local instNum = cgilua.cgilua.POST._InstNum
for i=0, instNum - 1 do
local identityName = "_InstID_" .. i
local identity = cgilua.cgilua.POST[identityName]
local PARA_RQ = {}
if identity ~= nil then
for j, k in ipairs(PARA) do
PARA_RQ[k] = cgilua.cgilua.POST[k .. "_" .. i]
end
tError = applyOrNewOrDelInst(FP_OBJNAME, FP_ACTION, identity, PARA_RQ, tError)
end
end
end
if need2Get == 1 then
local wlanCommFunc = require "modules.wlan_common_func"
local FilterBySSIDName = wlanCommFunc.getSSIDNameFilter()
local function preProcessInstData(tResult, i)
local paraName = "PortName"
local aliasName = tResult[paraName]
if string.sub(aliasName,1,4) =="SSID" then
if FilterBySSIDName(aliasName) then
return true
else
return false
end
end
tResult.PortName=ChangePortName(tResult.PortName)
return true
end
InstXML, tError = getAllInstXML(FP_OBJNAME, "IGD", tError, preProcessInstData, transToFilterTab(PARA))
end
ErrorXML = outputErrorXML(tError)
OutXML = ErrorXML .. InstXML
outputXML(OutXML)
