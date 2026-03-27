local cbi = require("data_assemble.comapi")
local dataruleModel = require("data_assemble.datarule")
local util = require("data_assemble.util")
module(..., package.seeall)
local FunctionArea = cbi.FunctionArea
local SetArea = cbi.SetArea
local ParRadio = cbi.ParRadio
local ParSelect = cbi.ParSelect
local ParComboSelect = cbi.ParComboSelect
local ParTextBox = cbi.ParTextBox
local SegmentRow = cbi.SegmentRow
local DataRuleInteger = dataruleModel.DataRuleInteger
local functionId = "LocalUPnP"
local OBJ_UPnP_ID = "OBJ_UPNPCONFIG_ID"
modelArea = FunctionArea(functionId, nil, lang.UPnP_001)
g_logger:debug("_NAME ".. _NAME)
setArea = SetArea(functionId, 0, util.PathSeparatorChar.. util.luaPath2LocalPath(_NAME))
setArea.dataModel = "DEV"
EnableUPnPIGD = ParRadio(functionId, OBJ_UPnP_ID, "EnableUPnPIGD", lang.UPnP_001, {{value="1", text=lang.public_033}, {value="0", text=lang.public_034}})
setArea:append(EnableUPnPIGD)
IPv4 = cbi.EmphasisBox(functionId, "IPv4")
WanName = ParComboSelect(functionId, OBJ_UPnP_ID, "WanName", lang.UPnP_005, {appId="IPv4UPnP"})
IPv4:append(WanName)
ADPeriod = ParTextBox(functionId, OBJ_UPnP_ID, "ADPeriod", lang.UPnP_003, lang.public_012)
ADPeriodValidRule = DataRuleInteger(true, 4, 1440)
ADPeriod:bindDataRule(ADPeriodValidRule)
IPv4:append(ADPeriod)
TTL = ParTextBox(functionId, OBJ_UPnP_ID, "TTL", lang.UPnP_004, lang.public_091)
TTLValidRule = DataRuleInteger(true, 1, 255)
TTL:bindDataRule(TTLValidRule)
IPv4:append(TTL)
setArea:append(IPv4)
Segm = SegmentRow("")
setArea:append(Segm)
IPv6 = cbi.EmphasisBox(functionId, "IPv6")
Wanv6Name = ParComboSelect(functionId, OBJ_UPnP_ID, "Wanv6Name", lang.UPnP_006, {appId="IPv6UPnP"})
IPv6:append(Wanv6Name)
setArea:append(IPv6)
modelArea:append(setArea)
g_logger:debug("return  ".. modelArea.id .. " title " .. modelArea.title)
