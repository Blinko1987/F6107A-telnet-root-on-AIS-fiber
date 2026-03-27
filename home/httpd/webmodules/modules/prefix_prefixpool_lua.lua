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
local StaticPd_OBJNAME = "OBJ_PREFIXPOOL_ID"
local DynPd_OBJNAME = "OBJ_IPV6DynPrefix_ID"
local AllPd_PARA =
{
"Prefix",
"PrefixLen",
"PreferredLifetime",
"ValidLifetime",
"IfName",
"isStaticPrefix",
"PrefixPoolInst",
}
local FP_ACTION = cgilua.cgilua.POST.IF_ACTION
local FP_IDENTITY = cgilua.cgilua.POST._InstID
if FP_IDENTITY == nil then
FP_IDENTITY = ""
end
local function callback(t, id)
t.PrefixPoolInst = id
t.IfName = lang.LanMgrIpv6_066
t.isStaticPrefix = 1
return true
end
function DynPdcallback(t, id)
t.PrefixPoolInst = id
_, t.IfName = FindNameBaseID(id)
t.isStaticPrefix = 0
return true
end
local xmlTable = {}
xmlTable, tError = getAllInstTbl(StaticPd_OBJNAME, "DEV", tError, callback, transToFilterTab(AllPd_PARA), xmlTable)
InstXML = table.concat(xmlTable)
InstXML = getXMLNodeEntity(StaticPd_OBJNAME, InstXML)
ErrorXML = outputErrorXML(tError)
OutXML = ErrorXML .. InstXML
outputXML(OutXML)
