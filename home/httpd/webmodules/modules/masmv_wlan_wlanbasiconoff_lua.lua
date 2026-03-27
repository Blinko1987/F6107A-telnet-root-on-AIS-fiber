require "data_assemble.common_lua"
local InstXML = ""
local InstXMLTMP = ""
local xmlStr = ""
local xmlTable = {}
local ErrorXML = ""
local OutXML = ""
local tError = {IF_ERRORID = 0}
local need2Get = 1
local WLANSETTING_OBJNAME = "OBJ_WLANSETTING_ID"
local WLANSETTING_PARA =
{
"RadioStatus",
"Band"
}
local TIMECFG_OBJNAME = "OBJ_WLANTIMECFG_ID";
local TIMECFG_PARA =
{
"TimerEnable"
}
local WLANTIME_OBJNAME = "OBJ_WLANTIME_ID"
local WLANTIME_PARA =
{
"TimeStartHour",
"TimeStartMin",
"TimeEndHour",
"TimeEndMin"
}
local SMARTWIFI_OBJNAME = "OBJ_SMART_WIFI_ID";
local SMARTWIFI_PARA =
{
"SmartWifiEnable"
}
local FP_ACTION = cgilua.cgilua.POST.IF_ACTION
local FP_IDENTITY = cgilua.cgilua.POST._InstID
function setWlanRadio()
local index = 0
while cgilua.cgilua.POST["_InstID_" .. index] do
local InstID = cgilua.cgilua.POST["_InstID_" .. index]
local t_Data = {}
for j, k in pairs(WLANSETTING_PARA) do
if k ~= "Band" then
t_Data[k] = cgilua.cgilua.POST[k .. "_" .. index]
end
end
tError = applyOrNewOrDelInst(WLANSETTING_OBJNAME, FP_ACTION, InstID,
t_Data, tError)
index = index + 1
end
end
if FP_ACTION == "Apply" then
need2Get = 0
local TimerEnable = cgilua.cgilua.POST.TimerEnable
if TimerEnable == "1" then
tError = applyOrNewOrDelInst(WLANTIME_OBJNAME, FP_ACTION, FP_IDENTITY,
transToPostTab(WLANTIME_PARA), tError)
end
tError = applyOrNewOrDelInst(TIMECFG_OBJNAME, FP_ACTION, FP_IDENTITY,
transToPostTab(TIMECFG_PARA), tError)
if TimerEnable == "0" then
setWlanRadio()
end
end
if need2Get == 1 then
InstXMLTMP, tError = getAllInstXML(TIMECFG_OBJNAME, "IGD", tError, nil, transToFilterTab(TIMECFG_PARA))
InstXML = InstXML .. InstXMLTMP
InstXMLTMP, tError = getAllInstXML(WLANTIME_OBJNAME, "IGD", tError, nil, transToFilterTab(WLANTIME_PARA))
InstXML = InstXML .. InstXMLTMP
InstXML, tError = getAllInstXML(WLANSETTING_OBJNAME, "IGD", tError, nil, transToFilterTab(WLANSETTING_PARA))
table.insert(xmlTable, InstXML)
InstXMLTMP, tError = getAllInstXML(SMARTWIFI_OBJNAME, "IGD", tError, nil, transToFilterTab(SMARTWIFI_PARA))
table.insert(xmlTable, InstXMLTMP)
end
xmlStr = table.concat(xmlTable)
ErrorXML = outputErrorXML(tError)
OutXML = ErrorXML .. xmlStr
outputXML(OutXML)
