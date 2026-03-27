require "data_assemble.common_lua"
local ErrorXML = ""
local InstXML1 = ""
local InstXML2 = ""
local OutXML = ""
local tError = nil
local FP_ACTION = cgilua.cgilua.POST.IF_ACTION
local FP_IDENTITY = cgilua.cgilua.POST._InstID
local IPv6IP_OBJNAME = "OBJ_LANADDR6_ID";
local IPv6IP_PARA =
{
"IPAddress",
}
InstXML, tError = ManagerOBJ(IPv6IP_OBJNAME, FP_ACTION, FP_IDENTITY, IPv6IP_PARA, nil, nil, nil, "DEV")
ErrorXML = outputErrorXML(tError)
OutXML = ErrorXML .. InstXML
outputXML(OutXML)
