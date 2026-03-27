local oopclass = require("common_lib.oop_class")
local class = oopclass.class
local assertlib = require("common_lib.assert_utils")
local typeAssert = assertlib.typeAssert
local valueAssert = assertlib.valueAssert
local AttrNode = require("common_lib.attr_node_class")
local CollectionNode = require("common_lib.collection_node_class")
local HiddenItemClass = class(AttrNode)
HiddenItemClass.__init__ = function ( self, hiddenItemTable )
typeAssert(hiddenItemTable, "table")
typeAssert(hiddenItemTable.basicType, "string")
valueAssert(hiddenItemTable.basicType, "data", "view")
typeAssert(hiddenItemTable.urlPath, "string")
typeAssert(hiddenItemTable.fileName, "string")
typeAssert(hiddenItemTable.needLogin, "boolean")
typeAssert(hiddenItemTable.right, "number", "nil")
typeAssert(hiddenItemTable.needSessUpdate, "boolean", "nil")
self:__attrInitialize( hiddenItemTable, {
"basicType",
"urlPath",
"fileName",
"needLogin",
"right",
"needSessUpdate"
})
if nil == self.needSessUpdate then
self.needSessUpdate = true
end
end
local HiddenTableClass = class(CollectionNode)
HiddenTableClass.__singleton = true
HiddenTableClass.__init__ = function ( self, itemProtoDesc )
typeAssert(itemProtoDesc, "table")
CollectionNode.__init__( self, itemProtoDesc )
end
local hiddenTableMgr = HiddenTableClass({class=HiddenItemClass,
keyName="urlPath"})
return hiddenTableMgr
