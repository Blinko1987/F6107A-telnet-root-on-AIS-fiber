require "model.pageCommon"
require "model.buildCommon"
local cgilua_lp = require("cgilua.lp")
function getDiagnosisValue(Page)
local ret = {
IF_ERRORID = 0,
IF_ERRORTYPE = "SUCC",
IF_ERRORSTR = "SUCC",
IF_ERRORPARAM = "SUCC"
}
local id = ""
local errorTbl, list = getValueFromModel(Page.ParaModel[1], id)
if errorTbl == nil then
ret[Page.ParaModel[1].objname] = {Instance={}}
table.insert(ret[Page.ParaModel[1].objname].Instance, list)
else
transError(ret, errorTbl)
end
if type(Page.handleAfterGet) == "function" then
Page.handleAfterGet(ret)
end
sendJsonRespone(ret)
end
function setDiagnosisValue(Page)
if type(Page.handleBeforSet) == "function" then
Page.handleBeforSet(cgilua.cgilua.POST)
end
local id = ""
local result = {}
local ret = setValueFromModel(Page.ParaModel[1], id)
transError(result, ret)
sendJsonRespone(result)
end
DiagnosisPage = {
pageType = "config",
leftWidth = "",
rightWidth = "",
mode = "diagnosis",
tempFile = "diagnosis_template_t.lp",
collapBar = "",
modelFile = "",
}
function DiagnosisPage:creat(paraModel, pageAttr)
o = setmetatable({}, { __index = self })
o.ParaModel = paraModel or {}
if pageAttr then
for k,v in pairs(pageAttr) do
o[k] = v
end
end
o.RunAction = {}
o.RunAction["getValue"] = getDiagnosisValue
o.RunAction["setValue"] = setDiagnosisValue
return o
end
function DiagnosisPage:buildView(env)
local page = {}
local jsConf = {objList={}}
local contentList = {}
local nodeStr = ""
page.id = self.pageId
page.title = ""
if self.collapBar ~= nil then
page.title = lang[self.collapBar]
end
if self.modelButtonName ~= nil then
page.buttonName = lang[self.modelButtonName]
end
if self.modelAreaLabel ~= nil then
page.areaLabel = lang[self.modelAreaLabel]
end
if self.modelAreaId ~= nil then
page.areaId = self.modelAreaId
end
page.dataFile = self.modelFile
jsConf.id = self.pageId
jsConf.areaId = self.modelAreaId
jsConf.time = self.modelTime
jsConf.Msg = self.confirm
jsConf.mode = self.mode
for _,func in ipairs(self.ParaModel) do
table.insert(jsConf.objList, func.objname)
for _,attr in ipairs(func.para) do
if attr.label ~= nil then
nodeStr = string.format("<div class='row' style='%s'>", attr.display)
table.insert(contentList, nodeStr)
nodeStr = buildTextDiv(attr, self)
table.insert(contentList, nodeStr)
nodeStr = buildSelectDiv(attr, self)
table.insert(contentList, nodeStr)
nodeStr = buildInputDiv(attr)
table.insert(contentList, nodeStr)
table.insert(contentList, "</div>")
end
end
end
page.content = table.concat(contentList, "\n")
page.jsInfo = transJsInfo(jsConf)
local file = "../model/template/" .. self.tempFile
env.page = page
cgilua_lp.include(file, env, true)
end
function DiagnosisPage:dataRun()
local FP_ACTION = cgilua.cgilua.POST.IF_ACTION
if FP_ACTION == nil then
FP_ACTION = "getValue"
end
if FP_ACTION == self.POST then
FP_ACTION = "setValue"
end
local handleAction = self.RunAction[FP_ACTION];
if handleAction then
handleAction(self)
else
end
end
return DiagnosisPage
