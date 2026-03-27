local oopclass = require("common_lib.oop_class")
local class = oopclass.class
local routerTableMgr = require("router.router_table_mgr")
local urlpath2typemap = require("router.urlpath_2type_map")
local fileutils = require"common_lib.file_utils"
local filterIllegalPath = fileutils.filterIllegalPath
local getextension = fileutils.getextension
local RouterLogicClass = class()
RouterLogicClass.__URLPath2RouterType = function ( self, urlPath )
local mapItem = urlpath2typemap:findItem(urlPath)
if not mapItem then
local extension = getextension(urlPath)
if extension then
if extension == "lp"
or extension == "html"
or extension == "htm" then
return "hiddenView", urlPath
elseif extension == "lua"
or extension == "json"
or extension == "xml" then
return "hiddenData", urlPath
end
end
return nil, nil
end
local routerType = mapItem:getAttribute("routerType")
if type(routerType) == "string" then
return routerType, nil
end
if type(routerType) == "function" then
return routerType()
end
return nil, nil
end
RouterLogicClass.__URL2RouterType = function ( self, urlPath, queryTable )
local routerType, resourceTag
if #urlPath == 0 then
routerType = queryTable._type
if not routerType then
routerType, resourceTag = self:__URLPath2RouterType(urlPath)
else
resourceTag = queryTable._tag
end
else
routerType, resourceTag = self:__URLPath2RouterType(urlPath)
if not routerType then
routerType = "hiddenView"
resourceTag = urlPath
end
end
return routerType, resourceTag
end
RouterLogicClass.loadRoutingRules = function ( self )
routerTableMgr:loadStaticConfig({
tableFile="router.router_table_conf",
modifierFile="router.router_table_modifier"
})
end
RouterLogicClass.loadURLPath2TypeRules = function ( self )
urlpath2typemap:loadStaticConfig({
tableFile="router.urlpath_2type_conf",
modifierFile="router.urlpath_2type_modifier"
})
end
RouterLogicClass.run = function ( self )
local cgilua = require "cgilua.cgilua"
local urlPath = cgilua.urlpath
local queryTable = cgilua.QUERY
local files, data = {}, {}
g_logger:debug("urlPath="..urlPath)
local routerType, resourceTag = self:__URL2RouterType(urlPath, queryTable)
g_logger:debug("routerType="..tostring(routerType).."&resourceTag="..tostring(resourceTag))
resourceTag = filterIllegalPath(resourceTag)
local basicType = "view"
local routingRule = routerTableMgr:findItem(routerType)
g_logger:debug("routingRule="..tostring(routingRule))
if routingRule then
basicType = routingRule:getAttribute("basicType")
local url2filefunc = routingRule:getAttribute("URL2FileFunc")
if url2filefunc then
local ret
ret, files, data = url2filefunc(routerType, resourceTag)
g_logger:debug("ret="..tostring(ret))
if not ret then
routerType = nil
end
end
else
routerType = nil
end
if basicType == "view" then
require("view_assemble.view_logic_impl"):run(files, routerType, data)
else
require("data_assemble.data_logic_impl"):run(files, routerType)
end
end
local routerLogicImpl = RouterLogicClass()
routerLogicImpl:loadRoutingRules()
routerLogicImpl:loadURLPath2TypeRules()
return routerLogicImpl
