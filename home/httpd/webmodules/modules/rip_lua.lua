require "data_assemble.common_lua"
local cgilua = cgilua.cgilua
local ErrorXML = ""
local InstXML = ""
local OutXML = ""
local tError = nil
local FP_OBJNAME = "OBJ_RIP_ID"
local PARA =
{
"RipEnabled",
"RipModes",
"RipProtocol",
"RipAuthType",
"RipAuthKey"
}
local para_table = {}
para_table.para = PARA
para_table.encrypt = {"RipAuthKey"}
local FP_ACTION = cgilua.POST.IF_ACTION
local FP_IDENTITY = ""
InstXML, tError = ManagerOBJ(FP_OBJNAME, FP_ACTION, FP_IDENTITY, para_table, nil, nil)
ErrorXML = outputErrorXML(tError)
OutXML = ErrorXML .. InstXML
outputXML(OutXML)
