local oopclass = require("common_lib.oop_class")
local class = oopclass.class
local assertlib = require("common_lib.assert_utils")
local typeAssert = assertlib.typeAssert
local envTableMgr = require("cgilua.globalenv_table_mgr")
local EnvLogicClass = class()
EnvLogicClass.loadRules = function ( self )
envTableMgr:loadStaticConfig({
tableFile="config.globalenv_table_conf",
modifierFile="config.globalenv_register"
})
end
EnvLogicClass.initGlobalEnv = function ( self )
envTableMgr:searchItem(function ( item, index )
local envName = item.envName
local envValFunc = item.envValFunc
local conditionFunc = item.conditionFunc
local actionFunc = item.actionFunc
if item.conditionFunc() then
local envVal = envValFunc()
env.setenv(envName, envVal)
if actionFunc then
actionFunc(envVal)
end
end
end)
end
local envLogicImpl = EnvLogicClass()
envLogicImpl:loadRules()
return envLogicImpl
