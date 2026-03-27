require "data_assemble.common_lua"
local ErrorXML = ""
local InstXML = ""
local OutXML = ""
local tError = nil
local FP_OBJNAME = "OBJ_MGTS_ROAM_ID";
local PARA =
{
"TimeInverval",
"ReqTimeout",
"RoamRssiLmt24G",
"RoamRssiLmt5G",
"RssiDelta",
"RoamBounceDetectTimeLmt",
"RoamBounceCountsLmt",
"RoamBounceDwellTimeLmt"
};
local FP_ACTION = cgilua.cgilua.POST.IF_ACTION
local FP_IDENTITY = "IGD.WiFi.ROAM"
if FP_ACTION == "Apply" then
tError = applyOrNewOrDelInst(FP_OBJNAME, FP_ACTION, FP_IDENTITY ,transToPostTab(PARA))
else
InstXML, tError = getSpecificInstXML(FP_OBJNAME, FP_IDENTITY , nil, back, transToFilterTab(PARA))
end
ErrorXML = outputErrorXML(tError)
OutXML = ErrorXML .. InstXML
outputXML(OutXML)
