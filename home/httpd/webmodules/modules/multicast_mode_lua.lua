require "data_assemble.common_lua"
local ErrorXML = ""
local InstXML = ""
local OutXML = ""
local tError = nil
local FP_OBJNAME_IGMPMODE = "OBJ_IGMPMODE_ID"
local PARA_IGMPMODE =
{
"multicastmode",
}
local FP_ACTION = cgilua.cgilua.POST.IF_ACTION
local FP_IDENTITY = ""
InstXML, tError = ManagerOBJ(FP_OBJNAME_IGMPMODE, FP_ACTION, FP_IDENTITY, PARA_IGMPMODE, tError)
ErrorXML = outputErrorXML(tError)
OutXML = ErrorXML .. InstXML
outputXML(OutXML)
