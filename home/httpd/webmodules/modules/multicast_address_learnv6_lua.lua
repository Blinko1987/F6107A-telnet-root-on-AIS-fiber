require "data_assemble.common_lua"
local ErrorXML = ""
local InstXML = ""
local OutXML = ""
local need2Get = 1
local tError = {
IF_ERRORID = 0,
IF_ERRORTYPE = "SUCC",
IF_ERRORSTR = "SUCC",
IF_ERRORPARAM = "SUCC"
}
local OBJNAME = "OBJ_ADDRLEARNV6_ID"
local PARA =
{
"Addr",
"Vlan",
"ClientIP6Addr"
}
function MultiTblToXML (OBJNAME, ID, getTParam)
local err = {
IF_ERRORID = 0,
IF_ERRORTYPE = "SUCC",
IF_ERRORSTR = "SUCC",
IF_ERRORPARAM = "SUCC"
}
local retTable = nil
local xmlStr = ""
retTable = cmapi.getinst(OBJNAME, ID)
if type(retTable) ~= "table" then
g_logger:warn("retTable is not a table!")
return xmlStr, err
end
local xmlTable = {}
if retTable.IF_ERRORID == 0 then
local OneToMultiNum = retTable["INST_NUM"]
local i
for i=0, OneToMultiNum-1 do
table.insert(xmlTable, getXMLLabelStart("Instance"))
local k, v
for k,v in pairs(getTParam) do
local ReaLNameInRetTbl = k .. i
local ReaLValInRetTbl = retTable[ReaLNameInRetTbl]
ReaLValInRetTbl = encodeXML(ReaLValInRetTbl)
table.insert(xmlTable, getParaXMLNodeEntity(k, ReaLValInRetTbl))
end
table.insert(xmlTable, getXMLLabelEnd("Instance"))
end
else
err = retTable
end
xmlStr = table.concat(xmlTable)
xmlStr = getXMLNodeEntity(OBJNAME, xmlStr)
return xmlStr, err
end
InstXML, tError = MultiTblToXML(OBJNAME, "DEV.BRIDGING.BR1.BRPORT2", transToFilterTab(PARA))
ErrorXML = outputErrorXML(tError)
OutXML = ErrorXML .. InstXML
outputXML(OutXML)
