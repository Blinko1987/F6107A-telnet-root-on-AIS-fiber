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
local FP_ACTION = cgilua.cgilua.POST.IF_ACTION
local FP_OBJNAME = "OBJ_TUNNEL_ID"
local FP_OBJTUNN = "OBJ_TUNNEL46_ID"
local FP_IDENTITY = cgilua.cgilua.POST._InstID or ""
local PARA =
{
"TUN46WANCViewName",
"TUN46Localv4Addr",
"IsHMREMOTEAddrSrc",
"TUN46REMOTEIPAddr",
"Tunnel46name",
"Wanctype",
"ConnStatus",
"AFTRAddr"
};
function callback(t)
if "::" == t.TUN46REMOTEIPAddr then
t.TUN46REMOTEIPAddr = ""
end
_,t.TUN46WANName = FindNameBaseID(t.TUN46WANCViewName)
return true
end
if "-1" == FP_IDENTITY then
FP_IDENTITY = ""
end
if not FP_ACTION then
local reTable = cmapi.querylist(FP_OBJNAME, "IGD")
local InstTmp = ""
if reTable.IF_ERRORID ~= 0 then
tError = reTable
else
for i=1, reTable.Count do
InstTmp, tError = getSpecificInstXML(FP_OBJTUNN, reTable[i].InstName, tError, callback, nil)
InstXML = InstXML..InstTmp
end
end
elseif "Cancel" == FP_ACTION then
InstXML, tError = getSpecificInstXML(FP_OBJTUNN,FP_IDENTITY, tError, callback, nil)
else
tError = applyOrNewOrDelInst(FP_OBJTUNN, FP_ACTION, FP_IDENTITY, transToPostTab(PARA))
ReturnIdentity = tError.INSTIDENTITY or ""
InstXML = getXMLNodeEntity("_InstID", encodeXML(ReturnIdentity))
end
ErrorXML = outputErrorXML(tError)
OutXML = ErrorXML .. InstXML
outputXML(OutXML)
