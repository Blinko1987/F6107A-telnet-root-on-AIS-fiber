require "data_assemble.common_lua"
local cgilua = cgilua.cgilua
local ErrorXML = ""
local InstXML = ""
local InstXML1 = ""
local OutXML = ""
local tError = {
IF_ERRORID = 0,
IF_ERRORTYPE = "SUCC",
IF_ERRORSTR = "SUCC",
IF_ERRORPARAM = "SUCC"
}
local FP_OBJNAME = "OBJ_PWFLAG_ID"
local PARA =
{
"PwFlag",
"Ridpw"
}
local para_table = {}
para_table.para = PARA
local FP_ACTION = cgilua.POST.IF_ACTION
if FP_ACTION == "Apply" then
cgilua.POST.PwFlag = '0'
InstXML, tError = ManagerOBJ(FP_OBJNAME, FP_ACTION, "IGD", para_table, tError, nil, nil)
end
if FP_ACTION == "registeWait" then
if env.getenv("MibStatus") == "1" then
env.setenv("RegisterSucc","1");
InstXML1 = getXMLNodeEntity("RegisterStatus", "Register_OK")
end
end
ErrorXML = outputErrorXML(tError)
OutXML = ErrorXML .. InstXML .. InstXML1
outputXML(OutXML)
