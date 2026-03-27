require "data_assemble.common_lua"
local WPSXML = ""
local ErrorXML = ""
local OutXML = ""
local tError = nil
local WLANBasicXML = ""
local WPSALLXML = ""
local WPS_OBJNAME = "OBJ_WPS_ID"
local WPS_PARA =
{
"Enable",
"WPSMode",
"WpsPINShow"
}
local WLANBasic_OBJNAME = "OBJ_WLANSETTING_ID"
local WLANBasic_PARA =
{
"Band",
"RadioStatus",
"LockStatusBase"
}
local FP_ACTION = cgilua.cgilua.POST.IF_ACTION
local WNICIdentity = cgilua.cgilua.POST._InstID
local AP_IDENTITY = {}
local cardnum = cmapi.querylist("OBJ_WLANSETTING_ID", "DEV").Count
for i=1, cardnum do
local cardIndex = "DEV.WIFI.RD" .. i
local reTable = cmapi.querylist("OBJ_WLAN_CONFIG_ID", cardIndex)
if reTable.IF_ERRORID == 0 then
table.insert(AP_IDENTITY, reTable[1])
end
end
local WPS_IDENTITY = {}
for _, v in ipairs(AP_IDENTITY) do
local reTable = cmapi.querylist("OBJ_WPS_ID", v)
if reTable.IF_ERRORID == 0 then
table.insert(WPS_IDENTITY, reTable[1])
end
end
local t_WPSInst = cmapi.getinst("OBJ_WPS_INST_ID", "DEV.WIFI.RD1")
if t_WPSInst.IF_ERRORID == 0 then
table.remove(WPS_IDENTITY, 1)
table.insert(WPS_IDENTITY, 1, t_WPSInst.WPSInst)
end
local SSID_IDENTITY = cgilua.cgilua.POST.SSID_InstID
local wlanCommFunc = require "modules.wlan_common_func"
if SSID_IDENTITY == nil then
local _, SSID_IDENTITY_Tab = wlanCommFunc.QueryWCardAndSSIDIdentity(1)
SSID_IDENTITY = SSID_IDENTITY_Tab[1][1]
end
local _PINMode = cgilua.cgilua.POST.PINMode
if _PINMode == nil then
_PINMode = "AutoPIN"
end
local sess_id = cgilua.getCurrentSessID()
local initialWpsPIN
local function callback(t, ID)
return true
end
if FP_ACTION == "Apply" then
tError = applyOrNewOrDelInst(WPS_OBJNAME, FP_ACTION, SSID_IDENTITY, transToPostTab(WPS_PARA), tError)
end
WLANBasicXML, tError = getAllInstXML(WLANBasic_OBJNAME, "IGD", tError, nil, transToFilterTab(WLANBasic_PARA))
if FP_ACTION == "Refresh" or FP_ACTION == "Apply" then
WPSXML, tError = getAllInstXML(WPS_OBJNAME, SSID_IDENTITY, tError, callback, transToFilterTab(WPS_PARA))
ErrorXML = outputErrorXML(tError)
OutXML = ErrorXML .. WLANBasicXML .. WPSXML
else
for _, v in ipairs(WPS_IDENTITY) do
tempXML, tError = getAllInstXML(WPS_OBJNAME, v, tError, nil, transToFilterTab(WPS_PARA))
WPSALLXML = WPSALLXML .. tempXML
end
ErrorXML = outputErrorXML(tError)
OutXML = ErrorXML .. WLANBasicXML .. WPSALLXML
end
outputXML(OutXML)
