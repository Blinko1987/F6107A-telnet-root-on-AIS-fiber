local oopclass = require("common_lib.oop_class")
local class = oopclass.class
local assertlib = require("common_lib.assert_utils")
local typeAssert = assertlib.typeAssert
local valueAssert = assertlib.valueAssert
local AttrNode = require("common_lib.attr_node_class")
local CollectionNode = require("common_lib.collection_node_class")
local RouterItemClass = class(AttrNode)
RouterItemClass.__init__ = function ( self, routerItemTable )
typeAssert(routerItemTable, "table")
typeAssert(routerItemTable.type, "string")
typeAssert(routerItemTable.basicType, "string")
valueAssert(routerItemTable.basicType, "data", "view")
typeAssert(routerItemTable.URL2FileFunc, "function", "nil")
self:__attrInitialize( routerItemTable, {
"type",
"basicType",
"URL2FileFunc"
})
end
local RouterTableClass = class(CollectionNode)
RouterTableClass.__singleton = true
RouterTableClass.__init__ = function ( self, itemProtoDesc )
typeAssert(itemProtoDesc, "table")
CollectionNode.__init__( self, itemProtoDesc )
end
local routerTableMgr = RouterTableClass({class=RouterItemClass,
keyName="type"})
return routerTableMgr
