require "data_assemble.common_lua"
local InstXML = ""
local ErrorXML = ""
local OutXML = ""
local tError = ""
local FP_OBJNAME = "OBJ_FWSC_ID"
local PARA =
{
"Name",
"Enable",
"INCViewName",
"MinSrcIp",
"MaxSrcIp",
"FilterTarget",
"ServiceList",
"IPMode"
}
cgilua.cgilua.POST.IPMode = 1
local FP_ACTION = cgilua.cgilua.POST.IF_ACTION
local FP_IDENTITY = cgilua.cgilua.POST._InstID
if FP_IDENTITY == "-1" then
FP_IDENTITY = ""
end
InstXML, tError = ManagerOBJ(FP_OBJNAME, FP_ACTION, FP_IDENTITY, PARA, nil, {xmlType = 1})
ErrorXML = outputErrorXML(tError)
OutXML = ErrorXML .. InstXML
outputXML(OutXML)
