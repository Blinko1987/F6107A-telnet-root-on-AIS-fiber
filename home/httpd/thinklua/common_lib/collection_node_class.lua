local oopclass = require("common_lib.oop_class")
local class = oopclass.class
local instanceof = oopclass.instanceof
local AttrNode = require("common_lib.attr_node_class")
local assertlib = require("common_lib.assert_utils")
local typeAssert = assertlib.typeAssert
local tableUtils = require("common_lib.table_utils")
local CollectionNode = class(AttrNode)
CollectionNode.__init__ = function ( self, itemProtoDesc, withStaticConfig )
typeAssert(itemProtoDesc, "table")
typeAssert(itemProtoDesc.class, "table")
typeAssert(itemProtoDesc.keyName, "string")
typeAssert(withStaticConfig, "boolean", "nil")
self.__itemProtoDesc = itemProtoDesc
self.__itemSet = {}
self.__staticModFuncs = {}
self.__withStaticConfig = withStaticConfig or true
self.__isStaticConfigLoaded = false
self.__dynamicModFuncs = {}
end
CollectionNode.findItem = function ( self, keyValue )
typeAssert(keyValue, "string")
local targetObj = nil
local targetIndex = nil
local keyName = self.__itemProtoDesc.keyName
self:searchCollection(self.__itemSet, function ( item, index )
if keyValue == item:getAttribute(keyName) then
targetObj = item
targetIndex = index
return false
end
end)
return targetObj, targetIndex
end
CollectionNode.findItemByIndex = function ( self, index )
typeAssert(index, "number")
local total = #self.__itemSet
if index < 1 or index > total then
return nil
end
local targetObj = self.__itemSet[index]
return targetObj
end
CollectionNode.__getInsertingIndex = function ( self, posDesc )
typeAssert(posDesc, "table", "nil")
if posDesc then
typeAssert(posDesc.before, "string", "number", "nil")
typeAssert(posDesc.after, "string", "number", "nil")
end
local total = #self.__itemSet
if not posDesc then
return total + 1
end
local before = posDesc.before
local after = posDesc.after
if not before and not after then
return total + 1
end
if before then
if type(before) == "number" then
if before < 1 then
return 1
elseif before > total then
return total + 1
else
return before
end
else
local obj, index = self:findItem(before)
if obj then
return index
else
return total + 1
end
end
end
if after then
if type(after) == "number" then
if after < 1 then
return 1
elseif after > total then
return total + 1
else
return after + 1
end
else
local obj, index = self:findItem(before)
if obj then
return index + 1
else
return total + 1
end
end
end
return total + 1
end
CollectionNode.addItem = function ( self, itemTable, posDesc )
typeAssert(itemTable, "table")
typeAssert(posDesc, "table", "nil")
local itemClass = self.__itemProtoDesc.class
local itemObj = itemClass(itemTable)
if not instanceof(itemObj, itemClass) then
return self
end
local keyName = self.__itemProtoDesc.keyName
local keyValue = itemObj:getAttribute(keyName)
if keyValue == nil then
return self
end
itemObj:defineAttrReadOnly(keyName)
local sameKeyObj, sameKeyIndex = self:findItem(keyValue)
if sameKeyObj then
local errmsg = "addItem keyName("..keyName..")'s keyValue("..keyValue..") conflict!"
g_logger:error(errmsg)
error(errmsg)
end
local posIndex = self:__getInsertingIndex(posDesc)
table.insert(self.__itemSet, posIndex, itemObj)
return self
end
CollectionNode.removeItem = function ( self, keyValue )
typeAssert(keyValue, "string")
local targetObj, targetIndex = self:findItem(keyValue)
if targetObj then
table.remove(self.__itemSet, targetIndex)
end
return self
end
CollectionNode.clearItemSet = function ( self )
self.__itemSet = {}
self.__staticModFuncs = {}
self.__dynamicModFuncs = {}
return self
end
CollectionNode.searchItem = function (self, func)
typeAssert(func, "function")
self:searchCollection(self.__itemSet, func)
return self
end
CollectionNode.__loadConfig = function (self, configTable)
typeAssert(configTable, "table")
self:searchCollection(configTable, function ( item, index )
self:addItem(item)
end)
return self
end
CollectionNode.addModifier = function (self, modFunc)
typeAssert(modFunc, "function")
table.insert(self.__staticModFuncs, modFunc)
return self
end
CollectionNode.__loadModifier = function (self)
for _,modFunc in ipairs(self.__staticModFuncs) do
modFunc()
end
return self
end
CollectionNode.loadStaticConfig = function (self, staticConfigs)
typeAssert(staticConfigs, "table")
typeAssert(staticConfigs.tableFile, "string", "nil")
typeAssert(staticConfigs.modifierFile, "string", "nil")
local tableFile = staticConfigs.tableFile
if tableFile then
local ret, configTable = pcall(require, tableFile)
if ret then
self:__loadConfig(configTable)
package.loaded[tableFile] = nil
tableUtils.removeTableOfLuaPath(tableFile)
else
g_logger:debug("require file("..tostring(tableFile)..") fail.")
end
end
local modifierFile = staticConfigs.modifierFile
if modifierFile then
local ret = pcall(require, modifierFile)
if ret then
self:__loadModifier()
package.loaded[modifierFile] = nil
tableUtils.removeTableOfLuaPath(modifierFile)
else
g_logger:debug("require file("..tostring(modifierFile)..") fail.")
end
end
self.__isStaticConfigLoaded = true
local dynamicModFuncs = self.__dynamicModFuncs
if #dynamicModFuncs > 0 then
for _,modFunc in ipairs(dynamicModFuncs) do
modFunc()
end
end
return self
end
return CollectionNode
