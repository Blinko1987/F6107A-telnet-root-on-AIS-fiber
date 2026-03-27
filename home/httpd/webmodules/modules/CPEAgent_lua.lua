require "data_assemble.common_lua"
local ErrorXML = ""
local InstXML = ""
local OutXML = ""
local tError = nil
local Agent_OBJNAME = "OBJ_WIFIAGENT_ID"
local Agent_PARA =
{
"FirstServerEnable",
"FirstServer",
"FirstIntervalTime",
"SecondServerEnable",
"SecondServer",
"SecondIntervalTime",
"ImmediatelySend",
"FirstServerStat",
"SecondServerStat",
"ImmediatelySendStat",
"SecretKeyVersion",
"SecretKey"
}
local FP_ACTION = cgilua.POST.IF_ACTION
local FirstEnable = cgilua.POST.FirstServerEnable
local SecondEnable = cgilua.POST.SecondServerEnable
local ImmediatelyEnable = cgilua.POST.ImmediatelySend
if FP_ACTION == "Apply" then
if ImmediatelyEnable == nil then
if FirstEnable == nil then
cgilua.POST.FirstServerEnable = "0"
end
if SecondEnable == nil then
cgilua.POST.SecondServerEnable = "0"
end
end
end
InstXML, tError = ManagerOBJ(Agent_OBJNAME, FP_ACTION, "IGD", Agent_PARA, tError, {xmlType = 2} )
ErrorXML = outputErrorXML(tError)
OutXML = ErrorXML .. InstXML
outputXML(OutXML)
