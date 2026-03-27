require "data_assemble.common_lua"
local ErrorXML = ""
local InstXML = ""
local OutXML = ""
local tError = nil
local FP_OBJNAME = "OBJ_IGMPPROXYEX_ID"
local PARA =
{
"WanCID",
}
local FP_ACTION = cgilua.cgilua.POST.IF_ACTION
local FP_IDENTITY = cgilua.cgilua.POST._InstID
if FP_IDENTITY == "-1" then
FP_IDENTITY = ""
end
if FP_ACTION == "Apply" then
tError = applyOrNewOrDelInst(FP_OBJNAME, FP_ACTION, FP_IDENTITY, transToPostTab(PARA))
tError._InstID = tError.INSTIDENTITY
else
InstXML, tError = getAllInstXML(FP_OBJNAME, "IGD", nil, nil,transToFilterTab(PARA))
end
ErrorXML = outputErrorXML(tError)
OutXML = ErrorXML .. InstXML
outputXML(OutXML)
