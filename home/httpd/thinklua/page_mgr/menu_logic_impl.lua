local oopclass = require("common_lib.oop_class")
local class = oopclass.class
local assertlib = require("common_lib.assert_utils")
local typeAssert = assertlib.typeAssert
local valueAssert = assertlib.valueAssert
local tableUtils = require("common_lib.table_utils")
local menuMgr = require("page_mgr.menu_tree_mgr")
local Dmenu = menuMgr.Dmenu
local MenuLogicImplClass = class()
MenuLogicImplClass.__init__ = function ( self )
self.menutree = nil
self.menutree_phone = nil
self.menulang = nil
end
MenuLogicImplClass.initialize = function ( self )
local menutree = self.menutree
local menutree_phone = self.menutree_phone
local menulang = self.menulang
local cver = env.getenv("CountryCode")
if menutree == nil or (menutree and menulang ~= lang.LANG) then
local menuPath = "config.dmenu"
if _G.commConf.menu ~= nil then
menuPath =string.format("config.%s_dmenu",_G.commConf.menu)
g_logger:warn("self menu ="..menuPath)
end
package.loaded[menuPath] = nil
local menuConfig = require(menuPath)
package.loaded[menuPath] = nil
tableUtils.removeTableOfLuaPath(menuPath)
if menutree then
menutree:destroyInstance()
end
menutree = Dmenu(menuConfig)
local menuModifer = "../../webmodules/config/dmenu_modifier.lua"
local menuModiferExt = nil
if _G.commConf.menu ~= nil then
menuModifer = string.format("../../webmodules/config/%s_dmenu_modifier.lua",_G.commConf.menu)
g_logger:info("self menu = "..menuModifer)
else
local cverModifier = string.format("../../webmodules/config/dmenu_modifier_%s.lua",cver)
if cmapi.file_exists(string.format("config/dmenu_modifier_%s.lua",cver)) == 1 then
g_logger:info(cverModifier .. " exists!")
menuModiferExt = cverModifier
end
end
menutree:doMenuModifier(menuModifer,menuModiferExt)
menutree:doMenuTrimming("../../webmodules/modules/")
self.menulang = lang.LANG
self.menutree = menutree
end
return self.menutree
end
local menuLogicImpl = MenuLogicImplClass()
return menuLogicImpl
