require "data_assemble.common_lua"
local ErrorXML = ""
local InstXML = ""
local OutXML = ""
local need2Get = 1
local tError = nil
local FP_OBJNAME = "OBJ_VOIPH248MAIN_ID"
local PARA =
{
"AuthenticationMethID",
"MD5AuthMGIDType",
"MD5AuthMGID",
"InitPublicKey",
"DhPara_P",
"DhPara_G",
}
local FP_ACTION = cgilua.cgilua.POST.IF_ACTION
local FP_IDENTITY = cgilua.cgilua.POST._InstID
InstXML, tError = ManagerOBJ(FP_OBJNAME, FP_ACTION, FP_IDENTITY, PARA, tError)
ErrorXML = outputErrorXML(tError)
OutXML = ErrorXML .. InstXML
outputXML(OutXML)
