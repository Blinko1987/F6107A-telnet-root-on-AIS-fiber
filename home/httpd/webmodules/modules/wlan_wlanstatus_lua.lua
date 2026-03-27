require "data_assemble.common_lua"
local ErrorXML = ""
local InstXML1 = ""
local InstXML2 = ""
local InstXML3 = ""
local OutXML = ""
local tError = nil
local FP_ACTION = cgilua.cgilua.POST.IF_ACTION
if FP_ACTION == "WLAN_CLEAR" then
tError = cmapi.dev_action({CmdId = "cmd_clear_wlanstate"})
else
local wlanCommFunc = require "modules.wlan_common_func"
local SSIDFilterByNIC = wlanCommFunc.getSSIDFilterByNIC();
local t_PARA =
{
"BeaconType",
"Enable",
"ESSID",
"Alias",
"WLANViewName",
"WPAAuthMode",
"WPA3AuthMode",
"11iAuthMode",
"WPAEncryptType",
"11iEncryptType",
"WEPAuthMode"
}
InstXML1, tError = getAllInstXML("OBJ_WLANAP_ID", "IGD", tError, SSIDFilterByNIC, transToFilterTab(t_PARA))
local t_DRV_PARA=
{
"RealRF",
"TotalPacketsReceived",
"TotalBytesReceived",
"TotalPacketsSent",
"TotalBytesSent",
"Bssid",
"ChannelInUsed",
"WLANViewName"
}
InstXML2, tError = getAllInstXML("OBJ_WLANCONFIGDRV_ID", "IGD", tError, SSIDFilterByNIC, transToFilterTab(t_DRV_PARA))
local WLANSETTING_OBJNAME = "OBJ_WLANSETTING_ID"
local WLANSETTING_PARA =
{
"Band"
}
InstXML3, tError = getAllInstXML(WLANSETTING_OBJNAME, "IGD", tError, nil, transToFilterTab(WLANSETTING_PARA))
end
ErrorXML = outputErrorXML(tError)
OutXML = ErrorXML .. InstXML1 .. InstXML2 .. InstXML3
outputXML(OutXML);
