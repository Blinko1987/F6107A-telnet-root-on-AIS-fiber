require "data_assemble.common_lua"
local ErrorXML = ""
local InstXML = ""
local OutXML = ""
local tError = nil
local OBJNAME = "OBJ_VOIP_CALL_LOG";
local PARA =
{
"BeginTime",
"LocNumber",
"RmtNumber",
"Duration",
"Result"
};
function CalllogTblToXML (OBJNAME, ID, getTParam, param_table, OneToMultiNum)
local err = {
IF_ERRORID = 0,
IF_ERRORTYPE = "SUCC",
IF_ERRORSTR = "SUCC",
IF_ERRORPARAM = "SUCC"
}
local xmlStr = ""
if OneToMultiNum == 0 then
return xmlStr, err
end
local retTable = nil
retTable = cmapi.getinst(OBJNAME, ID, param_table)
if type(retTable) ~= "table" then
g_logger:warn("retTable is not a table!")
return xmlStr, err
end
local xmlTable = {}
if retTable.IF_ERRORID == 0 then
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
local retTab = cmapi.querylist(OBJNAME, "IGD")
local disp_num = tonumber(retTab.Count)
local param_table = {DispNum=disp_num}
InstXML, tError = CalllogTblToXML (OBJNAME, "IGD", transToFilterTab(PARA),
param_table, disp_num)
ErrorXML = ErrorXML .. outputErrorXML(tError)
OutXML = ErrorXML .. InstXML
outputXML(OutXML)
