require "data_assemble.common_lua"
local InstXML = ""
local ErrorXML = ""
local OutXML = ""
local tError = nil
local FP_OBJNAME = "OBJ_VoiceDiagnosisE_ID"
local PARA =
{
"RegStatus"
}
local FP_ACTION = cgilua.cgilua.POST.IF_ACTION
local FP_IDENTITY = cgilua.cgilua.POST._InstID
local function callback(t)
if t.RegStatus == "200" then
t.RegStatus = "Pass"
elseif t.RegStatus == "401" then
t.RegStatus = lang.voipdiag_05
elseif t.RegStatus == "403" then
t.RegStatus = lang.voipdiag_06
elseif t.RegStatus == "404" then
t.RegStatus = lang.voipdiag_07
elseif t.RegStatus == "408" then
t.RegStatus = lang.voipdiag_08
elseif t.RegStatus == "503" then
t.RegStatus = lang.voipdiag_09
else
t.RegStatus = lang.voipdiag_10
end
return true
end
InstXML, tError = ManagerOBJ(FP_OBJNAME, FP_ACTION, FP_IDENTITY, PARA, tError, nil, callback)
ErrorXML = outputErrorXML(tError)
OutXML = ErrorXML .. InstXML
outputXML(OutXML)
