require "data_assemble.common_lua"
local InstXML = ""
local ErrorXML = ""
local OutXML = ""
local tError = nil
local tError = {
IF_ERRORID = 0,
IF_ERRORTYPE = "SUCC",
IF_ERRORSTR = "SUCC",
IF_ERRORPARAM = "SUCC"
}
local FP_OBJNAME = "OBJ_TRACERT_ID"
local PARA =
{
"Host",
"Interface",
"Timeout",
"DataBlockSize",
"MaxHopCount",
"DSCP",
"Port",
"NumberOfTries",
"Flag",
"ResponseTime",
"NumberOfPRouteHops",
"DiagnosticsState",
"Protocol",
"Control",
"Result"
,"IPVersion"
}
function SetFixValue(t)
t.DSCP = '0'
t.DataBlockSize = '38'
t.DiagnosticsState = 'Requested'
t.NumberOfTries = '3'
end
local FP_ACTION = cgilua.cgilua.POST.IF_ACTION
if FP_ACTION == "TraceRouteDiagnosis" then
local t = transToPostTab(PARA)
SetFixValue(t)
if t.MaxHopCount == '' then
t.MaxHopCount = nil
end
if t.Timeout == '' then
t.Timeout = nil
end
tError = cmapi.setinst(FP_OBJNAME, "", t)
end
if FP_ACTION == "TRStop" then
local tData = transToPostTab(PARA)
for i, v in ipairs(PARA) do
if "Control"==v then
tData[v] = "1"
else
tData[v] = "NULL"
end
end
SetFixValue(tData)
cmapi.setinst(FP_OBJNAME, "", tData)
end
cmapi.undoDBSave()
function getInstTraceRouteParaXML(OBJNAME, ID, PARA, PARANUM)
local xmlStr = getParaXMLNodeEntity("_InstID", encodeXML(ID))
local t = cmapi.getinst(OBJNAME, ID);
for i, v in ipairs(PARA) do
local paraVal = t[v]
if "Result" == v then
if "" ~= paraVal then
paraVal = read_file(paraVal)
else
paraVal = "NULL"
end
end
local paraValTrans = encodeXML(paraVal)
xmlStr = xmlStr .. getParaXMLNodeEntity(v, paraValTrans)
end
xmlStr = getXMLNodeEntity("Instance", xmlStr)
return xmlStr
end
if tError.IF_ERRORID ==0 then
InstXML = getInstTraceRouteParaXML(FP_OBJNAME, "", PARA)
InstXML = getXMLNodeEntity(FP_OBJNAME, InstXML)
end
ErrorXML = outputErrorXML(tError)
OutXML = ErrorXML .. InstXML
outputXML(OutXML)
