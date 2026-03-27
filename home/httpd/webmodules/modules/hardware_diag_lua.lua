require "data_assemble.json_common_lua"
local OutTbl = {}
local tError = {
IF_ERRORID = 0,
IF_ERRORTYPE = "SUCC",
IF_ERRORSTR = "SUCC",
IF_ERRORPARAM = "SUCC"
}
local objTble = {}
local FP_OBJNAME_LOS = "OBJ_LOS_INFO_ID"
local PARA_LOS =
{
"LosInfo"
}
objTble, tError = getAllInst_json(FP_OBJNAME_LOS, "IGD", tError, nil, transToFilterTab(PARA_LOS))
OutTbl["OBJ_LOS_INFO_ID"] = objTble
local FP_OBJNAME = "OBJ_PON_OPTICALPARA_ID"
local PARA =
{
"RxPower",
"TxPower"
}
objTble, tError = getAllInst_json(FP_OBJNAME, "IGD", tError, nil,transToFilterTab(PARA))
OutTbl["OBJ_PON_OPTICALPARA_ID"] = objTble
local U_PARA =
{
"DevNum"
}
objTble, tError = getAllInst_json("OBJ_USBSTORAGE_ID", "IGD", tError, nil, transToFilterTab(U_PARA))
OutTbl["OBJ_USBSTORAGE_ID"] = objTble
local PARA_ETH =
{
"Status"
}
objTble , tError = getAllInst_json("OBJ_PON_PORT_BASIC_STATUS_ID", "DEV", tError, nil, transToFilterTab(PARA_ETH))
OutTbl["OBJ_PON_PORT_BASIC_STATUS_ID"] = objTble
local PARA_DRV =
{
"RadioStatus"
}
objTble, tError = getAllInst_json("OBJ_WLANSETTING_ID", "IGD", tError, nil, transToFilterTab(PARA_DRV))
OutTbl["OBJ_WLANSETTING_ID"] = objTble
convertErrorStr_json(OutTbl,tError)
outputJson(OutTbl)
