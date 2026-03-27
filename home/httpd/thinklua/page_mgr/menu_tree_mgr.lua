local oopclass = require("common_lib.oop_class")
local class = oopclass.class
local instanceof = oopclass.instanceof
local assertlib = require("common_lib.assert_utils")
local typeAssert = assertlib.typeAssert
local usermgr = require("user_mgr.usermgr_logic_impl")
local lfs = require("lfs")
local AttrNode = require("common_lib.attr_node_class")
local cgilua = require("cgilua.cgilua")
local RightAttrNode, MenuNode, MenuItem, Page, Area, Dmenu
RightAttrNode = class(AttrNode)
RightAttrNode.__abstract = true
RightAttrNode.__checkRightPassed = function ( self )
local nodeRight = self:getAttribute("right")
if not nodeRight then
return false
end
nodeRight = tonumber(nodeRight)
if not usermgr:isLogined() then
if not usermgr:isRightsMeeted(4, nodeRight) then
return false
end
else
if not usermgr:checkRightPassed(nodeRight) then
return false
end
end
return true
end
RightAttrNode.__checkAccessible = function ( self )
if not self:__checkRightPassed() then
return false
end
local filterFunc = self:getAttribute("filterFunc")
local beFilter = false
if filterFunc then
if type(filterFunc) == "function" then
beFilter = filterFunc()
else
for _, f in ipairs(filterFunc) do
beFilter = f()
if beFilter then
break
end
end
end
if beFilter then
return false
end
end
return true
end
MenuNode = class(RightAttrNode)
MenuNode.__abstract = true
MenuNode.__killZombie = function (self)
local subMenu = self.__subMenu
if #subMenu > 0 then
return
end
self:remove()
end
MenuNode.remove = function (self)
local parentMenu = self.__parentMenu
if not parentMenu then
return self
end
local subMenu = parentMenu.__subMenu
self:searchCollection(subMenu, function ( item, index )
if self == item then
table.remove(subMenu, index)
item.__parentMenu = nil
return false
end
end)
parentMenu:__killZombie()
return self
end
MenuNode.appendTo = function (self, menuid, position)
typeAssert(menuid, "string")
typeAssert(position, "number", "nil")
if self.__parentMenu then
error("self menuNode must be removed from menutree first!")
end
local targetMenu = Dmenu:getInstance():findMenu(menuid)
if not targetMenu then
error("menuid cannot be found!")
end
if not instanceof(targetMenu, MenuItem) then
error("menuid must be MenuItem!")
end
local subMenu = targetMenu.__subMenu
if not position then
position = #subMenu + 1
elseif position < 1 then
position = 1
elseif position > #subMenu then
position = #subMenu + 1
end
table.insert(subMenu, position, self)
self.__parentMenu = targetMenu
return self
end
MenuNode.insertAfter = function (self, menuid)
typeAssert(menuid, "string")
if self.__parentMenu then
error("self menuNode must be removed from menutree first!")
end
local selfNode = Dmenu:getInstance():findMenu(self.id)
if selfNode then
error(self.id .. " has been exist.")
end
local targetMenuNode = Dmenu:getInstance():findMenu(menuid)
if not targetMenuNode then
error("menuid doesn't exist.")
end
if not instanceof(targetMenuNode, MenuNode) then
error("menuid isnot a MenuNode.")
end
local targetIndex = nil
local parentMenu = targetMenuNode.__parentMenu
parentMenu:searchCollection(parentMenu.__subMenu, function ( item, index )
if item:getAttribute("id") == menuid then
targetIndex = index
return false
end
end)
table.insert(parentMenu.__subMenu, targetIndex+1, self)
self.__parentMenu = parentMenu
return self
end
MenuNode.insertBefore = function (self, menuid)
typeAssert(menuid, "string")
if self.__parentMenu then
error("self menuNode must be removed from menutree first!")
end
local targetMenuNode = Dmenu:getInstance():findMenu(menuid)
if not targetMenuNode then
error("menuid doesn't exist.")
end
if not instanceof(targetMenuNode, MenuNode) then
error("menuid isnot a MenuNode.")
end
local targetIndex = nil
local parentMenu = targetMenuNode.__parentMenu
parentMenu:searchCollection(parentMenu.__subMenu, function ( item, index )
if item:getAttribute("id") == menuid then
targetIndex = index
return false
end
end)
table.insert(parentMenu.__subMenu, targetIndex, self)
self.__parentMenu = parentMenu
return self
end
MenuNode.replace = function ( self, menuid )
typeAssert(menuid, "string")
if self.__parentMenu then
error("self menuNode must be removed from menutree first!")
end
local targetMenuNode = Dmenu:getInstance():findMenu(menuid)
if not targetMenuNode then
error("menuid doesn't exist.")
end
if not instanceof(targetMenuNode, MenuNode) then
error("menuid isnot a MenuNode.")
end
local targetIndex = nil
local parentMenu = targetMenuNode.__parentMenu
parentMenu:searchCollection(parentMenu.__subMenu, function ( item, index )
if menuid == item:getAttribute("id") then
targetIndex = index
return false
end
end)
table.remove(parentMenu.__subMenu, targetIndex)
table.insert(parentMenu.__subMenu, targetIndex, self)
self.__parentMenu = parentMenu
return self
end
MenuItem = class(MenuNode)
MenuItem.__init__ = function ( self, menuItemTable )
typeAssert(menuItemTable, "table")
typeAssert(menuItemTable.id, "string")
typeAssert(menuItemTable.name, "string")
typeAssert(menuItemTable.extData, "table", "string", "nil")
typeAssert(menuItemTable.extData2, "number", "nil")
self:__attrInitialize( menuItemTable, {
"id",
"name",
"extData",
"extData2",
})
typeAssert(menuItemTable.children, "table")
self:__initSubMenu(menuItemTable.children)
end
MenuItem.__initSubMenu = function ( self, subMenuTable )
typeAssert(subMenuTable, "table")
self.__subMenu = {}
for _, menuTable in ipairs(subMenuTable) do
local menuNode = nil
if menuTable.children then
menuNode = MenuItem(menuTable)
else
menuNode = Page(menuTable)
end
if menuNode then
table.insert(self.__subMenu, menuNode)
menuNode.__parentMenu = self
end
end
end
MenuItem.__traverseTree = function ( self, handler )
if handler(self) then
return self
end
local targetMenu = nil
local targetIndex = nil
self:searchCollection(self.__subMenu, function ( item, index )
if instanceof( item, MenuItem ) then
targetMenu,targetIndex = item:__traverseTree(handler)
elseif instanceof( item, Page ) then
if handler(item) then
targetMenu = item
targetIndex = index
end
end
if targetMenu then
return false
end
end)
return targetMenu,targetIndex
end
MenuItem.findMenuByCondition = function ( self, conditionFunc )
return self:__traverseTree(conditionFunc)
end
MenuItem.findFirstAvailablePage = function ( self )
local pageObj = self:findMenuByCondition(function ( menuNode )
if instanceof(menuNode, Page) then
if menuNode:__checkAccessible() then
return true
end
end
end)
return pageObj
end
MenuItem.findMenu = function ( self, menuid )
return self:__traverseTree(function ( menuNode )
if menuNode:getAttribute("id") == menuid then
return true
end
end)
end
MenuItem.setSubPageFilterFunc = function ( self, func )
self:searchCollection(self.__subMenu, function ( item, index )
if instanceof( item, MenuItem ) then
item:setSubPageFilterFunc(func)
elseif instanceof( item, Page ) then
item:setAttribute("filterFunc", func)
item:searchCollection(item.__areas, function ( area, index )
if instanceof( area, Area ) then
area:setAttribute("filterFunc", func)
end
end)
end
end)
end
MenuItem.__nodeToJSON = function (self, attrs)
typeAssert(attrs, "table", "nil")
if not self:findFirstAvailablePage() then
return nil
end
if not attrs then
attrs = self.__legal_attrs
end
local cache = {}
self:searchCollection(attrs, function ( item, index )
table.insert(cache, self:__attrToNVPair(item, ":"))
end)
local childrenCache = {}
local subMenu = self.__subMenu
self:searchCollection(subMenu, function ( item, index )
if instanceof(item, Page) then
if item:__checkAccessible() then
table.insert(childrenCache, item:__nodeToJSON({"id","name","pageHelp","extData","extData2"}))
end
else
local jsonStr = item:__nodeToJSON(attrs)
if jsonStr then
table.insert(childrenCache, jsonStr)
end
end
end)
local childrenContent = table.concat(childrenCache, ",")
local childrenNVPair = string.format("\"children\":[%s]", childrenContent)
table.insert(cache, childrenNVPair)
local contentStr = table.concat(cache, ",")
local jsonStr = string.format("{%s}", contentStr)
return jsonStr
end
Page = class(MenuNode)
Page.__init__ = function ( self, pageTable )
typeAssert(pageTable, "table")
typeAssert(pageTable.id, "string")
typeAssert(pageTable.name, "string")
typeAssert(pageTable.right, "number")
typeAssert(pageTable.pageHelp, "string")
typeAssert(pageTable.filterFunc, "function", "nil")
typeAssert(pageTable.children, "nil")
typeAssert(pageTable.extData, "table", "string", "nil")
typeAssert(pageTable.extData2, "number", "nil")
self:__attrInitialize( pageTable, {
"id",
"name",
"right",
"pageHelp",
"filterFunc",
"extData",
"extData2",
})
typeAssert(pageTable.areas, "table")
self:__initAreas(pageTable.areas)
end
Page.__initAreas = function ( self, areasTable )
typeAssert(areasTable, "table")
self.__areas = {}
for _,areaTable in ipairs(areasTable) do
local areaObj = Area(areaTable)
if areaObj then
table.insert(self.__areas, areaObj)
areaObj.__page = self
end
end
end
Page.findArea = function ( self, area )
typeAssert(area, "string")
local targetArea = nil
local targetIndex = nil
local pageAreas = self.__areas
self:searchCollection(pageAreas, function ( item, index )
if item:getAttribute("area") == area then
targetArea = item
targetIndex = index
end
if targetArea then
return false
end
end)
return targetArea, targetIndex
end
Page.__searchAccessibleAreas = function ( self, handler )
local areas = self.__areas
self:searchCollection(areas, function ( item, index )
local areaObj = item
if areaObj:__checkAccessible() then
handler(areaObj)
end
end)
end
Page.__queryAccessibleAreaViews = function ( self )
local accessibleAreaViews = {}
local getMeetedViews = function ( areaObj )
table.insert(accessibleAreaViews, areaObj:getAttribute("area"))
end
self:__searchAccessibleAreas(getMeetedViews)
return accessibleAreaViews
end
Page.__queryAccessibleAreaDatas = function ( self )
local accessibleAreaDatas = {}
local accessibleAreas = {}
local getMeetedDatas = function ( areaObj )
local backendFile = areaObj:getAttribute("backendFile")
if not backendFile then
backendFile = areaObj:getAttribute("area")
end
table.insert(accessibleAreaDatas, backendFile)
table.insert(accessibleAreas, areaObj)
end
self:__searchAccessibleAreas(getMeetedDatas)
return accessibleAreaDatas, accessibleAreas
end
Page.__nodeToJSON = function (self, attrs)
typeAssert(attrs, "table", "nil")
if not attrs then
attrs = self.__legal_attrs
end
local cache = {}
self:searchCollection(attrs, function ( item, index )
table.insert(cache, self:__attrToNVPair(item, ":"))
end)
local areaCache = {}
local _, areas = self:__queryAccessibleAreaDatas()
self:searchCollection(areas, function ( area, index )
table.insert(areaCache, area:__nodeToJSON({"area","extData","extData2"}))
end)
local areaContent = table.concat(areaCache, ",")
local areaNVPair = string.format("\"area\":[%s]", areaContent)
table.insert(cache, areaNVPair)
local contentStr = table.concat(cache, ",")
local jsonStr = string.format("{%s}", contentStr)
return jsonStr
end
local function filterFuncTransfer(oldFilterFunc, value)
typeAssert(value, "function", "nil")
local newValue
if not oldFilterFunc or value == nil then
newValue = value
elseif type(oldFilterFunc) == "function" then
local filterFuncList = {oldFilterFunc}
table.insert(filterFuncList, value)
newValue = filterFuncList
else
table.insert(oldFilterFunc, value)
newValue = oldFilterFunc
end
return newValue
end
Page.setAttribute = function (self, name, value)
if name ~= "filterFunc" then
return self.__class.__parent.setAttribute(self, name, value)
end
return self.__class.__parent.setAttribute(self, name, filterFuncTransfer(self:getAttribute("filterFunc"), value))
end
Area = class(RightAttrNode)
Area.__init__ = function ( self, areaTable )
typeAssert(areaTable, "table")
typeAssert(areaTable.area, "string")
typeAssert(areaTable.right, "number", "nil")
typeAssert(areaTable.filterFunc, "function", "table", "nil")
typeAssert(areaTable.backendFile, "string", "table", "nil")
typeAssert(areaTable.extData, "string", "table", "nil")
typeAssert(areaTable.extData2, "number", "nil")
typeAssert(areaTable.needSessUpdate, "boolean", "nil")
self:__attrInitialize( areaTable, {
"area",
"right",
"filterFunc",
"backendFile",
"extData",
"extData2",
"needSessUpdate"
})
if nil == self.needSessUpdate then
self.needSessUpdate = true
end
end
Area.__checkRightPassed = function ( self )
local areaRight = self:getAttribute("right")
if not areaRight then
local pageRight = self.__page:getAttribute("right")
self:setAttribute("right", pageRight)
end
return self.__class.__parent.__checkRightPassed(self)
end
Area.remove = function (self)
local page = self.__page
if not page then
return self
end
local areas = page.__areas
local selfIndex = nil
page:searchCollection(areas, function ( item, index )
if self == item then
selfIndex = index
return false
end
end)
table.remove(areas, selfIndex)
self.__page = nil
return self
end
Area.appendTo = function (self, menuid, position)
typeAssert(menuid, "string")
typeAssert(position, "number", "nil")
if self.__page then
error("area must be removed from page first!")
end
local targetPage = Dmenu:getInstance():findMenu(menuid)
if not targetPage then
error("menuid doesn't exist!")
end
if not instanceof(targetPage, Page) then
error("menuid isnot a page!")
end
local areas = targetPage.__areas
if not position then
position = #areas + 1
elseif position < 1 then
position = 1
elseif position > #areas then
position = #areas + 1
end
table.insert(areas, position, self)
self.__page = targetPage
return self
end
Area.insertAfter = function (self, menuid, area)
typeAssert(area, "string")
if self.__page then
error("area must be removed from page first!")
end
local targetPage = Dmenu:getInstance():findMenu(menuid)
if not targetPage then
error("menuid doesn't exist!")
end
if not instanceof(targetPage, Page) then
error("menuid isnot a page!")
end
local areas = targetPage.__areas
local targetIndex = nil
targetPage:searchCollection(areas, function ( item, index )
if item:getAttribute("area") == area then
targetIndex = index
return false
end
end)
table.insert(areas, targetIndex+1, self)
self.__page = targetPage
return self
end
Area.insertBefore = function (self, menuid, area)
typeAssert(area, "string")
if self.__page then
error("area must be removed from page first!")
end
local targetPage = Dmenu:getInstance():findMenu(menuid)
if not targetPage then
error("menuid doesn't exist!")
end
if not instanceof(targetPage, Page) then
error("menuid isnot a page!")
end
local areas = targetPage.__areas
local targetIndex = nil
targetPage:searchCollection(areas, function ( item, index )
if item:getAttribute("area") == area then
targetIndex = index
return false
end
end)
table.insert(areas, targetIndex, self)
self.__page = targetPage
return self
end
Area.setAttribute = function (self, name, value)
if name ~= "filterFunc" then
return self.__class.__parent.setAttribute(self, name, value)
end
return self.__class.__parent.setAttribute(self, name, filterFuncTransfer(self:getAttribute("filterFunc"), value))
end
Dmenu = class()
Dmenu.__singleton = true
Dmenu.__init__ = function ( self, configTable )
local rootConfig = {
id = "__root_id",
name = "__root_name",
children = configTable
}
local rootObj = MenuItem(rootConfig)
if rootObj then
self.__root = rootObj
end
end
Dmenu.checkIfLeafNode = function ( self, item )
if instanceof( item, Page ) or instanceof( item, Area ) then
return true
end
return false
end
Dmenu.findMenu = function ( self, menuid )
local rootMenu = self.__root
return rootMenu:findMenu(menuid)
end
Dmenu.newMenuItem = function ( self, menuItemTable )
return MenuItem(menuItemTable)
end
Dmenu.newPage = function ( self, pageTable )
return Page(pageTable)
end
Dmenu.newArea = function ( self, areaTable )
return Area(areaTable)
end
Dmenu.__loadMenuModifier = function ( self, modifierFile )
local dmenu = self
local prog = loadfile(modifierFile)
if not prog then
return false
end
local env = setmetatable({dmenu=dmenu}, {__index=_G})
if env then
setfenv (prog, env)
end
prog ()
return true
end
Dmenu.addModifierLoader = function ( self, loaderFunc )
typeAssert(loaderFunc, "function")
if not self.__modifierLoaders then
self.__modifierLoaders = {}
end
table.insert(self.__modifierLoaders, loaderFunc)
end
Dmenu.doMenuModifier = function ( self, modifierFile, modifierFileCver )
if not self:__loadMenuModifier(modifierFile) then
return
end
if modifierFileCver ~= nil then
if not self:__loadMenuModifier(modifierFileCver) then
return
end
end
for _, loaderFunc in ipairs(self.__modifierLoaders) do
loaderFunc()
end
end
Dmenu.doMenuTrimming = function ( self, areaPath )
local zombiePages = {}
local rootMenu = self.__root
rootMenu:__traverseTree(function ( menuNode )
if not instanceof(menuNode, Page) then
return
end
local pageNode = menuNode
local zombieAreas = {}
local areas = pageNode.__areas
pageNode:searchCollection(areas, function ( item, index )
local areaObj = item
local areaFile = areaObj:getAttribute("area")
local areaFilePath = areaPath .. areaFile
if lfs.attributes (areaFilePath, "mode") == nil then
table.insert(zombieAreas, areaObj)
end
end)
if #zombieAreas == #areas then
table.insert(zombiePages, pageNode)
else
pageNode:searchCollection(zombieAreas, function ( item, index )
local zombieAreaObj = item
zombieAreaObj:remove()
end)
end
end)
for _, zombiePage in ipairs(zombiePages) do
zombiePage:remove()
end
end
Dmenu.setRight = function (self, newRight, paraTable)
local rootMenu = self.__root
local menu
if newRight == nil or paraTable == nil then
return
end
if paraTable.menuList ~= nil then
for _,v in pairs(paraTable.menuList) do
menu = rootMenu:findMenu(v)
if menu ~= nil and menu:getAttribute("right") ~= nil then
menu:setAttribute("right",newRight)
end
end
end
if paraTable.pageList ~= nil then
for _,v in pairs(paraTable.pageList) do
menu = rootMenu:findMenu(v[1])
if menu ~= nil then
for j = 2,#v do
local area = menu:findArea(v[j])
if area ~= nil and (area:getAttribute("right") ~= nil or menu:getAttribute("right") ~= nil) then
area:setAttribute("right",newRight)
end
end
end
end
end
end
Dmenu.setDisabled = function (self, DisabledUser, paraTable)
local rootMenu = self.__root
local menu
if DisabledUser == nil or paraTable == nil then
return
end
if paraTable.menuList ~= nil then
for _,v in pairs(paraTable.menuList) do
menu = rootMenu:findMenu(v)
if menu ~= nil then
menu:setAttribute("extData2",DisabledUser)
end
end
end
if paraTable.pageList ~= nil then
for _,v in pairs(paraTable.pageList) do
menu = rootMenu:findMenu(v[1])
if menu ~= nil then
for j = 2,#v do
local area = menu:findArea(v[j])
if area ~= nil then
area:setAttribute("extData2",DisabledUser)
end
end
end
end
end
end
Dmenu.removeList = function (self, removeTable)
local rootMenu = self.__root
local menu
if removeTable == nil then
return
end
if removeTable.menuList ~= nil then
for _,v in pairs(removeTable.menuList) do
menu = rootMenu:findMenu(v)
if menu ~= nil then
menu:remove()
end
end
end
if removeTable.pageList ~= nil then
for _,v in pairs(removeTable.pageList) do
menu = rootMenu:findMenu(v[1])
if menu ~= nil then
for j = 2,#v do
local area = menu:findArea(v[j])
if area ~= nil then
area:remove()
end
end
end
end
end
end
Dmenu.replaceArea = function (self, replaceTable)
local rootMenu = self.__root
local menu
for _,v in pairs(replaceTable) do
menu = rootMenu:findMenu(v[1])
if menu ~= nil then
local area = menu:findArea(v[2])
if area ~= nil then
area:setAttribute("area",v[3])
if v[4] ~= nil then
area:setAttribute("backendFile",v[4])
end
end
end
end
end
Dmenu.getDefaultPage = function ( self )
local menuid = nil
if type(self.defineDefaultPage) == "function" then
menuid = self:defineDefaultPage()
if type(menuid) ~= "string" then
menuid = nil
else
local pageObj = self:findMenu(menuid)
if not pageObj then
menuid = nil
end
if not pageObj:__checkAccessible() then
menuid = nil
end
end
end
if not menuid then
local pageObj = self.__root:findFirstAvailablePage()
menuid = pageObj:getAttribute("id")
end
return menuid
end
Dmenu.getPageIDOnFullLoading = function ( self )
local nextpage = cgilua.getCurrentSessAttr("nextpage")
if not nextpage then
nextpage = menutree:getDefaultPage()
else
local pageObj = self:findMenu(nextpage)
if not pageObj then
nextpage = menutree:getDefaultPage()
end
if not pageObj:__checkAccessible() then
nextpage = menutree:getDefaultPage()
end
end
cgilua.setCurrentSessAttr("nextpage", nextpage)
return nextpage
end
Dmenu.OutputMenuJSData_unlogined = function ( self )
local rootMenu = self.__root
local cache = {}
local menu1Objs = rootMenu.__subMenu
rootMenu:searchCollection(menu1Objs, function ( item, index )
if instanceof(item, Page) then
if item:__checkAccessible() then
table.insert(cache, item:__nodeToJSON({"id","name","extData","extData2"}))
end
else
local pageObj = item:findFirstAvailablePage()
if pageObj then
table.insert(cache, AttrNode.__nodeToJSON(item, {"id","name","extData","extData2"}))
end
end
end)
local contentStr = table.concat(cache, ",")
local jsonStr = string.format("[%s]", contentStr)
return jsonStr
end
Dmenu.OutputMenuJSData_logined = function ( self )
local rootMenu = self.__root
local cache = {}
local menu1Objs = rootMenu.__subMenu
rootMenu:searchCollection(menu1Objs, function ( item, index )
if instanceof(item, Page) then
if item:__checkAccessible() then
table.insert(cache, item:__nodeToJSON({"id","name","extData","extData2"}))
end
else
local jsonStr = item:__nodeToJSON({"id","name","extData","extData2"})
if jsonStr then
table.insert(cache, jsonStr)
end
end
end)
local contentStr = table.concat(cache, ",")
local jsonStr = string.format("[%s]", contentStr)
return jsonStr
end
Dmenu.setNoRightDiff = function ( self, customRight )
local rootMenu = self.__root
rootMenu:__traverseTree(function ( menuNode )
if not instanceof(menuNode, Page) then
return
end
local menuRight = menuNode:getAttribute("right")
if menuRight ~= nil and menuRight ~= "0" then
local retVal = cmapi.nocsrf.bitOpera("and", menuRight, customRight)
if retVal > 0 then
local curRight = cmapi.nocsrf.bitOpera("or", menuRight, customRight)
menuNode:setAttribute("right", string.format("%s", curRight))
end
end
local pageNode = menuNode
local areas = pageNode.__areas
pageNode:searchCollection(areas, function ( item, index )
local areaObj = item
local areaRight = areaObj:getAttribute("right")
if areaRight ~= nil and areaRight ~= "0" then
local retVal = cmapi.nocsrf.bitOpera("and", areaRight, customRight)
if retVal > 0 then
local curRight = cmapi.nocsrf.bitOpera("or", areaRight, customRight)
areaObj:setAttribute("right", string.format("%s", curRight))
end
end
end)
end)
end
Dmenu.queryAccessibleAreaViews = function ( self, menuid )
local pageObj = self:findMenu(menuid)
if not instanceof(pageObj, Page) then
return {}
end
return pageObj:__queryAccessibleAreaViews()
end
Dmenu.checkMenuAccessible = function ( self, menuID )
local pageObj = self:findMenu(menuID)
if not pageObj then
return false
end
if not pageObj:__checkAccessible() then
return false
end
return true
end
Dmenu.checkBackEndFile = function ( self, backendFile )
local menuid = cgilua.getCurrentSessAttr("nextpage")
if not menuid then
return false
end
local pageObj = self:findMenu(menuid)
if not pageObj then
return false
end
if not pageObj:__checkAccessible() then
return false
end
local isFound = false
local dataFiles, areaObjs = pageObj:__queryAccessibleAreaDatas()
local areaIndex
pageObj:searchCollection(dataFiles, function ( fileItem, index )
if type(fileItem) == "table" then
for _,fileName in ipairs(fileItem) do
if fileName == backendFile then
isFound = true
areaIndex = index
return false
end
end
else
if fileItem == backendFile then
isFound = true
areaIndex = index
return false
end
end
end)
local areaObj
if isFound then
areaObj = areaObjs[areaIndex]
end
return isFound, areaObj
end
Dmenu:freeze()
return {
Dmenu = Dmenu
}
