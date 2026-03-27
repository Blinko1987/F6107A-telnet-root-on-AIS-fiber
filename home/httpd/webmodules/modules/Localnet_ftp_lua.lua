require "data_assemble.common_lua"
local cgilua = cgilua.cgilua
local ErrorXML = ""
local InstXML1 = ""
local InstXML2 = ""
local OutXML = ""
local tError = nil
local FP_OBJNAME1 = "OBJ_FMFTPSERVERCFG_ID"
local PARA1 =
{
"FtpEnable",
"FtpAnon",
}
local FP_OBJNAME2 = "OBJ_FMFTPUSER_ID"
local PARA2 =
{
"Username",
"Password",
}
local para_table = {}
para_table.para = PARA2
para_table.encrypt = {"Password"}
local FP_ACTION = cgilua.POST.IF_ACTION
local FP_IDENTITY = cgilua.POST._InstID
local strpass = string.format("%c%c%c%c%c%c", 9,9,9,9,9,9)
if strpass == cgilua.POST.Password then
cgilua.POST.Password = nil
end
local function callback(t)
if string.find(_G.commConf.passCanSee,"Ftp") == nil then
t.Password = nil
end
return true
end
InstXML1, tError = ManagerOBJ(FP_OBJNAME1, FP_ACTION, FP_IDENTITY, PARA1)
InstXML2, tError = ManagerOBJ(FP_OBJNAME2, FP_ACTION, FP_IDENTITY, para_table, tError, nil, callback)
ErrorXML = outputErrorXML(tError)
OutXML = ErrorXML .. InstXML1 .. InstXML2
outputXML(OutXML)
