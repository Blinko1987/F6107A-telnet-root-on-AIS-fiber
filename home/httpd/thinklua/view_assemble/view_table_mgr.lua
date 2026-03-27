local oopclass = require("common_lib.oop_class")
local class = oopclass.class
local assertlib = require("common_lib.assert_utils")
local typeAssert = assertlib.typeAssert
local valueAssert = assertlib.valueAssert
local AttrNode = require("common_lib.attr_node_class")
local CollectionNode = require("common_lib.collection_node_class")
local ViewItemClass = class(AttrNode)
ViewItemClass.__init__ = function ( self, viewItemTable )
typeAssert(viewItemTable, "table")
typeAssert(viewItemTable.type, "string")
typeAssert(viewItemTable.assembleFile, "string", "function")
self:__attrInitialize( viewItemTable, {
"type",
"assembleFile"
})
end
local ViewTableClass = class(CollectionNode)
ViewTableClass.__singleton = true
ViewTableClass.__init__ = function ( self, itemProtoDesc )
typeAssert(itemProtoDesc, "table")
CollectionNode.__init__( self, itemProtoDesc )
end
local viewTableMgr = ViewTableClass({class=ViewItemClass,
keyName="type"})
return viewTableMgr
