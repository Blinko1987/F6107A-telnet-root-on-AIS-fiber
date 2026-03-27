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
local need2Get = 1
local FP_OBJNAME = "OBJ_FW_SERVPORT_ID"
local PARA =
{
"ServName",
"ServPort"
}
local tData = {}
local FP_ACTION = cgilua.cgilua.POST.IF_ACTION
if FP_ACTION == "Apply" then
need2Get = 0
local instNum = cgilua.cgilua.POST._InstNum
for i=0, instNum -1 do
local identityName = "_InstID_" .. i
local identity = cgilua.cgilua.POST[identityName]
for j, k in ipairs(PARA) do
tData[k] = cgilua.cgilua.POST[ k .. "_" .. i]
end
tError = applyOrNewOrDelInst(FP_OBJNAME, FP_ACTION, identity, tData, tError)
end
end
if need2Get == 1 then
local hiddenStr = _G.commConf.fwPortServHidden
local retTab = cmapi.querylist(FP_OBJNAME, "IGD")
local sess_id = cgilua.cgilua.getCurrentSessID()
local Right = session_get(sess_id, "Right")
local uRight = string.match(hiddenStr, "(%d+)")
if retTab.IF_ERRORID == 0 then
local InstNum = retTab.Count
if InstNum ~= 888 then
for i,v in ipairs(retTab) do
local instStr = ""
local id = v
instStr = getParaXMLNodeEntity("_InstID", id)
local t = cmapi.getinst(FP_OBJNAME, id)
if t.IF_ERRORID ~= 0 then
tError = t
break
end
if t.ServName == "WEB" then
t.ServName = "HTTP"
end
local ServName = t.ServName
local ServNameTmp = ServName .. ","
local findLocation = nil
if uRight == nil or uRight == Right then
findLocation = string.find(hiddenStr,ServNameTmp,1)
end
if ( (ServName == "HTTP"
or ServName == "FTP"
or ServName == "SSH"
or ServName == "TELNET"
or ServName == "HTTPS"
) and (findLocation == nil) ) then
for j,k in ipairs(PARA) do
local paraVal = t[k]
local paraValTrans = encodeXML(paraVal)
instStr = instStr .. getParaXMLNodeEntity(k, paraValTrans)
end
InstXML = InstXML .. getXMLNodeEntity("Instance", instStr)
end
end
InstXML = getXMLNodeEntity(FP_OBJNAME, InstXML)
end
else
tError = retTab
end
end
ErrorXML = outputErrorXML(tError)
OutXML = ErrorXML .. InstXML
outputXML(OutXML)
