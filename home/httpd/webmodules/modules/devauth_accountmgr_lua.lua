require "data_assemble.common_lua"
local InstXML = ""
local ErrorXML = ""
local OutXML = ""
local need2Get = 1
local tError = nil
local sess_id = cgilua.cgilua.getCurrentSessID()
local login_Right = session_get(sess_id, "login_right");
local FP_OBJNAME = "OBJ_USERINFO_ID"
local ShowPARA =
{
"Enable",
"Username",
"Right",
"Password",
"Keyword"
}
local para_table = {}
para_table.para = ShowPARA
para_table.encrypt = {"Password","NewPassword"}
local function callbackAccount(t)
if string.find(_G.commConf.passCanSee,"AccountMgr") == nil then
t.Password = nil
end
if t.Type == "1" and t.Enable == "1" then
if login_Right == "1" then
return true
elseif login_Right == "2" then
if t.Right ~= "1" then
return true
end
else
if t.Right ~= "1" and t.Right ~= "2" then
return true
end
end
end
return false
end
local FP_ACTION = cgilua.cgilua.POST.IF_ACTION
local FP_IDENTITY = cgilua.cgilua.POST._InstID
if FP_ACTION == "Apply" then
need2Get = 0
local CheckError = 0
tError = cmapi.getinst(FP_OBJNAME, FP_IDENTITY)
if cgilua.POST.encode ~= nil then
local decodeKV = cmapi.nocsrf.rsa_decrypt(cgilua.POST.encode)
local key,iv = string.match(decodeKV,"(%d+)%+(%d+)")
for i,v in ipairs(para_table.encrypt) do
if cgilua.cgilua.POST[v] ~= nil and string.len(cgilua.cgilua.POST[v]) > 0 then
cgilua.cgilua.POST[v] = cmapi.nocsrf.aes_decrypt(cgilua.cgilua.POST[v], key, iv)
end
end
end
if tError.IF_ERRORID == 0 then
local NowLoginRight = tonumber(login_Right)
local PostRight = cgilua.cgilua.POST["Right"]
if PostRight ~= nil then
PostRight = tonumber(PostRight)
end
for i, v in ipairs(ShowPARA) do
local IgnoreTag = 0
local ParaValueReference = tError[v]
local ParaValueTmp = cgilua.cgilua.POST[v]
if PostRight ~= nil and NowLoginRight < PostRight then
if v == "Username" or v == "Password" then
IgnoreTag = 1
end
end
if v == "Username" then
IgnoreTag = 1
end
if v == "Type" and ParaValueTmp == nil then
ParaValueTmp = "1"
end
if v == "Keyword" then
IgnoreTag = 1
end
if ParaValueTmp ~= ParaValueReference and 0 == IgnoreTag then
CheckError = 1
for i, val in ipairs(ShowPARA) do
if tError[val] then
tError[val]= nil
end
end
tError.IF_ERRORID = 0
tError.IF_ERRORSTR = lang.cmret_231
tError.IF_ERRORPARAM = "SUCC"
tError.IF_ERRORTYPE = 2
break
end
end
if NowLoginRight > PostRight then
CheckError = 1
tError.IF_ERRORSTR = lang.cmret_233
end
if CheckError == 0 then
local t_Data = {Password = cgilua.cgilua.POST.NewPassword,Username = cgilua.cgilua.POST.Username,Keyword = cgilua.cgilua.POST.Keyword}
tError = cmapi.setinst(FP_OBJNAME, FP_IDENTITY, t_Data)
if tError.IF_ERRORSTR == "239" then
if "17" == env.getenv("CountryCode") then
tError.IF_ERRORSTR = 2390
end
end
if tError.IF_ERRORID == 0 then
if 0 == require("user_mgr.session_mgr").session_checkactive(sess_id) then
local nowLoginName = session_get(sess_id, "login_name")
local logintoken = session_get(sess_id, "logintoken")
if cgilua.cgilua.POST.Username == nowLoginName and
cgilua.cgilua.POST.Right == login_Right then
session_set(sess_id, "login_pwd", cmapi.nocsrf.sha256(cgilua.cgilua.POST.NewPassword..logintoken))
end
end
if "66" == env.getenv("CountryCode") then
local destIP = cgilua.cgilua.servervariable"REMOTE_HDRHOST"
local accessFrom = "LAN"
local isWAN = cmapi.IsWANAccess(cgilua.cgilua.remote_addr)
if isWAN == 2 then
accessFrom = "LAN"
else
accessFrom = "WAN"
end
local logstr = "Changed by: right = " .. login_Right .. "(1:superadmin,2:admin),"
.. "source_ip = " .. cgilua.cgilua.remote_addr .. "/" .. accessFrom
.. ",dest_ip = " .. destIP
logapi.OssUserLogId(logstr, "LOGID_WEBD_ROS_LOGIN")
end
end
end
end
end
if FP_ACTION == "Cancel" then
need2Get = 0
InstXML, tError = getSpecificInstXML(FP_OBJNAME, FP_IDENTITY, tError, callbackAccount,
transToFilterTab(para_table))
end
if need2Get == 1 then
InstXML, tError = getAllInstXML(FP_OBJNAME, "IGD",tError,callbackAccount,
transToFilterTab(para_table))
end
ErrorXML = outputErrorXML(tError)
OutXML = ErrorXML .. InstXML
outputXML(OutXML)
