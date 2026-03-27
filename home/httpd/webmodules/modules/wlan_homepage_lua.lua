require "data_assemble.common_lua"
local ErrorXML = ""
local InstXML = ""
local InstXMLTMP = ""
local OutXML = ""
local tError = nil
local need2Get = 1
local PARA =
{
"HostName",
"IPAddress",
"IPV6Address",
"MACAddress"
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
local outputInstCount = 0
local function preProcessInstData(tResult, i)
local isOutPutXML = false
local isBreakLoop = false
local paraName = "AliasName"..i
local aliasName = tResult[paraName]
if FilterBySSIDName(aliasName) then
local paraName = "IPV6Address"..i
local ipv6Addr = tResult[paraName]
tResult[paraName] = dealIPv6Addr(ipv6Addr)
outputInstCount = outputInstCount + 1
isOutPutXML = true
end
local maxNum = cgilua.cgilua.QUERY.InstNum
if maxNum then
maxNum = tonumber(maxNum)
if outputInstCount >= maxNum then
isBreakLoop = true
end
end
return isOutPutXML, isBreakLoop
end
local FP_OBJNAME = "OBJ_ACCESSDEV_ID"
local tError, OBJXML = getAllInstXML_MultiGet(FP_OBJNAME, PARA, preProcessInstData, {["InterfaceType"]="802.11"})
InstXML = InstXML .. OBJXML
local RadioStatusValue = 0
if cmapi.wlanswitch() == 1 then
RadioStatusValue = 1
end
local XMLValue = getParaXMLNodeEntity("RadioSwitch", RadioStatusValue)
local RadioInstXML = "<OBJ_WLANRADIO_ID><Instance>" .. XMLValue .. "</Instance></OBJ_WLANRADIO_ID>"
InstXML = InstXML .. RadioInstXML
ErrorXML = outputErrorXML(tError)
OutXML = ErrorXML .. InstXML
outputXML(OutXML)
