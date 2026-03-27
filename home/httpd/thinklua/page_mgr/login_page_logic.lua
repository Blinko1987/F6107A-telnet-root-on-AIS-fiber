local oopclass = require("common_lib.oop_class")
local class = oopclass.class
local loginpageTableMgr = require("page_mgr.login_page_mgr")
local isFileExist = require"common_lib.file_utils".isFileExist
local usermgrLogicImpl = require("user_mgr.usermgr_logic_impl")
local sessmgr = require("user_mgr.session_mgr")
local LoginPageMgrClass = class()
LoginPageMgrClass.loadLoginpageRules = function ( self )
loginpageTableMgr:loadStaticConfig({
tableFile="page_mgr.login_table_conf",
modifierFile="page_mgr.login_table_modifier"
})
end
LoginPageMgrClass.getViewFiles = function ( routerType, resourceTag )
g_logger:debug("routerType="..routerType)
local loginType = resourceTag
if not usermgrLogicImpl:checkAccessFrom() then
loginType = "checkAccessFrom"
else
loginType = usermgrLogicImpl:getStatus()
if loginType == "logined" then
return false
elseif loginType == "unchecked" or loginType == "timeout" then
sessmgr.set_sess_client_cookie("_TESTCOOKIESUPPORT", "1")
if not usermgrLogicImpl:checkIfNeedAuth() then
loginType = "autoAuth"
end
elseif loginType == "chpwd" then
loginType = "chpwd"
elseif loginType == "wanneedchpwd" then
loginType = "wanneedchpwd"
end
end
local loginpageItem = loginpageTableMgr:findItem(loginType)
if not loginpageItem then
return false
end
local basicType = loginpageItem:getAttribute("basicType")
if basicType ~= "view" then
return false
end
local file = loginpageItem:getAttribute("fileName")
g_logger:debug("file="..file)
if not isFileExist(file) then
return false
end
return true, {{file=file}}, nil
end
LoginPageMgrClass.getDataFiles = function ( routerType, resourceTag )
g_logger:debug("routerType="..routerType)
local loginType = resourceTag
local loginpageItem = loginpageTableMgr:findItem(loginType)
if not loginpageItem then
return false
end
local basicType = loginpageItem:getAttribute("basicType")
if basicType ~= "data" then
return false
end
local needLogin = loginpageItem:getAttribute("needLogin")
if needLogin then
if not usermgrLogicImpl:isLogined() then
return false
end
end
local file = loginpageItem:getAttribute("fileName")
g_logger:debug("file="..file)
if not isFileExist(file) then
return false
end
return true, {{file=file}}, nil
end
local loginPageMgr = LoginPageMgrClass()
loginPageMgr.loadLoginpageRules()
return loginPageMgr
