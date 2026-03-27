require "data_assemble.common_lua"
local cgilua = cgilua.cgilua
local ErrorXML = ""
local InstXML = ""
local OutXML = ""
local tError = nil
local FP_OBJNAME = "OBJ_SAMBACFG_ID"
local PARA =
{
"NetbiosName",
"EnableSmb",
"AutoRun",
"AuthType"
}
local USER_OBJNAME = "OBJ_SAMBAUSER_ID"
local PARA_USER =
{
"UserName",
"PassWord",
"UserRight",
"UserEnable"
}
local para_table = {}
para_table.para = PARA_USER
para_table.encrypt = {"PassWord"}
local need2Get = 1
local FP_ACTION = cgilua.POST.IF_ACTION
local FP_IDENTITY = ""
local strpass = string.format("%c%c%c%c%c%c", 9,9,9,9,9,9)
local function callback(t)
if string.find(_G.commConf.passCanSee,"Samba") == nil then
t.PassWord = nil
end
return true
end
if FP_ACTION == "Apply" then
need2Get = 0
local instNum = cgilua.POST._InstNum
for i = 0, instNum - 1 do
local identityName = "_InstID_" .. i
local identity = cgilua.POST[identityName]
if identity ~= nil then
local t_Data = {}
for j, k in pairs(PARA_USER) do
t_Data[k] = cgilua.POST[k .. "_" .. i]
end
if cgilua.POST.encode ~= nil and
t_Data["PassWord"] ~= nil and string.len(t_Data["PassWord"]) > 0 then
local decodeKV = cmapi.nocsrf.rsa_decrypt(cgilua.POST.encode)
local key,iv = string.match(decodeKV,"(%d+)%+(%d+)")
t_Data["PassWord"] = cmapi.nocsrf.aes_decrypt(t_Data["PassWord"], key, iv)
end
if t_Data["PassWord"] == strpass then
t_Data["PassWord"] = nil
end
tError = applyOrNewOrDelInst(USER_OBJNAME, FP_ACTION, identity, t_Data, tError)
end
end
end
local InstXML1 = ""
if need2Get == 1 then
InstXML1, tError = getAllInstXML(USER_OBJNAME, "IGD", nil, callback,transToFilterTab(para_table))
end
if tError.IF_ERRORID == 0 then
InstXML, tError = ManagerOBJ(FP_OBJNAME, FP_ACTION, FP_IDENTITY, PARA, nil, nil, callback)
end
ErrorXML = outputErrorXML(tError)
OutXML = ErrorXML .. InstXML .. InstXML1
outputXML(OutXML)
