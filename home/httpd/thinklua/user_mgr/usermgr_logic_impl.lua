local cgilua = require("cgilua.cgilua")
local oopclass = require("common_lib.oop_class")
local class = oopclass.class
local assertlib = require("common_lib.assert_utils")
local typeAssert = assertlib.typeAssert
local valueAssert = assertlib.valueAssert
local userMgrTbl = require("user_mgr.usermgr_table_mgr")
local sessmgr = require("user_mgr.session_mgr")
local fileutils = require"common_lib.file_utils"
local filterIllegalPath = fileutils.filterIllegalPath
local getextension = fileutils.getextension
local loginErrCode = {
SESSION_CHECK_OK = 100,
EXCEED_MAX_USER = 101,
EXCEED_MAX_USER_PREEMPT = 102,
EXCEED_MAX_SESSION = 103,
NEED_CHANGE_PASSWORD = 104,
LOGIN_NOT_FAILED = 200,
INVALID_USERNAME_PASSWORD = 201,
LOGIN_LOCKED = 202,
INVALID_CAPTCHA = 203,
CSRF_CHECK_FAIL = 204,
PASSWORD_CHANGE_ERROR = 210,
PASSWORD_ISNOT_SECURITY = 211,
USER_LEVEL_NOT_MATCH = 220,
DEFAULT_LOGINFO_CHANGED = 221,
DEFAULT_LOGINFO_NOTCHANGED= 222,
REMOTE_ACCESS_DISABLE = 223
}
local UserMgrLogicClass = class()
local function __getRightNickName( login_right )
local nickName = ""
if login_right == "1" then
nickName = "xxx"
elseif login_right == "2" then
nickName = "yyy"
elseif login_right == "3" then
nickName = "zzz"
else
end
return nickName
end
local function __printLogOutMsg( session_id,clientIP )
local login_right = session_get(session_id, "login_right")
local logstr = ""
local nickName = __getRightNickName(login_right)
logstr = clientIP .. "--" .. nickName .. ":logout success"
local logoutInfoItem = userMgrTbl:findItem("logoutInfo")
if logoutInfoItem ~= nil then
local customValue = logoutInfoItem:getAttribute("value")
local customFunc = logoutInfoItem:getAttribute("func")
if customFunc then
logstr = customFunc()
elseif customValue then
logstr = customValue
end
end
if "66" == env.getenv("CountryCode") then
logapi.OssUserLogId(logstr, "LOGID_WEBD_ROS_LOGIN")
else
g_logger:custom(logstr, "ERROR", "SECURITY")
end
end
UserMgrLogicClass.loadUsermgrAttrRules = function ( self )
userMgrTbl:loadStaticConfig({
tableFile="user_mgr.usermgr_table_conf",
modifierFile="user_mgr.usermgr_table_modifier"
})
end
UserMgrLogicClass.getUserMgrAttr = function (self, Attr, subAttr, dsubAttr)
typeAssert(Attr, "string")
typeAssert(subAttr, "string")
typeAssert(dsubAttr, "string", "nil")
local attrItem = userMgrTbl:findItem(Attr)
local retValue = attrItem:getAttribute(subAttr)
if subAttr == "value" then
local func = attrItem:getAttribute("func")
if func then
retValue = func()
end
elseif subAttr == "opts" and dsubAttr then
if retValue[dsubAttr] then
retValue = retValue[dsubAttr]
else
retValue = nil
end
end
if type(retValue) == "function" then
retValue = retValue()
end
return retValue
end
UserMgrLogicClass.getUserMgrAttrValue = function (self, Attr)
return self:getUserMgrAttr(Attr,"value")
end
local function __curAccessFrom( ip )
local isWAN = cmapi.IsWANAccess(ip)
if isWAN == 2 then
return "LAN"
else
return "WAN"
end
end
UserMgrLogicClass.checkAccessFrom = function (self)
local accessFrom = __curAccessFrom(cgilua.remote_addr)
local allowSide =self:getUserMgrAttrValue("fromLANorWAN")
local isAllow = true
if allowSide == "ALL" then
isAllow = true
elseif allowSide == accessFrom then
isAllow = true
else
isAllow = false
end
g_logger:debug("isAllow == "..tostring(isAllow)..", allowSide == "..tostring(allowSide))
return isAllow, allowSide
end
UserMgrLogicClass.checkIfNeedAuth = function (self)
local ifNeedAuth = true
local needAuth = self:getUserMgrAttrValue("needAuth")
local accessFrom = __curAccessFrom(cgilua.remote_addr)
if needAuth == "ALL" then
ifNeedAuth = true
elseif needAuth == "NO" then
ifNeedAuth = false
elseif needAuth == "LAN" and accessFrom == "LAN" then
ifNeedAuth = true
elseif needAuth == "LAN" and accessFrom == "WAN" then
ifNeedAuth = false
elseif needAuth == "WAN" and accessFrom == "WAN" then
ifNeedAuth = true
else
ifNeedAuth = true
end
g_logger:debug("ifNeedAuth == "..tostring(ifNeedAuth))
return ifNeedAuth
end
UserMgrLogicClass.__checkUserLevel = function (self, curUserLevel)
return true
end
local function __getUserInfoFromDB( userLevel )
local user,pass
local userInfoTbl = cmapi.querylist("OBJ_USERINFO_ID", "IGD")
if "table" == type(userInfoTbl) then
for i, v in ipairs(userInfoTbl) do
local instTbl = cmapi.getinst("OBJ_USERINFO_ID", v)
if instTbl["Type"] == "1" and instTbl["Right"] == userLevel then
user = instTbl["Username"]
pass = instTbl["Password"]
break
end
end
end
return user,pass
end
local function __getUserDefInfoFromDB( userLevel )
local user,pass
local userInfoTbl = cmapi.querylist("OBJ_USERINFO_DEFAULT_ID", "IGD")
if "table" == type(userInfoTbl) then
for i, v in ipairs(userInfoTbl) do
local instTbl = cmapi.getinst("OBJ_USERINFO_DEFAULT_ID", v)
if instTbl["Type"] == "1" and instTbl["Right"] == userLevel then
user = instTbl["Username"]
pass = instTbl["Password"]
break
end
end
end
return user,pass
end
local function __getRemoteAccessFromDB( userLevel )
local RemoteAccess = "1"
local userInfoTbl = cmapi.querylist("OBJ_USERINFO_ID", "IGD")
if "table" == type(userInfoTbl) then
for i, v in ipairs(userInfoTbl) do
local instTbl = cmapi.getinst("OBJ_USERINFO_ID", v)
if instTbl["Type"] == "1" and instTbl["Right"] == userLevel then
RemoteAccess = instTbl["RemoteAccessCapable"]
break
end
end
end
return RemoteAccess
end
UserMgrLogicClass.getAutoAuthAccount = function (self)
local userLevel = tostring(self:getUserMgrAttr("needAuth","opts","dftUser"))
return __getUserInfoFromDB(userLevel)
end
UserMgrLogicClass.getAutofillUsername = function (self)
local username, disabled = nil, false
local userLevel = tostring(self:getUserMgrAttrValue("autofillUsername"))
if userLevel ~= "0" then
username = __getUserInfoFromDB(userLevel)
end
if username then
disabled = self:getUserMgrAttr("autofillUsername","opts","disableUsername")
end
return username, disabled
end
UserMgrLogicClass.getAutofillPassword = function (self)
local username, password, disabled = nil, false
local userLevel = tostring(self:getUserMgrAttrValue("autofillPassword"))
if userLevel ~= "0" then
username,password = __getUserInfoFromDB(userLevel)
end
if password then
disabled = self:getUserMgrAttr("autofillPassword","opts","disablePassword")
end
return password, disabled
end
UserMgrLogicClass.getStatus = function (self)
return sessmgr.GetCurrentSessAttr("status_login") or "unchecked"
end
UserMgrLogicClass.__isUserNamePwdCorrect = function (self, username, userpwd, logintoken)
if username == nil or userpwd == nil then
g_logger:warn("username and userpwd can not be nil")
return {IF_ERRORID = -1}
end
local t = cmapi.login("OBJ_LOGIN_ID", {Username = username, Password = userpwd, UserRandomNum=logintoken})
return t
end
UserMgrLogicClass.__checkIfLogin = function (self)
local sess_id = sessmgr.GetCurrentSessID()
local retCheck = sessmgr.session_checkactive(sess_id)
if 0 == retCheck then
local tCheck = self:__isUserNamePwdCorrect(session_get(sess_id, "login_name"),
session_get(sess_id, "login_pwd"),
session_get(sess_id, "logintoken"))
if 0 == tCheck.IF_ERRORID then
if session_get(sess_id, "status_login") == "logined" then
return 0
else
return 100
end
else
local needLogout = true
local failReason = tCheck["failReason"]
if "accountDisabled" == failReason then
needLogout = false
end
if session_get(sess_id, "status_login") == "logined" then
if needLogout then
session_set(sess_id, "status_login", "unchecked")
else
return 0
end
end
return 100
end
end
return retCheck
end
UserMgrLogicClass.isLogined = function (self)
return sessmgr.GetCurrentSessAttr("status_login") == "logined"
end
UserMgrLogicClass.getLoginStatus = function (self)
local loginStatus = nil
local retCheck = self:__checkIfLogin()
if 0 == retCheck then
loginStatus = "loginAlready"
elseif 99 == retCheck then
loginStatus = "loginTimeout"
else
loginStatus = "loginNone"
end
g_logger:debug("loginStatus == ".. tostring(loginStatus))
return loginStatus
end
UserMgrLogicClass.setUserRight2Sess = function(self)
sessmgr.SetCurrentSessAttr("Right", "0")
session_set(sessmgr.GetCurrentSessID(), "login_right", "0")
env.setenv("Right", "0")
end
UserMgrLogicClass.isRightsMeeted = function(self, userRight, resourceRight)
typeAssert(userRight, "number")
typeAssert(resourceRight, "number")
local rightMeeted = false
if resourceRight == 0 then
rightMeeted = true
elseif ((resourceRight*((0.5)^(userRight - 1)))%2) >= 1 then
rightMeeted = true
end
return rightMeeted
end
UserMgrLogicClass.checkRightPassed = function(self, resourceRight)
return true
end
UserMgrLogicClass.doLogout = function (self)
local loginStatus = self:getLoginStatus()
if loginStatus and loginStatus == "loginAlready" then
if cgilua.POST.IF_LogOff == "1" then
local sess_id = sessmgr.GetCurrentSessID()
__printLogOutMsg(sess_id, cgilua.remote_addr)
sessmgr.session_destroy(sess_id)
return true
end
end
return false
end
UserMgrLogicClass.doLogin = function (self)
local sess_id = sessmgr.GetCurrentSessID()
local loginErrType = "NULL"
local hdrCookie = cgilua.servervariable("HTTP_COOKIE")
if hdrCookie == nil or hdrCookie == "" then
loginErrType = "NULL"
return loginErrType
end
if self:__exceedSessMax(self:getUserMgrAttrValue("sessMax")) then
loginErrType = "EXCEED_MAX_SESSION"
return loginErrType
end
if self:__isLoginlocked() then
loginErrType = "LOGIN_LOCKED"
return loginErrType
end
session_set(sess_id, "logintoken", env.getenv("logintoken"))
local retErrID = self:__authLogin(sess_id)
env.unsetenv("logintoken")
function viettelPass()
local username, password, ret
local passDefault = "ZTEG00000000"
local retTable = cmapi.getinst("OBJ_SN_INFO_ID", "IGD")
if type(retTable) ~= "table" then
g_logger:debug("retTable is not a table!")
else
passDefault = "ZTEG" .. string.upper(string.sub(retTable.Sn,5,12))
end
username, password = __getUserInfoFromDB("1")
if (password == passDefault) then
ret = 0
else
ret = 1
end
return ret
end
if retErrID == 0 then
if self:getStatus() == "chpwd" then
loginErrType = "LOGIN_REFRESH_PAGE"
return loginErrType
end
loginErrType = self:__loginProcess(sess_id)
if loginErrType == "LOGIN_REFRESH_PAGE" then
return loginErrType
end
elseif retErrID == loginErrCode.INVALID_CAPTCHA then
loginErrType = "INVALID_CAPTCHA"
elseif retErrID == loginErrCode.CSRF_CHECK_FAIL then
loginErrType = "CSRF_CHECK_FAIL"
elseif retErrID == loginErrCode.INVALID_USERNAME_PASSWORD then
if "54" == env.getenv("CountryCode") or "122" == env.getenv("CountryCode") then
if viettelPass() == 1 then
loginErrType = "DEFAULT_LOGINFO_CHANGED"
else
loginErrType = "DEFAULT_LOGINFO_NOTCHANGED"
end
else
loginErrType = "INVALID_USERNAME_PASSWORD"
end
elseif retErrID == loginErrCode.USER_LEVEL_NOT_MATCH then
loginErrType = "USER_LEVEL_NOT_MATCH"
elseif retErrID == loginErrCode.REMOTE_ACCESS_DISABLE then
loginErrType = "REMOTE_ACCESS_DISABLE"
elseif retErrID == loginErrCode.LOGIN_LOCKED then
loginErrType = "LOGIN_LOCKED"
else
g_logger:warn("Unexpected retErrID!!! retErrID =" .. tostring(retErrID))
end
g_logger:debug("retErrID = " .. retErrID .. ",loginErrType = " .. loginErrType)
return loginErrType
end
UserMgrLogicClass.__loginProcess = function (self, sess_id)
local loginErrType = "LOGIN_REFRESH_PAGE"
local Right = session_get(sess_id, "login_right")
local sessTbl = sessmgr.filterSession({key="status_login",value="logined"})
for _, sid in ipairs(sessTbl) do
if session_get(sid, "client_ip") == cgilua.remote_addr then
g_logger:debug("Destroy another browser's session, because we come from a same IP.")
__printLogOutMsg(sid, cgilua.remote_addr)
sessmgr.session_destroy(sid)
self:__setLogined(sess_id)
return loginErrType
end
end
if not self:__exceedUserMax(self:getUserMgrAttrValue("userMax")) then
self:__setLogined(sess_id)
return loginErrType
end
local policy = self:getUserMgrAttrValue("loginPolicy")
if policy == "block" then
loginErrType = "EXCEED_MAX_USER"
session_set(sess_id, "status_login", "block")
elseif policy == "preempt" then
local kickedUsers = self:getUserMgrAttr("loginPolicy","opts","beKickedUsers")
if next(kickedUsers) then
loginErrType = "EXCEED_MAX_USER_PREEMPT"
session_set(sess_id, "status_login", "preempt")
else
loginErrType = "EXCEED_MAX_USER"
session_set(sess_id, "status_login", "block")
end
else
g_logger:warn("Login policy may be exceed setting range!")
end
return loginErrType
end
UserMgrLogicClass.doPreempt = function (self, action)
local loginErrType = "LOGIN_REFRESH_PAGE"
local sess_id = sessmgr.GetCurrentSessID()
if action == "preempt" then
local preemptSessID = cgilua.POST.preempt_sessid
if not preemptSessID then return "LOGIN_REFRESH_PAGE" end
if session_get(sess_id, "status_login") ~= "preempt" then
return "LOGIN_REFRESH_PAGE"
end
if session_get(preemptSessID, "status_login") ~= "logined" then
self:__setLogined(sess_id)
return "LOGIN_REFRESH_PAGE"
end
local postIsOK = false
local kickedUsers = self:getUserMgrAttr("loginPolicy","opts","beKickedUsers")
for i, v in ipairs(kickedUsers) do
if preemptSessID == v then
postIsOK = true
break
end
end
if postIsOK then
sessmgr.session_destroy(preemptSessID)
else
return "LOGIN_REFRESH_PAGE"
end
if not self:__exceedUserMax(self:getUserMgrAttrValue("userMax")) then
loginErrType = "LOGIN_REFRESH_PAGE"
self:__setLogined(sess_id)
return loginErrType
end
elseif action == "preempt_cancel" then
if sess_id ~= nil and
session_get(sess_id, "status_login") == "preempt" then
__printLogOutMsg(sess_id, session_get(sess_id, "client_ip"))
sessmgr.session_destroy(sess_id)
end
loginErrType = "LOGIN_REFRESH_PAGE"
else
g_logger:error("Unexpected action!!! action = " .. tostring(action))
end
g_logger:debug("loginErrType == " .. loginErrType)
return loginErrType
end
UserMgrLogicClass.__authAccount = function (self, sess_id, user, pass, logintoken)
local tCheck = self:__isUserNamePwdCorrect(user, pass, logintoken)
local result = tCheck.IF_ERRORID
local username, password
local passDefault
session_set(sess_id, "login_name", user)
session_set(sess_id, "login_pwd", pass)
if 0 == result then
if _G.commConf.ValidateCode then
if not __checkCaptcha(cgilua.POST.captcha) then
return loginErrCode.INVALID_CAPTCHA
end
end
local login_right = "0"
session_set(sess_id, "login_right", login_right)
env.setenv("Right", "0")
sessmgr.SetCurrentSessAttr("Right", "0")
session_set(sess_id, "status_login", "checked")
local chg_pwd = tCheck["ChgPwd"]
if chg_pwd == "1" then
session_set(sess_id, "status_login", "chpwd")
end
else if -1452 == result then
result = loginErrCode.CSRF_CHECK_FAIL
else
result = loginErrCode.INVALID_USERNAME_PASSWORD
end
session_set(sess_id, "status_login", "unchecked")
end
g_logger:debug("auth account result == " .. result)
return result
end
function __checkCaptcha(captcha)
local ret = false
local CAPTCHA = sessmgr.GetCurrentSessAttr("CAPTCHA")
if captcha and CAPTCHA and string.upper(captcha) == string.upper(CAPTCHA) then
ret = true
if (env.getenv("CountryCode") == "98" or env.getenv("CountryCode") == "36") and captcha ~= CAPTCHA then
ret = false
end
else
g_logger:error("POST.captcha=" .. tostring(captcha) .. ", sess.CAPTCHA=" .. tostring(CAPTCHA))
end
return ret
end
UserMgrLogicClass.__authLogin = function(self, sess_id)
local user = cgilua.POST.Username
local pass = cgilua.POST.Password
g_logger:debug("Check user & password")
local authCode = self:__authAccount(sess_id, user, pass, env.getenv("logintoken"))
pass = nil
local nickName = __getRightNickName(session_get(sess_id, "login_right"))
if authCode == 0 then
self:__clearLoginErr()
local logstr = "Web user (username == " .. nickName .. ") is authenticated ok."
if "66" == env.getenv("CountryCode") then
local right = session_get(sess_id, "login_right")
local accessFrom = __curAccessFrom(cgilua.remote_addr)
local destIP = cgilua.servervariable"REMOTE_HDRHOST"
logstr = "Web user (username == " .. user .. ",right == " .. right .. "(1:superadmin,2:admin),"
.. "source_ip == " .. cgilua.remote_addr .. "/" .. accessFrom .. ",dest_ip == " .. destIP .. ")is logined success ! "
logapi.OssUserLogId(logstr, "LOGID_WEBD_ROS_LOGIN")
else
g_logger:custom(logstr, "ERROR", "SECURITY")
end
local logstr = cgilua.remote_addr .. "  Web user  is authenticated fail."
local loginInfoItem = userMgrTbl:findItem("loginFailInfo")
if loginInfoItem ~= nil then
local customValue = loginInfoItem:getAttribute("value")
local customFunc = loginInfoItem:getAttribute("func")
if customFunc then
logstr = customFunc()
elseif customValue then
logstr = customValue
end
end
if "66" == env.getenv("CountryCode") then
local accessFrom = __curAccessFrom(cgilua.remote_addr)
local destIP = cgilua.servervariable"REMOTE_HDRHOST"
logstr = "Web user (username == " .. user .. ",source_ip == " .. cgilua.remote_addr .. "/" .. accessFrom .. ",dest_ip == " .. destIP .. ") is logined fail. "
logapi.OssUserLogId(logstr, "LOGID_WEBD_ROS_LOGIN")
else
g_logger:custom(logstr, "ERROR", "SECURITY")
end
else
g_logger:warn("Unexpected authCode!!!")
end
return authCode
end
UserMgrLogicClass.__exceedSessMax = function(self, sessMax)
local _, existSessNum = sessmgr.filterSession({key="all"}, true)
if not sessMax then sessMax = 100 end
g_logger:debug("sessMax =="..tostring(sessMax))
if tonumber(existSessNum) >= tonumber(sessMax) then
g_logger:warn("Sessions will exceed sessMax!!! existSessNum == "..existSessNum)
return true
end
return false
end
UserMgrLogicClass.__exceedUserMax = function(self, userMax)
local _, loginedUsers = sessmgr.filterSession({key="status_login",value="logined"}, true)
if not userMax then userMax = 1 end
g_logger:debug("userMax =="..tostring(userMax))
if tonumber(loginedUsers) >= tonumber(userMax) then
g_logger:warn("Logined users will exceed userMax!!! loginedUsers == "..loginedUsers)
return true
end
return false
end
UserMgrLogicClass.__setLogined = function(self, sess_id)
session_set(sess_id, "status_login", "logined")
local nickName = __getRightNickName(session_get(sess_id, "login_right"))
local logstr = cgilua.remote_addr.." -- "..nickName..": login success"
local loginInfoItem = userMgrTbl:findItem("loginSuccInfo")
if loginInfoItem ~= nil then
local customValue = loginInfoItem:getAttribute("value")
local customFunc = loginInfoItem:getAttribute("func")
if customFunc then
logstr = customFunc()
elseif customValue then
logstr = customValue
end
end
g_logger:custom(logstr , "ERROR", "SECURITY")
if env.getenv("CountryCode") == "98" then
local indiahathwaylog = "user login from " .. cgilua.remote_addr
g_logger:custom(indiahathwaylog , "ERROR", "SYSTEM")
end
if env.getenv("CountryCode") == "124" then
local setData = {["RestoreFlag"] = 1}
local setTbl = cmapi.nocsrf.setinst("OBJ_USERIF_ID", "IGD", setData)
end
return sessmgr.session_replace(sess_id)
end
function __changePwd(pwd, chpwdFlag)
local InstId, objId, retId = "IGD", "OBJ_USERINFO_ID", 0
local name = sessmgr.GetCurrentSessAttr("login_name")
local right = sessmgr.GetCurrentSessAttr("login_right")
local listTbl = cmapi.querylist(objId, "IGD")
if listTbl.IF_ERRORID ~= 0 or listTbl.Count == 888 then
g_logger:warn("OBJ_USERINFO_ID querylist error")
retId = loginErrCode.PASSWORD_CHANGE_ERROR
return retId
end
for i=1, listTbl.Count do
local id = listTbl[i].InstName or listTbl[i]
local getTbl = cmapi.getinst(objId, id)
if name == getTbl.Username and 1 == tonumber(getTbl.Type) and right == getTbl.Right then
InstId = id
break
end
end
if InstId ~= "IGD" then
local setData = {["Username"] = name, ["Password"] = pwd, ["ChgPwd"] = chpwdFlag}
local setTbl = cmapi.setinst(objId, InstId, setData)
if type(setTbl) == "table" then
if setTbl.IF_ERRORID ~= 0 then
g_logger:warn("OBJ_USERINFO_ID setinst error.")
if 239 == tonumber(setTbl.IF_ERRORSTR) then
retId = loginErrCode.PASSWORD_ISNOT_SECURITY
else
retId = loginErrCode.PASSWORD_CHANGE_ERROR
end
else
if pwd then
local token = sessmgr.GetCurrentSessAttr("logintoken")
sessmgr.SetCurrentSessAttr("login_pwd", cmapi.nocsrf.sha256(pwd .. token))
end
end
else
g_logger:warn("cmapi.setinst's ret is not a table.")
retId = loginErrCode.PASSWORD_CHANGE_ERROR
end
else
g_logger:warn("Not find the target instance.")
retId = loginErrCode.PASSWORD_CHANGE_ERROR
end
return retId
end
UserMgrLogicClass.doChangePwd = function (self, action)
local sess_id = sessmgr.GetCurrentSessID()
if self:getStatus() ~= "chpwd" then
g_logger:warn("Should not go into doChangePwd!!! status == "..tostring(status))
return "LOGIN_REFRESH_PAGE"
end
if action == "changepwd" then
local newPwd = cgilua.POST.Password
local chpwdFlag = "0"
local retCode = __changePwd(newPwd, chpwdFlag)
newPwd = nil
if retCode == 0 then
return self:__loginProcess(sess_id)
elseif retCode == loginErrCode.PASSWORD_ISNOT_SECURITY then
return "PASSWORD_ISNOT_SECURITY"
elseif retCode == loginErrCode.PASSWORD_CHANGE_ERROR then
return "PASSWORD_CHANGE_ERROR"
end
elseif action == "changepwd_cancel" then
local chpwdMode = self:getUserMgrAttrValue("chpwdMode")
if chpwdMode == "required" then
sessmgr.SetCurrentSessAttr("status_login", "unchecked")
elseif chpwdMode == "optional" then
local typeofOptional = self:getUserMgrAttr("chpwdMode","opts","typeofOptional")
if typeofOptional == "one-off" then
if 0 ~= __changePwd(nil, "0") then
g_logger:warn("Set ChgPwd to 0 fail. But still let in.")
end
return self:__loginProcess(sess_id)
elseif typeofOptional == "repeat-until" then
return self:__loginProcess(sess_id)
else
g_logger:error("Unexpected typeofOptional! typeofOptional == " .. tostring(typeofOptional))
end
else
g_logger:error("Unexpected chpwdMode! chpwdMode == " .. tostring(chpwdMode))
end
return "LOGIN_REFRESH_PAGE"
else
g_logger:error("Unexpected action! action == " .. tostring(action))
end
end
UserMgrLogicClass.__countLoginErrNum = function(self, sess_id)
local errLoginNum = tonumber(session_get(sess_id, "errLoginNum") or 0)
errLoginNum = errLoginNum + 1
session_set(sess_id, "errLoginNum", errLoginNum)
session_set(sess_id, "errLoginTime", cmapi.timestamp())
end
UserMgrLogicClass.__clearLoginErr = function(self)
local sessTbl = sessmgr.filterSession({key="client_ip", value=cgilua.remote_addr})
for _, sid in ipairs(sessTbl) do
session_set(sid, "errLoginNum", 0)
session_set(sid, "errLoginTime", 0)
end
end
UserMgrLogicClass.__synTimestampWhenLocked = function(self)
local currSessId = sessmgr.GetCurrentSessID()
local timestamp = session_get(currSessId, "timestamp")
local sessTbl = sessmgr.filterSession({key="client_ip", value=cgilua.remote_addr})
for _, sid in ipairs(sessTbl) do
if sid ~= currSessId then
local errLoginNum = tonumber(session_get(sid, "errLoginNum") or 0)
if errLoginNum > 0 then
session_set(sid, "timestamp", timestamp)
end
end
end
end
UserMgrLogicClass.__isLoginlocked = function(self)
local LOCKING_PERIOD = tonumber(self:getUserMgrAttrValue("lockTimeout") or 60)
if (env.getenv("LockNum") == "1" and "2008" == env.getenv("CountryCode")) or "123" == env.getenv("CountryCode") then
LOCKING_PERIOD = tonumber(120)
end
local totalErrNum, lastErrTime, lastLockTimestamp, lockingLeftTime, isLocked = 0, 0, 0, 0, false
local sessTbl = sessmgr.filterSession({key="client_ip", value=cgilua.remote_addr})
for _, sid in ipairs(sessTbl) do
local errLoginNum = tonumber(session_get(sid, "errLoginNum") or 0)
if errLoginNum > 0 then
totalErrNum = totalErrNum + errLoginNum
local errLoginTime = tonumber(session_get(sid, "errLoginTime") or 0)
if errLoginTime > lastErrTime then
lastErrTime = errLoginTime
end
local lockTs = tonumber(session_get(sid, "LockTimestamp") or 0)
if lockTs > lastLockTimestamp then
lastLockTimestamp = lockTs
end
end
end
g_logger:debug("totalErrNum == "..totalErrNum)
local curTime = cmapi.timestamp()
lockingLeftTime = LOCKING_PERIOD - (curTime - lastLockTimestamp)
if lockingLeftTime > 0 and lastLockTimestamp > 0 then
g_logger:debug("Still locking. lockingLeftTime == "..lockingLeftTime)
return true, lockingLeftTime
end
if totalErrNum > 0 and totalErrNum % tonumber(self:getUserMgrAttrValue("lockMaxTime") or 3) == 0 then
lockingLeftTime = LOCKING_PERIOD - (curTime - lastErrTime)
if lockingLeftTime > 0 then
isLocked = true
sessmgr.SetCurrentSessAttr("LockTimestamp", curTime)
else
env.setenv("LockNum", "1")
end
end
if not isLocked then
lockingLeftTime = 0
sessmgr.UnsetCurrentSessAttr("LockTimestamp")
else
local logstr = cgilua.remote_addr.." failed to login repeatedly and it was locked."
g_logger:custom(logstr, "ERROR", "SECURITY")
end
g_logger:debug("isLocked == "..tostring(isLocked))
return isLocked, lockingLeftTime
end
UserMgrLogicClass.__getErrTypebyDefault = function(self)
local loginStatus = self:getLoginStatus()
if loginStatus == "loginTimeout" then
return "LOGIN_TIMEOUT"
end
local totalErrNum = 0
local sessTbl = sessmgr.filterSession({key="client_ip", value=cgilua.remote_addr})
for _, sid in ipairs(sessTbl) do
totalErrNum = totalErrNum + tonumber(session_get(sid, "errLoginNum") or 0)
end
if totalErrNum > 0 then
if self:__isLoginlocked() then
return "LOGIN_LOCKED"
else
return "LOGIN_PAGE_NO_ERROR"
end
else
return "LOGIN_PAGE_NO_ERROR"
end
end
UserMgrLogicClass.getLoginErrMsg2Show = function(self, loginErrType)
local errIdTbl = {
LOGIN_PAGE_NO_ERROR = {loginErrMsg="", lockingTime=0, promptMsg=""},
LOGIN_TIMEOUT = {loginErrMsg=lang.login_020, lockingTime=-1, promptMsg=""},
EXCEED_MAX_USER = {loginErrMsg=lang.login_012, lockingTime=-1, promptMsg=""},
USER_LEVEL_NOT_MATCH = {loginErrMsg=lang.login_016, lockingTime=-1, promptMsg=""},
EXCEED_MAX_SESSION = {loginErrMsg=lang.login_025, lockingTime=-1, promptMsg=""},
INVALID_USERNAME_PASSWORD = function(self)
if "2008" == env.getenv("CountryCode") then
return {loginErrMsg=lang.AccountManag_016, lockingTime=-1, promptMsg=""}
else
return {loginErrMsg=lang.login_013, lockingTime=-1, promptMsg=""}
end
end,
LOGIN_LOCKED = function(self)
local _, lockingTime = self:__isLoginlocked()
if "54" == env.getenv("CountryCode") then
return {loginErrMsg="", lockingTime=lockingTime, promptMsg=lang.AccountManag_014}
elseif "122" == env.getenv("CountryCode") then
return {loginErrMsg="", lockingTime=lockingTime, promptMsg=lang.AccountManag_mytel_014}
else
return {loginErrMsg="", lockingTime=lockingTime, promptMsg=lang.login_014}
end
end,
LOGIN_REFRESH_PAGE = function(self)
local sess_id = sessmgr.GetCurrentSessID()
if "95"==env.getenv("CountryCode") and "2"==session_get(sess_id, "login_right") then
local needTipVal = false
if env.getenv("TimeSyn") == "1" then
local tUserIf = cmapi.getinst("OBJ_USERIF_ID", "IGD")
local tCurTime = cmapi.getinst("OBJ_CURTIME_ID", "IGD")
local intervl = tonumber(tCurTime.curTimeSec) - tonumber(tUserIf.ExtraDwd)
if tonumber(tUserIf.ExpiryTime) > 0 and intervl > tonumber(tUserIf.ExpiryTime) then
needTipVal = true
end
end
return {login_need_refresh=true, needTip=needTipVal}
else
return {login_need_refresh=true}
end
end,
EXCEED_MAX_USER_PREEMPT = {login_need_refresh=true},
PASSWORD_CHANGE_ERROR = {loginErrMsg=lang.cmret_001, lockingTime=-1, promptMsg=""},
PASSWORD_ISNOT_SECURITY = {loginErrMsg=lang.cmret_239, lockingTime=-1, promptMsg=""},
INVALID_CAPTCHA = {loginErrMsg=lang.login_026, lockingTime=-1, promptMsg=""},
CSRF_CHECK_FAIL = {loginErrMsg=lang.cmret_1452, lockingTime=-1, promptMsg=""},
DEFAULT_LOGINFO_CHANGED = {loginErrMsg=lang.login_030, lockingTime = -1,promptMsg=""},
DEFAULT_LOGINFO_NOTCHANGED= {loginErrMsg=lang.login_029, lockingTime = -1,promptMsg=""},
REMOTE_ACCESS_DISABLE = {loginErrMsg=lang.pdt_login_029, lockingTime=-1, promptMsg=""},
}
if "122"==env.getenv("CountryCode") then
errIdTbl.DEFAULT_LOGINFO_CHANGED = {loginErrMsg=lang.mytel_login_002, lockingTime = -1,promptMsg=""}
errIdTbl.DEFAULT_LOGINFO_NOTCHANGED= {loginErrMsg=lang.mytel_login_001, lockingTime = -1,promptMsg=""}
end
if not loginErrType or loginErrType=="NULL" then
loginErrType = self:__getErrTypebyDefault()
end
g_logger:debug("loginErrType == " .. loginErrType)
local msg = errIdTbl[loginErrType]
if type(msg) == "function" then msg = msg(self) end
g_logger:debug("loginErrMsg == " .. tostring(msg.loginErrMsg) .. ", promptMsg == " .. tostring(msg.promptMsg))
return msg or {login_need_refresh=true}
end
local usermgrLogicImpl = UserMgrLogicClass()
usermgrLogicImpl:loadUsermgrAttrRules()
return usermgrLogicImpl
