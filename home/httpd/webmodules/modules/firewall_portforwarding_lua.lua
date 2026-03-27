require "data_assemble.common_lua"
local ErrorXML = ""
local InstXML = ""
local OutXML = ""
local tError = nil
local FP_OBJNAME = "OBJ_FWPM_ID"
local PARA =
{
"Interface",
"AllInterface",
"Enable",
"Protocol",
"Alias",
"ExternalPort",
"ExternalPortEndRange",
"InternalClient",
"InternalPort",
"InternalPortEndRange",
"RemoteHost",
"RemoteHostEndRange",
"Description"
}
local FP_ACTION = cgilua.cgilua.POST.IF_ACTION
local FP_IDENTITY = cgilua.cgilua.POST._InstID
if FP_IDENTITY == "-1" then
FP_IDENTITY = ""
end
InstXML, tError = ManagerOBJ(FP_OBJNAME, FP_ACTION, FP_IDENTITY, PARA, nil, {xmlType = 1}, nil,"DEV")
ErrorXML = outputErrorXML(tError)
OutXML = ErrorXML .. InstXML
outputXML(OutXML)
