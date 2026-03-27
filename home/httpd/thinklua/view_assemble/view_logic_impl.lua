local oopclass = require("common_lib.oop_class")
local class = oopclass.class
local assertlib = require("common_lib.assert_utils")
local typeAssert = assertlib.typeAssert
local valueAssert = assertlib.valueAssert
local viewTableMgr = require("view_assemble.view_table_mgr")
local ViewAssembleLogic = class()
local cgilua = require("cgilua.cgilua")
local cgilua_lp = require "cgilua.lp"
local cbi = require("data_assemble.comapi")
local doModelViewRender = cbi.doModelViewRender
local fileutils = require"common_lib.file_utils"
local remove_suffix_filename = fileutils.remove_suffix_filename
local sessmgr = require("user_mgr.session_mgr")
local function getNowStatus()
local Status = require("user_mgr.usermgr_logic_impl"):getLoginStatus()
local NowStatus = nil
if "loginAlready" == Status then
NowStatus = "showCommonPage"
else
NowStatus = "showloginPage"
end
return NowStatus
end
ViewAssembleLogic.getAssembleEnv = function ( self )
local sess_id = sessmgr.GetCurrentSessID()
local Right = sessmgr.GetCurrentSessAttr("Right") or "4"
local TypeValue = env.getenv("TypeValue")
local CountryCode = env.getenv("CountryCode")
local ModeSwitchEnv = sessmgr.GetCurrentSessAttr("ModeSwitchEnv")
local NowLoginAccount = sessmgr.GetCurrentSessAttr("login_name")
local gw_lang = env.getenv("gw_lang")
local NowStatus = getNowStatus()
cgilua.lp = cgilua_lp
local params_Tab =
{
cgilua = cgilua,
cgilua_lp = cgilua_lp,
require = require,
print = print,
ipairs = ipairs,
pairs = pairs,
getfenv = getfenv,
setfenv = setfenv,
type = type,
tonumber = tonumber,
string = string,
g_logger = g_logger,
sess_id = sess_id,
lang = lang,
io = io,
env = env,
Right = Right,
menutree = menutree,
doModelViewRender = doModelViewRender,
session_get= session_get,
session_set= session_set,
TypeValue = TypeValue,
CountryCode= CountryCode,
ModeSwitchEnv=ModeSwitchEnv,
NowLoginAccount=NowLoginAccount,
gw_lang=gw_lang,
NowStatus = NowStatus,
pro_footer=pro_footer,
remove_suffix_filename = remove_suffix_filename,
cmapi = cmapi,
logapi = logapi,
_G = _G,
}
if params_Tab.menutree == nil then
g_logger:info("menutree nil")
end
if params_Tab.cgilua == nil then
g_logger:info("cgilua nil")
end
if params_Tab.g_logger == nil then
g_logger:info("g_logger nil")
end
if params_Tab.sess_id == nil then
g_logger:info("sess_id  nil")
end
if params_Tab.lang == nil then
g_logger:info("lang  nil")
end
if params_Tab.env == nil then
g_logger:info("env  nil")
end
if params_Tab.Right == nil then
g_logger:info("Right  nil")
end
if params_Tab.session_get == nil then
g_logger:info("session_get  nil")
end
return params_Tab
end
ViewAssembleLogic.loadViewRules = function ( self )
viewTableMgr:loadStaticConfig({
tableFile="view_assemble.view_table_conf",
modifierFile="view_assemble.view_table_modifier"
})
end
ViewAssembleLogic.run = function ( self, files, routerType, params )
g_logger:debug("routerType="..tostring(routerType))
routerType = routerType or ""
files = files or {}
local includeEnv = self:getAssembleEnv()
cgilua.contentheader ("text", "html; charset="..lang.CHARSET)
local assembleRule = viewTableMgr:findItem(routerType)
if assembleRule then
local assembleFile = assembleRule:getAttribute("assembleFile")
includeEnv.renderFiles = files
includeEnv.renderData = params
if type(assembleFile) == "function" then
assembleFile(files, params)
elseif type(assembleFile) == "string" then
cgilua_lp.include(assembleFile, includeEnv, true)
end
else
local firstFile = files[1]
if firstFile then
cgilua_lp.include(firstFile.file, includeEnv, true)
else
sapi.Response.statusline("HTTP/1.1 404 Not Found")
cgilua_lp.include("../template/NotFoundPage.html", {cgilua=cgilua})
end
end
end
local viewAssembler = ViewAssembleLogic()
viewAssembler:loadViewRules()
return viewAssembler
