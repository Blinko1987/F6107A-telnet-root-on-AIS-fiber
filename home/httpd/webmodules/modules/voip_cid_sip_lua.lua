require "data_assemble.common_lua"
local FP_ACTION = cgilua.cgilua.POST.IF_ACTION
local FP_IDENTITY = cgilua.cgilua.POST._InstID_CIDSIP
local FP_SIPIDENTITY = cgilua.cgilua.POST._InstID
local OutXML = ""
local ErrorXML = ""
local InstXML_DTMF = ""
local ErrorXML_DTMF = ""
local tError_DTMF = nil
local FP_OBJNAME_DTMF = "OBJ_VOIPDTMF_ID"
local PARA_DTMF =
{
"ViewName",
"CIDMode",
"TimeEnable",
"CallerNameAsCIDNumber",
"ETSICallIDStandard",
"FskFrameType"
}
InstXML_DTMF, tError_DTMF = ManagerOBJ(FP_OBJNAME_DTMF, FP_ACTION, FP_IDENTITY, PARA_DTMF, nil, nil, nil)
ErrorXML_DTMF = outputErrorXML(tError_DTMF)
local InstXML_VoipBase = ""
local ErrorXML_VoipBase = ""
local tError_VoipBase = nil
local FP_OBJNAME_VoipBase = "OBJ_VOIPSIP_ID"
local PARA_VoipBase =
{
"PAssertedID"
}
InstXML_VoipBase, tError_VoipBase = ManagerOBJ(FP_OBJNAME_VoipBase, FP_ACTION, FP_SIPIDENTITY, PARA_VoipBase, nil, nil, nil)
ErrorXML_VoipBase = outputErrorXML(tError_VoipBase)
if tError_DTMF.IF_ERRORID ~= 0 then
ErrorXML = ErrorXML_DTMF
elseif tError_VoipBase.IF_ERRORID ~= 0 then
ErrorXML = ErrorXML_VoipBase
else
ErrorXML = ErrorXML_DTMF
end
OutXML = InstXML_DTMF .. InstXML_VoipBase .. ErrorXML
outputXML(OutXML)
