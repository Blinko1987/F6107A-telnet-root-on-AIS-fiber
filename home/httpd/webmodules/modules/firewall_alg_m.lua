local cbi = require("data_assemble.comapi")
local util = require("data_assemble.util")
module(..., package.seeall)
local FunctionArea = cbi.FunctionArea
local SetArea = cbi.SetArea
local ParRadio = cbi.ParRadio
local BatchSelectButton = cbi.BatchSelectButton
functionId = "alg"
dataObjId = "OBJ_FWALG_ID"
modelArea = FunctionArea(functionId, nil, lang.Alg_001)
setArea = SetArea(functionId, 0, util.PathSeparatorChar.. util.luaPath2LocalPath(_NAME))
paramTbl = {
{"IsFTPAlg", lang.Alg_003},
{"IsH323Alg", lang.Alg_007},
{"IsPPTPAlg", lang.Alg_009},
{"IsRTSPAlg", lang.Alg_008},
{"IsSIPAlg", lang.Alg_005},
{"IsTFTPAlg", lang.Alg_004}
}
for k,v in ipairs(paramTbl) do
setArea:append(cbi.ParRadio(functionId, dataObjId, v[1], v[2], {{value="1", text=lang.public_033}, {value="0",text=lang.public_034}}, "1"))
end
setArea.buttonGroupBox:append(BatchSelectButton(functionId))
modelArea:append(setArea)
