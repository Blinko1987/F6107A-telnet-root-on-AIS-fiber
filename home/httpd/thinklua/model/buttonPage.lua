require "model.pageCommon"
require "model.buildCommon"
local cgilua_lp = require("cgilua.lp")
ButtonPage = {
pageType = "config",
mode = "button",
tempFile = "button_template_t.lp",
collapBar = "",
modelFile = "",
}
function ButtonPage:creat(paraModel, pageAttr)
o = setmetatable({}, { __index = self })
o.ParaModel = paraModel or {}
if pageAttr then
for k,v in pairs(pageAttr) do
o[k] = v
end
end
o.RunAction = {}
o.RunAction["runCMD"] = runCmd
return o
end
function ButtonPage:buildView(env)
local page = {}
local jsConf = {}
local contentList = {}
local nodeStr = ""
page.id = self.pageId
page.title = ""
if self.collapBar ~= nil then
page.title = lang[self.collapBar]
end
if self.modelStyle ~= nil then
page.style = self.modelStyle
end
if self.modelAction ~= nil then
page.action = self.modelAction
end
if self.modelActionName ~= nil then
page.actionName = lang[self.modelActionName]
end
page.dataFile = self.modelFile
jsConf.id = self.pageId
jsConf.action = self.modelAction
jsConf.Msg = lang[self.confirm]
jsConf.OK = lang[self.succ]
jsConf.mode = self.mode
jsConf.POST = self.POST
for _,func in ipairs(self.ParaModel) do
for _,attr in ipairs(func.para) do
nodeStr = buildTextDiv(attr, self)
table.insert(contentList, nodeStr)
end
end
page.content = table.concat(contentList, "\n")
page.jsInfo = transJsInfo(jsConf)
local file = "../model/template/" .. self.tempFile
env.page = page
cgilua_lp.include(file, env, true)
end
function ButtonPage:dataRun()
local FP_ACTION = cgilua.cgilua.POST.IF_ACTION
if FP_ACTION == self.POST then
FP_ACTION = "runCMD"
end
local handleAction = self.RunAction[FP_ACTION];
if handleAction then
handleAction(self)
else
end
end
return ButtonPage
