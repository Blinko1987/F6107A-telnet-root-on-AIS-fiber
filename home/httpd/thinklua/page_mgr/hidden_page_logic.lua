local oopclass = require("common_lib.oop_class")
local class = oopclass.class
local hiddenTableMgr = require("page_mgr.hidden_table_mgr")
local usermgr = require("user_mgr.usermgr_logic_impl")
local sessmgr = require("user_mgr.session_mgr")
local fileutils = require"common_lib.file_utils"
local isFileExist = fileutils.isFileExist
local HiddenPageMgrClass = class()
HiddenPageMgrClass.loadHiddenRules = function ( self )
hiddenTableMgr:loadStaticConfig({
tableFile="page_mgr.hidden_table_conf",
modifierFile="page_mgr.hidden_table_modifier"
})
end
HiddenPageMgrClass.getViewFile = function ( routerType, resourceTag )
g_logger:debug("routerType="..routerType)
local urlPath = resourceTag
local hiddenItem = hiddenTableMgr:findItem(urlPath)
if not hiddenItem then
return false
end
local basicType = hiddenItem:getAttribute("basicType")
if basicType ~= "view" then
return false
end
local needLogin = hiddenItem:getAttribute("needLogin")
if needLogin then
local refreshPage = "../template/NotFoundPage_reload.html"
local refreshFiles = {{file=refreshPage}}
if not usermgr:isLogined() then
return false, refreshFiles
end
local right = hiddenItem:getAttribute("right")
if right and not usermgr:checkRightPassed(right) then
return false, refreshFiles
end
local needSessUpdate = hiddenItem:getAttribute("needSessUpdate")
if needSessUpdate then
sessmgr.UpdateCurrentSess()
end
end
local file = hiddenItem:getAttribute("fileName")
if not isFileExist(file) then
return false
end
return true, {{file=file}}, nil
end
HiddenPageMgrClass.getDataFile = function ( routerType, resourceTag )
g_logger:debug("routerType="..routerType)
local urlPath = resourceTag
local hiddenItem = hiddenTableMgr:findItem(urlPath)
if not hiddenItem then
return false
end
local basicType = hiddenItem:getAttribute("basicType")
if basicType ~= "data" then
return false
end
local needLogin = hiddenItem:getAttribute("needLogin")
if needLogin then
if not usermgr:isLogined() then
return false
end
local right = hiddenItem:getAttribute("right")
if right and not usermgr:checkRightPassed(right) then
return false
end
local needSessUpdate = hiddenItem:getAttribute("needSessUpdate")
if needSessUpdate then
sessmgr.UpdateCurrentSess()
end
end
local file = hiddenItem:getAttribute("fileName")
if not isFileExist(file) then
return false
end
return true, {{file=file}}, nil
end
local hiddenPageMgr = HiddenPageMgrClass()
hiddenPageMgr:loadHiddenRules()
return hiddenPageMgr
