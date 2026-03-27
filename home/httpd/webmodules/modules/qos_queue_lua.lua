require "data_assemble.common_lua"
local ErrorXML = ""
local InstXML = ""
local InstXMLTMP = ""
local OutXML = ""
local tError = nil
local need2Get = 1
local FP_OBJNAME = "OBJ_QOSQQ_ID";
local ReturnIdentity = "";
local PARA =
{
"Alias",
"Enable",
"TrafficClasses",
"QueueInterface",
"DefaultQueue",
"NeedStats",
"SchedulerAlgorithm",
"Weight",
"QueueNum",
"ShapingRate"
};
local FP_ACTION = cgilua.cgilua.POST.IF_ACTION
local FP_IDENTITY = cgilua.cgilua.POST._InstID
if FP_IDENTITY == "-1" then
FP_IDENTITY = ""
end
local InterfaceFilter = cgilua.cgilua.QUERY.InterfaceFilter
if InterfaceFilter == nil then
InterfaceFilter = "WAN"
end
InstXML, tError = ManagerOBJ(FP_OBJNAME, FP_ACTION, FP_IDENTITY, PARA, tError, {xmlType = 2}, nil, InterfaceFilter)
ErrorXML = outputErrorXML(tError)
OutXML = ErrorXML .. InstXML
outputXML(OutXML)
