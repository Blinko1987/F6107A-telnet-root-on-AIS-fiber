local oopclass = require("common_lib.oop_class")
local class = oopclass.class
local assertlib = require("common_lib.assert_utils")
local typeAssert = assertlib.typeAssert
local AttrNode = require("common_lib.attr_node_class")
local CollectionNode = require("common_lib.collection_node_class")
local MapItemClass = class(AttrNode)
MapItemClass.__init__ = function ( self, mapItemTable )
typeAssert(mapItemTable, "table")
typeAssert(mapItemTable.urlPath, "string")
typeAssert(mapItemTable.routerType, "string", "function")
self:__attrInitialize( mapItemTable, {
"urlPath",
"routerType"
})
end
local MapTableClass = class(CollectionNode)
MapTableClass.__singleton = true
MapTableClass.__init__ = function ( self, itemProtoDesc )
typeAssert(itemProtoDesc, "table")
CollectionNode.__init__( self, itemProtoDesc )
end
local mapTableMgr = MapTableClass({class=MapItemClass,
keyName="urlPath"})
return mapTableMgr
