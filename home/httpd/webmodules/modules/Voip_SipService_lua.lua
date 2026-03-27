require "data_assemble.common_lua"
local FP_ACTION = cgilua.cgilua.POST.IF_ACTION
local FP_IDENTITY = cgilua.cgilua.POST._InstID
local OutXML = ""
local ErrorXML = ""
local InstXML_CALLTIMER = ""
local ErrorXML_CALLTIMER = ""
local tError_CALLTIMER = nil
local FP_OBJNAME_CALLTIMER = "OBJ_VOIPVPCALLTIMER_ID"
local PARA_CALLTIMER =
{
"CfnrTimer",
"AlertingTimer",
"CallWaitingTimer",
"ProceedingTimer",
"BusyToneTimer",
"HaulToneTimer",
"DhlTimer",
"CallerTimer",
"VoiceMessageTimer"
}
InstXML_CALLTIMER, tError_CALLTIMER = ManagerOBJ(FP_OBJNAME_CALLTIMER, FP_ACTION, "IGD", PARA_CALLTIMER, nil, nil, nil)
ErrorXML_CALLTIMER = outputErrorXML(tError_CALLTIMER)
local InstXML_VoipBase = ""
local ErrorXML_VoipBase = ""
local tError_VoipBase = nil
local FP_OBJNAME_VoipBase = "OBJ_VOIPSIPLINE_ID"
local PARA_VoipBase =
{
"AuthUserName"
}
if FP_ACTION == "Cancel" then
local index = string.gsub(FP_IDENTITY, "LF", "LS")
InstXML_VoipBase, tError_VoipBase = getSpecificInstXML(FP_OBJNAME_VoipBase, index, nil, nil, transToFilterTab(PARA_VoipBase))
else
InstXML_VoipBase, tError_VoipBase = getAllInstXML( FP_OBJNAME_VoipBase, "IGD", nil, nil,transToFilterTab(PARA_VoipBase))
end
ErrorXML_VoipBase = outputErrorXML(tError_VoipBase)
local InstXML_VoipVP = ""
local ErrorXML_VoipVP = ""
local tError_VoipVP = nil
local FP_OBJNAME_VoipVP = "OBJ_VOIPVPLINE_ID"
local PARA_VoipVP =
{
"DirectoryNumber"
}
InstXML_VoipVP, tError_VoipVP = getAllInstXML( FP_OBJNAME_VoipVP, "IGD", nil, nil,transToFilterTab(PARA_VoipVP))
ErrorXML_VoipVP = outputErrorXML(tError_VoipVP)
local InstXML_CALLFEA = ""
local ErrorXML_CALLFEA = ""
local tError_CALLFEA = nil
local FP_OBJNAME_CALLFEA = "OBJ_VOIPVPCALLFEATURE_ID"
local PARA_CALLFEA =
{
"CallWaitingEnable",
"AntiPole",
"CallForwardUnconditionalEnable",
"CallForwardUnconditionalNumber",
"CallForwardOnBusyEnable",
"CallForwardOnBusyNumber",
"CallForwardOnNoAnswerEnable",
"CallForwardOnNoAnswerNumber",
"SoftSwitchUnconditionalEnable",
"SoftSwitchOnBusyEnable",
"SoftSwitchOnNoReachable",
"OneNumber",
"CidDisplayEnable",
"CallerIDEnable",
"CallerIDNameEnable",
"CallerIDName",
"MWIEnable",
"MessageWaiting",
"MCIDEnable",
"CallHoldFlag",
"ThreeWayTalkingBySelf",
"ThreeWayTalkingBySS",
"DoNotDisturbEnable",
"TTYDevice",
"SipDelayHookonFlag",
"HotLine",
"HLDialType",
"HLNumber",
"CallTransfer",
"ConfUri",
"ServInfoReport",
"ReAccessIfPeerHookedOn",
"CallerIDEnable",
"CidDisplayEnable"
}
InstXML_CALLFEA, tError_CALLFEA = ManagerOBJ(FP_OBJNAME_CALLFEA, FP_ACTION, FP_IDENTITY, PARA_CALLFEA, nil, nil, nil)
ErrorXML_CALLFEA = outputErrorXML(tError_CALLFEA)
if tError_CALLTIMER.IF_ERRORID ~= 0 then
ErrorXML = ErrorXML_CALLTIMER
elseif tError_VoipBase.IF_ERRORID ~= 0 then
ErrorXML = ErrorXML_VoipBase
elseif tError_VoipVP.IF_ERRORID ~= 0 then
ErrorXML = ErrorXML_VoipVP
else
ErrorXML = ErrorXML_CALLFEA
end
OutXML = InstXML_CALLTIMER .. InstXML_VoipBase .. InstXML_VoipVP .. InstXML_CALLFEA .. ErrorXML
outputXML(OutXML)
