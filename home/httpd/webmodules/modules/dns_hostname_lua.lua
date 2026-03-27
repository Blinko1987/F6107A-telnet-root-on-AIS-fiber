require "data_assemble.common_lua"
local ErrorXML = ""
local InstXML = ""
local OutXML = ""
local tError = {
IF_ERRORID = 0,
IF_ERRORTYPE = "SUCC",
IF_ERRORSTR = "SUCC",
IF_ERRORPARAM = "SUCC"
}
local need2Get = 1
local FP_OBJNAMEDhcp = "OBJ_DNSDHCPHOST_ID"
local PARADhcp =
{
"IPAddress",
"HostName",
"MacAddr",
"LeaseTime"
};
local FP_OBJNAMEDns = "OBJ_DNSHOST_ID"
local PARADns =
{
"HostName",
"IPAddress"
};
local FP_ACTION = cgilua.cgilua.POST.IF_ACTION
local FP_IDENTITY = cgilua.cgilua.POST._InstID
local FP_GETTYPE = cgilua.cgilua.POST.OBJID
if "-1" == FP_IDENTITY then
FP_IDENTITY = ""
end
if "Apply" == FP_ACTION or "Delete" == FP_ACTION then
need2Get = 0
tError = applyOrNewOrDelInst(FP_OBJNAMEDns, FP_ACTION, FP_IDENTITY, transToPostTab(PARADns))
local ReturnIdentity = tError.INSTIDENTITY or ""
InstXML = getXMLNodeEntity("_InstID",encodeXML(ReturnIdentity))
end
if "Cancel" == FP_ACTION then
need2Get = 0
if "DNS" == FP_GETTYPE then
InstXML, tError = getSpecificInstXML(FP_OBJNAMEDns, FP_IDENTITY, nil, nil, transToFilterTab(PARADns))
elseif "DHCP" == FP_GETTYPE then
InstXML, tError = getSpecificInstXML(FP_OBJNAMEDhcp, FP_IDENTITY, nil, nil, transToFilterTab(PARADhcp))
end
end
if need2Get == 1 then
local strtmp
local xmlTableDhcp = {}
local reTable = cmapi.querylist(FP_OBJNAMEDhcp, "IGD")
local count = reTable.Count
for i=1, count do
local id = reTable[i].InstName or reTable[i]
if tError.IF_ERRORID == 0 then
xmlTableDhcp, tError, _ = getInstParaXML(FP_OBJNAMEDhcp, id, nil, transToFilterTab(PARADhcp), xmlTableDhcp)
else
xmlTableDhcp, _, _ = getInstParaXML(FP_OBJNAMEDhcp, id, nil, transToFilterTab(PARADhcp), xmlTableDhcp)
end
end
strtmp = table.concat(xmlTableDhcp)
InstXML = InstXML..strtmp
local xmlTableDns = {}
local reTable = cmapi.querylist(FP_OBJNAMEDns, "IGD")
local DNScount = reTable.Count
for i=1, DNScount do
local id = reTable[i].InstName or reTable[i]
if tError.IF_ERRORID == 0 then
xmlTableDns, tError, _ = getInstParaXML(FP_OBJNAMEDns, id, nil, transToFilterTab(PARADns), xmlTableDns)
else
xmlTableDns, _, _ = getInstParaXML(FP_OBJNAMEDns, id, nil, transToFilterTab(PARADns), xmlTableDns)
end
end
strtmp = table.concat(xmlTableDns)
InstXML = InstXML..strtmp
InstXML = getXMLNodeEntity("ALLDNSHOST", InstXML)
end
ErrorXML = outputErrorXML(tError)
OutXML = ErrorXML .. InstXML
outputXML(OutXML)
