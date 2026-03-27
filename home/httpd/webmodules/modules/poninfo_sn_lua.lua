require "data_assemble.common_lua"
local cgilua = cgilua.cgilua
local ErrorXML = ""
local InstXML = ""
local OutXML = ""
local tError = nil
local FP_OBJNAME = "OBJ_SN_INFO_ID"
local PARA =
{
"ViewName",
"Sn",
"Pwd",
"IsInform"
}
local para_table = {}
para_table.para = PARA
para_table.encrypt = {"Pwd"}
local FP_ACTION = cgilua.POST.IF_ACTION
local FP_IDENTITY = cgilua.POST._InstID
if FP_ACTION == "Apply" then
if env.getenv("Right") == "2" and env.getenv("CountryCode") == "1" then
return true
end
end
local function callback(t)
if "1" == env.getenv("CountryCode") then
t.Sn = string.upper(t.Sn)
end
if "131" ~= env.getenv("CountryCode") and env.getenv("CountryCode") ~= "1" and env.getenv("CountryCode") ~= "21" and env.getenv("CountryCode") ~= "4" and string.find(_G.commConf.passCanSee,"SN") == nil then
t.Pwd = nil
end
return true
end
if FP_ACTION == "Restart" then
InstXML, tError = ManagerOBJ(FP_OBJNAME, "Apply", FP_IDENTITY, para_table, tError, nil, callback)
else
InstXML, tError = ManagerOBJ(FP_OBJNAME, FP_ACTION, FP_IDENTITY, para_table, tError, nil, callback)
end
ErrorXML = outputErrorXML(tError)
OutXML = ErrorXML .. InstXML
outputXML(OutXML)
