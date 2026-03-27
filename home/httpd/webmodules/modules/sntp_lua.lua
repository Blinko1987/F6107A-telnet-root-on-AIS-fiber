require "data_assemble.common_lua"
local ErrorXML = ""
local InstXML = ""
local OutXML = ""
local tError = nil
local FP_OBJNAME = "OBJ_SNTP_ID"
local PARA =
{
"NtpServer1",
"NtpServer2",
"NtpServer3",
"NtpServer4",
"NtpServer5",
"CurrentLocalTime",
"DaylightSavingsUsed",
"PollTimeInterval",
"Dscp",
"ZoneIndex",
"AutoSetTzname",
"NtpConfigPermission",
"SntpBindWanName",
"Enable",
}
local FP_ACTION = cgilua.cgilua.POST.IF_ACTION
local FP_IDENTITY = cgilua.cgilua.POST._InstID
InstXML, tError = ManagerOBJ(FP_OBJNAME, FP_ACTION, FP_IDENTITY, PARA, nil, {xmlType= 2, retCheck = 2})
ErrorXML = outputErrorXML(tError)
OutXML = ErrorXML .. InstXML
outputXML(OutXML)
