local oopclass = require("common_lib.oop_class")
local class = oopclass.class
local assertlib = require("common_lib.assert_utils")
local typeAssert = assertlib.typeAssert
local valueAssert = assertlib.valueAssert
local AttrNode = require("common_lib.attr_node_class")
local CollectionNode = require("common_lib.collection_node_class")
local UserMgrItemClass = class(AttrNode)
UserMgrItemClass.__init__ = function ( self, usermgrItemTable )
typeAssert(usermgrItemTable, "table")
typeAssert(usermgrItemTable.attr, "string")
typeAssert(usermgrItemTable.value, "string", "number")
typeAssert(usermgrItemTable.func, "function", "nil")
typeAssert(usermgrItemTable.opts, "table", "nil")
self:__attrInitialize( usermgrItemTable, {
"attr",
"value",
"func",
"opts"
})
end
local UserMgrTableClass = class(CollectionNode)
UserMgrTableClass.__singleton = true
UserMgrTableClass.__init__ = function ( self, itemProtoDesc )
typeAssert(itemProtoDesc, "table")
CollectionNode.__init__( self, itemProtoDesc )
end
UserMgrTableClass.setUserMgrAttr = function (self, Attr, subAttr, subAttrValue)
typeAssert(Attr, "string")
typeAssert(subAttr, "string")
self:findItem(Attr):setAttribute(subAttr, subAttrValue)
return self
end
local userMgrTbl = UserMgrTableClass({class=UserMgrItemClass,
keyName="attr"})
return userMgrTbl
