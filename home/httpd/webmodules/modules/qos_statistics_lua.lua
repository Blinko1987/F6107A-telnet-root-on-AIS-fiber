require "data_assemble.common_lua"
local ErrorXML = ""
local InstXML = ""
local InstXMLTMP = ""
local OutXML = ""
local tError = {IF_ERRORID = 0}
local need2Get = 1
local FP_OBJNAME_STATS = "OBJ_QOSQQSTATS_ID"
local PARA_STATS =
{
"Alias",
"DroppedPackets",
"OutputPackets",
"DroppedBytes",
"OutputBytes",
}
local FP_ACTION = cgilua.cgilua.POST.IF_ACTION
local FP_IDENTITY = cgilua.cgilua.POST._InstID
if FP_IDENTITY == "-1" then
FP_IDENTITY = ""
end
local InterfaceFilter = cgilua.cgilua.QUERY.InterfaceFilter
if InterfaceFilter == nil then
InterfaceFilter = "WAN"
end
local function modAlias(t)
for k,v in pairs(t) do
if k == "Queue" then
local qqTbl = cmapi.getinst("OBJ_QOSQQ_ID", v)
if type(qqTbl) ~= "table" then
return true
end
if qqTbl.IF_ERRORID == 0 then
t.Alias = qqTbl.Alias
end
end
end
return true
end
if FP_ACTION == "Refresh" then
need2Get = 0
InstXML, tError = getSpecificInstXML(FP_OBJNAME_STATS, FP_IDENTITY, nil, modAlias, transToFilterTab(PARA_STATS))
elseif FP_ACTION == "Reset" then
local tData = {}
tData["Reset"] = "1"
tData["Interface"] = cgilua.cgilua.POST.QueueInterface
InterfaceFilter = cgilua.cgilua.POST.QueueInterface
local instNum = cgilua.cgilua.POST._InstNum or 0
instNum = tonumber(instNum)
for i=1, instNum do
local FP_IDENTITY = cgilua.cgilua.POST["_InstID_" .. i-1]
tError = cmapi.setinst(FP_OBJNAME_STATS, FP_IDENTITY, tData)
if tError.IF_ERRORID == 0 then
cmapi.undoDBSave()
else
break
end
end
elseif FP_ACTION == "Delete" then
need2Get = 0
else
end
if need2Get == 1 then
InstXMLTMP, tError = getAllInstXML(FP_OBJNAME_STATS, InterfaceFilter, nil, modAlias, transToFilterTab(PARA_STATS))
InstXML = InstXML .. InstXMLTMP
end
ErrorXML = outputErrorXML(tError)
OutXML = ErrorXML .. InstXML
outputXML(OutXML)
