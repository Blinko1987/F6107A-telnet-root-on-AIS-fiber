require "data_assemble.common_lua"
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
local function preProcessInstData(tResult, i)
local ipv6Addr = tResult["IPV6Address"..i]
tResult["IPV6Address"..i] = dealIPv6Addr(ipv6Addr)
return true
end
function getQueryTable()
local queryCondition = {["InterfaceType"]="Ethernet"}
local instNum = cgilua.cgilua.QUERY.InstNum
if instNum then
queryCondition["InstNum"] = instNum
else
queryCondition["InstNum"] = nil
end
return queryCondition
end
local FP_OBJNAME = "OBJ_ACCESSDEV_ID"
local tError, OBJXML = getAllInstXML_MultiGet(FP_OBJNAME, PARA, preProcessInstData, getQueryTable())
local ErrorXML = outputErrorXML(tError)
local OutXML = ErrorXML .. OBJXML
outputXML(OutXML)
