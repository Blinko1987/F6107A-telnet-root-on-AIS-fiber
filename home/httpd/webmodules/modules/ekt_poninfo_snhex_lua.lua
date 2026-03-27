require "data_assemble.common_lua"
local cgilua = cgilua.cgilua
local ErrorXML = ""
local InstXML = ""
local OutXML = ""
local tError = nil
local FP_OBJNAME = "OBJ_PWFLAG_ID"
local PARA =
{
"ViewName",
"Sn",
"PwFlag",
"Ridpw"
}
local FP_ACTION = cgilua.POST.IF_ACTION
local FP_IDENTITY = cgilua.POST._InstID
local para_table = {}
para_table.para = PARA
para_table.encrypt = {"Ridpw"}
local function callback(t)
t.Ridpw = nil
return true
end
InstXML, tError = ManagerOBJ(FP_OBJNAME, FP_ACTION, FP_IDENTITY, para_table, tError, nil, callback)
ErrorXML = outputErrorXML(tError)
OutXML = ErrorXML .. InstXML
outputXML(OutXML)
