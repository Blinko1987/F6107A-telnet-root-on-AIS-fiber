local oopclass = require("common_lib.oop_class")
local class = oopclass.class
local assertlib = require("common_lib.assert_utils")
local typeAssert = assertlib.typeAssert
local AttrNode = class()
AttrNode.__abstract = true
AttrNode.__attrInitialize = function ( self, source, attrs )
typeAssert(source, "table")
typeAssert(attrs, "table")
self.__legal_attrs = attrs
for _,para in ipairs(attrs) do
if source[para] ~= nil then
self[para] = source[para]
end
end
self.__readonly_attrs = {}
end
AttrNode.__checkAttrLegal = function ( self, name )
typeAssert(name, "string")
local legalAttrs = self.__legal_attrs
for _,attr in ipairs(legalAttrs) do
if name == attr then
return
end
end
assert(false, "attr name is illegal!")
end
AttrNode.setAttribute = function (self, name, value)
typeAssert(name, "string")
typeAssert(value, "string", "number", "table", "function", "nil")
self:__checkAttrLegal(name)
for _,readOnlyAttr in ipairs(self.__readonly_attrs) do
if readOnlyAttr == name then
return self
end
end
self[name] = value
return self
end
AttrNode.getAttribute = function (self, name)
typeAssert(name, "string")
self:__checkAttrLegal(name)
return self[name]
end
AttrNode.defineAttrReadOnly = function (self, name)
typeAssert(name, "string")
self:__checkAttrLegal(name)
table.insert(self.__readonly_attrs, name)
return self
end
AttrNode.searchCollection = function (self, collection, func)
typeAssert(collection, "table")
typeAssert(func, "function")
local isloop = nil
for index,item in ipairs(collection) do
isloop = func(item, index)
if isloop == false then
break
end
end
end
AttrNode.__attrToNVPair = function (self, name, splitter)
typeAssert(name, "string")
typeAssert(splitter, "string")
self:__checkAttrLegal(name)
local val = self[name]
local typeOfVal = type(val)
local valstr = "null"
if typeOfVal == "nil" then
return nil
elseif typeOfVal == "string" then
valstr = string.format("%q", val)
elseif typeOfVal == "number" then
valstr = tostring(val)
elseif typeOfVal == "table" then
local cache = {}
for _,v in ipairs(val) do
if type(v) == "string" then
local quotedStr = string.format("%q", v)
table.insert(cache, quotedStr)
end
end
local contentStr = table.concat(cache, ",")
valstr = string.format("[%s]", contentStr)
else
end
local quotedName = string.format("%q", name)
local ret = quotedName .. splitter .. valstr
return ret
end
AttrNode.__getNVPairsofAttrs = function (self, splitter, attrs)
typeAssert(splitter, "string")
typeAssert(attrs, "table", "nil")
if not attrs then
attrs = self.__legal_attrs
end
local cache = {}
self:searchCollection(attrs, function ( item, index )
table.insert(cache, self:__attrToNVPair(item, splitter))
end)
return cache
end
AttrNode.__nodeToJSON = function (self, attrs)
typeAssert(attrs, "table", "nil")
local cache = self:__getNVPairsofAttrs(":", attrs)
local contentStr = table.concat(cache, ",")
local jsonStr = string.format("{%s}", contentStr)
return jsonStr
end
return AttrNode
