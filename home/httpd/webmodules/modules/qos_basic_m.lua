local cbi = require("data_assemble.comapi")
local util = require("data_assemble.util")
local dataruleModel = require("data_assemble.datarule")
local relationruleModel = require("template.luquid_template.relationrule")
module(..., package.seeall)
local FunctionArea = cbi.FunctionArea
local SetArea = cbi.SetArea
local ParRadio = cbi.ParRadio
local ParTextBox = cbi.ParTextBox
local ParSelect = cbi.ParSelect
local ParComboSelect = cbi.ParComboSelect
local SegmentRow = cbi.SegmentRow
local DataRuleInteger = dataruleModel.DataRuleInteger
local ApplyRelationRule = relationruleModel.ApplyRelationRule
functionId = "qosbasic"
dataObjId = "OBJ_QOSQB_ID"
modelArea = FunctionArea(functionId, nil, lang.QosBasic_001)
setArea = SetArea(functionId, 0, util.PathSeparatorChar.. util.luaPath2LocalPath(_NAME))
qosEnable = ParRadio(functionId, dataObjId, "Enable", lang.QosBasic_003, {{value="1", text=lang.public_033}, {value="0", text=lang.public_034}}, "1")
setArea:append(qosEnable)
aSegm = SegmentRow("")
setArea:append(aSegm)
trafficName = ParTextBox(functionId, dataObjId, "DefaultTrafficClass", lang.QosBasic_004)
trafficNameRule = DataRuleInteger(false, 1, 128)
trafficName:bindDataRule(trafficNameRule)
setArea:append(trafficName)
pqOpt = {{text="",value=""}}
listTbl = cmapi.querylist("OBJ_QOSQP_ID","DEV")
for i, v in ipairs(listTbl) do
getInstTbl = cmapi.getinst("OBJ_QOSQP_ID", v)
aKeyValTbl = {}
aKeyValTbl["text"] = getInstTbl.Alias
aKeyValTbl["value"] = v
table.insert(pqOpt, aKeyValTbl)
end
policerQueue = ParSelect(functionId, dataObjId, "DefaultPolicer", lang.QosBasic_005, pqOpt)
setArea:append(policerQueue)
transferOpt = {
{text=lang.QosBasic_008,value="-1"},
{text=lang.QosBasic_009,value="-2"},
{text=lang.QosBasic_010,value="0"},
{text=lang.QosBasic_011,value="14"},
{text=lang.QosBasic_012,value="12"},
{text=lang.QosBasic_013,value="10"},
{text=lang.QosBasic_014,value="8"},
{text=lang.QosBasic_015,value="22"},
{text=lang.QosBasic_016,value="20"},
{text=lang.QosBasic_017,value="18"},
{text=lang.QosBasic_018,value="16"},
{text=lang.QosBasic_019,value="30"},
{text=lang.QosBasic_020,value="28"},
{text=lang.QosBasic_021,value="26"},
{text=lang.QosBasic_022,value="24"},
{text=lang.QosBasic_023,value="38"},
{text=lang.QosBasic_024,value="36"},
{text=lang.QosBasic_025,value="34"},
{text=lang.QosBasic_026,value="32"},
{text=lang.QosBasic_027,value="46"},
{text=lang.QosBasic_028,value="40"},
{text=lang.QosBasic_029,value="48"},
{text=lang.QosBasic_030,value="56"},
{text=lang.QosBasic_031,value="other"} }
dscpMark = ParSelect(functionId, dataObjId, "DefaultDSCPMark", lang.QosBasic_006, transferOpt, "-1")
setArea:append(dscpMark)
inputDscpMark = ParTextBox(functionId, dataObjId, "other_DefaultDSCPMark", "&nbsp;")
idmRule = DataRuleInteger(true, -2, 63)
inputDscpMark:bindDataRule(idmRule)
setArea:append(inputDscpMark)
ApplyRelationRule({
display = {
{
event = {
{dscpMark, {"other"}}
},
action = {
{inputDscpMark, {show = true}}
}
}
}
})
vpmOpt = {
{text=lang.QosBasic_008,value="-1"},
{text=lang.QosBasic_032,value="0"},
{text="1",value="1"},
{text="2",value="2"},
{text="3",value="3"},
{text="4",value="4"},
{text="5",value="5"},
{text="6",value="6"},
{text="7",value="7"}}
vlanPrioMark = ParSelect(functionId, dataObjId, "DefaultVlanprioMark", lang.QosBasic_007, vpmOpt, "-1")
setArea:append(vlanPrioMark)
function isDefaultDSCPMarkOption(v)
if (v == "-1" or v == "-2" or v == "0" or v == "14" or v == "12" or
v == "10" or v == "8" or v == "22" or v == "20" or v == "18" or
v == "16" or v == "30" or v == "28" or v == "26" or v == "24" or
v == "38" or v == "36" or v == "34" or v == "32" or v == "46" or
v == "40" or v == "48" or v == "56") then return true end
return false
end
function modGETData(self, t)
if t["DefaultTrafficClass"] == "-1" then
t["DefaultTrafficClass"] = ""
end
local dm = t["DefaultDSCPMark"]
if dm == "-0" then dm = "0" end
if not isDefaultDSCPMarkOption(dm) then
t["DefaultDSCPMark"] = "other"
t["other_DefaultDSCPMark"] = dm
end
end
function modPOSTData(self, t)
if t["DefaultDSCPMark"] and t["DefaultDSCPMark"] == "other" then
t["DefaultDSCPMark"] = t["other_DefaultDSCPMark"]
end
if not t["DefaultTrafficClass"] or t["DefaultTrafficClass"] == "" then
t["DefaultTrafficClass"] = "-1"
end
end
setArea.modInstGetData = modGETData
setArea.modInstPostData = modPOSTData
setArea.getInstAfterSet = true
modelArea:append(setArea)
