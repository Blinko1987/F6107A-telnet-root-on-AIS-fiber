local oopclass = require("common_lib.oop_class")
local class = oopclass.class
local assertlib = require("common_lib.assert_utils")
local typeAssert = assertlib.typeAssert
local AttrNode = require("common_lib.attr_node_class")
local CollectionNode = require("common_lib.collection_node_class")
local EnvItemClass = class(AttrNode)
EnvItemClass.__init__ = function ( self, envItemTable )
typeAssert(envItemTable, "table")
typeAssert(envItemTable.envName, "string")
typeAssert(envItemTable.envValFunc, "function")
typeAssert(envItemTable.conditionFunc, "function", "nil")
typeAssert(envItemTable.actionFunc, "function", "nil")
self:__attrInitialize( envItemTable, {
"envName",
"envValFunc",
"conditionFunc",
"actionFunc"
})
if not self.conditionFunc then
self.conditionFunc = function ()
local envName = self.envName
if "N/A" == env.getenv(envName) then
return true
end
end
end
end
local EnvTableMgrClass = class(CollectionNode)
EnvTableMgrClass.__singleton = true
EnvTableMgrClass.__init__ = function ( self, itemProtoDesc )
typeAssert(itemProtoDesc, "table")
CollectionNode.__init__( self, itemProtoDesc )
end
local envTableMgr = EnvTableMgrClass({class=EnvItemClass,
keyName="envName"})
return envTableMgr
