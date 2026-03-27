local oopclass = require("common_lib.oop_class")
local class = oopclass.class
local assertlib = require("common_lib.assert_utils")
local typeAssert = assertlib.typeAssert
local prePostOpTableMgr = require("router.prepostop_table_mgr")
local PrePostOpLogicClass = class()
PrePostOpLogicClass.loadRules = function ( self )
prePostOpTableMgr:loadStaticConfig({
tableFile="router.prepostop_table_conf",
modifierFile="router.prepostop_table_modifier"
})
end
PrePostOpLogicClass.doPreOperation = function ( self )
local needStop = false
prePostOpTableMgr:searchItem(function ( item, index )
local topic = item.topic
local preOpFunc = item.preOpFunc
if preOpFunc then
local isBreakLoop = preOpFunc()
if isBreakLoop == true then
needStop = true
return false
end
end
end)
return needStop
end
PrePostOpLogicClass.DoPostOperation = function ( self )
prePostOpTableMgr:searchItem(function ( item, index )
local postOpFunc = item.postOpFunc
if postOpFunc then
local isBreakLoop = postOpFunc()
if isBreakLoop == true then
return false
end
end
end)
end
local prePostOpLogicImpl = PrePostOpLogicClass()
prePostOpLogicImpl:loadRules()
return prePostOpLogicImpl
