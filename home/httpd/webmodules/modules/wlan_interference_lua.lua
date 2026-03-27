require "data_assemble.common_lua"
local ErrorXML = ""
local InstXML = ""
local OutXML = ""
local tError = nil
local WLanInterference_OBJNAME = "OBJ_WLAN_INTERFERENCE_ID"
local WLanInterference_PARA =
{
"Active",
"StartTime",
"EndTime",
"PeriodTime"
}
local WLanInterferencestartup_OBJNAME = "OBJ_WLAN_INTERFERENCE_STARTUP_ID"
local FP_ACTION = cgilua.POST.IF_ACTION
local FP_IDENTITY = cgilua.cgilua.POST._InstID
if FP_IDENTITY == "-1" then
FP_IDENTITY = ""
end
InstXML, tError = ManagerOBJ(WLanInterference_OBJNAME, FP_ACTION, FP_IDENTITY, WLanInterference_PARA, nil, nil, nil, "DEV")
if FP_ACTION == "startup" then
tError = cmapi.getinst(WLanInterferencestartup_OBJNAME, "")
end
ErrorXML = outputErrorXML(tError)
OutXML = ErrorXML .. InstXML
outputXML(OutXML)
