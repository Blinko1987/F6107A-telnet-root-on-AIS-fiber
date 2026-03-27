local oopclass = require("common_lib.oop_class")
local class = oopclass.class
local assertlib = require("common_lib.assert_utils")
local typeAssert = assertlib.typeAssert
local valueAssert = assertlib.valueAssert
local AttrNode = require("common_lib.attr_node_class")
local CollectionNode = require("common_lib.collection_node_class")
local LoginpageItemClass = class(AttrNode)
LoginpageItemClass.__init__ = function ( self, loginpageItemTable )
typeAssert(loginpageItemTable, "table")
typeAssert(loginpageItemTable.basicType, "string")
valueAssert(loginpageItemTable.basicType, "data", "view")
typeAssert(loginpageItemTable.loginType, "string")
typeAssert(loginpageItemTable.fileName, "string")
typeAssert(loginpageItemTable.needLogin, "boolean")
self:__attrInitialize( loginpageItemTable, {
"basicType",
"loginType",
"fileName",
"needLogin"
})
end
local LoginpageTableClass = class(CollectionNode)
LoginpageTableClass.__singleton = true
LoginpageTableClass.__init__ = function ( self, itemProtoDesc )
typeAssert(itemProtoDesc, "table")
CollectionNode.__init__( self, itemProtoDesc )
end
local loginpageTableMgr = LoginpageTableClass({class=LoginpageItemClass,
keyName="loginType"})
return loginpageTableMgr
