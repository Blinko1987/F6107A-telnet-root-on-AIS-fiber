local cbi = require("data_assemble.comapi")
local util = require("data_assemble.util")
module(..., package.seeall)
local FunctionArea = cbi.FunctionArea
local SetArea = cbi.SetArea
local ParRadio = cbi.ParRadio
functionId = "RIPng"
dataObjId = "OBJ_RIPNG_ID"
modelArea = FunctionArea(functionId, nil, lang.RIP_012)
setArea = SetArea(functionId, 0, util.PathSeparatorChar.. util.luaPath2LocalPath(_NAME))
ripngEnable = ParRadio(functionId, dataObjId, "RipngEnabled", lang.RIP_011, {{value="1", text=lang.public_033}, {value="0", text=lang.public_034}})
setArea:append(ripngEnable)
modelArea:append(setArea)
