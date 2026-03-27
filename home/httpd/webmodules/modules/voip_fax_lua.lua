require "data_assemble.common_lua"
local InstXML = ""
local ErrorXML = ""
local OutXML = ""
local tError = nil
local need2Get = 1
local isTR104v2 = env.getenv("VoIPTR104V2")
local FP_OBJNAME = "OBJ_VOIPFAXT38_ID"
local PARA =
{
"Enable",
}
if isTR104v2 == "1" then
FP_OBJNAME = "OBJ_VOIPSIPLINE_ID"
PARA =
{
"T38Enable"
}
end
local FP_ACTION = cgilua.cgilua.POST.IF_ACTION
local FP_IDENTITY = cgilua.cgilua.POST._InstID
InstXML, tError = ManagerOBJ(FP_OBJNAME, FP_ACTION, FP_IDENTITY, PARA, tError, nil)
ErrorXML = outputErrorXML(tError)
local InstXML_FAXMODE = ""
local tError_FAXMODE = nil
local ErrorXML_FAXMODE = ""
local FP_FAXMODE_OBJNAME = "OBJ_VOIPFAXMODE_ID"
local FAXMODE_PARA =
{
"MGInteract",
}
if _G.commConf.voipFax == true then
local FP_IDENTITY_MODE = cgilua.cgilua.POST._InstID_mode
InstXML_FAXMODE, tError_FAXMODE = ManagerOBJ(FP_FAXMODE_OBJNAME, FP_ACTION, FP_IDENTITY_MODE, FAXMODE_PARA, tError_FAXMODE, nil)
ErrorXML_FAXMODE = outputErrorXML(tError_FAXMODE)
if tError.IF_ERRORID == 0 and tError_FAXMODE.IF_ERRORID ~= 0 then
ErrorXML = ErrorXML_FAXMODE
end
end
OutXML = ErrorXML .. InstXML .. InstXML_FAXMODE
outputXML(OutXML)
