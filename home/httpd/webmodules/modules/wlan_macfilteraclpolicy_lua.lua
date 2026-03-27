require "data_assemble.common_lua"
local ErrorXML = ""
local InstXML = ""
local WLANBasicXML = ""
local InstXMLTMP = ""
local OutXML = ""
local need2Get = 1
local tError = nil
local WLANBasic_OBJNAME = "OBJ_WLANSETTING_ID"
local WLANBasic_PARA =
{
"WdsMode",
"Band",
"RadioStatus"
}
local FP_OBJNAME = "OBJ_WLANAP_ID"
local PARA =
{
"Alias",
"ACLPolicy",
"WLANViewName"
}
local FP_ACTION = cgilua.cgilua.POST.IF_ACTION
local FP_IDENTITY = cgilua.cgilua.POST._InstID
if FP_ACTION == "Apply" then
need2Get = 0
local PARA_RQ = {}
local instNum = cgilua.cgilua.POST._InstNum
for i=0, instNum - 1 do
local identityName = "_InstID_" .. i
local identity = cgilua.cgilua.POST[identityName]
for j, v in pairs(PARA) do
PARA_RQ[v] = cgilua.cgilua.POST[v .. "_" .. i]
end
tError = applyOrNewOrDelInst(FP_OBJNAME, FP_ACTION, identity, PARA_RQ, tError)
end
end
local wlanCommFunc = require "modules.wlan_common_func"
local SSIDFilterByNIC = wlanCommFunc.getSSIDFilterByNIC();
local function callback(t, ID)
local callret = true
if SSIDFilterByNIC and type(SSIDFilterByNIC) == "function" then
callret = SSIDFilterByNIC(t, ID)
end
if callret == false then
return false
end
if _G.ssidConf["GRE"].ssidHide == "true" then
local GREEnable = ""
local greIndex = ""
local APIndex = ""
local greData = cmapi.getinst("OBJ_GRE_ID","IGD")
GREEnable = greData["GREEnable"]
greIndex = string.gsub(greData.SSIDIfName, "DEV.BRIDGING.BR1.BRPORT", "")
if GREEnable=="1" and greIndex ~= "" then
for v in string.gmatch(greIndex, "%d") do
local greIndexNum = _G.tonumber(v) - tonumber(env.getenv("lanSupport")) - 1
APIndex = APIndex .. "DEV.WIFI.AP" .. greIndexNum .. ","
end
end
local tmpID = ID ..","
if APIndex~="" and string.find(APIndex, tmpID)~=nil then
return false
end
end
return true
end
if need2Get == 1 then
WLANBasicXML, tError = getAllInstXML(WLANBasic_OBJNAME, "IGD", tError,
nil, transToFilterTab(WLANBasic_PARA))
InstXML = InstXML .. WLANBasicXML
InstXMLTMP, tError = getAllInstXML(FP_OBJNAME, "IGD", tError, callback, transToFilterTab(PARA))
InstXML = InstXML .. InstXMLTMP
end
ErrorXML = outputErrorXML(tError)
OutXML = ErrorXML .. InstXML
outputXML(OutXML)
