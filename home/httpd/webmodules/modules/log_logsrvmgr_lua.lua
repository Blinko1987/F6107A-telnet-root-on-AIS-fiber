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
local FP_IDENTITY= "IGD"
local FP_OBJNAME = "OBJ_LOG_ID"
local ReturnIdentity = ""
local PARA =
{
"ServiceIp",
"ServiceEnable",
}
local FP_ACTION = cgilua.cgilua.POST.IF_ACTION
InstXML, tError = ManagerOBJ(FP_OBJNAME, FP_ACTION, FP_IDENTITY, PARA, nil, {xmlType = 1})
ErrorXML = outputErrorXML(tError)
OutXML = ErrorXML .. InstXML
outputXML(OutXML)
