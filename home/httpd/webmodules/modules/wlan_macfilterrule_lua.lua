require "data_assemble.common_lua"
local InstXML = ""
local InstXML2 = ""
local ErrorXML = ""
local OutXML = ""
local tError = nil
local need2Get = 1
local FP_OBJNAME = "OBJ_ACLCFG_ID"
local PARA =
{
"Name",
"Interface",
"MACAddress"
}
local FP_ACTION = cgilua.cgilua.POST.IF_ACTION
local FP_IDENTITY = cgilua.cgilua.POST._InstID
if FP_IDENTITY == "-1" then
FP_IDENTITY = ""
end
local ReturnIdentity = ""
if FP_ACTION == "Apply" or FP_ACTION == "Delete" then
need2Get = 0
tError = applyOrNewOrDelInst(FP_OBJNAME, FP_ACTION, FP_IDENTITY, transToPostTab(PARA))
ReturnIdentity = tError.INSTIDENTITY or ""
InstXML = getXMLNodeEntity("_InstID",encodeXML(ReturnIdentity));
end
if FP_ACTION == "Cancel" then
need2Get = 0
InstXML, tError = getSpecificInstXML(FP_OBJNAME, FP_IDENTITY, nil, nil, transToFilterTab(PARA))
end
if need2Get == 1 then
InstXML, tError = getAllInstXML(FP_OBJNAME, "IGD", tError, nil,transToFilterTab(PARA))
end
ErrorXML = outputErrorXML(tError)
OutXML = ErrorXML .. InstXML .. InstXML2
outputXML(OutXML)
