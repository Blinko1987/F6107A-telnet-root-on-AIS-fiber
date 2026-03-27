require "data_assemble.common_lua"
local ErrorXML = ""
local InstXML = ""
local InstXML1 = ""
local InstXML2 = ""
local OutXML = ""
local tError = nil
local FP_OBJNAME1 = "OBJ_TEMP_DOMAIN_BS";
local PARA1 =
{
"BsRssiLmt24G",
"BsRssiLmt5G"
};
local FP_OBJNAME = "OBJ_NETSPHERE_MAP_ID";
local PARA =
{
"Mode",
"Enable"
}
local FP_OBJNAME2 = "OBJ_MAP_MASTER_ID";
local PARA2 =
{
"EnBandSteer"
}
local FP_ACTION = cgilua.POST.IF_ACTION
local FP_IDENTITY = cgilua.POST._InstID
InstXML, tError = ManagerOBJ(FP_OBJNAME, FP_ACTION, FP_IDENTITY, PARA, tError)
if FP_ACTION == "Apply" then
tError = applyOrNewOrDelInst(FP_OBJNAME1, FP_ACTION, "IGD.WiFi.RD1.BS" ,transToPostTab(PARA1))
InstXML1 = getXMLNodeEntity("_InstID", tError.INSTIDENTITY)
else
InstXML1, tError = getSpecificInstXML(FP_OBJNAME1, "MULTIAPDOMAIN1" , nil, back, transToFilterTab(PARA1))
end
InstXML2, tError = ManagerOBJ(FP_OBJNAME2, FP_ACTION, FP_IDENTITY, PARA2, tError)
ErrorXML = outputErrorXML(tError)
OutXML = ErrorXML .. InstXML .. InstXML1 .. InstXML2
outputXML(OutXML)
