local json = require("common_lib.json")
local cgilua = require("cgilua.cgilua")
local usermgrLogicImpl = require("user_mgr.usermgr_logic_impl")
local action = cgilua.POST.action
local loginErrType = usermgrLogicImpl:doChangePwd(action)
local sessStatus = usermgrLogicImpl:getLoginErrMsg2Show(loginErrType)
if sessStatus ~= nil then
cgilua.put( json.encode(sessStatus) )
else
g_logger:debug("sessStatus is nil,loginErrType = " .. loginErrType)
end
cgilua.contentheader ("application", "json; charset="..lang.CHARSET)
