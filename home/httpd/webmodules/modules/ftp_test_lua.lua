require "data_assemble.common_lua"
local ErrorXML = ""
local InstXML = ""
local OutXML = ""
local tError = nil
local need2Get = 1
local FP_OBJNAME = "OBJ_FTPTEST_ID"
local PARA =
{
"IPAddress",
"Port",
"UserName",
"Password",
"FilePath",
"Ratio",
"Abbrevsize",
"Remaining",
"ReceivedBytes",
"Pastseconds",
"ByteSec",
"Curfile",
"Flag"
}
local para_table = {}
para_table.para = PARA
para_table.encrypt = {"Password"}
local FP_ACTION = cgilua.cgilua.POST.IF_ACTION
local FP_IDENTITY = cgilua.cgilua.POST._InstID
local FP_STOPOBJNAME = "OBJ_FTPCONTROL_ID"
local STOP_PARA = {
"Control"
}
if FP_ACTION == "STOP" then
local setData = {["Control"] = 0}
tError = cmapi.setinst("OBJ_FTPCONTROL_ID", "IGD", setData)
else
InstXML, tError = ManagerOBJ(FP_OBJNAME, FP_ACTION, FP_IDENTITY, para_table, tError, nil, nil)
end
ErrorXML = outputErrorXML(tError)
OutXML = ErrorXML .. InstXML
outputXML(OutXML)
