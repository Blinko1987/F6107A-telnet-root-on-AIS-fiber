require "data_assemble.common_lua"
local ErrorXML = ""
local InstXML = ""
local InstXMLTMP = ""
local OutXML = ""
local tError = nil
local tIgnoreDBError = {
IF_ERRORID = 0,
IF_ERRORTYPE = "SUCC",
IF_ERRORSTR = "SUCC",
IF_ERRORPARAM = "SUCC"
}
local need2Get = 1
local WNICIdentityArr = {}
local WLANBasicIDTableArr = {}
local wlanCommFunc = require "modules.wlan_common_func"
WNICIdentityArr,WLANBasicIDTableArr = wlanCommFunc.QueryWCardAndSSIDIdentity()
local AP_PARA =
{
"ESSID",
"BeaconType"
}
local BASE_PARA =
{
"Band"
}
local DRV_PARA =
{
"ChannelInUsed"
}
local function APFilter(t, identity)
for _, ssidTbl in pairs(WLANBasicIDTableArr) do
if ssidTbl.IF_ERRORID == 0 and ssidTbl.Count > 0 then
if identity == ssidTbl[1] then
return true
end
end
end
end
if need2Get == 1 then
InstXMLTMP, tError = getAllInstXML("OBJ_WLANSETTING_ID", "IGD",
tError, nil, transToFilterTab(BASE_PARA))
InstXML = InstXML .. InstXMLTMP
InstXMLTMP, tError = getAllInstXML("OBJ_WLANAP_ID", "IGD",
tError, APFilter, transToFilterTab(AP_PARA))
InstXML = InstXML .. InstXMLTMP
InstXMLTMP, tError = getAllInstXML("OBJ_WLANCONFIGDRV_ID", "IGD",
tError, APFilter, transToFilterTab(DRV_PARA))
InstXML = InstXML .. InstXMLTMP
end
if tError.IF_ERRORID and tError.IF_ERRORID == -8 then
tError = tIgnoreDBError
end
ErrorXML = outputErrorXML(tError)
OutXML = ErrorXML .. InstXML
outputXML(OutXML)
