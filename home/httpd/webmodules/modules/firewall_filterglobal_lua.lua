require "data_assemble.common_lua"
local ErrorXML = ""
local InstXML1 = ""
local InstXML2 = ""
local InstXML_Ipfilter = ""
local OutXML = ""
local tError = nil
local FP_ACTION = cgilua.cgilua.POST.IF_ACTION
local FireWall_OBJNAME = "OBJ_FWLEVEL_ID"
local FireWall_PARA =
{
"Enable",
"Level"
}
local MacUrlFiler_OBJNAME = "OBJ_FWBASE_ID"
local MacUrlFiler_PARA =
{
"MacFilterTarget",
"MacFilterEnable",
"UrlFilterTarget",
"UrlFilterEnable",
}
local FP_IDENTITY = ""
InstXML2,tError = ManagerOBJ(MacUrlFiler_OBJNAME, FP_ACTION, FP_IDENTITY, MacUrlFiler_PARA, tError)
ErrorXML = outputErrorXML(tError)
OutXML = ErrorXML .. InstXML_Ipfilter..InstXML2
outputXML(OutXML)
