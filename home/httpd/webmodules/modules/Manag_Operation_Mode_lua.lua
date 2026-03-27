require "data_assemble.common_lua"
local ErrorXML = ""
local InstXML = ""
local OutXML = ""
local tError = nil
local FP_OBJNAME = "OBJ_NETSPHERE_MAP_SETMODE_ID"
local PARA =
{
"RegionCode",
"CurrentMode"
}
local FP_ACTION = cgilua.POST.IF_ACTION
local FP_IDENTITY = ""
cgilua.POST.CurrentMode = cgilua.POST.RegionCode
InstXML, tError = ManagerOBJ(FP_OBJNAME, FP_ACTION, FP_IDENTITY, PARA, nil, nil)
if tError and tError.IF_ERRORID == -11 then
cmapi.dev_action({CmdId = "cmd_devrestart",Identity="",DelaySec="5"})
end
ErrorXML = outputErrorXML(tError)
OutXML = ErrorXML .. InstXML
outputXML(OutXML)
