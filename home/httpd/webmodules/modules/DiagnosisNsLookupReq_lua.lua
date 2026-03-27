require "data_assemble.common_lua"
local InstXML = ""
local InstXML1 = ""
local ErrorXML = ""
local OutXML = ""
local tError = {
IF_ERRORID = 0,
IF_ERRORTYPE = "SUCC",
IF_ERRORSTR = "SUCC",
IF_ERRORPARAM = "SUCC"
}
local FP_OBJNAME1 = "OBJ_DEVNSLOOKUP_ID"
local FP_OBJNAME2 = "OBJ_DEV_GETRESULT_NSLOOKUP_ID"
local PARA =
{
"DiagnosticsState",
"Interface",
"HostName",
"ServerIP",
"Timeout",
"NumberOfRepetitions"
,"IPVersion"
}
local Result_PARA =
{
"HostNameReturned",
"IPAddresses"
}
function SetFixValue(t)
t.DiagnosticsState = 'Requested'
t.NumberOfRepetitions = '1'
t.Timeout = '1000'
end
local FP_ACTION = cgilua.POST.IF_ACTION
if FP_ACTION == "NsLookupDiagnosis" then
local t = transToPostTab(PARA)
SetFixValue(t)
tError = cmapi.setinst(FP_OBJNAME1, "IGD.NSLOOKUP", t)
end
function getInstNsLookupParaXML(OBJNAME, ID, PARA)
local xmlStr = getParaXMLNodeEntity("_InstID", encodeXML(ID))
local t = cmapi.getinst(OBJNAME, ID)
for i, v in ipairs(PARA) do
local paraVal = t[v]
if "" == paraVal then
paraVal = "NULL"
end
local paraValTrans = encodeXML(paraVal)
xmlStr = xmlStr .. getParaXMLNodeEntity(v, paraValTrans)
end
xmlStr = getXMLNodeEntity("Instance", xmlStr)
return xmlStr
end
if tError.IF_ERRORID ==0 then
InstXML = getInstNsLookupParaXML(FP_OBJNAME2, "IGD.NSLOOKUP.RESULT1", Result_PARA)
InstXML = getXMLNodeEntity(FP_OBJNAME2, InstXML)
InstXML1 = getSpecificInstXML(FP_OBJNAME1, "IGD.NSLOOKUP", tError, nil, transToFilterTab(PARA))
InstXML = InstXML .. InstXML1
end
ErrorXML = outputErrorXML(tError)
OutXML = ErrorXML .. InstXML
outputXML(OutXML)
