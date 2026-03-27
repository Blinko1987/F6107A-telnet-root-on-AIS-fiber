require "data_assemble/common_lua"
local ErrorXML = ""
local InstXML
local OutXML = ""
local tResult
local need2Get = 1
local FP_FW_ACTION = cgilua.cgilua.POST.FW_ACTION
local FP_IDENTITY = ""
local tErr = nil
local PARA =
{
"Level",
"AntiAttack"
}
if FP_FW_ACTION == "Apply" then
tResult = applyOrNewOrDelInst("OBJ_FWLEVEL_ID", FP_FW_ACTION, FP_IDENTITY,transToPostTab(PARA))
end
if need2Get == 1 then
InstXML, tResult = getAllInstXML("OBJ_FWLEVEL_ID", FP_IDENTITY, tResult, nil, transToFilterTab(PARA))
end
ErrorXML = outputErrorXML(tResult)
OutXML = ErrorXML .. InstXML
outputXML(OutXML)
