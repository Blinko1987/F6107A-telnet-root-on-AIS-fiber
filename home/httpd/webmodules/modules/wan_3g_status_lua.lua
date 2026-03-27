require "data_assemble.common_lua"
local ErrorXML = ""
local InstXML = ""
local OutXML = ""
local tError = nil
local FP_OBJNAME_MODEM = "OBJ_TTYWANCPPP_ID";
local PARA_MODEM =
{
"WANCName",
"TtyPDPType",
"TtyAPN",
"TtyDialNum",
"IsNAT",
"IPAddress",
"SubnetMask",
"DNS1",
"DNS2",
"DNS3",
"ConnStatus",
"ConnError",
"UpTime"
}
local FP_OBJNAME_ROUTER = "OBJ_TTYROUTERWAN_ID";
local PARA_ROUTER =
{
"WANCName",
"IPAddress",
"SubnetMask",
"DNS1",
"DNS2",
"DNS3",
"GateWay"
}
local FP_ACTION = cgilua.cgilua.POST.IF_ACTION
local FP_IDENTITY = cgilua.cgilua.POST._InstID
if FP_IDENTITY == "-1" then
FP_IDENTITY = ""
end
local DongleStatus, DevType, DongleType
local wwanCommFunc = require "modules.wwan_common_func"
DongleStatus,DevType,DongleType = wwanCommFunc.QueryDongleCardStatus()
InstXML1 = getXMLNodeEntity("DongleStatus", DongleStatus)
.. getXMLNodeEntity("DevType", DevType)
.. getXMLNodeEntity("DongleType", DongleType)
if DongleType == "1" then
InstXML, tError = ManagerOBJ(FP_OBJNAME_MODEM, FP_ACTION, FP_IDENTITY, PARA_MODEM, tError)
elseif DongleType == "2" then
InstXML, tError = ManagerOBJ(FP_OBJNAME_ROUTER, FP_ACTION, FP_IDENTITY, PARA_ROUTER, tError)
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
