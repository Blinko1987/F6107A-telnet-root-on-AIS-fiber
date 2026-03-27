local oopclass = require("common_lib.oop_class")
local class = oopclass.class
local assertlib = require("common_lib.assert_utils")
local typeAssert = assertlib.typeAssert
local valueAssert = assertlib.valueAssert
local AttrNode = require("common_lib.attr_node_class")
local CollectionNode = require("common_lib.collection_node_class")
local DataItemClass = class(AttrNode)
DataItemClass.__init__ = function ( self, dataItemTable )
typeAssert(dataItemTable, "table")
typeAssert(dataItemTable.type, "string")
typeAssert(dataItemTable.assembleFile, "string", "function")
self:__attrInitialize( dataItemTable, {
"type",
"assembleFile"
})
end
local DataTableClass = class(CollectionNode)
DataTableClass.__singleton = true
DataTableClass.__init__ = function ( self, itemProtoDesc )
typeAssert(itemProtoDesc, "table")
CollectionNode.__init__( self, itemProtoDesc )
end
local dataTableMgr = DataTableClass({class=DataItemClass,
keyName="type"})
return dataTableMgr
