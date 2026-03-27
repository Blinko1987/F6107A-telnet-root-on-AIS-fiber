require "data_assemble.common_lua"
local ErrorXML = ""
local InstXML = ""
local InstXML1 = ""
local OutXML = ""
local tError = nil
local DONGLE3G_OBJNAME = "OBJ_DONGLE3G_ID";
local DONGLE3G_PARA =
{
"Enable",
"WANCName",
"StrServList",
"ServList",
"TtyPDPType",
"TtyAPN",
"TtyDialNum",
"MTU",
"UserName",
"Password",
"AuthType",
"ConnTrigger",
"IdleTime",
}
local DONGLELTE_OBJNAME = "OBJ_DONGLELTE_ID";
local DONGLELTE_PARA =
{
"Enable",
"WANCName",
"StrServList",
"ServList",
"IsNAT",
}
local FP_ACTION = cgilua.cgilua.POST.IF_ACTION
local FP_IDENTITY = cgilua.cgilua.POST._InstID
if FP_IDENTITY == "-1" then
FP_IDENTITY = ""
end
local strpass = string.format("%c%c%c%c%c%c", 9,9,9,9,9,9)
if strpass == cgilua.cgilua.POST.Password then
cgilua.cgilua.POST.Password = nil
end
local DongleStatus, DevType, DongleType
local wwanCommFunc = require "modules.wwan_common_func"
DongleStatus,DevType,DongleType = wwanCommFunc.QueryDongleCardStatus()
InstXML1 = getXMLNodeEntity("DongleStatus", DongleStatus)
.. getXMLNodeEntity("DevType", DevType)
.. getXMLNodeEntity("DongleType", DongleType)
local function callback(t)
t.Password = nil
return true
end
if DongleStatus ~= "Dev_FAILURE" then
if DongleType == "1" then
InstXML, tError = ManagerOBJ(DONGLE3G_OBJNAME, FP_ACTION, FP_IDENTITY, DONGLE3G_PARA, nil, {xmlType = 1}, callback)
else
InstXML, tError = ManagerOBJ(DONGLELTE_OBJNAME, FP_ACTION, FP_IDENTITY, DONGLELTE_PARA, nil, {xmlType = 1}, callback)
end
else
tError = {
IF_ERRORID = 0,
IF_ERRORTYPE = "SUCC",
IF_ERRORSTR = "SUCC",
IF_ERRORPARAM = "SUCC"
}
end
ErrorXML = outputErrorXML(tError)
OutXML = ErrorXML .. InstXML1 .. InstXML
outputXML(OutXML)
