local oopclass = require("common_lib.oop_class")
local class = oopclass.class
local assertlib = require("common_lib.assert_utils")
local typeAssert = assertlib.typeAssert
local valueAssert = assertlib.valueAssert
local AttrNode = require("common_lib.attr_node_class")
local CollectionNode = require("common_lib.collection_node_class")
local PrePostOpItemClass = class(AttrNode)
PrePostOpItemClass.__init__ = function ( self, prePostOpItemTable )
typeAssert(prePostOpItemTable, "table")
typeAssert(prePostOpItemTable.topic, "string")
typeAssert(prePostOpItemTable.preOpFunc, "function", "nil")
typeAssert(prePostOpItemTable.postOpFunc, "function", "nil")
self:__attrInitialize( prePostOpItemTable, {
"topic",
"preOpFunc",
"postOpFunc"
})
end
local PrePostOpTableClass = class(CollectionNode)
PrePostOpTableClass.__singleton = true
PrePostOpTableClass.__init__ = function ( self, itemProtoDesc )
typeAssert(itemProtoDesc, "table")
CollectionNode.__init__( self, itemProtoDesc )
end
local prePostOpTableMgr = PrePostOpTableClass({class=PrePostOpItemClass,
keyName="topic"})
return prePostOpTableMgr
