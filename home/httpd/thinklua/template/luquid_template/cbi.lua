local template = require("data_assemble.template")
local util = require("data_assemble.util")
local class = util.class
local instanceof = util.instanceof
local stringIsEmpty = util.stringIsEmpty
local clone = util.clone
local merge = util.merge
local json = require("common_lib.json")
local dataruleModel = require("data_assemble.datarule")
local DataRule = dataruleModel.DataRule
local DataRuleRangeBox = dataruleModel.DataRuleRangeBox
local dataModel = require("data_assemble.data")
local Data = dataModel.Data
local relationruleModel = require("template.luquid_template.relationrule")
local RelationRule = relationruleModel.RelationRule
local xmlModel = require("data_assemble.xml")
local XML = xmlModel.XML
local g_logger = g_logger
module(..., package.seeall)
Node = class()
function Node.__init__(self)
self.children = {}
end
function Node.append(self, obj, prevPostion)
local insertPostion = #self.children+1
if prevPostion == nil then
prevPostion = -1
end
if type(prevPostion) == "number" then
if prevPostion ~= 0 and prevPostion ~= -1 then
g_logger:warn("prevPostion type is error")
return false
elseif prevPostion == -1 then
prevPostion = #self.children
else
end
elseif type(prevPostion) == "table" then
for i=1, #self.children do
if self.children[i] == prevPostion then
prevPostion = i
break
end
end
else
g_logger:warn("prevPostion type is error")
return false
end
insertPostion = prevPostion + 1
table.insert(self.children, insertPostion, obj)
return true
end
function Node.remove(self, obj)
for i=1, #self.children do
if self.children[i] == obj then
table.remove(self.children, i)
return true
end
end
return false
end
function Node.render(self, env)
self.env = env or self.env
self.temp = template.Template(self.template)
self.html = self.temp:render(self, self.env)
self.temp = nil
return self.html
end
function Node.search_children(self, searchFunc, output, ...)
if type(self.children) ~= "table" or type(searchFunc) ~= "function" then
return
end
for k, node in pairs(self.children) do
output = searchFunc(self, node, output, ...)
end
return output
end
function Node._render_children(self, node, output, template, env)
if type(self.pre_render_children) == "function" then
local prestr = self:pre_render_children(node) or ""
table.insert(output, prestr)
end
if type(node) == "table" then
local nodeStr = node:render(env) or ""
table.insert(output, nodeStr)
end
if type(self.post_render_children) == "function" then
local poststr = self:post_render_children(node) or ""
table.insert(output, poststr)
end
return output
end
function Node.render_children(self, env)
local tmp = {}
self.env = env or self.env
self.temp = template.Template(self.template)
tmp = self:search_children(self._render_children, tmp, self.temp, self.env)
self.temp = nil
return table.concat(tmp)
end
ComponentStyle = {}
ComponentStyle.Short = -1
ComponentStyle.Norm = 0
ComponentStyle.Long = 1
AbstractElement = class(Node)
function AbstractElement.__init__(self, title, style)
Node.__init__(self)
self.title = title or ""
self.html = nil
self.NeedRender = true
self.NeedScript = false
self.NeedScriptClass = false
self.NeedWrapper = true
self.style = style or ComponentStyle.Norm
end
function AbstractElement.render(self, env)
if self.NeedRender then
if self.html == nil then
self.html = Node.render(self, env)
end
if self.NeedScriptClass then
self:getScriptClass(env)
end
if self.NeedScript then
self:getScript(env)
end
if self.ReadOnly == true and self._renderReadOnly ~= nil then
self:_renderReadOnly(self.setReadOnlyArg)
end
return self.html
else
self.html = ""
return self.html
end
end
function AbstractElement.setReadOnly(self, readOnly, ...)
if type(readOnly) ~= "boolean" then
return
end
self.ReadOnly = readOnly or true
self.setReadOnlyArg = {...}
end
function AbstractElement._renderReadOnly(self)
end
function AbstractElement.setRight(self, right)
if type(right) ~= "number" then
return
end
self.right = right or self.right
end
function AbstractElement.checkRight(self, env)
if not self.right then
return true
end
if type(self.right) ~= "number" then
return false
end
return require("user_mgr.usermgr_logic_impl"):checkRightPassed(self.right)
end
function AbstractElement.getScript(self, env)
if self.NeedRender then
self.temp = self.temp or template.Template(self.template)
local tmpScript = self.temp:getScript(self, env)
table.insert(env.__script, tmpScript)
end
end
function AbstractElement.injectScript(self, env, script)
if self.NeedRender then
table.insert(env.__script, script)
end
end
function AbstractElement.getScriptClass(self, env)
if self.NeedRender then
env.__ClassScriptRenderTbl = env.__ClassScriptRenderTbl or {}
if not env.__ClassScriptRenderTbl[self.template] then
self.temp = self.temp or template.Template(self.template)
local classScript = self.temp:getScriptClass(self, env)
table.insert(env.__script, classScript)
env.__ClassScriptRenderTbl[self.template] = true
end
end
end
function AbstractElement._getScriptListContent(self, tbScript, env)
local scriptContent = ""
if nil ~= tbScript then
scriptContent = table.concat(tbScript)
end
return scriptContent
end
function AbstractElement.appendDocumentReadyScript(self, documtReadyScript)
self.tbDocumtReadyScript = self.tbDocumtReadyScript or {}
if type(documtReadyScript) == "string" then
table.insert(self.tbDocumtReadyScript, documtReadyScript)
end
end
function AbstractElement.getDocumentReadyScript(self, env)
return self:_getScriptListContent(self.tbDocumtReadyScript, env)
end
function AbstractElement.appendOnEventScript(self, event, onEventScript)
self.tbOnEventScript = self.tbOnEventScript or {}
self.tbOnEventScript[event] = self.tbOnEventScript[event] or {}
if type(onEventScript) == "string" then
table.insert(self.tbOnEventScript[event], onEventScript)
end
end
function AbstractElement.getOnEventScript(self, env, event)
if nil ~= self.tbOnEventScript then
return self:_getScriptListContent(self.tbOnEventScript[event], env)
else
return ""
end
end
function AbstractElement.getElement(self, elementType)
if type(elementType) ~= "string" then
return nil
end
if not self.html then
if type(self.render) == "function" then
self.render(self, self.env)
end
end
if type(self.html) == "string" then
local pattern = "<[^>]*" .. elementType .. "%s*[^<]*/?>"
local targetElement = string.match(self.html, pattern)
return targetElement
else
return nil
end
end
function AbstractElement.getElementByID(self, elementID)
if type(elementID) ~= "string" then
return nil
end
if not self.html then
if type(self.render) == "function" then
self.render(self, self.env)
end
end
if type(self.html) == "string" then
local pattern = "<[^>]*id%s*=%s*[\"']" .. elementID .. "[\"'][^<]*/?>"
local targetElement = string.match(self.html,pattern)
return targetElement
else
return nil
end
end
function AbstractElement.getAttribute(self, elementType, attribute)
if type(elementType) ~= "string" or type(attribute) ~= "string" then
return nil
end
if not self.html then
if type(self.render) == "function" then
self.render(self, self.env)
end
end
if type(self.html) == "string" then
local pattern = [[<%s*]]..elementType..[[%s*.-]]..attribute.."%s*=%s*([\"'])(.-)%1"..[[.-/?>]]
local _, targetAttribute = string.match(self.html, pattern)
return targetAttribute
else
return nil
end
end
function AbstractElement.getAttributeByID(self, elementID, attribute)
if type(elementID) ~= "string" or type(attribute) ~= "string" then
return nil
end
if not self.html then
if type(self.render) == "function" then
self.render(self, self.env)
end
end
if type(self.html) == "string" then
local targetElement = self:getElementByID(elementID)
if targetElement == nil then
return nil
end
local pattern = "<%s*.-%s+"..attribute.."%s*=%s*([\"'])(.-)%1.-/?>"
local _, targetAttribute = string.match(targetElement,pattern)
return targetAttribute
else
return nil
end
end
function AbstractElement.replaceAttributeValByID(self, elementID, attribute, oldVal, newVal)
if type(elementID) ~= "string" or type(attribute) ~= "string" or
type(oldVal) ~= "string" or type(newVal) ~= "string" then
return nil
end
if not self.html then
if type(self.render) == "function" then
self.render(self, self.env)
end
end
if type(self.html) == "string" then
local target = self:getAttributeByID(elementID, attribute)
if target == nil then
return nil
end
local pattern = oldVal
local newValue = string.gsub(target, pattern, newVal)
return self:setAttributeByID(elementID, attribute, newValue)
else
return nil
end
end
function AbstractElement._setAttributeByElement(self, targetElement, attribute, value)
if type(targetElement) ~= "string" or type(attribute) ~= "string" then
return false
end
local pattern = attribute .. "%s*=%s*[\"'](.-)[\"']"
local repl
if value ~= nil then
repl = attribute..[[="]]..value..[["]]
else
repl = attribute
end
local oldElement = string.match(targetElement, pattern)
local newElement
if oldElement == nil then
pattern = "/?>"
endPart = string.match(targetElement, pattern)
newElement = string.gsub(targetElement, pattern, " " .. repl .. (endPart or ""))
else
newElement = string.gsub(targetElement, pattern, repl)
end
if newElement == nil then
return false
end
local startIdx, endIdx = string.find(self.html, targetElement, 1, true)
if startIdx then
local tmpTbl = {}
table.insert(tmpTbl, string.sub(self.html, 1, startIdx - 1))
table.insert(tmpTbl, newElement)
table.insert(tmpTbl, string.sub(self.html, endIdx + 1, string.len(self.html)))
self.html = table.concat(tmpTbl)
end
return true
end
function AbstractElement.setAttribute(self, elementType, attribute, value)
if type(elementType) ~= "string" or type(attribute) ~= "string" then
return false
end
if not self.html then
if type(self.render) == "function" then
self.render(self, self.env)
end
end
if type(self.html) == "string" then
local targetElement = self:getElement(elementType)
if targetElement == nil then
return false
end
return self:_setAttributeByElement(targetElement, attribute, value)
else
return false
end
end
function AbstractElement.setAttributeByID(self, elementID, attribute, value)
if type(elementID) ~= "string" or type(attribute) ~= "string" then
return false
end
if not self.html then
if type(self.render) == "function" then
self.render(self, self.env)
end
end
if type(self.html) == "string" then
local targetElement = self:getElementByID(elementID)
if targetElement == nil then
return false
end
return self:_setAttributeByElement(targetElement, attribute, value)
end
end
function AbstractElement.addAttributeByID(self, elementID, attribute, value)
if type(elementID) ~= "string" or type(attribute) ~= "string" then
return false
end
if not self.html then
if type(self.render) == "function" then
self.render(self, self.env)
end
end
if type(self.html) == "string" then
local oldValue = self:getAttributeByID(elementID,attribute)
local newValue = ""
if oldValue ~= nil and string.len(oldValue) > 0 then
newValue = oldValue .. " " .. value
else
newValue = value
end
return self:setAttributeByID(elementID, attribute, newValue)
else
return false
end
end
function AbstractElement.addAttribute(self, elementType, attribute, value)
if type(elementType) ~= "string" or type(attribute) ~= "string" then
return false
end
if not self.html then
if type(self.render) == "function" then
self.render(self, self.env)
end
end
if type(self.html) == "string" then
local oldValue = self:getAttribute(elementType, attribute)
local newValue = ""
if oldValue ~= nil and string.len(oldValue) > 0 then
newValue = oldValue .. " " .. value
else
newValue = value
end
return self:setAttribute(elementType, attribute, newValue)
else
return false
end
end
function AbstractElement.delAttribute(self, elementType, attribute)
if type(elementType) ~= "string" or type(attribute) ~= "string" then
return false
end
if not self.html then
if type(self.render) == "function" then
self.render(self, self.env)
end
end
if type(self.html) == "string" then
local targetElement = self:getElement(elementType)
if targetElement == nil then
return false
end
local pattern = attribute .. "%s*=%s*[\"'](.-)[\"']"
local newtargetElement = string.gsub(targetElement, pattern, "")
self.html = string.gsub(self.html,targetElement, newtargetElement)
else
return false
end
end
function AbstractElement.delAttributeByID(self, elementID, attribute)
if type(elementID) ~= "string" or type(attribute) ~= "string" then
return false
end
if not self.html then
if type(self.render) == "function" then
self.render(self, self.env)
end
end
if type(self.html) == "string" then
local targetElement = self:getElementByID(elementID)
if targetElement == nil then
return false
end
local pattern = attribute .. "%s*=%s*[\"'](.-)[\"']"
local newtargetElement = string.gsub(targetElement, pattern, "")
self.html = string.gsub(self.html, targetElement, newtargetElement)
else
return false
end
end
EmptyElement = class(AbstractElement)
function EmptyElement.__init__(self)
AbstractElement.__init__(self, "")
self.NeedRender = false
end
EventElement = class(AbstractElement)
function EventElement.__init__(self, title, style)
AbstractElement.__init__(self, title, style)
end
function EventElement._appendEventFunction(self, eventType, eventName, eventfunction)
self._eventFun = self._eventFun or {}
self._eventFun[eventType] = self._eventFun[eventType] or {}
self._eventFun[eventType][eventName] = eventfunction
end
function EventElement.getEventFunction(self, eventType, eventName)
self._eventFun = self._eventFun or {}
self._eventFun[eventType] = self._eventFun[eventType] or {}
return self._eventFun[eventType][eventName]
end
ParElement = class(AbstractElement)
function ParElement.__init__(self, title, style)
AbstractElement.__init__(self, title, style)
end
function ParElement.render(self, parent, env)
local cache = {"", "", ""}
parent.render(self, env)
if self.parLabel ~= nil then
table.insert(cache, self.parLabel:render(env))
table.insert(cache, "<div class=\"right\">")
table.insert(cache, self.html)
table.insert(cache, "</div>")
self.html = table.concat(cache)
end
return self.html
end
Button = class(EventElement)
function Button.__init__(self, title, style)
AbstractElement.__init__(self, title, style)
self.template = "Button"
end
function Button._renderReadOnly(self, setReadOnlyArg)
local absReadOnly = setReadOnlyArg[1] or false
if type(absReadOnly) ~= "boolean" then
absReadOnly = false
end
if not absReadOnly then
self:setAttributeByID(self.id, "_readonlycanberm", "")
end
self:setAttributeByID(self.id, "disabled", "disabled")
self:addAttributeByID(self.id, "class", "disableBtn")
end
ButtonCancel = class(Button)
function ButtonCancel.__init__(self, id, title, style)
Button.__init__(self, title or lang.public_019, style)
self.id = "Btn_cancel_"..id
self:_appendEventFunction("POST","Cancel", self._doCancel)
end
function ButtonCancel.render(self, env)
Button.render(self, env)
self:addAttributeByID(self.id, "class", "Btn_cancel")
return self.html
end
function ButtonCancel._doCancel(area, cgiLuaPOST)
if not instanceof(area, AbstractArea) then
return nil, nil
end
local getDataSet = {}
local tmpRet = clone(area.tDefaultRet)
local bRet,postDataSet = area:getPOSTData(cgiLuaPOST)
if not bRet then
g_logger:debug("ButtonCancel._doCancel: onPostData validate fail ~~~~~~~~~~")
return nil, nil
end
if type(postDataSet) ~= "table" then
return nil, nil
end
local paradataSet = area:getParaTable()
for dataObjectID, tbInsts in pairs(postDataSet) do
local dataTable = paradataSet[dataObjectID]
getDataSet[dataObjectID] = {}
for instID,_ in pairs(tbInsts) do
local instTable = clone(dataTable, true)
local instRet = area:getInstData(dataObjectID, instID, instTable)
if instRet.IF_ERRORID >= 0 then
table.insert(getDataSet[dataObjectID], instTable)
else
tmpRet = merge(tmpRet, instRet)
break
end
end
if tmpRet.IF_ERRORID < 0 then
break
end
end
return tmpRet, getDataSet
end
ButtonApply = class(Button)
function ButtonApply.__init__(self, id, title, style)
Button.__init__(self, title or lang.public_018, style)
self.id = "Btn_apply_"..id
self:_appendEventFunction("POST","Apply", self._doApply)
end
function ButtonApply.render(self, env)
Button.render(self, env)
self:addAttributeByID(self.id, "class", "Btn_apply")
return self.html
end
function ButtonApply._doApply(area, cgiLuaPOST)
local dataObjectID = nil
local tbInsts = nil
local dataTable = nil
if not instanceof(area, AbstractArea) then
return nil, nil
end
local getDataSet = {}
local tmpRet = clone(area.tDefaultRet)
local bRet,postDataSet = area:getPOSTData(cgiLuaPOST)
if not bRet then
g_logger:debug("ButtonApply._doApply: onPostData validate fail ~~~~~~~~~~")
return nil, nil
end
if type(postDataSet) ~= "table" then
return nil, nil
end
for dataObjectID, tbInsts in pairs(postDataSet) do
for instID, dataTable in pairs(tbInsts) do
local paramCount = dataTable["__PARAM_COUNT"]
dataTable["__PARAM_COUNT"] = nil
if paramCount > 0 then
if instID == "-1" then
instID = ""
end
if area.areaActionTbl and area.areaActionTbl.forbidModInst and instID ~= "" then
return nil, nil
end
if area.areaActionTbl and area.areaActionTbl.forbidAddInst and instID == "" then
return nil, nil
end
local linRet = cmapi.setinst(dataObjectID, instID, dataTable)
if linRet.IF_ERRORPARAM ~= nil and linRet.IF_ERRORPARAM ~= "SUCC" then
linRet.IF_ERRORPARAM = dataObjectID .. "." .. linRet.IF_ERRORPARAM
end
tmpRet = merge(tmpRet, linRet)
tmpRet[dataObjectID.."._OBJ_InstID"] = tmpRet.INSTIDENTITY or ""
if tmpRet.IF_ERRORID < 0 then
break
end
if area.getInstAfterSet then
local paradataSet = area:getParaTable()
if type(paradataSet) ~= "table" then
return nil, {}
end
local getDataTmpSet = clone(paradataSet, true)
local instTable = getDataTmpSet[dataObjectID]
local instRet = area:getInstData(dataObjectID, tmpRet.INSTIDENTITY, instTable)
if instRet.IF_ERRORID >= 0 then
getDataSet[dataObjectID] = {}
table.insert(getDataSet[dataObjectID], instTable)
else
g_logger:warn(" instRet.IF_ERRORID " .. tostring(instRet.IF_ERRORID))
tmpRet = merge(tmpRet, instRet)
end
end
end
end
if tmpRet.IF_ERRORID < 0 then
break
end
end
return tmpRet, getDataSet
end
ButtonDelete = class(Button)
function ButtonDelete.__init__(self, id, title, style)
Button.__init__(self, title or "Delete", style)
self.id = "Btn_delete_"..id
self:_appendEventFunction("POST","Delete", self._doDelete)
end
function ButtonDelete.render(self, env)
Button.render(self, env)
self:addAttributeByID(self.id, "class", "Btn_delete")
return self.html
end
function ButtonDelete._doDelete(area, cgiLuaPOST)
if not instanceof(area, AbstractArea) then
return nil, nil
end
local tmpRet = clone(area.tDefaultRet)
local bRet, postDataSet = area:getPOSTData(cgiLuaPOST)
if not bRet then
g_logger:debug("ButtonDelete._doDelete: onPostData validate fail ~~~~~~~~~~")
return nil, nil
end
if type(postDataSet) ~= "table" then
g_logger:info("postDataSet is not table");
return nil, nil
end
for dataObjectID, tbInsts in pairs(postDataSet) do
for instID, dataTable in pairs(tbInsts) do
tmpRet = merge(tmpRet, cmapi.delinst(dataObjectID, instID))
tmpRet[dataObjectID.."._OBJ_InstID"] = tmpRet.INSTIDENTITY or ""
if tmpRet.IF_ERRORID < 0 then
break
end
end
if tmpRet.IF_ERRORID < 0 then
break
end
end
return tmpRet, {}
end
ButtonRefresh = class(Button)
function ButtonRefresh.__init__(self, id, title, style)
Button.__init__(self, title or lang.public_003, style)
self.id = "Btn_refresh_"..id
end
function ButtonRefresh.render(self, env)
Button.render(self, env)
self:addAttributeByID(self.id, "class", "Btn_refresh")
return self.html
end
ButtonRestart = class(Button)
function ButtonRestart.__init__(self, id, title, style)
Button.__init__(self, title or lang.DeviceManag_006, style)
self.id = "Btn_restart_"..id
self.template = "ButtonRestart"
self.NeedScript = true
self:_appendEventFunction("POST", "Restart", self._doRestart)
end
function ButtonRestart._doRestart(area, cgiLuaPOST)
if not instanceof(area, AbstractArea) then
return nil, nil
end
local tmpRet = clone(area.tDefaultRet)
local tError = cmapi.dev_action({CmdId = "cmd_devrestart"})
tmpRet = merge(tmpRet, tError)
return tmpRet, {}
end
ButtonReset = class(Button)
function ButtonReset.__init__(self, id, title, style)
Button.__init__(self, title or lang.DeviceManag_009, style)
self.id = "Btn_reset_"..id
self.template = "ButtonReset"
self.NeedScript = true
self:_appendEventFunction("POST", "Reset", self._doReset)
end
function ButtonReset._doReset(area, cgiLuaPOST)
if not instanceof(area, AbstractArea) then
return nil, nil
end
local tmpRet = clone(area.tDefaultRet)
local tError = cmapi.dev_action({CmdId = "cmd_devrestore"})
tmpRet = merge(tmpRet, tError)
return tmpRet, {}
end
DataTable = class(AbstractElement)
DataTable.template = "DataTable"
function DataTable.__init__(self, dataID, dataTable)
AbstractElement.__init__(self, "")
self.dataID = dataID
self.dataTable = dataTable
end
DataSet = class(AbstractElement)
DataSet.template = "DataSet"
function DataSet.__init__(self, dataSet)
AbstractElement.__init__(self, "")
self.dataSet = dataSet
for dataID, dataTable in pairs(dataSet) do
self:append(DataTable(dataID, dataTable))
end
end
AbstractComponent = class(AbstractElement)
function AbstractComponent.__init__(self, id, dataID, dataField, title, style)
local cache = {"", "", ""}
AbstractElement.__init__(self, title, style)
if dataID ~= nil and dataField ~= nil then
table.insert(cache, dataID or "")
table.insert(cache, ".")
table.insert(cache, dataField or "")
table.insert(cache, ":")
table.insert(cache, id)
self.id = table.concat(cache)
else
self.id = id
end
self.dataID = dataID
self.dataField = dataField
self.dataRule = nil
self.relationRuleSet = {}
end
function AbstractComponent.onGetData(self, dataValue)
return true, dataValue
end
function AbstractComponent.onPostData(self, dataValue)
g_logger:debug("enter onPostData")
local pvResult = true
if self.dataRule then
pvResult = self.dataRule:postValidate(dataValue)
end
return pvResult, dataValue
end
function AbstractComponent.getDataObject(self)
if self.dataField ~= nil then
return Data(self.id, self.dataID, self.dataField, self.dataRule, self.onGetData, self.onPostData)
else
return nil
end
end
function AbstractComponent.bindDataRule(self, dataRule)
if instanceof(dataRule, DataRule) then
self.dataRule = clone(dataRule, true)
return true
else
g_logger:warn( "not instanceof DataRule")
return false
end
end
function AbstractComponent.bindRelationRule(self, relationRule)
if instanceof(relationRule, RelationRule) then
relationRule.__Component = self
table.insert(self.relationRuleSet, relationRule)
return true
else
g_logger:warn( "not instanceof RelationRule")
return false
end
end
function AbstractComponent.unbindRelationRule(self)
self.relationRuleSet = {}
end
function AbstractComponent.render(self, env)
AbstractElement.render(self, env)
if self.relationRuleSet and #self.relationRuleSet >= 1 then
for _, rule in ipairs(self.relationRuleSet) do
rule:renderRuleScript(env)
end
end
return self.html
end
function AbstractComponent.getTip(self)
if self.dataRule ~= nil then
return self.dataRule:getTip()
else
return ""
end
end
AbstractContainer = class(AbstractElement)
function AbstractContainer.__init__(self, id, title, style)
AbstractElement.__init__(self, title, style)
self.id = id
self.wrapperIsRow = false
end
function AbstractContainer.delegateChildOnEventScript(self)
for _, obj in ipairs(self.children) do
if type(obj.tbOnEventScript) == "table" then
self.tbOnEventScript = self.tbOnEventScript or {}
for event, onEventScriptTbl in pairs(obj.tbOnEventScript) do
self.tbOnEventScript[event] = self.tbOnEventScript[event] or {}
util.mergeByVal(self.tbOnEventScript[event], onEventScriptTbl)
end
end
if type(obj.tbDocumtReadyScript) == "table" then
self.tbDocumtReadyScript = self.tbDocumtReadyScript or {}
util.mergeByVal(self.tbDocumtReadyScript, obj.tbDocumtReadyScript)
end
end
end
function AbstractContainer._render_children(self, node, output, template, env)
if not node:checkRight() then
return output
end
local parentClass = AbstractContainer.__parent
output = parentClass._render_children(self, node, output, template, env)
return output
end
function AbstractContainer.render(self, env)
AbstractContainer.__parent.render(self, env)
self:delegateChildOnEventScript()
return self.html
end
Label = class(AbstractElement)
function Label.__init__(self, forId, title)
AbstractElement.__init__(self, title)
self.id = forId
self.template = "Label"
end
function Label.allocatWidth(self)
local titleLen = string.len(self.title)
if titleLen > 16 then
self.style = ComponentStyle.Long
end
end
function Label.render(self, env)
AbstractElement.render(self, env)
if self.style == ComponentStyle.Long then
self:addAttribute("label", "style", "width:250px")
elseif self.style == ComponentStyle.Short then
self:addAttribute("label","style", "width:100px")
end
return self.html
end
ServerHideComponent = class(AbstractComponent)
function ServerHideComponent.__init__(self, id, dataID, dataField)
AbstractComponent.__init__(self, id, dataID, dataField, nil)
self.NeedRender = false
self.NeedWrapper = false
self.template = "ServerHide"
end
BrowersHideComponent = class(AbstractComponent)
function BrowersHideComponent.__init__(self, id, dataID, dataField)
AbstractComponent.__init__(self, id, dataID, dataField, nil)
self.NeedWrapper = false
self.template = "BrowersHide"
end
RangeBox = class(AbstractContainer)
function RangeBox.__init__(self, startComp, rangeType, endComp, inOneRow, maxRange)
AbstractContainer.__init__(self, "RangeBox:"..startComp.id.."_"..endComp.id)
self.template = "RangeBox"
self:append(startComp)
self:append(endComp)
self.startComp = startComp
self.endComp = endComp
self.rangeType = rangeType
self.inOneRow = inOneRow
if self.inOneRow then
self.parLabel = self.startComp.parLabel or Label(self.startComp.id, self.startComp.title)
self.startComp.parLabel = nil
self.endComp.parLabel = nil
end
if self.startComp.dataRule and self.endComp.dataRule then
if self.startComp.dataRule.supportCompare == true and self.endComp.dataRule.supportCompare == true then
self:bindDataRule(DataRuleRangeBox(startComp, rangeType, endComp, inOneRow, maxRange))
else
g_logger:warn("RangeBox bind DataRule failed! startComp or endComp dataRule does not contain attribute supportCompare!")
end
else
g_logger:warn("RangeBox bind DataRule failed! startComp or endComp does not bindDataRule!")
end
end
function RangeBox.bindDataRule(self, dataRule)
return AbstractComponent.bindDataRule(self, dataRule)
end
function RangeBox.getTip(self)
return AbstractComponent.getTip(self)
end
function RangeBox.render(self, env)
local cache = {"", "", ""}
if (self.inOneRow) then
table.insert(cache, [[<div class="row">]])
table.insert(cache, ParElement.render(self, AbstractContainer, env))
table.insert(cache, [[</div>]])
return table.concat(cache)
else
return AbstractContainer.render(self, env)
end
end
TextBox = class(AbstractComponent)
function TextBox.__init__(self, id, dataID, dataField, title, prompt, style, ...)
AbstractComponent.__init__(self, id, dataID, dataField, title, style, ...)
self.prompt = prompt or ""
self.style = style or ComponentStyle.Norm
self.template = "TextBox"
end
function TextBox._renderReadOnly(self, setReadOnlyArg)
local absReadOnly = setReadOnlyArg[1] or false
if type(absReadOnly) ~= "boolean" then
absReadOnly = false
end
if not absReadOnly then
self:setAttributeByID(self.id, "_readonlycanberm", "")
end
self:setAttributeByID(self.id, "disabled", "disabled")
self:addAttributeByID(self.id, "class", "readonlyInputBg")
end
function TextBox.render(self, env)
AbstractComponent.render(self, env)
if (self.style ~= ComponentStyle.Norm) then
local width = "inputNorm"
if (self.style == ComponentStyle.Short) then
width = "inputShort"
elseif (self.style == ComponentStyle.Long) then
width = "inputLong"
end
self:replaceAttributeValByID(self.id, "class", "inputNorm", width)
end
return self.html
end
ParTextBox = class(TextBox)
function ParTextBox.__init__(self, id, dataID, dataField, title, prompt, style, ...)
TextBox.__init__(self, id, dataID, dataField, title, prompt, style, ...)
self.parLabel = Label(self.id, self.title)
end
function ParTextBox.render(self, env)
return ParElement.render(self, TextBox, env)
end
PasswordText = class(TextBox)
function PasswordText.__init__(self, id, dataID, dataField, title, prompt, style)
TextBox.__init__(self, id, dataID, dataField, title, prompt, style)
self.template = "PasswordText"
end
function PasswordText.onPostData(self, dataValue)
local strpass = string.format("%c%c%c%c%c%c", 9,9,9,9,9,9)
if strpass == dataValue then
dataValue = nil
end
return true, dataValue
end
function PasswordText.onGetData(self, dataValue)
dataValue = nil
return true, dataValue
end
ParPasswordText = class(PasswordText)
function ParPasswordText.__init__(self, id, dataID, dataField, title, prompt, style)
PasswordText.__init__(self, id, dataID, dataField, title, prompt, style)
self.parLabel = Label(self.id, self.title)
end
function ParPasswordText.render(self, env)
return ParElement.render(self, TextBox, env)
end
SegmentRow = class(AbstractElement)
function SegmentRow.__init__(self, title, all)
AbstractElement.__init__(self, title)
self.NeedWrapper = false
self.template = "Segment"
self.title = title or ""
if all then
self.blankRow = true
self.titleRow = true
else
if title ~= "" then
self.titleRow = true
else
self.blankRow = true
end
end
end
StaticInfoHintItem = class(AbstractElement)
function StaticInfoHintItem.__init__(self, title)
AbstractElement.__init__(self, title)
self.template = "staticInfoHintItem"
end
StaticInfoHint = class(AbstractElement)
function StaticInfoHint.__init__(self, content)
AbstractElement.__init__(self, nil)
self.template = "staticInfoHint"
if type(content) == "table" then
for _, value in pairs(content) do
self:append(StaticInfoHintItem(value))
end
elseif type(content) == "string" then
self:append(StaticInfoHintItem(content))
end
end
BatchSelectButton = class(AbstractElement)
function BatchSelectButton.__init__(self, id, textTable)
AbstractElement.__init__(self)
self.id = id
self.ontitle = lang.public_042
self.offtitle = lang.public_043
if textTable then
self.ontitle = textTable[1] or self.ontitle
self.offtitle = textTable[2] or self.offtitle
end
self.template = "BatchSelectButton"
end
RadioItem = class(AbstractElement)
function RadioItem.__init__(self, id, dataID, dataField, value, title)
AbstractElement.__init__(self, title)
self.id = dataID .. "." .. dataField..value..":"..id
self.name = dataID .. "." ..dataField..":"..id
self.template = "RadioItem"
self.value = value
self.checked = false
end
function RadioItem.render(self, env)
AbstractElement.render(self, env)
if self.checked == true then
self:setAttributeByID(self.id, "checked","checked")
end
return self.html
end
function RadioItem._renderReadOnly(self, setReadOnlyArg)
local absReadOnly = setReadOnlyArg[1] or false
if type(absReadOnly) ~= "boolean" then
absReadOnly = false
end
if not absReadOnly then
self:setAttributeByID(self.id, "_readonlycanberm", "")
end
self:setAttributeByID(self.id, "disabled", "disabled")
end
Radio = class(AbstractComponent)
function Radio.__init__(self, id, dataID, dataField, title, tbValueText, defaultValue, style)
AbstractComponent.__init__(self, id, dataID, dataField, title, style)
self.template = "Radio"
self.value = defaultValue or ""
self.tbValueText = tbValueText or {}
for _, item in pairs(self.tbValueText) do
local value = item.value
local text = item.text
local itemRadio = RadioItem(id, dataID, dataField, value, text)
if self.value == value then
itemRadio.checked = true
end
self:append(itemRadio)
end
end
function Radio._setItemReadOnly(self, radioItem, output, readOnly, absReadOnly)
if instanceof(radioItem, RadioItem) then
radioItem:setReadOnly(readOnly, absReadOnly)
end
return output
end
function Radio.setReadOnly(self, readOnly, absReadOnly)
self:search_children(self._setItemReadOnly, nil, readOnly, absReadOnly)
end
ParRadio = class(Radio)
function ParRadio.__init__(self, id, dataID, dataField, title, tbValueText, defaultValue)
Radio.__init__(self, id, dataID, dataField, title, tbValueText, defaultValue)
self.parLabel = Label(self.id,self.title)
end
function ParRadio.render(self, env)
return ParElement.render(self, Radio, env)
end
VerticalRadioItem = class(AbstractElement)
function VerticalRadioItem.__init__(self, id, dataID, dataField, value, text, title)
AbstractElement.__init__(self, title)
self.id = dataID .. "." .. dataField..value..":"..id
self.name = dataID .. "." ..dataField..":"..id
self.template = "VerticalRadioItem"
self.value = value
self.text = text
self.title = title
self.checked = false
end
function VerticalRadioItem.render(self, env)
AbstractElement.render(self, env)
if self.checked == true then
self:setAttributeByID(self.id, "checked","checked")
end
if self.style == ComponentStyle.Long then
self:addAttribute("label", "style", "width:250px")
elseif self.style == ComponentStyle.Short then
self:addAttribute("label","style", "width:100px")
end
return self.html
end
function VerticalRadioItem._setLabelStyle(parent, self, output, setarea)
self.style = setarea._parLabelStyle or ComponentStyle.Norm
end
function VerticalRadioItem._renderReadOnly(self, setReadOnlyArg)
local absReadOnly = setReadOnlyArg[1] or false
if type(absReadOnly) ~= "boolean" then
absReadOnly = false
end
if not absReadOnly then
self:setAttributeByID(self.id, "_readonlycanberm", "")
end
self:setAttributeByID(self.id, "disabled", "disabled")
end
VerticalRadio = class(AbstractComponent)
function VerticalRadio.__init__(self, id, dataID, dataField, title, tbValueText, defaultValue, style)
AbstractComponent.__init__(self, id, dataID, dataField, title, style)
self.template = "VerticalRadio"
self.value = defaultValue or ""
self.tbValueText = tbValueText or {}
for i, item in pairs(self.tbValueText) do
local value = item.value
local text = item.text
local title = title
if i ~= 1 then title = "&nbsp;" end
local itemRadio = VerticalRadioItem(id, dataID, dataField, value, text, title)
if self.value == value then
itemRadio.checked = true
end
self:append(itemRadio)
end
end
function VerticalRadio._setItemReadOnly(self, radioItem, output, readOnly, absReadOnly)
if instanceof(radioItem, VerticalRadioItem) then
radioItem:setReadOnly(readOnly, absReadOnly)
end
return output
end
function VerticalRadio.setReadOnly(self, readOnly, absReadOnly)
self:search_children(self._setItemReadOnly, nil, readOnly, absReadOnly)
end
ParVerticalRadio = class(VerticalRadio)
function ParVerticalRadio.__init__(self, id, dataID, dataField, title, tbValueText, defaultValue)
VerticalRadio.__init__(self, id, dataID, dataField, title, tbValueText, defaultValue)
self.NeedWrapper = false
end
function ParVerticalRadio.render(self, env)
return ParElement.render(self, VerticalRadio, env)
end
Checkbox = class(AbstractComponent)
function Checkbox.__init__(self, id, dataID, dataField, title, text, value, wrapWidth, style)
AbstractComponent.__init__(self, id, dataID, dataField, title, style)
self.template = "Checkbox"
self.value = value or ""
self.text = text
self.wrapWidth = wrapWidth or ""
end
RowBox = class(AbstractContainer)
function RowBox.__init__(self, ...)
local childSet = {...}
if #childSet < 1 then
childSet[1] = EmptyElement()
end
AbstractContainer.__init__(self, "RowBox:".. (childSet[1].id or math.random(100)))
self.NeedWrapper = false
self.template = "RowBox"
for i,obj in pairs(childSet) do
self:append(obj)
if i == 1 and instanceof(obj, Label) then
self.parLabel = obj
end
end
end
TemplateBox = class(AbstractContainer)
function TemplateBox.__init__(self, objID)
AbstractContainer.__init__(self, objID)
self.template = "TemplateBox"
self.wrapperIsRow = false
end
function TemplateBox.pre_render_children(self, childElement)
if not childElement.NeedWrapper then
return ""
elseif not instanceof(childElement, AbstractContainer)
or childElement.wrapperIsRow then
return [[<div class="row ControlWrapper">]]
else
return [[<div class="ControlWrapper">]]
end
end
function TemplateBox.post_render_children(self, childElement)
if not childElement.NeedWrapper then
return ""
else
return [[</div>]]
end
end
SelectOption = class(AbstractElement)
function SelectOption.__init__(self, id, value, title, attrTbl)
AbstractElement.__init__(self, title)
self.id = id
self.template = "SelectOption"
self.value = value
self.attrTbl = attrTbl or {}
self.checked = false
end
function SelectOption.render(self, env)
AbstractElement.render(self, env)
if self.checked == true then
self:setAttributeByID(self.id, "selected", "selected")
end
return self.html
end
Select = class(AbstractComponent)
function Select.__init__(self, id, dataID, dataField, title, tbValueText, defaultValue, style)
AbstractComponent.__init__(self, id, dataID, dataField , title, style)
self.template = "Select"
self.value = defaultValue or ""
self.tbValueText = tbValueText
if type(tbValueText) == "table" then
for i, tb in pairs(tbValueText) do
local oid = table.concat({tb.value or "", "_", self.id})
local selectOption = SelectOption(oid, tb.value or "", tb.text or "", tb.attrTbl)
if self.value == tb.value then
selectOption.checked = true
end
self:append(selectOption)
end
end
end
function Select._renderReadOnly(self, setReadOnlyArg)
local absReadOnly = setReadOnlyArg[1] or false
if type(absReadOnly) ~= "boolean" then
absReadOnly = false
end
if not absReadOnly then
self:setAttributeByID(self.id, "_readonlycanberm", "")
end
self:setAttributeByID(self.id, "disabled", "disabled")
self:addAttributeByID(self.id, "class", "readonlyInputBg")
end
function Select.render(self, env)
AbstractComponent.render(self, env)
if (self.style ~= ComponentStyle.Norm) then
local width = "selectNorm"
if (self.style == ComponentStyle.Short) then
width = "selectShort"
elseif (self.style == ComponentStyle.Long) then
width = "selectLong"
end
self:replaceAttributeValByID(self.id, "class", "selectNorm", width)
end
return self.html
end
ParSelect = class(Select)
function ParSelect.__init__(self, id, dataID, dataField, title, tbValueText, defaultValue, style)
Select.__init__(self, id, dataID, dataField, title, tbValueText, defaultValue, style)
self.parLabel = Label(self.id,self.title)
end
function ParSelect.render(self, env)
local ret = ParElement.render(self, Select, env)
return ret
end
Textarea = class(AbstractComponent)
function Textarea.__init__(self, id, dataID, dataField, title)
AbstractComponent.__init__(self, id, dataID, dataField, title)
self.template = "Textarea"
end
function Textarea._renderReadOnly(self, setReadOnlyArg)
local absReadOnly = setReadOnlyArg[1] or false
if type(absReadOnly) ~= "boolean" then
absReadOnly = false
end
if not absReadOnly then
self:setAttributeByID(self.id, "_readonlycanberm", "")
end
self:setAttributeByID(self.id, "readonly", "readonly")
end
ParTextarea = class(Textarea)
function ParTextarea.__init__(self, id, dataID, dataField, title)
Textarea.__init__(self, id, dataID, dataField,title)
self.parLabel = Label(self.id, self.title)
end
function ParTextarea.render(self, env)
return ParElement.render(self, Textarea, env)
end
TimeHour = class(AbstractComponent)
function TimeHour.__init__(self, id, dataID, dataField)
AbstractComponent.__init__(self, id, dataID, dataField)
self.template = "TimeHour"
end
function TimeHour._renderReadOnly(self, setReadOnlyArg)
local absReadOnly = setReadOnlyArg[1] or false
if type(absReadOnly) ~= "boolean" then
absReadOnly = false
end
if not absReadOnly then
self:setAttributeByID(self.id, "_readonlycanberm", "")
end
self:setAttributeByID(self.id, "disabled", "disabled")
self:addAttributeByID(self.id, "class", "readonlyInputBg")
end
TimeMinute = class(AbstractComponent)
function TimeMinute.__init__(self, id, dataID, dataField)
AbstractComponent.__init__(self, id, dataID, dataField)
self.template = "TimeMinute"
end
function TimeMinute._renderReadOnly(self, setReadOnlyArg)
local absReadOnly = setReadOnlyArg[1] or false
if type(absReadOnly) ~= "boolean" then
absReadOnly = false
end
if not absReadOnly then
self:setAttributeByID(self.id, "_readonlycanberm", "")
end
self:setAttributeByID(self.id, "disabled", "disabled")
self:addAttributeByID(self.id, "class", "readonlyInputBg")
end
TimeSecond = class(AbstractComponent)
function TimeSecond.__init__(self, id, dataID, dataField)
AbstractComponent.__init__(self, id, dataID, dataField)
self.template = "TimeSecond"
end
function TimeSecond._renderReadOnly(self, setReadOnlyArg)
local absReadOnly = setReadOnlyArg[1] or false
if type(absReadOnly) ~= "boolean" then
absReadOnly = false
end
if not absReadOnly then
self:setAttributeByID(self.id, "_readonlycanberm", "")
end
self:setAttributeByID(self.id, "disabled", "disabled")
self:addAttributeByID(self.id, "class", "readonlyInputBg")
end
Time = class(AbstractContainer)
function Time.__init__(self, id, dataID, dataField, title, tbCtrolID)
local comid = "Time:"..dataID.."."..(tbCtrolID.hourID or "").."."
..(tbCtrolID.minuteID or "").."."
..(tbCtrolID.secondID or "")..":"..id
AbstractContainer.__init__(self, comid, title)
self.template = "Time"
self.wrapperIsRow = true
self.tbCtrolID = tbCtrolID
if tbCtrolID["hourID"] then
local timehour = TimeHour(id, dataID, tbCtrolID["hourID"])
self:append(timehour)
end
if tbCtrolID["minuteID"] then
local timeminute = TimeMinute(id, dataID, tbCtrolID["minuteID"])
self:append(timeminute)
end
if tbCtrolID["secondID"] then
local timesecond = TimeSecond(id, dataID, tbCtrolID["secondID"])
self:append(timesecond)
end
end
function Time._setItemReadOnly(self, timeItem, output, readOnly, absReadOnly)
if timeItem ~= nil then
timeItem:setReadOnly(readOnly, absReadOnly)
end
end
function Time.setReadOnly(self, readOnly, absReadOnly)
self:search_children(self._setItemReadOnly, nil, readOnly, absReadOnly)
end
ParTime = class(Time)
function ParTime.__init__(self, id, dataID, tbCtrolID, title)
Time.__init__(self, id, dataID, nil, title, tbCtrolID)
self.parLabel = Label(self.id, self.title)
end
function ParTime.render(self, env)
return ParElement.render(self, Time, env)
end
TimeScalar = class(AbstractComponent)
function TimeScalar.__init__(self, id, dataID, dataField, title, option)
AbstractComponent.__init__(self, id, dataID, dataField, title)
self.id = "TimeScalar:" .. self.id
self.template = "TimeScalar"
self.NeedScript = true
self.NeedScriptClass = true
self.option = option
self.browseHideValue = BrowersHideComponent(id, dataID, dataField)
end
ParTimeScalar = class(TimeScalar)
function ParTimeScalar.__init__(self, id, dataID, dataField, title, option)
TimeScalar.__init__(self, id, dataID, dataField, title, option)
self.parLabel = Label(self.id, self.title)
end
function ParTimeScalar.render(self, env)
return ParElement.render(self, TimeScalar, env)
end
Week = class(AbstractComponent)
function Week.__init__(self, id, dataID, dataField, title)
AbstractComponent.__init__(self, id, dataID, dataField, title)
self.template = "Week"
self.NeedScript = true
self.browseHideValue = BrowersHideComponent(id, dataID, dataField)
end
ParWeek = class(Week)
function ParWeek.__init__(self, id, dataID, dataField, title)
Week.__init__(self, id, dataID, dataField, title)
self.parLabel = Label(self.id, self.title)
end
function ParWeek.render(self, env)
return ParElement.render(self, Week, env) .. [[<div class="clear"></div>]]
end
IPv4 = class(AbstractComponent)
function IPv4.__init__(self, id, dataID, dataField, title, defaultValue, needTip)
AbstractComponent.__init__(self, id, dataID, dataField, title)
self.template = "IPv4"
self.childrenID = "sub_"..self.id
self.NeedScript = false
self.needTip = needTip or false
if defaultValue then
if defaultValue == "" then
defaultValue = "..."
end
else
defaultValue = "0.0.0.0"
end
self.defaultValue = defaultValue
self._defaultIPSegs = util.split(self.defaultValue, ".")
self.browseHideValue = BrowersHideComponent(id, dataID, dataField)
self.browseHideValue.render =
function(self, env)
BrowersHideComponent.render(self, env)
self:addAttributeByID(self.id, "_LuQUID_splitIPID", "sub_"..self.id)
return self.html
end
end
function IPv4._renderReadOnly(self, setReadOnlyArg)
local absReadOnly = setReadOnlyArg[1] or false
local idxTbl = setReadOnlyArg[2] or nil
if type(absReadOnly) ~= "boolean" then
absReadOnly = false
end
if type(idxTbl) ~= "table" then
idxTbl = {0,1,2,3}
end
for k,v in pairs (idxTbl) do
if not absReadOnly then
self:setAttributeByID(self.childrenID..v, "_readonlycanberm", "")
end
self:setAttributeByID(self.childrenID..v, "disabled", "disabled")
self:addAttributeByID(self.childrenID..v, "class", "readonlyInputBg")
end
end
function IPv4.onPostData(self, dataValue)
if self.dataRule ~= nil and self.dataRule.isRequired == false then
if dataValue == "..." then
return true, "0.0.0.0"
else
return true, dataValue
end
else
return true, dataValue
end
end
function IPv4.onGetData(self, dataValue)
if self.dataRule ~= nil and self.dataRule.isRequired == false then
if dataValue == "0.0.0.0" then
return true, "..."
else
return true, dataValue
end
else
return true, dataValue
end
end
ParIPv4 = class(IPv4)
function ParIPv4.__init__(self, id, dataID, dataField, title, defaultValue, needTip)
IPv4.__init__(self, id, dataID, dataField, title, defaultValue, needTip)
self.parLabel = Label("sub_"..self.id.."0", self.title)
end
function ParIPv4.render(self, env)
return ParElement.render(self, IPv4, env)
end
Mac = class(AbstractComponent)
function Mac.__init__(self, id, dataID, dataField, title, otherInfo, defaultValue)
AbstractComponent.__init__(self, id, dataID, dataField, title)
self.template = "MAC"
self.childrenID = "sub_"..self.id
self.NeedScript = false
if otherInfo == nil or type(otherInfo) ~= "table" then
otherInfo = {
showOtherMac = false,
AccessMode = ""
}
end
self.otherInfo = otherInfo
self.dftValTbl = {"","","","","","",""}
if defaultValue then
local t = {}
t[1], t[2], t[3], t[4], t[5], t[6] = defaultValue:match("^(%x%x):(%x%x):(%x%x):(%x%x):(%x%x):(%x%x)$")
if t[1] then
self.dftValTbl = t
end
end
self.browseHideValue = BrowersHideComponent(id, dataID, dataField)
self.browseHideValue.render =
function(self, env)
BrowersHideComponent.render(self, env)
self:addAttributeByID(self.id, "_LuQUID_splitMACID", "sub_"..self.id)
return self.html
end
end
function Mac._renderReadOnly(self, setReadOnlyArg)
local absReadOnly = setReadOnlyArg[1] or false
local idxTbl = setReadOnlyArg[2] or nil
if type(absReadOnly) ~= "boolean" then
absReadOnly = false
end
if type(idxTbl) ~= "table" then
idxTbl = {0,1,2,3,4,5}
end
for k,v in pairs (idxTbl) do
if not absReadOnly then
self:setAttributeByID(self.childrenID..v, "_readonlycanberm", "")
end
self:setAttributeByID(self.childrenID..v, "disabled", "disabled")
self:addAttributeByID(self.childrenID..v, "class", "readonlyInputBg")
end
end
function Mac.onPostData(self, dataValue)
if self.dataRule ~= nil and self.dataRule.isRequired == false then
if dataValue == ":::::" then
return true, ""
else
return true, dataValue
end
else
return true, dataValue
end
end
function Mac.onGetData(self, dataValue)
if self.dataRule ~= nil and self.dataRule.isRequired == false then
if dataValue == "" then
return true, ":::::"
else
return true, dataValue
end
else
return true, dataValue
end
end
ParMac = class(Mac)
function ParMac.__init__(self, id, dataID, dataField, title, otherInfo, defaultValue)
Mac.__init__(self, id, dataID, dataField, title, otherInfo, defaultValue)
self.parLabel = Label("sub_"..self.id.."0", self.title)
end
function ParMac.render(self, env)
return ParElement.render(self, Mac, env)
end
IPv6 = class(TextBox)
function IPv6.__init__(self, id, dataID, dataField, title)
TextBox.__init__(self, id, dataID, dataField, title)
self.template = "IPv6"
end
IPv6Prefix = class(TextBox)
function IPv6Prefix.__init__(self, id, dataID, dataField, title, defaultValue)
TextBox.__init__(self, id, dataID, dataField, title)
self.template = "IPv6Prefix"
self.defaultValue = defaultValue or ""
end
ParIPv6 = class(IPv6)
function ParIPv6.__init__(self, id, dataID, dataField, title, prefix)
IPv6.__init__(self, id, dataID, dataField, title)
if prefix and instanceof(prefix, IPv6Prefix) then
self.prefix = prefix
self:append(self.prefix)
end
self.parLabel = Label(self.id, self.title)
end
function ParIPv6.getDataObject(self)
local outdata = AbstractComponent.getDataObject(self)
outdata.prefix = self.prefix
return outdata
end
function ParIPv6.render(self, env)
local cache = {"", "", ""}
table.insert(cache, self.parLabel:render(env))
table.insert(cache, "<div class=\"right\">")
table.insert(cache, IPv6.render(self, env))
table.insert(cache, "</div>")
self.html = table.concat(cache)
return self.html
end
ItemTitle = class(AbstractElement)
function ItemTitle.__init__(self, title, relatWidth)
AbstractElement.__init__(self, title, relatWidth)
self.template = "Span"
self.relatWidth = relatWidth
self.absolWidth = 0
end
function ItemTitle.render(self, env)
AbstractElement.render(self, env)
if self.absolWidth > 0 then
self:setAttribute("span", "style", "width:" .. tostring(self.absolWidth - self.absolWidth%1) .."px")
end
return self.html
end
ItemValue = class(AbstractComponent)
function ItemValue.__init__(self, id, dataID, dataField, relatWidth)
AbstractComponent.__init__(self, id, dataID, dataField, "")
self.template = "SpanComp"
self.relatWidth = relatWidth
self.absolWidth = 0
end
function ItemValue.render(self, env)
AbstractComponent.render(self, env)
if self.absolWidth >0 then
self:setAttribute("span", "style", "width:" .. tostring(self.absolWidth - self.absolWidth%1) .."px")
end
return self.html
end
TableItem = class(AbstractComponent)
function TableItem.__init__(self, id, dataID, dataField, title, relatWidth)
AbstractComponent.__init__(self, id, dataID, dataField, title)
self.template = "TableItem"
self.itemTitle = ItemTitle(title, relatWidth)
self.itemValue = ItemValue(id, dataID, dataField, relatWidth)
self:append(self.itemValue)
self.relatWidth = relatWidth
self.absolWidth = 0
end
function TableItem.setAbsolWidth(self, absolWidth)
self.absolWidth = absolWidth
if self.itemTitle.NeedRender then
self.itemTitle.absolWidth = absolWidth*0.4
self.itemValue.absolWidth = absolWidth*0.6
else
self.itemTitle.absolWidth = absolWidth
self.itemValue.absolWidth = absolWidth
end
end
TableRow = class(AbstractContainer)
function TableRow.__init__(self, rowWidth)
AbstractContainer.__init__(self, "")
self.template = "TableRow"
self.rowWidth = rowWidth
end
function TableRow.allocatWidth(self)
local freeRelateWidth = 100
local undefineItemNum = 0
for _, item in pairs(self.children) do
if type(item.relatWidth) == "number" then
freeRelateWidth = freeRelateWidth - item.relatWidth
else
undefineItemNum = undefineItemNum +1
end
end
self.rowWidth = self.rowWidth or 650
local undefineAbsolWidth = 0
if undefineItemNum > 0 then
local undefineRelatWidth = (freeRelateWidth / undefineItemNum)/100
undefineAbsolWidth = self.rowWidth*undefineRelatWidth
end
for _, item in pairs(self.children) do
local itemAbsolWidth = 0
if type(item.relatWidth) == "number" then
itemAbsolWidth = self.rowWidth*item.relatWidth/100
else
itemAbsolWidth = undefineAbsolWidth
end
item:setAbsolWidth(itemAbsolWidth)
end
end
TableTitle = class(AbstractComponent)
function TableTitle.__init__(self, id, dataID, dataField, title)
AbstractComponent.__init__(self, id, dataID, dataField, title)
self.template = "TableTitle"
end
function TableTitle.render(self, env)
AbstractComponent.render(self, env)
if stringIsEmpty(self.title) and type(self.children) == "table" and #self.children > 0 then
self:addAttributeByID(self.id, "style", "display:none")
end
return self.html
end
AbstractStatusTable = class(AbstractContainer)
function AbstractStatusTable.__init__(self, id, title, tableWidth)
AbstractContainer.__init__(self, id, title)
self.tableWidth = tableWidth
self.tableTitle = TableTitle(id.."_TableTitle", nil, nil, title)
if stringIsEmpty(title) then
self.tableTitle.NeedRender = false
end
end
function AbstractStatusTable.pre_render_children(self, node)
if not self.NeedWrapper then
return ""
end
if node.index ~= nil then
if node.index % 2 == 0 then
return "<div class=\"colorTblRow ControlWrapper colorRow\">"
else
return "<div class=\"colorTblRow ControlWrapper\">"
end
end
return "<div class=\"colorTblRow ControlWrapper\">"
end
function AbstractStatusTable.post_render_children(self, node)
if not self.NeedWrapper then
return ""
end
return "</div>"
end
function AbstractStatusTable.append(self, obj, ...)
obj.rowWidth = obj.rowWidth or self.tableWidth
return AbstractContainer.append(self, obj, ...)
end
VerticalTable = class(AbstractStatusTable)
function VerticalTable.__init__(self, id, title, tableWidth)
AbstractStatusTable.__init__(self, id, title, tableWidth)
self.template = "VerticalTable"
end
function VerticalTable.appendTitle(self, obj)
if instanceof(obj, TableTitle) then
self.tableTitle = obj
return true
else
return false
end
end
function VerticalTable.append(self, obj, ...)
if instanceof(obj, TableRow) then
obj:allocatWidth()
end
local ret = AbstractStatusTable.append(self, obj, ...)
obj.index = #self.children
return ret
end
HorizontalTable = class(AbstractStatusTable)
function HorizontalTable.__init__(self, id, title, tableWidth)
AbstractStatusTable.__init__(self, id, title,tableWidth)
self.template = "HorizontalTable"
self.NeedWrapper = false
if self.tableTitle ~= nil then
self.tableTitle.NeedRender = true
end
end
function HorizontalTable.append(self, obj, ...)
if instanceof(obj, TableRow) then
for k, tableItem in pairs(obj.children) do
tableItem.itemTitle.NeedRender = false
end
obj:allocatWidth()
for k, tableItem in pairs(obj.children) do
local itemTitle = clone(tableItem.itemTitle,true)
itemTitle.NeedRender = true
self.tableTitle:append(itemTitle)
end
return AbstractStatusTable.append(self, obj, ...)
else
return false
end
end
AbstractArea = class(AbstractContainer)
function AbstractArea.__init__(self, id, title, modelPath, maxInstNum)
AbstractContainer.__init__(self, id, title, nil)
self.modelPath = modelPath
if modelPath then
local util = require("data_assemble.util")
modelfile = util.strippath(modelPath)
self.dataAddress = "/?_type=menuData&_tag="..modelfile
end
self.dataModel = "DEV"
self.maxInstNum = maxInstNum or 0
self.tDefaultRet = {
IF_ERRORPARAM = "SUCC",
IF_ERRORTYPE = "SUCC",
IF_ERRORSTR = "SUCC",
IF_ERRORID = 0
}
self.tEventControlList = {}
self.dataFormat = XML()
self.modInstGetData = {}
self.modInstPostData = {}
end
function AbstractArea.getGETData(self, cgiluaGET)
local tmpRet = clone(self.tDefaultRet)
local paradataSet = self:getParaTable()
if type(paradataSet) ~= "table" then
return nil, {}
end
local getDataTmpSet = clone(paradataSet, true)
local getDataSet = {}
for dataObjectID, dataTable in pairs(getDataTmpSet) do
local instID = self.dataModel or "IGD"
local allInstRet, allInstTable = self:getObjAllInstData(dataObjectID, instID, dataTable)
getDataSet[dataObjectID] = allInstTable
merge(tmpRet,allInstRet)
end
return tmpRet, getDataSet
end
function AbstractArea.getObjAllInstData(self, dataObjectID, instID, instDataTable)
local getObjData= {}
local tmpRet = {}
local queryRet = cmapi.querylist(dataObjectID, instID)
if queryRet.IF_ERRORID < 0 or type(queryRet.Count) ~= "number" then
g_logger:warn("querylist error Ret" .. queryRet.IF_ERRORID .. " number " .. tostring(queryRet.Count or "nil") )
return queryRet, getObjData
end
if queryRet.Count ~= 888 then
for i=1, queryRet.Count do
local id = queryRet[i].InstName or queryRet[i]
local instTable = clone(instDataTable)
local instRet, filterThisInst = self:getInstData(dataObjectID, id, instTable)
if instRet.IF_ERRORID >= 0 then
if not filterThisInst then
table.insert(getObjData, instTable)
else
g_logger:debug("Instance's data is filtered out. Its id is: "..id)
end
else
g_logger:warn(" instRet.IF_ERRORID " .. tostring(instRet.IF_ERRORID))
tmpRet = merge(tmpRet, instRet)
end
end
else
local id = "IGD"
local instTable = clone(instDataTable)
local instRet = self:getInstData(dataObjectID, id, instTable)
if instRet.IF_ERRORID >= 0 then
table.insert(getObjData, instTable)
else
g_logger:warn(" instRet.IF_ERRORID " .. tostring(instRet.IF_ERRORID))
tmpRet = merge(tmpRet, instRet)
end
end
return tmpRet, getObjData
end
function AbstractArea.getInstData(self, dataObjectID, instID, instDataTable)
local retTable = clone(self.tDefaultRet)
local onGetDataCheck, modInstGetDataCheck, filterFlag = true, true, false
retTable = merge(retTable, cmapi.getinst(dataObjectID, instID))
if retTable.IF_ERRORID == 0 then
g_logger:debug("get " .. dataObjectID)
for para, pvalue in pairs(instDataTable) do
if pvalue.onGetData then
onGetDataCheck, instDataTable[para] = pvalue:onGetData(retTable[para] or "")
if not onGetDataCheck then
break
end
else
instDataTable[para] = retTable[para] or ""
end
end
if onGetDataCheck then
instDataTable["_OBJ_InstID"] = instID
g_logger:debug("type of self.modInstGetData is "..type(self.modInstGetData))
if type(self.modInstGetData) == "function" then
modInstGetDataCheck = self:modInstGetData(instDataTable)
elseif type(self.modInstGetData) == "table" and
type(self.modInstGetData[dataObjectID]) == "function" then
modInstGetDataCheck = self.modInstGetData[dataObjectID](self, instDataTable)
end
if modInstGetDataCheck == nil then
modInstGetDataCheck = true
end
end
if not onGetDataCheck or not modInstGetDataCheck then
filterFlag = true
end
end
return retTable, filterFlag
end
function AbstractArea._getDataField(self, node, output)
local dataID, dataField
for _,element in pairs(node.children) do
if element:checkRight() then
if instanceof(element, AbstractComponent) then
dataID = element.dataID
dataField = element.dataField
if dataID ~= nil then
if output[dataID] == nil then
output[dataID] = {}
end
end
if dataField ~= nil then
output[dataID][dataField] = element:getDataObject()
end
if type(element.children) == "table" then
output = self:_getDataField(element, output)
end
elseif instanceof(element, AbstractContainer) then
if type(element.children) == "table" then
output = self:_getDataField(element, output)
end
end
end
end
return output
end
function AbstractArea.getParaTable(self)
if nil == self._dataTable then
self._dataTable = self:_getDataField(self, {})
end
return self._dataTable
end
function AbstractArea.output(self, env)
self.env = env or self.env
if self.html == nil then
template.Template:SetUp()
self:render(env)
template.Template:TearDown()
end
env.__script = env.__script or self.script
self.script = env.__script
template.Template:output(self, self.html or "", env)
end
function AbstractArea.appendEventControl(self, eventControl)
self.tEventControlList = self.tEventControlList or {}
table.insert(self.tEventControlList, eventControl)
end
function AbstractArea.getEventFunction(self, eventType, eventName)
local eventFunctionList = {}
local eventFunction = nil
self.tEventControlList = self.tEventControlList or {}
for _, eventControl in pairs(self.tEventControlList) do
eventFunction = eventControl:getEventFunction(eventType, eventName)
if eventFunction ~= nil then
table.insert(eventFunctionList, eventFunction)
end
end
return eventFunctionList
end
function AbstractArea._searchChildDocumentReadScript(self, node, output, env)
local script = node:getDocumentReadyScript(env) or ""
table.insert(output, script)
table.insert(output, "\n")
return output
end
function AbstractArea.getChildDocumentReadScript(self, env)
local tmp = {}
self.env = env or self.env
tmp = self:search_children(self._searchChildDocumentReadScript, tmp, self.env)
return table.concat(tmp)
end
function AbstractArea._searchChildOnEventScript(self, node, output, env, event)
local eventScript = node:getOnEventScript(env,event)
if eventScript ~= nil then
local nodeEvent = {}
nodeEvent["evtID"] = node.id
if eventScript ~= "" then
nodeEvent["evtHandler"] = eventScript
table.insert(output, nodeEvent)
end
end
return output
end
function AbstractArea.getChildOnEventScript(self, env, event)
local tmpOnEventScript = {}
self.env = env or self.env
tmpOnEventScript = self:search_children(self._searchChildOnEventScript, tmpOnEventScript, self.env, event)
local evtJSArr = json.encode(tmpOnEventScript)
return "var eventArr ="..evtJSArr
end
AbstractSetArea = class(AbstractArea)
function AbstractSetArea.__init__(self, id, maxInstNum, title, modelPath)
AbstractArea.__init__(self, id, title, modelPath, maxInstNum)
self.id = id
end
function AbstractSetArea.render(self, env, ...)
self.dataSet = DataSet(self:getParaTable())
AbstractArea.render(self,env,...)
return self.html
end
function AbstractSetArea.pre_render_children(self)
return "<div>\n"
end
function AbstractSetArea.post_render_children(self)
return "</div>\n"
end
function AbstractSetArea.getGroupScript(self, env)
local paradataSet = self:getParaTable()
local groupScript = {}
for dataObjectID, dataTable in pairs(paradataSet) do
for dataField, dataPara in pairs(dataTable) do
if dataPara.dataRule and dataPara.dataRule.getGroupScript then
local groupScriptRet = dataPara.dataRule:getGroupScript(env, dataPara)
if groupScriptRet then
table.insert(groupScript, groupScriptRet)
table.insert(groupScript, ",")
end
end
end
end
table.remove(groupScript, #groupScript)
groupScript = table.concat(groupScript)
return groupScript
end
function AbstractSetArea.getDataRuleScript(self, env)
local paradataSet = self:getParaTable()
local dataRuleScript = {}
for dataObjectID, dataTable in pairs(paradataSet) do
for dataField, dataPara in pairs(dataTable) do
if dataPara.dataRule then
local oneRuleScript = dataPara.dataRule:getRuleScript(env, dataPara)
table.insert(dataRuleScript, oneRuleScript)
end
end
end
dataRuleScript = table.concat(dataRuleScript, ",\n")
return dataRuleScript
end
function AbstractSetArea.prepareRet(self, retTable)
if type(retTable) ~= "table" then
retTable = clone(self.tDefaultRet or {})
end
if retTable.IF_ERRORID ~= 0 then
if type(retTable.IF_ERRORSTR) == "string" and retTable.IF_ERRORSTR ~= "FAIL" then
retTable.IF_ERRORSTR = lang["cmret_"..retTable.IF_ERRORSTR] or lang.cmret_001
end
end
retTable.IF_ERRORTYPE = retTable.IF_ERRORTYPE or "SUCC"
retTable.IF_ERRORSTR = retTable.IF_ERRORSTR or "SUCC"
retTable.IF_ERRORPARAM = retTable.IF_ERRORPARAM or "SUCC"
return retTable
end
function AbstractSetArea.transPost2InstData(self, cgiLuaPOST, dataObjectID, dataTable, i)
local bRet = true
local fieldVal = nil
local instData = {}
local ifAction = cgiLuaPOST.IF_ACTION
if ifAction ~= "Apply" then
return true, instData
end
instData["__PARAM_COUNT"] = 0
for dataField, dataObj in pairs(dataTable) do
local suffix = ""
if i then
suffix = "_"..i
end
fieldVal = cgiLuaPOST[table.concat({dataObjectID, ".", dataField, suffix})]
if fieldVal then
instData["__PARAM_COUNT"] = instData["__PARAM_COUNT"] + 1
if dataObj.onPostData then
bRet, instData[dataField] = dataObj:onPostData(fieldVal)
if not bRet then
break
end
else
instData[dataField] = fieldVal
end
else
g_logger:debug(dataField .. ": nil")
end
end
g_logger:debug("type of self.modInstPostData is "..type(self.modInstPostData))
if type(self.modInstPostData) == "function" then
self:modInstPostData(instData)
elseif type(self.modInstPostData) == "table" and
type(self.modInstPostData[dataObjectID]) == "function" then
self.modInstPostData[dataObjectID](self, instData)
end
return bRet, instData
end
function AbstractSetArea.getPOSTData(self, cgiLuaPOST)
local postDataSet = {}
local bRet = false
local paradataSet = self:getParaTable()
if type(paradataSet) ~= "table" then
return false, postDataSet
end
for dataObjectID, dataTable in pairs(paradataSet) do
g_logger:debug("post OBJ_XXX_ID:" .. dataObjectID)
postDataSet[dataObjectID] = {}
local postOBJData = postDataSet[dataObjectID]
local instNum = cgiLuaPOST[dataObjectID.."._OBJ_InstNUM"]
if not instNum then
local instId = cgiLuaPOST[dataObjectID.."._OBJ_InstID"]
bRet, postOBJData[instId] = self:transPost2InstData(cgiLuaPOST, dataObjectID, dataTable)
else
instNum = tonumber(instNum)
for i=0,instNum-1 do
local instId = cgiLuaPOST[dataObjectID.."._OBJ_InstID_"..i]
bRet, postOBJData[instId] = self:transPost2InstData(cgiLuaPOST, dataObjectID, dataTable, i)
if not bRet then
break
end
end
end
if not bRet then
break
end
end
return bRet, postDataSet
end
function AbstractSetArea.doPOST(self, cgiLuaPOST)
local tbRet = {}
local tbData = {}
if type(cgiLuaPOST.IF_ACTION) ~= "string" then
return tbRet, tbData
end
local eventFunctionList = self:getEventFunction("POST", cgiLuaPOST.IF_ACTION)
if type(eventFunctionList) == "table" and #eventFunctionList> 0 then
for event, eventFunction in pairs(eventFunctionList) do
tbRetTmp, tbDataTmp = eventFunction(self, cgiLuaPOST)
util.merge(tbRet, tbRetTmp)
util.merge(tbData, tbDataTmp)
end
g_logger:debug("eventFunction return ")
return tbRet, tbData
end
return tbRet, tbData
end
AbstractEmptyArea = class(AbstractArea)
function AbstractEmptyArea.__init__(self, id, title, modelPath, maxInstNum)
AbstractArea.__init__(self, id, title, modelPath, maxInstNum)
self.id = id
self.template = "EmptyArea"
end
function AbstractEmptyArea.render(self, env, ...)
self.dataSet = DataSet(self:getParaTable())
AbstractArea.render(self,env,...)
return self.html
end
AbstractFileUploadArea = class(AbstractArea)
function AbstractFileUploadArea.__init__(self, id, btnName,labelName)
AbstractArea.__init__(self, id, nil, nil)
self.id = id
self.btnName = btnName or lang.public_018
self.labelName = labelName or ""
self.template = "FileUploadArea"
end
FileUpload = class(AbstractComponent)
function FileUpload.__init__(self, id, labelName)
AbstractComponent.__init__(self, id, nil, nil, labelName)
self.id = id
self.labelName = labelName or ""
self.template = "FileInput"
end
ParFileUpload = class(FileUpload)
function ParFileUpload.__init__(self, id, labelName)
FileUpload.__init__(self, id, labelName)
end
AbstractStatusArea = class(AbstractArea)
function AbstractStatusArea.__init__(self, id, title, modelPath, maxInstNum)
AbstractArea.__init__(self, id, title, modelPath, maxInstNum)
self.id = id
self.template = "StatusArea"
end
function AbstractStatusArea.render(self, env, ...)
self.dataSet = DataSet(self:getParaTable())
AbstractArea.render(self,env,...)
return self.html
end
FunctionArea = class(AbstractArea)
function FunctionArea.__init__(self, id, modelPath, title)
AbstractArea.__init__(self, id, title, modelPath)
self.areaTip = EmptyElement()
self.template = "FunctionArea"
end
function FunctionArea.render(self, env)
env.__script = {}
self.html = AbstractArea.render(self, env)
local scriptCache = {}
table.insert(scriptCache, self.html)
table.insert(scriptCache, [[<script type="text/javascript">]])
local scriptStr = self:_getScriptListContent(env.__script)
table.insert(scriptCache, scriptStr)
table.insert(scriptCache, [[</script>]])
self.html = table.concat(scriptCache)
env.__script = nil
return self.html
end
function FunctionArea.append(self, obj, ...)
if not instanceof(obj, AbstractArea) then
return false
else
obj.modelPath = obj.modelPath or self.modelPath
self.modelPath = self.modelPath or obj.modelPath
return AbstractArea.append(self, obj, ...)
end
end
function FunctionArea.doPOSTRet(self, cgiLuaPOST)
local postRetList = {}
local postRetDataList = {}
local postRetTmp = nil
local postRetDataTmp = nil
for k, area in pairs(self.children) do
if area.doPOST ~= nil then
postRetTmp, postRetDataTmp = area:doPOST(cgiLuaPOST)
if postRetTmp ~= nil and postRetTmp.IF_ERRORID ~= nil then
postRetList[area.id] = postRetTmp
end
if postRetDataTmp ~= nil then
postRetDataList[area.id] = postRetDataTmp
end
end
end
return postRetList, postRetDataList
end
function FunctionArea.doPOST(self, cgiLuaPOST)
self.dataFormat = self.dataFormat or XML()
self.outputPOST = {}
local postRetList, postRetDataList = self:doPOSTRet(cgiLuaPOST)
if postRetList == nil or postRetDataList == nil then
return
end
for id, postRet in pairs(postRetList) do
if postRet ~= nil and postRet.IF_ERRORID ~= nil then
table.insert(self.outputPOST, self.dataFormat:transRet(postRet))
if (postRetDataList ~= nil) and (type(postRetDataList[id]) == "table") then
table.insert(self.outputPOST, self.dataFormat:transData(postRetDataList[id]))
end
end
end
self.outputPOST = table.concat(self.outputPOST)
self.dataFormat:output(self.outputPOST, sapi.Response.write)
end
function FunctionArea.getGETData(self, cgiLuaGET)
local getDataRet = nil
local tmpRet = nil
local getDataList = {}
local getRetList = {}
for k, area in pairs(self.children) do
if area.getGETData ~= nil then
tmpRet, getDataSet = area:getGETData(cgiLuaGET)
if tmpRet ~= nil and tmpRet.IF_ERRORID ~= nil then
if tmpRet.IF_ERRORID >= 0 then
getDataList[area.id] = getDataSet
end
getRetList[area.id] = tmpRet
g_logger:debug("FunctionArea.getGETData IF_ERRORID" .. tmpRet.IF_ERRORID)
else
g_logger:warn("get area \"" .. area.id .. "\"'s Data fail")
return getRetList, getDataList
end
end
end
return getRetList, getDataList
end
function FunctionArea.doGET(self, cgiLuaGET)
local getDataList = {}
local getRetList = {}
self.dataFormat = self.dataFormat or XML()
self.outputGET = {}
getRetList, getDataList = self:getGETData(cgiLuaGET)
if getRetList == nil or getDataList == nil then
return
end
for id, getRet in pairs(getRetList) do
if getRet ~= nil and getRet.IF_ERRORID ~= nil then
table.insert(self.outputGET, self.dataFormat:transRet(getRet))
if getRet.IF_ERRORID >= 0 and type(getDataList[id]) == "table" then
table.insert(self.outputGET, self.dataFormat:transData(getDataList[id]))
end
end
end
self.outputGET = table.concat(self.outputGET)
self.dataFormat:output(self.outputGET, sapi.Response.write)
end
function FunctionArea.doRequest(self, pCgiLua)
if type(pCgiLua.POST) == "table" and type(pCgiLua.POST.IF_ACTION) == "string" then
g_logger:debug("entry POST " )
self:doPOST(pCgiLua.POST)
else
g_logger:debug("entry GET " )
self:doGET(pCgiLua.GET)
end
end
AbstractPage = class(AbstractArea)
function AbstractPage.__init__(self, pageName)
AbstractArea.__init__(self, pageName, pageName, nil, nil)
self.pageName = pageName
end
