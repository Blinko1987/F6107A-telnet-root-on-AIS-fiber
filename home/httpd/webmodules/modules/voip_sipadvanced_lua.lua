require "data_assemble.common_lua"
local InstXML = ""
local InstXMLTMP = ""
local ErrorXML = ""
local OutXML = ""
local need2Get = 1
local tError = nil
local FP_ACTION = cgilua.cgilua.POST.IF_ACTION
local FP_IDENTITY = cgilua.cgilua.POST._InstID
if FP_IDENTITY == "-1" then
FP_IDENTITY = ""
end
if FP_IDENTITY ~= nil then
print("###################FP_IDENTITY=" .. FP_IDENTITY)
end
local FP_IDENTITYRTP
if FP_IDENTITY == "IGD.SV.VS1.VP1" then
FP_IDENTITYRTP = "IGD.SV.VS1.VP1.VR"
end
if FP_IDENTITY == "IGD.SV.VS1.VP2" then
FP_IDENTITYRTP = "IGD.SV.VS1.VP2.VR"
end
if FP_IDENTITY =="" then
FP_IDENTITYRTP = ""
end
local ADV_OBJNAME = "OBJ_VRTPADV_ID"
local ADV_PARA =
{
"JitMode",
"FixedJitLen",
"AdaptJitMin",
"AdaptJitMax"
}
local DTMF_OBJNAME = "OBJ_VOIPVPDTMF_ID"
local DTMF_PARA =
{
"DTMFMethod",
}
local FAD_OBJNAME = "OBJ_VOIPDTMFAD_ID"
local FAD_PARA =
{
"RFC2833EncryptEnable",
}
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
tError = ActionOneOBJ(ADV_OBJNAME, ADV_PARA, tError, FP_ACTION, FP_IDENTITYRTP)
tError = ActionOneOBJ(DTMF_OBJNAME, DTMF_PARA, tError, FP_ACTION, FP_IDENTITY)
tError = ActionOneOBJ(FAD_OBJNAME, FAD_PARA, tError, FP_ACTION, FP_IDENTITY)
end
local InstXML1 = ""
local InstXML2 = ""
local InstXML3 = ""
if FP_ACTION == "Cancel" then
need2Get = 0
InstXML1, tError = getSpecificInstXML(ADV_OBJNAME, FP_IDENTITYRTP, nil, callback, transToFilterTab(t_PARA))
InstXML2, tError = getSpecificInstXML(DTMF_OBJNAME, FP_IDENTITY, nil, callback, transToFilterTab(t_PARA))
InstXML3, tError = getSpecificInstXML(FAD_OBJNAME, FP_IDENTITY, nil, callback, transToFilterTab(t_PARA))
InstXML = InstXML1 .. InstXML2 .. InstXML3
end
if need2Get == 1 then
InstXMLTMP, tError = getAllInstXML(ADV_OBJNAME, "IGD", tError, nil, transToFilterTab(ADV_PARA))
InstXML = InstXML .. InstXMLTMP
InstXMLTMP, tError = getAllInstXML(DTMF_OBJNAME, "IGD", tError, nil, transToFilterTab(DTMF_PARA))
InstXML = InstXML .. InstXMLTMP
InstXMLTMP, tError = getAllInstXML(FAD_OBJNAME, "IGD", tError, nil, transToFilterTab(FAD_PARA))
InstXML = InstXML .. InstXMLTMP
end
ErrorXML = outputErrorXML(tError)
OutXML = ErrorXML .. InstXML
outputXML(OutXML)
