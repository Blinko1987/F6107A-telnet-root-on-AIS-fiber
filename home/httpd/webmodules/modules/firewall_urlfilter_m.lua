local cbi = require("data_assemble.comapi")
local util = require("data_assemble.util")
local dataruleModel = require("data_assemble.datarule")
module(..., package.seeall)
local FunctionArea = cbi.FunctionArea
local SetArea = cbi.SetArea
local ParTextBox = cbi.ParTextBox
local DataRuleUtf8 = dataruleModel.DataRuleUtf8
local DataRuleRangeLength = dataruleModel.DataRuleRangeLength
functionId = "URLFilter"
dataObjId = "OBJ_FWURL_ID"
modelArea = FunctionArea(functionId, nil, lang.Security_013)
local areaActionTbl = {
forbidModInst = true
}
SetArea = SetArea(functionId, 1, util.PathSeparatorChar.. util.luaPath2LocalPath(_NAME), nil, areaActionTbl)
name = ParTextBox(functionId, dataObjId, "Name", lang.public_016)
nameRule = DataRuleUtf8(true, 1, 32)
name:bindDataRule(nameRule)
SetArea:append(name)
SetArea:bindInstName(name)
url = ParTextBox(functionId, dataObjId, "Url", lang.Security_014)
urlRule = DataRuleRangeLength(true, 1, 128)
urlRule:appendValidator("url", "true")
url:bindDataRule(urlRule)
SetArea:append(url)
modelArea:append(SetArea)
