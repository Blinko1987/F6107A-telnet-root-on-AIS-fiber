require "data_assemble.common_lua"
local ErrorXML = ""
local InstXML1 = ""
local InstXML2 = ""
local OutXML = ""
local tError = nil
local FP_OBJNAME_IGMPPROXYC = "OBJ_IGMPPROXYC_ID"
local PARA_IGMPPROXYC =
{
"ProxyEnable",
}
local FP_OBJNAME_IGMPSNOOPING = "OBJ_IGMPBASIC_ID"
local PARA_IGMPSNOOPING =
{
"IgmpMode",
"Agtime"
};
local FP_ACTION = cgilua.cgilua.POST.IF_ACTION
local FP_IDENTITY = ""
InstXML1, tError = ManagerOBJ(FP_OBJNAME_IGMPPROXYC, FP_ACTION, FP_IDENTITY, PARA_IGMPPROXYC)
InstXML2, tError = ManagerOBJ(FP_OBJNAME_IGMPSNOOPING, FP_ACTION, FP_IDENTITY, PARA_IGMPSNOOPING, tError)
ErrorXML = outputErrorXML(tError)
OutXML = ErrorXML .. InstXML1 .. InstXML2
outputXML(OutXML)
