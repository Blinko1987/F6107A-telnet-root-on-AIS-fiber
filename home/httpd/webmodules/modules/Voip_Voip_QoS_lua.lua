require "data_assemble.common_lua"
local ErrorXML = ""
local InstXML = ""
local InstXMLTMP = ""
local OutXML = ""
local need2Get = 1
local tError = nil
local FP_OBJQOSSignal = ""
local voipProtocol = env.getenv("VoIPProtocal")
if voipProtocol == "SIP" then
FP_OBJQOSSignal = "OBJ_VOIPSIP_ID"
else
FP_OBJQOSSignal = "OBJ_VOIPH248MAIN_ID"
end
local PARA =
{
"DSCPMarkSignalling",
"EthernetPriorityMark"
}
local FP_ACTION = cgilua.cgilua.POST.IF_ACTION
local FP_IDENTITY = cgilua.cgilua.POST._InstID
function ActionOneOBJ(OBJNAME, PARA_TAB, err, ActionType, FP_IDENTITY)
if type(err) == "table" and err.IF_ERRORID ~= 0 then
return err
end
local t_Data = {}
for j, k in pairs(PARA_TAB) do
t_Data[k] = cgilua.cgilua.POST[k]
end
err = applyOrNewOrDelInst(OBJNAME, ActionType, FP_IDENTITY, t_Data, err)
return err
end
if FP_ACTION == "Apply" then
need2Get = 0
tError = ActionOneOBJ(FP_OBJQOSSignal, PARA, tError, FP_ACTION, FP_IDENTITY)
end
local InstXML1 = ""
if FP_ACTION == "Cancel" then
need2Get = 0
InstXML1, tError = getSpecificInstXML(FP_OBJQOSSignal, FP_IDENTITY, nil, callback, transToFilterTab(t_PARA))
InstXML = InstXML1
end
if need2Get == 1 then
InstXMLTMP, tError = getAllInstXML(FP_OBJQOSSignal, "IGD", tError, nil, transToFilterTab(PARA))
InstXML = InstXML .. InstXMLTMP
end
ErrorXML = outputErrorXML(tError)
OutXML = ErrorXML .. InstXML
outputXML(OutXML)
