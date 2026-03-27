require "data_assemble.common_lua"
local ErrorXML = ""
local InstXML = ""
local InstXML2 = ""
local OutXML = ""
local tError = nil
local FP_OBJNAME = "OBJ_MGTS_BANDSTEER_ID"
local PARA =
{
"Enable",
"BsRssiLmt24G",
"BsRssiLmt5G",
"BsVhtChk24G",
"BsVhtChk5G",
"BsActiveStaChk24G",
"BsActiveStaChk5G",
"BsStaIdleRateLmt24G",
"BsStaIdleRateLmt5G",
"BsBwUtil24G",
"BsBwUtil5G",
"BsAcceptBwUtil24G",
"BsAcceptBwUtil5G",
"BsAcceptRssi24G",
"BsAcceptRssi5G",
"BsAcceptVhtCheck24G",
"BsAcceptVhtCheck5G",
"BsBounceDetectTimeLmt",
"BsBounceCountsLmt",
"BsBounceDwellTimeLmt"
}
local FP_ENABLE_OBJNAME = "OBJ_BANDSTEER_ENABLE_ID"
local ENABLE_PARA =
{
"EnBandSteer"
}
local FP_PARAM_ACTION, FP_ENABLE_ACTION
local FP_ACTION = cgilua.POST.IF_ACTION
if FP_ACTION == "SET_ENABLES" then
FP_PARAM_ACTION = nil
FP_ENABLE_ACTION = "Apply"
elseif FP_ACTION == "Apply" then
FP_PARAM_ACTION = "Apply"
FP_ENABLE_ACTION = nil
else
FP_PARAM_ACTION = FP_ACTION
FP_ENABLE_ACTION = FP_ACTION
end
local FP_IDENTITY = cgilua.POST._InstID
if not FP_IDENTITY then
FP_IDENTITY = "IGD"
end
local PARAM_IDENTITY = "IGD.WiFi.RD1.BS"
if FP_PARAM_ACTION == "Apply" then
tError = applyOrNewOrDelInst(FP_OBJNAME, FP_PARAM_ACTION, PARAM_IDENTITY ,transToPostTab(PARA))
else
InstXML, tError = getSpecificInstXML(FP_OBJNAME, PARAM_IDENTITY , nil, back, transToFilterTab(PARA))
end
InstXML2, tError = ManagerOBJ(FP_ENABLE_OBJNAME, FP_ENABLE_ACTION, FP_IDENTITY, ENABLE_PARA, tError)
ErrorXML = outputErrorXML(tError)
OutXML = ErrorXML .. InstXML .. InstXML2
outputXML(OutXML)
