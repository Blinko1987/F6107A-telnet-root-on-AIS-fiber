require "data_assemble.common_lua"
local function addLuquidPrefixPara(t, i)
t["_LuQUID_MACAddress"..i] = t["MACAddress"..i]
t["_LuQUID_HostName"..i] = t["HostName"..i]
t["_LuQUID_IPAddress"..i] = t["IPAddress"..i]
end
local wlanCommFunc = require "modules.wlan_common_func"
local FilterBySSIDName = wlanCommFunc.getSSIDNameFilter()
local function preProcessInstData_WLAN(tResult, i)
local aliasName = tResult["AliasName"..i]
if FilterBySSIDName(aliasName) then
addLuquidPrefixPara(tResult, i)
return true
end
return false
end
local function preProcessInstData_ETH(tResult, i)
addLuquidPrefixPara(tResult, i)
return true
end
local function preProcessInstData_ALL(tResult, i)
addLuquidPrefixPara(tResult, i)
local aliasName = tResult["AliasName"..i]
local InterfaceType = tResult["InterfaceType"..i]
local Active = tResult["Active"..i]
if Active == "1" then
if InterfaceType == "Ethernet" then
return true
elseif InterfaceType == "802.11"
and FilterBySSIDName(aliasName) then
return true
else
return false
end
else
return false
end
return false
end
local inputArgs = {
ALL={preProcessInstData=preProcessInstData_ALL, queryCondition={}},
ETH={preProcessInstData=preProcessInstData_ETH, queryCondition={["InterfaceType"]="Ethernet"}},
WLAN={preProcessInstData=preProcessInstData_WLAN, queryCondition={["InterfaceType"]="802.11"}},
}
local FP_OBJNAME = "OBJ_ACCESSDEV_ID"
local PARA =
{
"_LuQUID_MACAddress",
"_LuQUID_HostName",
"_LuQUID_IPAddress"
}
local DeveiceType = cgilua.cgilua.QUERY.DeveiceType
local targetArg = inputArgs[DeveiceType]
local preProcessInstData = targetArg["preProcessInstData"]
local queryCondition = targetArg["queryCondition"]
local tError, InstXML = getAllInstXML_MultiGet(FP_OBJNAME, PARA, preProcessInstData, queryCondition)
local ErrorXML = outputErrorXML(tError)
local OutXML = ErrorXML .. InstXML
outputXML(OutXML)
