require "data_assemble.common_lua"
local InstXML = ""
local ErrorXML = ""
local OutXML = ""
local tError = {
IF_ERRORID = 0,
IF_ERRORTYPE = "SUCC",
IF_ERRORSTR = "SUCC",
IF_ERRORPARAM = "SUCC"
}
local PPPOE_GET_OBJNAME = "OBJ_SIMULATION_PPPOE_GET_ID"
local PPPOE_GET_PARA =
{
"PortViewName",
"PortState",
"SimulationType",
"Issucceed",
"SimuGateWay",
"SimuIp",
"FailReason",
"RetryTimes",
"AuthType",
"SessionID",
"UserName",
"PassWord",
"OptLen",
"OptContent",
"Opt60Mode",
"PingDestIP",
"PingTimes",
"PingTimeOut",
"PingSuccessCount",
"PingFailCount",
"PingResTimeMax",
"PingResTimeMin",
"PingResTimeAver",
"IPMode",
"AuthCode",
"IPv6IPAddress",
"IPv6DNSAddress",
"DefaultIPv6Gateway",
"SimuMAC"
}
local PPPOE_SET_OBJNAME = "OBJ_SIMULATION_PPPOE_ID"
local PPPOE_SET_PARA =
{
"PortViewName",
"UseVlan",
"VlanId",
"VlanPri",
"AuthType",
"PppoeUserName",
"PppoePassWord",
"IPMode",
"RetryTimes"
}
local para_table = {}
para_table.para = PPPOE_SET_PARA
para_table.encrypt = {"PppoePassWord"}
local DHCP_GET_OBJNAME = "OBJ_SIMULATION_DHCP_GET_ID"
local DHCP_GET_PARA = PPPOE_GET_PARA
local DHCP_SET_OBJNAME = "OBJ_SIMULATION_DHCP_ID"
local DHCP_SET_PARA =
{
"PortViewName",
"UseVlan",
"VlanId",
"VlanPri",
"SimuMAC",
"SimuTimeOut",
"OptCode",
"OptLen",
"OptContent",
"UserNameOpt60",
"PassWordOpt60",
"BNeedPing",
"BNeedRelease",
"PingDestIP",
"PingTimes",
"PingTimeOut",
"Opt60Mode"
}
local simulationType = cgilua.cgilua.POST.SimulationType
if simulationType == "" or simulationType == nil then
simulationType = "1";
end
local FP_ACTION = cgilua.cgilua.POST.IF_ACTION
if FP_ACTION == "PPPoE_APPLY" then
tError = cmapi.setinst(PPPOE_SET_OBJNAME, "", transToPostTab(para_table))
elseif FP_ACTION == "DHCP_APPLY" then
tError = cmapi.setinst(DHCP_SET_OBJNAME, "", transToPostTab(DHCP_SET_PARA))
elseif FP_ACTION == "PPPoE_DEL" then
tError = cmapi.delinst(PPPOE_SET_OBJNAME, "")
elseif FP_ACTION == "DHCP_DEL" then
tError = cmapi.delinst(DHCP_SET_OBJNAME, "")
end
cmapi.undoDBSave()
local function callback(t)
t.PassWord = "******"
return true
end
if tError.IF_ERRORID == 0 then
if simulationType == "1" then
InstXML, tError = getSpecificInstXML(PPPOE_GET_OBJNAME, "", tError, callback, transToFilterTab(PPPOE_GET_PARA))
else
InstXML, tError = getSpecificInstXML(DHCP_GET_OBJNAME, "", tError, callback, transToFilterTab(DHCP_GET_PARA))
end
end
ErrorXML = outputErrorXML(tError)
OutXML = ErrorXML .. InstXML
outputXML(OutXML)
