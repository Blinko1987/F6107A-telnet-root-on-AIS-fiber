require "data_assemble.common_lua"
local ErrorXML = ""
local xmlStr = ""
local OutXML = ""
local tError = nil
local APIndex = ""
local FP_OBJNAME = "OBJ_WLAN_AD_ID"
local PARA =
{
"HostName",
"IPAddress",
"IPV6Address",
"MACAddress",
"AliasName",
"MCS",
"BAND",
"RSSI",
"TxRate",
"RxRate",
"NOISE",
"SNR",
"CurrentMode",
"LinkTime"
}
local FP_AP_OBJNAME = "OBJ_WLANAP_ID"
local AP_PARA =
{
"ESSID",
"Alias"
}
local xmlTable = {}
local reTable = cmapi.querylist("OBJ_WPS_ID", "DEV")
if reTable.IF_ERRORID==0 then
IndexNum = reTable.Count
end
local ssidFileter = ""
local sess_id = cgilua.cgilua.getCurrentSessID()
local usrRight = session_get(sess_id, "Right")
if _G.ssidConf[usrRight] ~= nil and _G.ssidConf[usrRight].hidden ~= nil then
ssidFileter = _G.ssidConf[usrRight].hidden
end
for i=1,IndexNum do
local ListBaseStr = "DEV.WIFI.AP" .. i
local instTbl = cmapi.getinst(FP_AP_OBJNAME, ListBaseStr)
local tmpListBaseStr = ListBaseStr .. ","
if string.find(APIndex,tmpListBaseStr) ==nil and string.find(ssidFileter,tmpListBaseStr) == nil and instTbl.LocalSetEnable == "1" then
xmlTable,tError = getAllInstTbl(FP_OBJNAME, ListBaseStr, tError, nil, transToFilterTab(PARA), xmlTable)
end
end
xmlStr = table.concat(xmlTable)
xmlStr = getXMLNodeEntity(FP_OBJNAME, xmlStr)
xmlStrAP, tError = getAllInstXML(FP_AP_OBJNAME, "IGD", tError, nil, transToFilterTab(AP_PARA))
ErrorXML = ErrorXML .. outputErrorXML(tError)
OutXML = ErrorXML .. xmlStr .. xmlStrAP
outputXML(OutXML)
