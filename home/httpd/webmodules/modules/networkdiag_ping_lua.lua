require "data_assemble.common_lua"
local InstXML = ""
local ErrorXML = ""
local OutXML = ""
local tError = {
IF_ERRORID = 0,
IF_ERRORTYPE = "SUCC",
IF_ERRORSTR = "SUCC",
IF_ERRORPARAM = "SUCC"
}
local FP_OBJNAME = "OBJ_DEVPING_ID"
local PARA =
{
"Host",
"NumofRepeat",
"DataBlockSize",
"PingAck",
"MinimumResponseTime",
"MaximumResponseTime",
"AverageResponseTime",
"SuccessCount",
"FailureCount",
"DiagnosticsState",
"DSCP",
"Interface",
"Timeout"
,"IPVersion"
}
function SetFixValue(t)
t.DiagnosticsState = 'Requested'
t.DataBlockSize = '56'
t.NumofRepeat = '4'
t.Timeout = '2000'
end
local FP_ACTION = cgilua.cgilua.POST.IF_ACTION
if FP_ACTION == "PingDiagnosis" then
local t = transToPostTab(PARA)
SetFixValue(t)
tError = cmapi.setinst(FP_OBJNAME, "", t)
end
function getInstPingParaXML(OBJNAME, ID, PARA)
local xmlStr = getParaXMLNodeEntity("_InstID", encodeXML(ID))
local t = cmapi.getinst(OBJNAME, ID)
for i, v in ipairs(PARA) do
local paraVal = t[v]
if "" == paraVal and "PingAck" == v then
paraVal = "NULL"
end
local paraValTrans = ""
if paraVal ~= nil then
paraValTrans = encodeXML(paraVal)
end
xmlStr = xmlStr .. getParaXMLNodeEntity(v, paraValTrans)
end
xmlStr = getXMLNodeEntity("Instance", xmlStr)
return xmlStr
end
if tError.IF_ERRORID ==0 then
InstXML = getInstPingParaXML(FP_OBJNAME, "", PARA)
InstXML = getXMLNodeEntity(FP_OBJNAME, InstXML)
end
ErrorXML = outputErrorXML(tError)
OutXML = ErrorXML .. InstXML
outputXML(OutXML)
