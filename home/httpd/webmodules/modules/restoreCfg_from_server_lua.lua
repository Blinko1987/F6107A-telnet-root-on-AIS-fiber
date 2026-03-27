require "data_assemble.common_lua"
local ErrorXML = ""
local InstXML = ""
local OutXML = ""
local tError = nil
local FP_OBJNAME = "OBJ_CFGAROUNDSERVER_ID";
local PARA =
{
"DownloadServer",
"DownloadStatus",
"DownloadEnable"
}
local FP_ACTION = cgilua.POST.IF_ACTION
local FP_IDENTITY = cgilua.POST._InstID
if FP_ACTION == "Trigger" then
cgilua.POST.DownloadEnable = 1
InstXML, tError = ManagerOBJ(FP_OBJNAME, "Apply", "IGD", PARA, nil, nil)
end
if FP_ACTION == "GetStatus" then
InstXML, tError = ManagerOBJ(FP_OBJNAME, "Cancel", "IGD", PARA, nil, nil)
end
ErrorXML = outputErrorXML(tError)
OutXML = ErrorXML .. InstXML
outputXML(OutXML)
