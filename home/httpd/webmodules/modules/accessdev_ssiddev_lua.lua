require "data_assemble.common_lua"
local ErrorXML = ""
local InstXML = ""
local OutXML = ""
local tError = nil
local PARA =
{
"HostName",
"IPAddress",
"IPV6Address",
"MACAddress",
"AliasName"
}
function dealIPv6Addr(inputStr)
local retStr = Split(inputStr, ";")
for k,v in ipairs(retStr) do
if v ~= "::" then
return v
end
end
return "::"
end
local wlanCommFunc = require "modules.wlan_common_func"
local FilterBySSIDName = wlanCommFunc.getSSIDNameFilter()
local function preProcessInstData(tResult, i)
local paraName = "AliasName"..i
local aliasName = tResult[paraName]
if FilterBySSIDName(aliasName) then
local paraName = "IPV6Address"..i
local ipv6Addr = tResult[paraName]
tResult[paraName] = dealIPv6Addr(ipv6Addr)
return true
end
return false
end
local FP_OBJNAME = "OBJ_ACCESSDEV_ID"
local tError, InstXML = getAllInstXML_MultiGet(FP_OBJNAME, PARA, preProcessInstData, {["InterfaceType"]="802.11"})
ErrorXML = outputErrorXML(tError)
OutXML = ErrorXML .. InstXML
outputXML(OutXML)
