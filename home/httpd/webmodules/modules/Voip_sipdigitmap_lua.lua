require "data_assemble.common_lua"
local ErrorXML = ""
local InstXML = ""
local OutXML = ""
local tError = nil
local FP_OBJNAME = "OBJ_VOIPVOICEPROFILE_ID"
local PARA =
{
"DigitMap"
}
local FP_ACTION = cgilua.cgilua.POST.IF_ACTION
local FP_IDENTITY = cgilua.cgilua.POST._InstID
InstXML, tError = ManagerOBJ(FP_OBJNAME, FP_ACTION, FP_IDENTITY, PARA, tError, nil)
ErrorXML = outputErrorXML(tError)
local InstXML_DMTTIMER = ""
local ErrorXML_DMTTIMER = ""
local tError_DMTTIMER = nil
local FP_OBJNAME_DMTTIMER = "OBJ_VOIPDMTIMER_ID"
local PARA_DMTTIMER =
{
"ShortTimer",
"LongTimer"
}
if _G.commConf.voipMap == true then
local FP_IDENTITY_TIMER = cgilua.cgilua.POST._InstID_timer
InstXML_DMTTIMER, tError_DMTTIMER = ManagerOBJ(FP_OBJNAME_DMTTIMER, FP_ACTION, FP_IDENTITY_TIMER, PARA_DMTTIMER, tError_DMTTIMER, nil)
ErrorXML_DMTTIMER = outputErrorXML(tError_DMTTIMER)
if tError.IF_ERRORID == 0 and tError_DMTTIMER.IF_ERRORID ~= 0 then
ErrorXML = ErrorXML_DMTTIMER
end
end
OutXML = ErrorXML .. InstXML .. InstXML_DMTTIMER
outputXML(OutXML)
