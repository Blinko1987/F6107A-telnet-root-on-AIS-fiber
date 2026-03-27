require "model.pageCommon"
require "model.buildCommon"
local cgilua_lp = require("cgilua.lp")
SingleConfigPage = {
pageType = "config",
leftWidth = "",
rightWidth = "",
style = "",
mode = "single",
tempFile = "single_template_t.lp",
collapBar = "",
modelFile = "",
}
function SingleConfigPage:creat(paraModel, pageAttr)
o = setmetatable({}, { __index = self })
o.ParaModel = paraModel or {}
if pageAttr then
for k,v in pairs(pageAttr) do
o[k] = v
end
end
o.RunAction = {}
o.RunAction["getValue"] = getSingleConfigValue
o.RunAction["setValue"] = setSingleConfigValue
return o
end
function SingleConfigPage:buildView(env)
local page = {}
local jsConf = {objList={}}
local contentList = {}
local nodeStr = ""
page.id = self.pageId
page.title = ""
if self.collapBar ~= nil then
page.title = lang[self.collapBar]
end
page.dataFile = self.modelFile
jsConf.id = self.pageId
jsConf.mode = self.mode
jsConf.pageCtrl = self.pageCtrl or ""
jsConf.rules = self.rules
for _,func in ipairs(self.ParaModel) do
table.insert(jsConf.objList, func.objname)
for _,attr in ipairs(func.para) do
if attr.label ~= nil then
nodeStr = string.format("<div class='row' style='%s'>", attr.display)
table.insert(contentList, nodeStr)
nodeStr = buildTextDiv(attr, self)
table.insert(contentList, nodeStr)
nodeStr = buildRadioDiv(attr, self)
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
function SingleConfigPage:dataRun()
local FP_ACTION = cgilua.cgilua.POST.IF_ACTION
if FP_ACTION == nil or FP_ACTION == "Cancel" then
FP_ACTION = "getValue"
end
if FP_ACTION == "Apply" then
FP_ACTION = "setValue"
end
local handleAction = self.RunAction[FP_ACTION];
if handleAction then
handleAction(self)
else
end
end
return SingleConfigPage
