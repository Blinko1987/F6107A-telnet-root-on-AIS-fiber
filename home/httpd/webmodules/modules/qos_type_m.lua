local cbi = require("data_assemble.comapi")
local util = require("data_assemble.util")
local dataruleModel = require("data_assemble.datarule")
local relationruleModel = require("template.luquid_template.relationrule")
module(..., package.seeall)
local FunctionArea = cbi.FunctionArea
local SetArea = cbi.SetArea
local AreaTip = cbi.AreaTip
local ParRadio = cbi.ParRadio
local ParSelect = cbi.ParSelect
local ParComboSelect = cbi.ParComboSelect
local ParTextBox = cbi.ParTextBox
local ParMac = cbi.ParMac
local ParIPv6 = cbi.ParIPv6
local IPv6Prefix = cbi.IPv6Prefix
local RangeBox = cbi.RangeBox
local SegmentRow = cbi.SegmentRow
local DataRuleInteger = dataruleModel.DataRuleInteger
local DataRuleMACSegment = dataruleModel.DataRuleMACSegment
local DataRuleUtf8 = dataruleModel.DataRuleUtf8
local ApplyRelationRule = relationruleModel.ApplyRelationRule
functionId = "QoSType"
dataObjId = "OBJ_QOSQC_ID"
modelArea = FunctionArea(functionId, nil, lang.QosType_001)
modelArea.areaTip = AreaTip(lang.QosType_028,{lang.QosType_029})
instSwitchTbl = {
dataID = dataObjId,
dataField = "Enable",
switchTable = { {value="1", text=lang.public_033}, {value="0", text=lang.public_034} },
deftValue = "0"
}
qtSetArea = SetArea(functionId, 1, util.PathSeparatorChar.. util.luaPath2LocalPath(_NAME), instSwitchTbl)
name = ParTextBox(functionId, dataObjId, "Alias", lang.public_016)
nameRule = DataRuleUtf8(true, 1, 64)
name:bindDataRule(nameRule)
local evtFuncJS = [[
var ruleName = $("input[id*=']].. name.id ..[[']", ContainerOBJ).val();
if ( 0 == ruleName.indexOf("_QC_") )
{
$(".Btn_delete", ContainerOBJ).remove();
$(".Btn_cancel,.Btn_apply", ContainerOBJ)
.attr("disabled","disabled")
.addClass("disableBtn");
$("input,select", ContainerOBJ).attr("disabled","disabled");
}
]]
local evtFuncJS_namePrefixLimit = [[
var nameObj = $("[id^='OBJ_QOSQC_ID.Alias']", ContainerOBJ);
if (nameObj.length > 0)
{
nameObj.rules("add", {
"QCNamePrefix": true
});
}
]]
name.NeedScript = true
function name.getScript(self, env)
self:appendOnEventScript("fillDataByCustom", evtFuncJS)
self:appendOnEventScript("fillDataByCustom", evtFuncJS_namePrefixLimit)
self:appendOnEventScript("ActionBeforeAddInst", evtFuncJS_namePrefixLimit)
end
qtSetArea:append(name)
qtSetArea:bindInstName(name)
order = ParTextBox(functionId, dataObjId, "Order", lang.QosType_012)
order:setReadOnly(true, true)
qtSetArea:append(order)
qtSetArea.getInstAfterSet = true
Criterion = SegmentRow(lang.QosType_026, true)
qtSetArea:append(Criterion)
itfEnable = ParRadio(functionId, dataObjId, "AllInterface", lang.QosType_008, {{value="1", text=lang.public_033}, {value="0", text=lang.public_034}},"0")
qtSetArea:append(itfEnable)
devIn = ParComboSelect(functionId, dataObjId, "DevIn", lang.QosType_003, {appId="QoSTypeIn"})
qtSetArea:append(devIn)
ApplyRelationRule({
display = {
{
event = {
{itfEnable, {"0"}}
},
action = {
{devIn, {show = true}}
}
}
}
})
macRule = DataRuleMACSegment(true)
sMAC = ParMac(functionId, dataObjId, "MACSrc", lang.QosType_005, {showDeviceList=true, AccessMode="ALL"}, "00:00:00:00:00:00")
sMAC:bindDataRule(macRule)
qtSetArea:append(sMAC)
dMAC = ParMac(functionId, dataObjId, "MACDest", lang.QosType_004, {showDeviceList=true, AccessMode="ALL"}, "00:00:00:00:00:00")
dMAC:bindDataRule(macRule)
qtSetArea:append(dMAC)
vpOpt = {{text=lang.QosType_025,value="-1"},
{text="0",value="0"},
{text="1",value="1"},
{text="2",value="2"},
{text="3",value="3"},
{text="4",value="4"},
{text="5",value="5"},
{text="6",value="6"},
{text="7",value="7"}}
vlanPrio = ParSelect(functionId, dataObjId, "VlanPrio", lang.public_103, vpOpt, "-1")
qtSetArea:append(vlanPrio)
vlanId = ParTextBox(functionId, dataObjId, "VlanID", lang.public_137)
vlanIdRule = DataRuleInteger(false, 0, 4095)
vlanId:bindDataRule(vlanIdRule)
qtSetArea:append(vlanId)
l2Segm = SegmentRow("")
qtSetArea:append(l2Segm)
l2pOpt = {{text=lang.QosType_025,value=""},
{text=lang.public_100, value="IP"},
{text=lang.public_101, value="IPV6"},
{text=lang.public_045, value="ARP"},
{text=lang.public_047, value="PPPOE"}}
l2Protocol = ParSelect(functionId, dataObjId, "L2Protocol", lang.QosType_007, l2pOpt)
qtSetArea:append(l2Protocol)
IPSrcMask = IPv6Prefix(functionId, dataObjId, "IPSrcMask")
IPSrc = ParIPv6(functionId, dataObjId, "IPSrc", lang.QosType_009, IPSrcMask)
qtSetArea:append(IPSrc)
IPDestMask = IPv6Prefix(functionId, dataObjId, "IPDestMask")
IPDest = ParIPv6(functionId, dataObjId, "IPDest", lang.QosType_010, IPDestMask)
qtSetArea:append(IPDest)
DSCPCheck = ParTextBox(functionId, dataObjId, "DSCPCheck", lang.QosType_019)
dcdRule = DataRuleInteger(false, 0, 63)
DSCPCheck:bindDataRule(dcdRule)
qtSetArea:append(DSCPCheck)
l3Segm = SegmentRow("")
qtSetArea:append(l3Segm)
l3pOpt = {{text=lang.QosType_025,value=""},
{text=lang.public_036, value="TCP"},
{text=lang.public_037, value="UDP"},
{text=lang.public_038, value="ICMP"}}
l3Protocol = ParSelect(functionId, dataObjId, "L3ProtocolList", lang.QosType_017, l3pOpt)
qtSetArea:append(l3Protocol)
function setPortWidth(self, env)
self.__parent.render(self, env)
self:replaceAttributeValByID(self.id, "class", "inputNorm", "port")
return self.html
end
portRule = DataRuleInteger(false, 0, 65535)
SrcPort = ParTextBox(functionId, dataObjId, "SrcPort", lang.QosType_013)
SrcPort:bindDataRule(portRule)
SrcPort.render = setPortWidth
SrcPortMax = ParTextBox(functionId, dataObjId, "SrcPortMax",lang.QosType_013)
SrcPortMax:bindDataRule(portRule)
SrcPortMax.render = setPortWidth
spRange = RangeBox(SrcPort, "<=", SrcPortMax, true)
qtSetArea:append(spRange)
DestPort = ParTextBox(functionId, dataObjId, "DestPort", lang.QosType_018)
DestPort:bindDataRule(portRule)
DestPort.render = setPortWidth
DestPortMax = ParTextBox(functionId, dataObjId, "DestPortMax",lang.QosType_018)
DestPortMax:bindDataRule(portRule)
DestPortMax.render = setPortWidth
dpRange = RangeBox(DestPort, "<=", DestPortMax, true)
qtSetArea:append(dpRange)
TcpAck = ParRadio(functionId, dataObjId, "TcpAck", lang.QosType_011, {{value="1", text=lang.public_033}, {value="0", text=lang.public_034}},"0")
qtSetArea:append(TcpAck)
ApplyRelationRule({
display = {
{
event = {
{l3Protocol, {"","ICMP"}}
},
action = {
{spRange, {show = false}},
{dpRange, {show = false}}
}
}
}
})
ApplyRelationRule({
display = {
{
event = {
{l3Protocol, {"TCP"}}
},
action = {
{TcpAck, {show = true}}
}
}
}
})
resultSegm = SegmentRow(lang.QosType_027, true)
qtSetArea:append(resultSegm)
vpmOpt = {{text=lang.QosBasic_008,value="-1"},
{text=lang.QosBasic_032,value="0"},
{text="1",value="1"},
{text="2",value="2"},
{text="3",value="3"},
{text="4",value="4"},
{text="5",value="5"},
{text="6",value="6"},
{text="7",value="7"}}
VlanPrioMark = ParSelect(functionId, dataObjId, "VlanPrioMark", lang.QosType_020, vpmOpt, "-1")
qtSetArea:append(VlanPrioMark)
dmOpt = { {text=lang.QosBasic_008,value="-1"},
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
DscpMark = ParSelect(functionId, dataObjId, "DscpMark", lang.QosType_021, dmOpt, "-1")
qtSetArea:append(DscpMark)
inputDscpMark = ParTextBox(functionId, dataObjId, "other_DscpMark", "&nbsp;")
idmRule = DataRuleInteger(true, -2, 63)
inputDscpMark:bindDataRule(idmRule)
qtSetArea:append(inputDscpMark)
ApplyRelationRule({
display = {
{
event = {
{DscpMark, {"other"}}
},
action = {
{inputDscpMark, {show = true}}
}
}
}
})
ApplyRelationRule({
display = {
{
event = {
{l2Protocol, {"ARP"}}
},
action = {
{IPSrcMask, {show = false}},
{IPDestMask, {show = false}},
{DSCPCheck, {show = false}},
{l3Protocol, {show = false}},
{spRange, {show = false}},
{dpRange, {show = false}},
{TcpAck, {show = false}},
{DscpMark, {show = false}},
{inputDscpMark, {show = false}}
}
}
}
})
pqOpt = {{text="",value=""}}
listTbl = cmapi.querylist("OBJ_QOSQP_ID","DEV")
for i, v in ipairs(listTbl) do
getInstTbl = cmapi.getinst("OBJ_QOSQP_ID", v)
aKeyValTbl = {}
aKeyValTbl["text"] = getInstTbl.Alias
aKeyValTbl["value"] = v
table.insert(pqOpt, aKeyValTbl)
end
PolicerQueue = ParSelect(functionId, dataObjId, "PolicerQueue", lang.QosType_022, pqOpt)
qtSetArea:append(PolicerQueue)
TrafficClass = ParTextBox(functionId, dataObjId, "TrafficClass", lang.QosType_023)
tcRule = DataRuleInteger(false, 1, 128)
TrafficClass:bindDataRule(tcRule)
qtSetArea:append(TrafficClass)
function isDscpMarkOption(v)
if (v == "-1" or v == "-2" or v == "0" or v == "14" or v == "12" or
v == "10" or v == "8" or v == "22" or v == "20" or v == "18" or
v == "16" or v == "30" or v == "28" or v == "26" or v == "24" or
v == "38" or v == "36" or v == "34" or v == "32" or v == "46" or
v == "40" or v == "48" or v == "56") then return true end
return false
end
function modGETData(self, t)
local idTbl = {"SrcPort","SrcPortMax","DestPort","DestPortMax","VlanID","DSCPCheck","TrafficClass"}
for i, id in pairs(idTbl) do
if t[idTbl[i]] == "-1" then
t[idTbl[i]] = ""
end
end
local smask = t["IPSrcMask"]
if smask ~= "" then
smask = smask:match(".+/(%d+)$")
t["IPSrcMask"] = smask
end
local dmask = t["IPDestMask"]
if dmask ~= "" then
dmask = dmask:match(".+/(%d+)$")
t["IPDestMask"] = dmask
end
local dm = t["DscpMark"]
if dm == "-0" then dm = "0" end
if not isDscpMarkOption(dm) then
t["DscpMark"] = "other"
t["other_DscpMark"] = dm
end
if t["DevIn"] == "" then
t["DevIn"] = "LAN"
end
end
function modPOSTData(self, t)
if t["DscpMark"] and t["DscpMark"] == "other" then
t["DscpMark"] = t["other_DscpMark"]
end
if t["L2Protocol"] == "ARP" then
local l2IdTbl = {"IPDest","IPDestMask","IPSrc","IPSrcMask","SrcPort","SrcPortMax",
"DestPortMax","DestPort","DSCPCheck","DscpMark","L3ProtocolList"}
for i, id in pairs(l2IdTbl) do
t[l2IdTbl[i]] = ""
end
end
if t["L3ProtocolList"] and t["L3ProtocolList"] ~= "TCP" and t["L3ProtocolList"] ~= "UDP" then
local portIdTbl = {"SrcPort","SrcPortMax","DestPortMax","DestPort"}
for i, id in pairs(portIdTbl) do
t[portIdTbl[i]] = "-1"
end
end
if t["L3ProtocolList"] and t["L3ProtocolList"] ~= "TCP" then
t["TcpAck"] = "0"
end
local sMask, dMask, sIP, dIP = t["IPSrcMask"], t["IPDestMask"], t["IPSrc"], t["IPDest"]
if (sMask and sMask ~= "") and (sIP and sIP ~= "") then
t["IPSrcMask"] = table.concat({sIP, "/", sMask})
end
if (dMask and dMask ~= "") and (dIP and dIP ~= "") then
t["IPDestMask"] = table.concat({dIP, "/", dMask})
end
local idTbl = {"SrcPort","SrcPortMax","DestPort","DestPortMax","VlanID","DSCPCheck","TrafficClass","DscpMark"}
for i, id in pairs(idTbl) do
if t[idTbl[i]] == "" then
t[idTbl[i]] = "-1"
end
end
end
qtSetArea.modInstGetData = modGETData
qtSetArea.modInstPostData = modPOSTData
local specialValidRule = [[
$(document).ready(function()
{
jQuery.validator.addMethod("QCNamePrefix", function(value, element) {
return ( this.optional(element) || value.match(/^_QC_/) == null );
}, $.validator.format("]] .. _G.encodeJS(lang.QosType_030) .. [["));
});
]]
function qtSetArea.getScript(self, env)
SetArea.getScript(self, env)
self:injectScript(env, specialValidRule)
end
modelArea:append(qtSetArea)
