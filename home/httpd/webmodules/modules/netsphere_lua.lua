require "data_assemble.common_lua"
local ErrorXML = ""
local InstXML1 = ""
local InstXML2 = ""
local InstXML3 = ""
local OutXML = ""
local tError = nil
local FP_OBJNAME1 = "OBJ_MULTIAP_ROAM_ID";
local PARA1 =
{
"RoamRssiLmt24G",
"RoamRssiLmt5G"
};
local FP_OBJNAME2 = "OBJ_WLAN_BANDSTEERING_ID";
local PARA2 =
{
"BsEnable"
};
local FP_OBJNAME3 = "OBJ_NETSPHERE_MAP_ID";
local PARA3 =
{
"Enable"
};
local FP_ACTION = cgilua.cgilua.POST.IF_ACTION
local FP_IDENTITY = cgilua.cgilua.POST._InstID
local FP_IDENTITY_Domain = "MULTIAPDOMAIN1"
if FP_ACTION == "Apply" then
tError = applyOrNewOrDelInst(FP_OBJNAME1, FP_ACTION, FP_IDENTITY_Domain ,transToPostTab(PARA1))
else
InstXML1, tError = getSpecificInstXML(FP_OBJNAME1, FP_IDENTITY_Domain , nil, back, transToFilterTab(PARA1))
end
InstXML2, tError = ManagerOBJ(FP_OBJNAME2, FP_ACTION, FP_IDENTITY, PARA2, tError)
InstXML3, tError = ManagerOBJ(FP_OBJNAME3, FP_ACTION, FP_IDENTITY, PARA3, tError)
ErrorXML = outputErrorXML(tError)
OutXML = ErrorXML .. InstXML1 .. InstXML2 .. InstXML3
outputXML(OutXML)
