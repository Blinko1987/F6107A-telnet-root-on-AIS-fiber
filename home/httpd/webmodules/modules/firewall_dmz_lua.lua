require "data_assemble.common_lua"
local InstXML = ""
local ErrorXML = ""
local OutXML = ""
local need2Get = 1
local tError = {
IF_ERRORID = 0,
IF_ERRORTYPE = "SUCC",
IF_ERRORSTR = "SUCC",
IF_ERRORPARAM = "SUCC"
}
local FP_OBJNAME = "OBJ_FWDMZ_ID";
local PARA =
{
"Enable",
"InternalClient",
"WANCViewName"
}
local FP_ACTION = cgilua.cgilua.POST.IF_ACTION
local FP_IDENTITY = cgilua.cgilua.POST._InstID
local ReturnIdentity = ""
if FP_ACTION == "Apply" then
need2Get = 0;
tError = applyOrNewOrDelInst(FP_OBJNAME, FP_ACTION, FP_IDENTITY, transToPostTab(PARA))
tError._InstID = tError.INSTIDENTITY
elseif FP_ACTION == "Cancel" then
need2Get = 0
InstXML, tError = getSpecificInstXML(FP_OBJNAME, FP_IDENTITY, nil, nil, transToFilterTab(PARA))
else
end
if need2Get == 1 then
InstXML, tError = getAllInstXML(FP_OBJNAME, "IGD", nil, nil,transToFilterTab(PARA))
end
ErrorXML = outputErrorXML(tError)
OutXML = ErrorXML .. InstXML
outputXML(OutXML)
