local oopclass = require("common_lib.oop_class")
local class = oopclass.class
local assertlib = require("common_lib.assert_utils")
local typeAssert = assertlib.typeAssert
local AttrNode = require("common_lib.attr_node_class")
local CollectionNode = require("common_lib.collection_node_class")
local LangResoureItemClass = class(AttrNode)
LangResoureItemClass.__init__ = function ( self, langItemTable )
typeAssert(langItemTable, "table")
typeAssert(langItemTable.langName, "string")
typeAssert(langItemTable.langFileName, "string")
typeAssert(langItemTable.langTableName, "string")
self:__attrInitialize( langItemTable, {
"langName",
"langFileName",
"langTableName",
})
end
local LangTableClass = class(CollectionNode)
LangTableClass.__singleton = true
LangTableClass.__init__ = function ( self, itemProtoDesc )
typeAssert(itemProtoDesc, "table")
CollectionNode.__init__( self, itemProtoDesc )
end
local langTableMgr = LangTableClass({class=LangResoureItemClass,
keyName="langName"})
return langTableMgr
