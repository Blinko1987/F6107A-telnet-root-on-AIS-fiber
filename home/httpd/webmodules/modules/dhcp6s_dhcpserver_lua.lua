require "data_assemble.common_lua"
local ErrorXML = ""
local InstXML = ""
local InstXML1 = ""
local OutXML = ""
local tError = nil
local IPv6Server_OBJNAME = "OBJ_DHCP6S_ID";
local IPv6Server_PARA =
{
"Enable",
"DnsRefreshTime",
"IANAEnable",
"IsPrefixAutoMode",
"IANAManualPrefixes",
"ManualDNSEnable",
"DNSAddr1",
"DNSAddr2",
"DNSAddr3",
}
local FP_OBJNAME1 = "OBJ_LANDNS_ID"
local PARA1 ={
"Ipv4DnsOrigin",
"Ipv6DnsOrigin",
"IPv4AssignLANIP",
"IPv6AssignLANIP"
}
local FP_ACTION = cgilua.cgilua.POST.IF_ACTION
local FP_IDENTITY = cgilua.cgilua.POST._InstID
if FP_IDENTITY == nil then
FP_IDENTITY = ""
end
local FP_IDENTITY1 = cgilua.cgilua.POST._InstID_DNS
if FP_IDENTITY1 == nil then
FP_IDENTITY1 = ""
end
local DNSAddrArray = {"DNSAddr1","DNSAddr2","DNSAddr3"}
for i,j in ipairs(DNSAddrArray) do
if cgilua.cgilua.POST.ManualDNSEnable == "0" then
cgilua.cgilua.POST[j] = nil
else
if cgilua.cgilua.POST[j] and cgilua.cgilua.POST[j] == "" then
cgilua.cgilua.POST[j] = "::"
end
end
end
function OnlyKeepFstInst(tbl, InstID)
if InstID == "DEV.DHCP6SPool1" then
for i,j in ipairs(DNSAddrArray) do
if tbl[j] == "::" then
tbl[j] = ""
end
end
return true
end
return false
end
InstXML, tError = ManagerOBJ(IPv6Server_OBJNAME, FP_ACTION, FP_IDENTITY, IPv6Server_PARA, tError, {xmlType = 2}, OnlyKeepFstInst, "DEV")
InstXML1, tError = ManagerOBJ(FP_OBJNAME1, FP_ACTION, FP_IDENTITY1, PARA1,tError)
ErrorXML = outputErrorXML(tError)
OutXML = ErrorXML .. InstXML .. InstXML1
outputXML(OutXML)
