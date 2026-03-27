local oopclass = require("common_lib.oop_class")
local class = oopclass.class
local assertlib = require("common_lib.assert_utils")
local typeAssert = assertlib.typeAssert
local valueAssert = assertlib.valueAssert
local fileutils = require"common_lib.file_utils"
local isFileExist = fileutils.isFileExist
local usermgr = require("user_mgr.usermgr_logic_impl")
local sessmgr = require("user_mgr.session_mgr")
local MenuPageMgrClass = class()
MenuPageMgrClass.getFramePageFiles = function ( routerType, resourceTag )
g_logger:debug("routerType="..routerType)
local frameFile = "../template/commonpageFrame.lp"
if not usermgr:isLogined() then
return false
end
sessmgr.UpdateCurrentSess()
local menuID = menutree:getPageIDOnFullLoading()
local areaFiles = menutree:queryAccessibleAreaViews(menuID)
local path = "../../webmodules/modules/"
local areaViewFiles = {}
for _,file in ipairs(areaFiles) do
g_logger:debug("areaFile="..path..file)
table.insert(areaViewFiles, {file=path..file})
end
local viewFiles = {file=frameFile,
children=areaViewFiles}
return true, {viewFiles}, nil
end
MenuPageMgrClass.getFuncAreaFiles = function ( routerType, resourceTag )
g_logger:debug("routerType="..routerType)
local menuID = resourceTag
local refreshPage = "../template/NotFoundPage_reload.html"
local refreshFiles = {{file=refreshPage}}
if not usermgr:isLogined() then
g_logger:debug("isLogined() return false")
return false, refreshFiles
end
if not menutree:checkMenuAccessible(menuID) then
g_logger:debug("checkMenuAccessible(menuID) return false")
return false, refreshFiles
end
sessmgr.SetCurrentSessAttr("nextpage", menuID);
sessmgr.UpdateCurrentSess()
local areaFiles = menutree:queryAccessibleAreaViews(menuID)
local path = "../../webmodules/modules/"
local viewFiles = {}
for _,file in ipairs(areaFiles) do
g_logger:debug("areaFile="..path..file)
table.insert(viewFiles, {file=path..file})
end
return true, viewFiles, nil
end
MenuPageMgrClass.getFuncAreaData = function ( routerType, resourceTag )
g_logger:debug("routerType="..routerType.."&resourceTag="..resourceTag)
if not usermgr:isLogined() then
return false
end
local dataFile = resourceTag
local ret, areaObj = menutree:checkBackEndFile(dataFile)
if not ret then
return false
end
local path = "../../webmodules/modules/"
local file = path..dataFile
if not isFileExist(file) then
return false
end
local needSessUpdate = areaObj:getAttribute("needSessUpdate")
if needSessUpdate then
sessmgr.UpdateCurrentSess()
end
return true, {{file=file}}, nil
end
MenuPageMgrClass.changeCurrentPage = function ( self, pageID )
typeAssert(pageID, "string")
if not usermgr:isLogined() then
return false
end
if not menutree:checkMenuAccessible(pageID) then
return false
end
sessmgr.SetCurrentSessAttr("nextpage", pageID);
return true
end
local menuPageMgr = MenuPageMgrClass()
return menuPageMgr
