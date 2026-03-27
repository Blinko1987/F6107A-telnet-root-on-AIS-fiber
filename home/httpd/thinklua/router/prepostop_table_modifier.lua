local fileutils = require "common_lib.file_utils"
local tableutils = require "common_lib.table_utils"
local stringutils = require "common_lib.string_utils"
require "view_assemble.view_common_func"
require "data_assemble.cmapi"
local cgilua = cgilua.cgilua
local logapi = logapi
local usermgr = require("user_mgr.usermgr_logic_impl")
local sessmgr = require("user_mgr.session_mgr")
local logFlag = ""
local prePostOpTableMgr = require("router.prepostop_table_mgr")
prePostOpTableMgr:addModifier(function ()
local preOpFunc = function ()
math.randomseed(cmapi.randomseed())
local sess_id = sessmgr.initsession()
if sess_id == nil or sess_id == "" then
sapi.Response.statusline("Location: /")
return true
end
sessmgr.session_start(sess_id)
local expnfilename = cgilua.servervariable("SCRIPT_NAME")
if string.find(expnfilename, "information/getinfo.cgi/", 1, true) == nil then
sessmgr.set_sess_client_cookie("SID", sess_id)
end
end
prePostOpTableMgr:addItem({topic="initSession",
preOpFunc=preOpFunc,
postOpFunc=nil})
end)
:addModifier(function ()
local preOpFunc = function ()
local client_ip = sessmgr.GetCurrentSessAttr("client_ip")
if client_ip ~= nil and client_ip ~= cgilua.remote_addr then
g_logger:notice("client_ip is changed")
sessmgr.remove_sess_client_cookie("SID")
web_service_go2_login_page()
return true
end
end
prePostOpTableMgr:addItem({topic="makeSaferByIPAddress",
preOpFunc=preOpFunc,
postOpFunc=nil})
end)
:addModifier(function ()
local preOpFunc = function ()
if cmapi.file_exists("template/pro_interface.lua") == 1 then
require "template.pro_interface"
end
local cver = env.getenv("CountryCode")
local configFreshFile = string.format("template/fresh_config_%s.lua",cver)
local configFreshModule = string.format("template/fresh_config_%s",cver)
if cmapi.file_exists(configFreshFile) == 1 then
package.loaded[configFreshModule] = nil
require(configFreshModule)
package.loaded[configFreshModule] = nil
end
end
prePostOpTableMgr:addItem({topic="loadingProInterface",
preOpFunc=preOpFunc,
postOpFunc=nil})
end)
:addModifier(function ()
local preOpFunc = function ()
local modeSwitchEnv = sessmgr.GetCurrentSessAttr("ModeSwitchEnv")
if not modeSwitchEnv then
modeSwitchEnv = "Advanced"
sessmgr.SetCurrentSessAttr("ModeSwitchEnv", modeSwitchEnv)
end
usermgr:setUserRight2Sess()
end
prePostOpTableMgr:addItem({topic="setUserRight2Session",
preOpFunc=preOpFunc,
postOpFunc=nil})
end)
:addModifier(function ()
local preOpFunc = function ()
local envLogicImpl = require("cgilua.globalenv_logic_impl")
envLogicImpl:initGlobalEnv()
end
prePostOpTableMgr:addItem({topic="initializeGlobalEnv",
preOpFunc=preOpFunc,
postOpFunc=nil})
end)
:addModifier(function ()
local preOpFunc = function ()
local langLogicImpl = require("view_assemble.lang_logic_impl")
_G.lang = langLogicImpl:initialize()
end
prePostOpTableMgr:addItem({topic="loadLanguageModule",
preOpFunc=preOpFunc,
postOpFunc=nil})
end)
:addModifier(function ()
local preOpFunc = function ()
_G.menutree = require("page_mgr.menu_logic_impl"):initialize()
end
prePostOpTableMgr:addItem({topic="loadMenuModule",
preOpFunc=preOpFunc,
postOpFunc=nil})
end)
:addModifier(function ()
local preOpFunc = function ()
local expnfilename = cgilua.servervariable("SCRIPT_NAME")
if string.find(expnfilename, "information/getinfo.cgi/", 1, true) == nil then
cgilua.header("Server","")
cgilua.header("Accept-Ranges","bytes")
cgilua.header("X-Content-Type-Options", "nosniff")
cgilua.header("X-XSS-Protection", "1; mode=block")
cgilua.header("Content-Security-Policy", "frame-ancestors 'self' ")
cgilua.header("X-Frame-Options", "SAMEORIGIN")
end
cgilua.__content_type_cache = nil
end
local postOpFunc = function ()
local contenttype = cgilua.__content_type_cache
if contenttype then
cgilua.header("Content-Type", contenttype)
end
end
prePostOpTableMgr:addItem({topic="setResponseHeader",
preOpFunc=preOpFunc,
postOpFunc=postOpFunc})
end)
