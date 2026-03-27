local usermgrTableMgr = require("user_mgr.usermgr_table_mgr")
usermgrTableMgr:addModifier(function ()
if "21" == env.getenv("CountryCode") then
usermgrTableMgr:setUserMgrAttr("autofillUsername", "value", 2)
usermgrTableMgr:setUserMgrAttr("autofillPassword", "value", 2)
end
end)local usermgrTableMgr = require("user_mgr.usermgr_table_mgr")
usermgrTableMgr:addModifier(function ()
if env.getenv("CountryCode") == "21" then
usermgrTableMgr:setUserMgrAttr("autofillUsername", "value", 4)
usermgrTableMgr:setUserMgrAttr("autofillPassword", "value", 4)
end
end)usermgrTableMgr:addModifier(function ()
end)usermgrTableMgr:addModifier(function ()
end)local usermgrTableMgr = require("user_mgr.usermgr_table_mgr")
usermgrTableMgr:addModifier(function ()
if env.getenv("CountryCode") == "136" then
usermgrTableMgr:setUserMgrAttr("lockTimeout", "value", 600)
usermgrTableMgr:setUserMgrAttr("lockMaxTime", "value", 5)
end
end)local usermgrTableMgr = require("user_mgr.usermgr_table_mgr")
usermgrTableMgr:addModifier(function ()
local function setAuthRight()
local IsWAN = cmapi.nocsrf.IsWANAccess(cgilua.remote_addr)
local IsLimitSuperAdmin = 0
local ACLTable = cmapi.getinst("OBJ_SUPERADMIN_ACL_ID", "IGD")
if ACLTable.IF_ERRORID == 0 then
IsLimitSuperAdmin = ACLTable.SuperEnable
end
if IsLimitSuperAdmin == "1" and IsWAN == 2 then
return 2
else
return 0
end
end
usermgrTableMgr:setUserMgrAttr("userLevel", "func", setAuthRight)
end)
local cgilua = require("cgilua.cgilua")
usermgrTableMgr:addModifier(function ()
if env.getenv("CountryCode") == "156" then
local function LoginCtr()
local accessPort = cgilua.servervariable("SERVER_PORT")
if accessPort==265 or accessPort==266 or accessPort==300 then
return 1
else
return 2
end
end
usermgrTableMgr:setUserMgrAttr("userLevel", "func", LoginCtr)
usermgrTableMgr:setUserMgrAttr("chpwdMode", "value", "required")
usermgrTableMgr:setUserMgrAttr("userMax", "value", 25)
usermgrTableMgr:setUserMgrAttr("needAuth", "value", "LAN")
end
end)
local cgilua = require("cgilua.cgilua")
usermgrTableMgr:addModifier(function ()
if env.getenv("CountryCode") == "2009" then
local function isLogin()
local accessFrom = cmapi.IsWANAccess(cgilua.remote_addr)
if accessFrom == 2 then
return 0
else
return 1
end
end
usermgrTableMgr:setUserMgrAttr("userLevel", "func", isLogin)
end
end)
usermgrTableMgr:addModifier(function ()
if env.getenv("CountryCode") == "79" then
usermgrTableMgr:setUserMgrAttr("chpwdMode", "value","optional")
:setUserMgrAttr("chpwdMode", "opts",{typeofOptional="one-off"})
end
end)local cgilua = require("cgilua.cgilua")
usermgrTableMgr:addModifier(function ()
if env.getenv("CountryCode") == "154" then
local function isLogin()
local accessFrom = cmapi.IsWANAccess(cgilua.remote_addr)
if accessFrom == 2 then
return 0
else
return 5
end
end
usermgrTableMgr:setUserMgrAttr("userLevel", "func", isLogin)
end
end)
local cgilua = require("cgilua.cgilua")
usermgrTableMgr:addModifier(function ()
if env.getenv("CountryCode") == "68" then
local function isLogin()
local accessFrom = cmapi.IsWANAccess(cgilua.remote_addr)
if accessFrom == 2 then
return 0
else
return 1
end
end
usermgrTableMgr:setUserMgrAttr("userLevel", "func", isLogin)
end
end)
local cgilua = require("cgilua.cgilua")
usermgrTableMgr:addModifier(function ()
end)
local usermgrTableMgr = require("user_mgr.usermgr_table_mgr")
local cgilua = require("cgilua.cgilua")
usermgrTableMgr:addModifier(function ()
if env.getenv("CountryCode") == "139" then
local getLoginSuccInfo = function ()
local customLoginStr = "user login success:current right is "
local sessmgr = require("user_mgr.session_mgr")
local sess_id = sessmgr.GetCurrentSessID()
local login_right = session_get(sess_id, "login_right")
local srcPort = cmapi.nocsrf.get_remote_port(REQUEST.SERVER_FD)
customLoginStr = customLoginStr .. login_right .. " source " .. cgilua.remote_addr .. ":" .. srcPort
return customLoginStr
end
usermgrTableMgr:addItem({attr="loginSuccInfo", value="", func=getLoginSuccInfo})
local getLoginFailInfo = function ()
local customLoginStr = "user login failed:"
local srcPort = cmapi.nocsrf.get_remote_port(REQUEST.SERVER_FD)
customLoginStr = customLoginStr .. " source " .. cgilua.remote_addr .. ":" .. srcPort
return customLoginStr
end
usermgrTableMgr:addItem({attr="loginFailInfo", value="", func=getLoginFailInfo})
local getLogoutInfo = function ()
local customLoginStr = "user logout success:"
local srcPort = cmapi.nocsrf.get_remote_port(REQUEST.SERVER_FD)
customLoginStr = customLoginStr .. " source " .. cgilua.remote_addr .. ":" .. srcPort
return customLoginStr
end
usermgrTableMgr:addItem({attr="logoutInfo", value="", func=getLogoutInfo})
end
end)
usermgrTableMgr:addModifier(function ()
if env.getenv("CountryCode") == "128" or env.getenv("CountryCode") == "185" or env.getenv("CountryCode") == "204" then
usermgrTableMgr:setUserMgrAttr("chpwdMode", "value", "required")
end
end)local usermgrTableMgr = require("user_mgr.usermgr_table_mgr")
usermgrTableMgr:addModifier(function ()
if env.getenv("CountryCode") == "14" then
usermgrTableMgr:setUserMgrAttr("lockTimeout", "value", 1800)
end
end)
