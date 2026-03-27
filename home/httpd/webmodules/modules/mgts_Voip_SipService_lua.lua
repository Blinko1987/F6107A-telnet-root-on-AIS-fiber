require "data_assemble.common_lua"
local FP_ACTION = cgilua.cgilua.POST.IF_ACTION
local FP_IDENTITY = cgilua.cgilua.POST._InstID_CALLFEA
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
"AuthUserName",
"DigestUserName"
}
InstXML_VoipBase, tError_VoipBase =getAllInstXML( FP_OBJNAME_VoipBase, "IGD", nil, nil,transToFilterTab(PARA_VoipBase))
ErrorXML_VoipBase = outputErrorXML(tError_VoipBase)
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
"ReAccessIfPeerHookedOn"
}
InstXML_CALLFEA, tError_CALLFEA = ManagerOBJ(FP_OBJNAME_CALLFEA, FP_ACTION, FP_IDENTITY, PARA_CALLFEA, nil, nil, nil)
ErrorXML_CALLFEA = outputErrorXML(tError_CALLFEA)
local InstXML_VP = ""
local ErrorXML_VP = ""
local tError_VP = nil
local FP_OBJNAME_VP = "OBJ_VOIPVPLINE_ID"
local PARA_VP =
{
"Enable",
"DirectoryNumber"
}
InstXML_VP, tError_VP =getAllInstXML( FP_OBJNAME_VP, "IGD", nil, nil,transToFilterTab(PARA_VP))
ErrorXML_VP = outputErrorXML(tError_VP)
if tError_CALLTIMER.IF_ERRORID ~= 0 then
ErrorXML = ErrorXML_CALLTIMER
elseif tError_VoipBase.IF_ERRORID ~= 0 then
ErrorXML = ErrorXML_VoipBase
elseif tError_CALLFEA.IF_ERRORID ~= 0 then
ErrorXML = ErrorXML_CALLFEA
else
ErrorXML = ErrorXML_VP
end
OutXML = InstXML_CALLTIMER .. InstXML_VoipBase .. InstXML_CALLFEA .. InstXML_VP .. ErrorXML
outputXML(OutXML)
