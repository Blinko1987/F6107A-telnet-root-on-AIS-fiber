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
local OBJNAME = "OBJ_GETARPINST_ID"
local PARA =
{
"DestIP",
"MACAddr",
"Status",
"Interface"
}
local FP_ACTION = cgilua.cgilua.POST.IF_ACTION
local FP_ARP_NUM, FP_THRESHOLD_NUM;
if FP_ACTION == nil then
FP_ACTION = ""
end
local rettab = cmapi.getinst("OBJ_GETARPNUM_ID", "")
FP_ARP_NUM = tonumber(rettab.ARP_NUM)
FP_THRESHOLD_NUM = tonumber(rettab.THRESHOLD_NUM)
local disp_num, showInst, disp_all;
if (FP_ARP_NUM < FP_THRESHOLD_NUM) or ("DISPALL"==FP_ACTION) then
disp_num = FP_ARP_NUM
disp_all = "0"
showInst = 1
elseif "DISPPART"==FP_ACTION then
disp_num = FP_THRESHOLD_NUM
disp_all = "1"
showInst = 1
else
disp_num = nil
disp_all = nil
showInst = 0
end
function ArpTblToXML (OBJNAME, ID, getTParam, param_table, OneToMultiNum)
local err = {
IF_ERRORID = 0,
IF_ERRORTYPE = "SUCC",
IF_ERRORSTR = "SUCC",
IF_ERRORPARAM = "SUCC"
}
local retTable = nil
local xmlStr = ""
if OneToMultiNum == 0 then
return xmlStr, err
end
retTable = cmapi.getinst(OBJNAME, ID, param_table)
if type(retTable) ~= "table" then
g_logger:warn("retTable is not a table!")
return xmlStr, err
end
local xmlTable = {}
if retTable.IF_ERRORID == 0 then
local WanLanTbl = ListAllWanLanIF()
local i
for i=0, OneToMultiNum-1 do
table.insert(xmlTable, getXMLLabelStart("Instance"))
local k, v
for k,v in pairs(getTParam) do
local ReaLNameInRetTbl = k .. i
local ReaLValInRetTbl = retTable[ReaLNameInRetTbl]
if k == "Interface" then
for x,y in ipairs(WanLanTbl) do
if ReaLValInRetTbl == y.InstID then
ReaLValInRetTbl = y.InstName
break;
end
end
end
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
local param_table = {DispNum=disp_num, DispType=disp_all}
if 1 == showInst then
InstXML, tError = ArpTblToXML (OBJNAME, "IGD", transToFilterTab(PARA),
param_table, disp_num)
end
tError.showInst = showInst;
tError.disp_all = disp_all;
tError.disp_num = disp_num;
ErrorXML = ErrorXML .. outputErrorXML(tError)
OutXML = ErrorXML .. InstXML
outputXML(OutXML)
