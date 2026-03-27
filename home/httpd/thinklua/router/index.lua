local prePostOpLogicImpl = require("router.prepostop_logic_impl")
local needStop = prePostOpLogicImpl:doPreOperation()
if needStop then
return
end
local routerLogicImpl = require("router.router_logic_impl")
routerLogicImpl:run()
prePostOpLogicImpl:DoPostOperation()
