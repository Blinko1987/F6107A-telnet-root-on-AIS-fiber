require "data_assemble.common_lua"
local ErrorXML = ""
local InstXML = ""
local InstXML1 = ""
local OutXML = ""
local tError = nil
local FP_OBJNAME = "OBJ_WWANPINCFG_ID"
local PARA =
{
"DevIndex",
"Flag",
"PinStatus",
"SimStatus",
"SimPin",
"SimNewPin",
"RemPin",
"PinRemain",
"SimPinOP",
"PukRemain",
"SimPuk"
}
local FP_ACTION = cgilua.cgilua.POST.IF_ACTION
local FP_IDENTITY = cgilua.cgilua.POST._InstID
if FP_IDENTITY == "-1" then
FP_IDENTITY = ""
end
local wwanCommFunc = require "modules.wwan_common_func"
local DongleStatus
DongleStatus = wwanCommFunc.QueryDongleCardStatus()
InstXML1 = getXMLNodeEntity("DongleStatus", DongleStatus)
InstXML, tError = ManagerOBJ(FP_OBJNAME, FP_ACTION, FP_IDENTITY, PARA)
cmapi.undoDBSave()
ErrorXML = outputErrorXML(tError)
OutXML = ErrorXML .. InstXML1 .. InstXML
outputXML(OutXML)
