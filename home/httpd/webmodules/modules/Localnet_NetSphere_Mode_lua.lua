require "data_assemble.common_lua"
local ErrorXML = ""
local InstXML = ""
local OutXML = ""
local tError = nil
local FP_OBJNAME = "OBJ_NETSPHERE_MAP_ID"
local PARA =
{
"Mode",
"Enable"
}
local FP_ACTION = cgilua.POST.IF_ACTION
local FP_IDENTITY = cgilua.POST._InstID
InstXML, tError = ManagerOBJ(FP_OBJNAME, FP_ACTION, FP_IDENTITY, PARA, tError)
local InstXML1 = ""
local FP_OBJNAME1 = "OBJ_MULTIAP_ROAM_ID";
local PARA1 =
{
"EnLegacyStaRoam",
"RoamRssiLmt24G",
"RoamRssiLmt5G"
};
local FP_IDENTITY_Domain = "MULTIAPDOMAIN1"
if FP_ACTION == "Apply" then
tError = applyOrNewOrDelInst(FP_OBJNAME1, FP_ACTION, FP_IDENTITY_Domain ,transToPostTab(PARA1))
else
InstXML1, tError = getSpecificInstXML(FP_OBJNAME1, FP_IDENTITY_Domain , nil, back, transToFilterTab(PARA1))
end
ErrorXML = outputErrorXML(tError)
OutXML = ErrorXML .. InstXML .. InstXML1
outputXML(OutXML)
