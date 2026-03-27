local cgilua = cgilua.cgilua
local baseComp = require("template.luquid_template.cbi")
local util = require("data_assemble.util")
local tableUtils = require("common_lib.table_utils")
local class = util.class
local instanceof = util.instanceof
local clone = util.clone
local merge = util.merge
local g_logger = g_logger
module(..., package.seeall)
AbstractElement = baseComp.AbstractElement
AbstractComponent = baseComp.AbstractComponent
AbstractContainer = baseComp.AbstractContainer
AbstractSetArea = baseComp.AbstractSetArea
AbstractEmptyArea = baseComp.AbstractEmptyArea
AbstractFileUploadArea = baseComp.AbstractFileUploadArea
AbstractArea = baseComp.AbstractArea
AbstractStatusArea = baseComp.AbstractStatusArea
AbstractPage = baseComp.AbstractPage
FunctionArea = baseComp.FunctionArea
VerticalTable = baseComp.VerticalTable
HorizontalTable = baseComp.HorizontalTable
TableTitle = baseComp.TableTitle
TableItem = baseComp.TableItem
TableRow = baseComp.TableRow
EmptyElement = baseComp.EmptyElement
ButtonCancel = baseComp.ButtonCancel
ButtonApply = baseComp.ButtonApply
ButtonDelete = baseComp.ButtonDelete
ButtonRefresh = baseComp.ButtonRefresh
ButtonRestart = baseComp.ButtonRestart
ButtonReset = baseComp.ButtonReset
ParTextBox = baseComp.ParTextBox
TextBox = baseComp.TextBox
ParPasswordText = baseComp.ParPasswordText
Radio = baseComp.Radio
VerticalRadio = baseComp.VerticalRadio
ParRadio = baseComp.ParRadio
ParVerticalRadio = baseComp.ParVerticalRadio
VerticalRadioItem = baseComp.VerticalRadioItem
Checkbox = baseComp.Checkbox
ParSelect = baseComp.ParSelect
ParTextarea = baseComp.ParTextarea
ParIPv4 = baseComp.ParIPv4
ParMac = baseComp.ParMac
ParTime = baseComp.ParTime
ParTimeScalar = baseComp.ParTimeScalar
ParWeek = baseComp.ParWeek
ParIPv6 = baseComp.ParIPv6
IPv6Prefix = baseComp.IPv6Prefix
ParFileUpload = baseComp.ParFileUpload
ServerHideComponent = baseComp.ServerHideComponent
BrowersHideComponent = baseComp.BrowersHideComponent
ComponentStyle = baseComp.ComponentStyle
AreaTip = baseComp.AreaTip
Label = baseComp.Label
StaticInfoHint = baseComp.StaticInfoHint
BatchSelectButton = baseComp.BatchSelectButton
RangeBox = baseComp.RangeBox
TemplateBox = baseComp.TemplateBox
RowBox = baseComp.RowBox
SegmentRow = baseComp.SegmentRow
AreaTipItem = class(AbstractElement)
function AreaTipItem.__init__(self, title)
AbstractElement.__init__(self, title)
self.template = "TipItem"
end
AreaTip = class(AbstractElement)
function AreaTip.__init__(self, title, content)
AbstractElement.__init__(self, title)
self.template = "Tip"
if type(content) == "table" then
for _, value in pairs(content) do
self:append(AreaTipItem(value))
end
elseif type(content) == "string" then
self:append(AreaTipItem(content))
end
end
ParComboSelect = class(ParSelect)
function ParComboSelect.__init__(self, id, dataID, dataField, title, appTbl, defaultValue, style)
local staticOpt = {
DMZ = {{value = "IGD.WANIF", text = lang.public_094}},
IGMP = {{value = "", text = lang.public_089}},
IPSEC = {{value = "", text = lang.public_089}},
L2TP = {{value = "", text = lang.public_089}},
MLD = {{value = "", text = lang.public_089}},
MulticastVlan = {{value = "", text = lang.public_089}},
PortForward = {{value = "WANAll", text = lang.public_094}},
QoSCongestion = {{value = "WAN", text = lang.public_128}},
QoSShaper = {{value = "WAN", text = lang.public_128}},
QoSTypeIn = {{value = "LAN", text = lang.public_084},{value = "WAN", text = lang.public_128}},
IPFilter = {{value = "", text = lang.public_039}},
IPv4ServCtl = {{value = "IGD.WANIF", text = lang.public_128}},
IPv6ServCtl = {{value = "IGD.WANIF", text = lang.public_128}},
Tunnel4in6 = {{value = "", text = lang.public_089}},
Tunnel6in4 = {{value = "", text = lang.public_089}},
IPv4UPnP = {{value = "", text = lang.public_094}},
IPv6UPnP = {{value = "", text = lang.public_094}},
IPv4Route = {{value = "", text = lang.public_089}},
IPv6Route = {{value = "", text = lang.public_089}},
PING = {{value = "", text = lang.public_094}},
Tracert = {{value = "", text = lang.public_094}},
MirrorSrc = {{value = "IGD.WANALL", text = lang.public_128}},
MirroDes = {{value = "", text = lang.public_089}},
TR069 = {{value = "", text = lang.public_094}},
SIP = {{value = "", text = lang.public_094, attrTbl = {IPmode = 0}}},
}
local optionTbl = appTbl.staticOptTbl or staticOpt[appTbl.appId] or {}
local listIFTbl = cmapi.ListIFByApp(appTbl.appId)
if listIFTbl.IF_ERRORID == 0 then
for i, v in ipairs(listIFTbl) do
if (appTbl.attrTbl) and type(appTbl.attrTbl) == "table" then
local otherAttrs = {}
for j, attrName in ipairs(appTbl.attrTbl) do
otherAttrs[attrName] = v[attrName] or ""
end
table.insert(optionTbl, {value = v.InstID, text = v.InstName, attrTbl = otherAttrs})
else
table.insert(optionTbl, {value = v.InstID, text = v.InstName})
end
end
else
g_logger:warn("cmapi.ListIFByApp fail. appId="..tostring(appTbl.appId))
end
ParSelect.__init__(self, id, dataID, dataField, title, optionTbl, defaultValue, style)
end
ButtonGroupBox = class(AbstractContainer)
function ButtonGroupBox.__init__(self)
AbstractElement.__init__(self)
self.template = "ButtonGroupBox"
end
EmphasisBox = class(AbstractContainer)
function EmphasisBox.__init__(self, id, title)
local maddr = tostring(self)
maddr = string.gsub(maddr, "[ :]", "_")
local comid = "EmphasisBox:" .. id .. ":" .. maddr
AbstractContainer.__init__(self, comid, title)
self.template = "EmphasisBox"
end
function EmphasisBox.pre_render_children(self, childElement)
if not childElement.NeedWrapper then
return ""
elseif not instanceof(childElement, baseComp.AbstractContainer)
or childElement.wrapperIsRow then
return [[<div class="row ControlWrapper">]]
else
return [[<div class="ControlWrapper">]]
end
end
function EmphasisBox.post_render_children(self, childElement)
if not childElement.NeedWrapper then
return ""
else
return [[</div>]]
end
end
EmptyArea = class(AbstractEmptyArea)
function EmptyArea.__init__(self, id, modelPath)
AbstractEmptyArea.__init__(self, id, "", modelPath)
self.id = id
self.template = "EmptyArea"
self.NeedScript = true
end
FileUploadArea = class(AbstractFileUploadArea)
function FileUploadArea.__init__(self, id, btnName,labelName,eventBeforeUpload)
AbstractFileUploadArea.__init__(self, id, btnName,labelName)
self.id = id
self.eventBeforeUpload = eventBeforeUpload or nil
self.template = "FileUploadArea"
self.NeedScript = true
end
function FileUploadArea.pre_render_children(self)
return [[<div class="row">]]
end
function FileUploadArea.post_render_children(self)
return [[</div>]]
end
AddInstBar = class(AbstractElement)
function AddInstBar.__init__(self, id)
AbstractElement.__init__(self, lang.public_098)
self.id = id
self.template = "AddInstBar"
end
InstButtonDelete = class(ButtonDelete)
function InstButtonDelete.__init__(self, id, title, style)
ButtonDelete.__init__(self, title or "Delete", style)
self.template = "ButtonDelete"
end
SetHeadCtrlBar = class(AbstractComponent)
function SetHeadCtrlBar.__init__(self, id, dataID, switchDataField, switchTable, deftValue, title, delButtonField)
AbstractComponent.__init__(self, id, nil, nil, title)
self.template = "CtrBar"
self.NeedScript = true
self.InstNameComp = nil
if delButtonField ~= nil then
self.buttonDelete = InstButtonDelete(id, nil, nil)
else
self.buttonDelete = EmptyElement()
end
if switchDataField ~= nil then
self.instSwitch = Radio(id, dataID, switchDataField, title, switchTable, (deftValue or "0"))
else
self.instSwitch = EmptyElement()
end
end
SetArea = class(AbstractSetArea)
function SetArea.__init__(self, id, maxInstNum, modelPath, instSwitchTbl, areaActionTbl)
AbstractSetArea.__init__(self, id, maxInstNum, "", modelPath)
self.id = id
self.template = "SetArea"
self.NeedScript = true
self.areaActionTbl = areaActionTbl
local forbidAddInst, forbidDelInst, forbidModInst = nil, nil, nil
if self.areaActionTbl then
forbidAddInst = self.areaActionTbl.forbidAddInst
forbidDelInst = self.areaActionTbl.forbidDelInst
forbidModInst = self.areaActionTbl.forbidModInst
end
self.succHint = lang.public_021 or "Your data have been stored!"
local delButtonField = true
if forbidDelInst then
delButtonField = nil
end
if not instSwitchTbl then
self.setHeadCtrlBar = SetHeadCtrlBar(id,
nil,
nil,
nil,
nil,
lang.public_041 or "New Item",
delButtonField)
else
self.setHeadCtrlBar = SetHeadCtrlBar(id,
instSwitchTbl.dataID,
instSwitchTbl.dataField,
instSwitchTbl.switchTable,
instSwitchTbl.deftValue,
lang.public_041 or "New Item",
delButtonField)
self:append(ServerHideComponent(id, instSwitchTbl.dataID, instSwitchTbl.dataField))
end
if forbidAddInst then
self.addInstBar = EmptyElement()
else
self.addInstBar = AddInstBar(id)
end
if self.maxInstNum >= 1 then
self.setHeadCtrlBar.NeedRender = true
if not forbidDelInst then
self.buttonDelete = self.setHeadCtrlBar.buttonDelete
self:appendEventControl(self.buttonDelete)
end
if not forbidAddInst then
self.addInstBar.NeedRender = true
end
else
self.setHeadCtrlBar.NeedRender = false
self.addInstBar.NeedRender = false
end
self.buttonCancel = ButtonCancel(id)
self.buttonApply = ButtonApply(id)
if forbidModInst then
self.buttonApply:setReadOnly(true)
if self.setHeadCtrlBar.instSwitch then
self.setHeadCtrlBar.instSwitch:setReadOnly(true)
end
end
self:appendEventControl(self.buttonCancel)
self:appendEventControl(self.buttonApply)
self.buttonGroupBox = ButtonGroupBox()
self.buttonGroupBox:append(self.buttonCancel)
self.buttonGroupBox:append(self.buttonApply)
end
function SetArea._updateAreaLabelStyle(parent, child, output, setarea)
if child.parLabel ~= nil then
if child.parLabel.style ~= ComponentStyle.Norm then
if setarea._parLabelStyleLock == true then
if child.parLabel.style > setarea._parLabelStyle then
setarea._parLabelStyle = child.parLabel.style
end
else
setarea._parLabelStyle = child.parLabel.style
setarea._parLabelStyleLock = true
end
else
if setarea._parLabelStyleLock ~= true then
child.parLabel:allocatWidth()
if setarea._parLabelStyle == nil or child.parLabel.style > setarea._parLabelStyle then
setarea._parLabelStyle = child.parLabel.style
end
end
end
elseif instanceof(child, AbstractContainer) then
child:search_children(SetArea._updateAreaLabelStyle, nil, setarea)
end
end
function SetArea._setParStyle(self, obj)
self._updateAreaLabelStyle(nil, obj, nil, self)
end
function SetArea._setComponentLabelStyle(parent, child, output, setarea)
if child.parLabel and child.parLabel.style ~= setarea._parLabelStyle then
child.parLabel.style = setarea._parLabelStyle
elseif instanceof(child, AbstractContainer) then
child:search_children(SetArea._setComponentLabelStyle, nil, setarea)
elseif instanceof(child, VerticalRadio) then
child:search_children(VerticalRadioItem._setLabelStyle, nil, setarea)
end
end
function SetArea._prepareRender(self)
if self._parLabelStyle ~= ComponentStyle.Norm then
self:search_children(SetArea._setComponentLabelStyle, nil, self)
end
end
function SetArea.bindInstName(self, obj)
self.setHeadCtrlBar.InstNameComp = obj
end
function SetArea.getChildOnEventScript(self, env, event)
local cache = {"", "\n", ""}
cache[1] = self.setHeadCtrlBar:getOnEventScript(env, event)
cache[3] = AbstractSetArea.getChildOnEventScript(self, env, event)
return table.concat(cache)
end
function SetArea.append(self, obj, ...)
if not instanceof(obj, AbstractElement) then
return false
end
self:_setParStyle(obj)
local ret = AbstractSetArea.append(self, obj, ...)
return ret
end
function SetArea.render(self, env, ...)
self:_prepareRender()
AbstractSetArea.render(self, env, ...)
if self.maxInstNum < 1 then
self:delAttributeByID("changeArea_"..self.id, "style")
self:setAttributeByID("_InstNum", "1")
end
return self.html
end
function SetArea.pre_render_children(self, childElement)
if not childElement.NeedWrapper then
return ""
elseif not instanceof(childElement, baseComp.AbstractContainer)
or childElement.wrapperIsRow then
return [[<div class="row ControlWrapper">]]
else
return [[<div class="ControlWrapper">]]
end
end
function SetArea.post_render_children(self, childElement)
if not childElement.NeedWrapper then
return ""
else
return [[</div>]]
end
end
StatusArea = class(AbstractStatusArea)
function StatusArea.__init__(self, id, title, modelPath, noDataHint, maxInstNum)
AbstractStatusArea.__init__(self, id, title, modelPath, maxInstNum)
self.template = "StatusArea"
self.NeedScript = true
self.buttonRefresh = ButtonRefresh(id)
self.noDataHint = noDataHint or lang.public_023
end
CommonPage = class(AbstractPage)
function CommonPage.__init__(self, pageName)
AbstractPage.__init__(self, pageName)
self.template = "CommonPage"
end
local function getModelArea(modelPath)
local Right = cgilua.getCurrentSessAttr("Right")
package.loaded[modelPath] = nil
local model = require(modelPath)
package.loaded[modelPath] = nil
tableUtils.removeTableOfLuaPath(modelPath)
if type(model) == "table" then
if type(model.modelArea) == "table" then
local modifierPath = modelPath .. "_modifier"
local ok, modifierLoader = pcall(require, modifierPath)
if ok then
modifierLoader(model)
end
return model.modelArea
else
g_logger:warn("model " .. modelPath .. "is error format!")
return nil
end
else
return nil
end
end
function doModelViewRender(modelName, env)
local modelPath = "modules."..modelName
local modelArea = getModelArea(modelPath)
if modelArea ~= nil then
if type(modelArea.output) == "function" then
modelArea:output(env)
end
else
g_logger:warn("model " .. modelPath .. "is error format!")
end
end
function doModelRequest(modelPath, cgilua)
local modelArea = getModelArea(modelPath)
if modelArea ~= nil then
if type(modelArea.doRequest) == "function" then
modelArea:doRequest(cgilua)
end
else
g_logger:warn("model " .. modelPath .. "is error format!")
end
end
