require "data_assemble.common_lua"
local ErrorXML = ""
local InstXML = ""
local OutXML = ""
local need2Get = 1
local tError = {
IF_ERRORID = 0,
IF_ERRORTYPE = "SUCC",
IF_ERRORSTR = "SUCC",
IF_ERRORPARAM = "SUCC"
}
local FP_OBJNAME = "OBJ_IGMPADDLIMITUNTAG_ID"
local PARA =
{
"PortViewName",
"PortName",
"MaxNodeNum"
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
local MulticastAddressLanTbl = cmapi.ListIFByApp("MulticastVlan")
function FindPortName(tbl, id)
for i, v in ipairs(MulticastAddressLanTbl) do
if v.InstID == tbl.PortViewName then
tbl.PortName = ChangePortName(v.InstName)
end
end
local wlanCommFunc = require "modules.wlan_common_func"
local FilterBySSIDName = wlanCommFunc.getSSIDNameFilter()
if string.sub(tbl.PortName,1,4) =="SSID" then
if FilterBySSIDName(tbl.PortName) then
return true
else
return false
end
end
return true
end
if need2Get == 1 then
local xmlTable = {}
for i, v in ipairs(MulticastAddressLanTbl) do
local LanInstID = v.InstID
local reTable = cmapi.querylist(FP_OBJNAME, LanInstID)
if reTable.IF_ERRORID == 0 then
local id = reTable[1].InstName or reTable[1]
xmlTable, tError, exitCycle = getInstParaXML(FP_OBJNAME, id, FindPortName, transToFilterTab(PARA), xmlTable)
end
end
InstXML = table.concat(xmlTable)
InstXML = getXMLNodeEntity(FP_OBJNAME, InstXML)
end
ErrorXML = outputErrorXML(tError)
OutXML = ErrorXML .. InstXML
outputXML(OutXML)
