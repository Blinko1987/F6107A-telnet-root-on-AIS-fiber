require "data_assemble.common_lua"
local ErrorXML = ""
local InstXML = ""
local OutXML = ""
local tError = nil
local FP_OBJNAME_LOS = "OBJ_LOS_INFO_ID"
local PARA_LOS =
{
"LosInfo"
}
InstXML_LOS, tError = getAllInstXML(FP_OBJNAME_LOS, "IGD", nil, nil,transToFilterTab(PARA_LOS))
local FP_OBJNAME_ONUID = "OBJ_PONONUID_ID"
local PARA_ONUID =
{
"OnuId"
}
InstXML_ONUID, tError = getAllInstXML(FP_OBJNAME_ONUID, "IGD", nil, nil,transToFilterTab(PARA_ONUID))
local FP_OBJNAME_REG = "OBJ_GPONREGSTATUS_ID"
local PARA_REG =
{
"RegStatus"
}
InstXML_REG, tError = getAllInstXML(FP_OBJNAME_REG, "IGD", nil, nil,transToFilterTab(PARA_REG))
local FP_OBJNAME_CATV = "OBJ_PON_CATV_ID"
local PARA_CATV =
{
"CatvEnable"
}
InstXML_CATV, tError = getAllInstXML(FP_OBJNAME_CATV, "IGD", nil, nil,transToFilterTab(PARA_CATV))
local FP_OBJNAME_TIME = "OBJ_PON_POWERONTIME_ID"
local PARA_TIME =
{
"PONOnTime"
}
InstXML_TIME, tError_Time = getAllInstXML(FP_OBJNAME_TIME, "IGD", nil, nil,transToFilterTab(PARA_TIME))
if tError_Time.IF_ERRORID ~= 0 then
ErrorXML = outputErrorXML(tError_Time)
end
local FP_OBJNAME = "OBJ_PON_OPTICALPARA_ID"
local PARA =
{
"Volt",
"RxPower",
"TxPower",
"Temp",
"Current",
"RFTxPower",
"VideoRxPower"
}
local function setValueCallback(tbl)
tbl.RxPower = tbl.RxPower/10000;
tbl.TxPower = tbl.TxPower/10000;
tbl.Current = tbl.Current/1000;
tbl.Temp = tbl.Temp/1000;
tbl.RFTxPower = tbl.RFTxPower/10000 - 60;
tbl.VideoRxPower = tbl.VideoRxPower/10000 - 30;
if env.getenv("CountryCode") == "131" then
tbl.Volt = tbl.Volt/1000;
end
return true
end
InstXML, tError = getAllInstXML(FP_OBJNAME, "IGD", nil, setValueCallback,transToFilterTab(PARA))
ErrorXML = outputErrorXML(tError)
OutXML = ErrorXML .. InstXML .. InstXML_LOS .. InstXML_ONUID .. InstXML_REG .. InstXML_CATV.. InstXML_TIME
outputXML(OutXML)
