require "data_assemble.common_lua"
local cgilua = cgilua.cgilua
local ErrorXML = ""
local InstXML = ""
local OutXML = ""
local tError = nil
local FP_OBJNAME = "OBJ_PON_LOID_ID"
local PARA =
{
"ViewName",
"PonLoid",
"LoidPasswd"
}
local para_table = {}
para_table.para = PARA
para_table.encrypt = {"LoidPasswd"}
local FP_ACTION = cgilua.POST.IF_ACTION
local FP_IDENTITY = cgilua.POST._InstID
local function callback(t)
if "1" ~= env.getenv("CountryCode") and string.find(_G.commConf.passCanSee,"Loid") == nil then
t.LoidPasswd = nil
end
return true
end
InstXML, tError = ManagerOBJ(FP_OBJNAME, FP_ACTION, FP_IDENTITY, para_table, tError, nil, callback)
ErrorXML = outputErrorXML(tError)
OutXML = ErrorXML .. InstXML
outputXML(OutXML)
