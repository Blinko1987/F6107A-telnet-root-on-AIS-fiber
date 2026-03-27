require "data_assemble.common_lua"
local InstXML = ""
local ErrorXML = ""
local OutXML = ""
local tError = nil
local FP_OBJNAME = "OBJ_FWIP_ID"
local PARA =
{
"ViewName",
"Enable",
"Protocol",
"Name",
"INCViewName",
"OUTCViewName",
"IPVersion",
"SourceIP",
"SourceIPMask",
"DestIP",
"DestIPMask",
"MinSrcPort",
"MaxSrcPort",
"MinDstPort",
"MaxDstPort",
"FilterTarget",
"FilterIndex",
"DSCP"
}
local FP_ACTION = cgilua.cgilua.POST.IF_ACTION
local FP_IDENTITY = cgilua.cgilua.POST._InstID
if FP_IDENTITY == "-1" then
FP_IDENTITY = "";
end
InstXML,tError = ManagerOBJ(FP_OBJNAME, FP_ACTION, FP_IDENTITY, PARA, tError, {xmlType = 1})
ErrorXML = outputErrorXML(tError)
OutXML = ErrorXML .. InstXML
outputXML(OutXML)
