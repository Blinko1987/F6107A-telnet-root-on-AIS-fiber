require "data_assemble.common_lua"
local ErrorXML = ""
local InstXML = ""
local InstXML1 = ""
local InstXML2 = ""
local OutXML = ""
local tError = nil
local FP_OBJNAME = "OBJ_NETSPHERE_MAP_ID";
local PARA =
{
"Mode",
"Enable"
}
local FP_OBJNAME3 = "OBJ_NETSPHERE_BANDSTEER_ID";
local PARA3 =
{
"BandSteerEnable"
}
local FP_ACTION = cgilua.POST.IF_ACTION
local FP_IDENTITY = cgilua.POST._InstID
InstXML, tError = ManagerOBJ(FP_OBJNAME, FP_ACTION, FP_IDENTITY, PARA, tError)
InstXML3, tError = ManagerOBJ(FP_OBJNAME3, FP_ACTION, FP_IDENTITY, PARA3, tError)
ErrorXML = outputErrorXML(tError)
OutXML = ErrorXML .. InstXML .. InstXML1 .. InstXML2 .. InstXML3
outputXML(OutXML)
