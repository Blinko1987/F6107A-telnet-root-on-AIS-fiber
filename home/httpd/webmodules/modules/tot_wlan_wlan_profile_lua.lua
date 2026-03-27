require "data_assemble.common_lua"
function getALLAPInstXML(OBJNAME_GETAP, PARA_GETAP, FP_IDENTITY, tError)
local xmlTable = {}
local tErrorInner = {
IF_ERRORID = 0,
IF_ERRORTYPE = "SUCC",
IF_ERRORSTR = "SUCC",
IF_ERRORPARAM = "SUCC"
}
if type(tError) == "table" then
if tError.IF_ERRORID ~= 0 then
return "", tErrorInner
end
end
local tData = cmapi.getinst(OBJNAME_GETAP, FP_IDENTITY)
if type(tData) ~= "table" then
g_logger:warn("tData is not a table!")
return "", tErrorInner
end
if tData.IF_ERRORID ~= 0 then
g_logger:warn("getinst failed")
return "", tData
end
local FP_INSTNUM = tData.MGET_INST_NUM
FP_INSTNUM = tonumber(FP_INSTNUM)
local xmlStr = ""
local paraName = ""
local paraVal = ""
for i=0, FP_INSTNUM - 1 do
table.insert(xmlTable, "<Instance>")
xmlStr = getParaXMLNodeEntity("_InstID", i)
table.insert(xmlTable, xmlStr)
for _,paraName in pairs(PARA_GETAP) do
paraVal = ""
if tData[paraName..i] then
paraVal = tData[paraName..i]
paraVal = encodeXML(paraVal)
table.insert(xmlTable, getParaXMLNodeEntity(paraName, paraVal))
end
end
table.insert(xmlTable, getParaXMLNodeEntity("NETWORK", "AP"))
table.insert(xmlTable, "</Instance>")
end
xmlStr = table.concat(xmlTable)
InstXML = getXMLNodeEntity(OBJNAME_GETAP, xmlStr);
return InstXML, tError;
end
local ErrorXML = ""
local InstXML = ""
local OutXML = ""
local tError = {IF_ERRORID = 0}
local need2Get = 1
local OBJNAME_GETAP = "OBJ_WLANGETNEBAP_ID"
local PARA_GETAP =
{
"Essid",
"MacAddr",
"AuthMode",
"Signal",
"Noise",
"Channel",
"ScndChannel",
"DTIM",
"BeaconIntervel"
}
local FP_ACTION = cgilua.cgilua.POST.IF_ACTION
local FP_IDENTITY = cgilua.cgilua.POST._InstID
if FP_IDENTITY == "-1" then
FP_IDENTITY = ""
end
local APGetFrom = cgilua.cgilua.QUERY.APGetFrom
if need2Get == 1 then
if "ScanAP" == APGetFrom then
FP_IDENTITY = "DEV.WIFI.AP1"
InstXML, tError = getALLAPInstXML(OBJNAME_GETAP, PARA_GETAP, FP_IDENTITY, tError)
elseif "ScanAP5g" == APGetFrom then
FP_IDENTITY = "DEV.WIFI.AP5"
InstXML, tError = getALLAPInstXML(OBJNAME_GETAP, PARA_GETAP, FP_IDENTITY, tError)
end
cmapi.undoDBSave();
end
ErrorXML = outputErrorXML(tError)
OutXML = ErrorXML .. InstXML
outputXML(OutXML)
