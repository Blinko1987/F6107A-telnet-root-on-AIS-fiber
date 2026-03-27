require "data_assemble.common_lua"
local ErrorXML = ""
local InstXML = ""
local OutXML = ""
local tError = nil
local FP_OBJNAME = "OBJ_L2TP_ID";
local PARA =
{
"Enable",
"SessionName",
"LowIFID",
"L2tpServer1",
"UserName",
"Password",
"AuthType",
"NATEnable",
"ConnSatus",
"IpMode",
"IPAddress",
"SubnetMask",
"GateWay",
"DNS1",
"DNS2",
"DNS3",
"UpTime"
}
local para_table = {}
para_table.para = PARA
para_table.encrypt = {"Password"}
local FP_ACTION = cgilua.cgilua.POST.IF_ACTION
local FP_IDENTITY = cgilua.cgilua.POST._InstID
if FP_IDENTITY == "-1" then
FP_IDENTITY = ""
end
local strpass = string.format("%c%c%c%c%c%c", 9,9,9,9,9,9)
if strpass == cgilua.cgilua.POST.Password then
cgilua.cgilua.POST.Password = nil
end
local function callback(t)
if string.find(_G.commConf.passCanSee,"L2tp") == nil then
t.Password = nil
end
return true
end
InstXML, tError = ManagerOBJ(FP_OBJNAME, FP_ACTION, FP_IDENTITY, para_table, tError, {xmlType=1}, callback)
ErrorXML = outputErrorXML(tError)
OutXML = ErrorXML .. InstXML
outputXML(OutXML)
