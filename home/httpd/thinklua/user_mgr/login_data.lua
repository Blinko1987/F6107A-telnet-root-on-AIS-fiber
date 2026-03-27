local json = require("common_lib.json")
local cgilua = require("cgilua.cgilua")
local usermgrLogicImpl = require("user_mgr.usermgr_logic_impl")
cgilua.contentheader ("application", "json; charset="..lang.CHARSET)
local loginErrType
local action = cgilua.POST.action
if action == "login" then
loginErrType = usermgrLogicImpl:doLogin()
if loginErrType == nil then
g_logger:warn(string.format("usermgrLogicImpl:doLogin() (%s) ret is nil!", action))
end
else
g_logger:debug(string.format("current action is %s.", tostring(action)))
end
local sessStatus = usermgrLogicImpl:getLoginErrMsg2Show(loginErrType)
if sessStatus~= nil then
local sessmgr = require("user_mgr.session_mgr")
local token = cmapi.nocsrf.tokenRandom()
sessmgr.SetCurrentSessAttr("sess_token", token)
sessStatus.sess_token = token
cgilua.put( json.encode(sessStatus) )
else
g_logger:debug("sessStatus is nil, loginErrType = " .. loginErrType)
end
