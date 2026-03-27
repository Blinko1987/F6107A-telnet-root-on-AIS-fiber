require "data_assemble.common_lua"
local ErrorXML = ""
local InstXML = ""
local InstXML1 = ""
local OutXML = ""
local tError = nil
local FP_OBJNAME = "OBJ_WWANMOBILEINFO_ID";
local PARA =
{
"SignalStrength",
"MobileName",
"NetWorkMode",
"IMEI",
"MobileAlarm",
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
InstXML, tError = ManagerOBJ(FP_OBJNAME, FP_ACTION, FP_IDENTITY, PARA)
ErrorXML = outputErrorXML(tError)
OutXML = ErrorXML .. InstXML1 .. InstXML
outputXML(OutXML)
