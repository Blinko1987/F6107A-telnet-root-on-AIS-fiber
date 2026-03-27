require "data_assemble.common_lua"
local InstXML = ""
local ErrorXML = ""
local OutXML = ""
local FP_ACTION = cgilua.cgilua.POST.IF_ACTION
local FP_OBJNAME = "OBJ_ROUTETABLE6_ID";
local PARA =
{
"DestIP",
"PrefixLen",
"GWIP",
"Interface"
}
local tError = {
IF_ERRORID = 0,
IF_ERRORTYPE = "SUCC",
IF_ERRORSTR = "SUCC",
IF_ERRORPARAM = "SUCC"
}
local xmlStr = ""
local xmlStrTmp = ""
local t = cmapi.getinst(FP_OBJNAME, "MGet")
local FP_INSTNUM = t.MGET_INST_NUM
FP_INSTNUM = tonumber(FP_INSTNUM)
for i=0,FP_INSTNUM - 1 do
local xmlSubStr = ""
local xmlSubStrTmp = ""
local DestIP = t["DestIP" .. i]
DestIP = encodeXML(DestIP)
xmlSubStr = getParaXMLNodeEntity("DestIP", DestIP)
local PrefixLen = t["PrefixLen" .. i]
PrefixLen = encodeXML(PrefixLen)
xmlSubStrTmp = getParaXMLNodeEntity("PrefixLen", PrefixLen)
xmlSubStr = xmlSubStr .. xmlSubStrTmp
local GWIP = t["GWIP" .. i]
GWIP = encodeXML(GWIP);
xmlSubStrTmp = getParaXMLNodeEntity("GWIP", GWIP)
xmlSubStr = xmlSubStr .. xmlSubStrTmp
local FP_IFNAME = t["Interface" .. i]
local IFNameTmp
local IFFind
IFFind,IFNameTmp = FindNameBaseID(FP_IFNAME)
if IFFind == 0 then
IFNameTmp = FP_IFNAME
end
xmlSubStrTmp = getParaXMLNodeEntity("Interface", encodeXML(IFNameTmp))
xmlSubStr = xmlSubStr .. xmlSubStrTmp
xmlStrTmp = getXMLNodeEntity("Instance", xmlSubStr)
xmlStr = xmlStr .. xmlStrTmp
end
InstXML = getXMLNodeEntity("OBJ_ROUTETABLE6_ID", xmlStr);
ErrorXML = outputErrorXML(tError)
OutXML = ErrorXML .. InstXML
outputXML(OutXML)
