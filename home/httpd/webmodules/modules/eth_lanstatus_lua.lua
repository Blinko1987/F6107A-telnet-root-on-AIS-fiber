require "data_assemble.common_lua"
local ErrorXML = ""
local InstXML = ""
local OutXML = ""
local tError = nil
local tQuery = nil
local t_PARA =
{
"Status",
"MACAddress",
"BytesReceived",
"BytesSent",
"AliasName"
}
InstXML, tError = getAllInstXML("OBJ_ETH_ID", "IGD.LD1", tError, nil , transToFilterTab(t_PARA))
local IPAddress = ""
local IPv6Addr = ""
tQuery = cmapi.querylist("OBJ_BRGRP_ID", "IGD")
for i, v in ipairs(tQuery) do
local retTable = cmapi.getinst("OBJ_BRGRP_ID", v)
if retTable.IF_ERRORID == 0 then
IPAddress = retTable.IPAddr
if IPAddress == nil or IPAddress=="" then
IPAddress = "0.0.0.0"
end
IPv6Addr = retTable.IPv6Addr
if IPv6Addr == nil or IPv6Addr=="" then
IPv6Addr = "::"
end
break
end
end
IPAddress = encodeXML(IPAddress)
IPv6Addr = encodeXML(IPv6Addr)
local xmlStr = ""
tQuery = cmapi.querylist("OBJ_ETH_ID", "IGD.LD1")
for i, v in ipairs(tQuery) do
local xmlStr2 = ""
xmlStr2 = getParaXMLNodeEntity("_InstID", encodeXML(v))
xmlStr2 = xmlStr2 .. getParaXMLNodeEntity("IPAddress", IPAddress)
xmlStr2 = xmlStr2 .. getParaXMLNodeEntity("IPv6Addr", IPv6Addr)
xmlStr = xmlStr .. getXMLNodeEntity("Instance", xmlStr2)
end
InstXML = InstXML .. getXMLNodeEntity("OBJ_WANLAN_ID", xmlStr)
ErrorXML = outputErrorXML(tError)
OutXML = ErrorXML .. InstXML
outputXML(OutXML)
