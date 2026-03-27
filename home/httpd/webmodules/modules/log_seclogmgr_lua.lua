require "data_assemble.common_lua"
local ErrorXML = ""
local InstXML = ""
local OutXML = ""
local tError = {
IF_ERRORID = 0,
IF_ERRORTYPE = "SUCC",
IF_ERRORSTR = "SUCC",
IF_ERRORPARAM = "SUCC"
}
local need2Get = 1
local FP_IDENTITY= ""
local FP_OBJNAME = "OBJ_LOG_ID"
local ReturnIdentity = ""
local PARA =
{
"SecLogEnable",
}
function GetSecLogContent(formerStr)
local logStr = ""
local logLine = ""
local xmlStrTmp = ""
local localIP = cgilua.cgilua.br0 or "192.168.1.1"
local logCache = {}
repeat
logLine = encodeXML(cmapi.show_log(localIP, "security"))
table.insert(logCache,logLine)
until logLine == ""
logStr = table.concat(logCache)
logStr = getParaXMLNodeEntity("logStr",logStr)
xmlStrTmp = formerStr .. logStr
xmlStrTmp = getXMLNodeEntity("Instance", xmlStrTmp)
xmlStrTmp = getXMLNodeEntity(FP_OBJNAME, xmlStrTmp)
return xmlStrTmp
end
local FP_ACTION = cgilua.cgilua.POST.IF_ACTION
if FP_ACTION == "Apply" then
need2Get = 0
tError = applyOrNewOrDelInst(FP_OBJNAME, FP_ACTION, FP_IDENTITY, transToPostTab(PARA))
InstXML = GetSecLogContent("")
elseif FP_ACTION == "Refresh" then
need2Get = 0
InstXML = GetSecLogContent("")
else
end
if need2Get == 1 then
local xmlStr = getParaXMLNodeEntity("_InstID", "IGD")
local t = cmapi.getinst(FP_OBJNAME, "IGD")
for i,v in ipairs(PARA) do
local paraVal = t[v]
local paraValTrans = encodeXML(paraVal)
xmlStr = xmlStr .. getParaXMLNodeEntity(v, paraValTrans)
end
xmlStr = xmlStr .. GetSecLogContent(xmlStr)
InstXML = xmlStr
end
ErrorXML = outputErrorXML(tError)
OutXML = ErrorXML .. InstXML
outputXML(OutXML)
