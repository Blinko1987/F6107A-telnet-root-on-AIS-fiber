require "model.pageCommon"
local cgilua_lp = require("cgilua.lp")
StatusPage = {
pageType = "status",
leftWidth = "w250",
rightWidth = "w250",
mode = "multi",
tempFile = "status_template_t.lp",
collapBar = "",
modelFile = "",
}
function StatusPage:creat(paraModel,pageAttr)
o = setmetatable({}, { __index = self })
o.ParaModel = paraModel or {}
if pageAttr then
for k,v in pairs(pageAttr) do
o[k] = v
end
end
o.RunAction = {}
o.RunAction["getValue"] = getAllValue
return o
end
function StatusPage:buildView(env)
local page = {}
local jsConf = {objList={}}
local contentList = {}
local nodeStr = ""
page.id = self.pageId
page.title = ""
if self.collapBar ~= nil then
page.title = lang[self.collapBar]
end
page.display = "display:none;"
if self.mode == "single" then
page.display = ""
end
page.dataFile = self.modelFile
jsConf.id = self.pageId
jsConf.mode = self.mode
for _,func in ipairs(self.ParaModel) do
table.insert(jsConf.objList,func.objname)
for _,para in ipairs(func.para) do
if para.label ~= nil then
local labelName = lang[para.label]
local paraName = para.name or "temp"
if para.head == true then
nodeStr = string.format("<div id='%sDiv' class='colorTblRow emFont titleRow'>",paraName)
else
nodeStr = string.format("<div id='%sDiv' class='colorTblRow'>",paraName)
end
table.insert(contentList,nodeStr)
nodeStr = string.format("<span class='%s emFont' id='%sText' title='%s'>%s</span>",self.leftWidth,paraName,labelName,labelName)
table.insert(contentList,nodeStr)
nodeStr = string.format("<span class='%s' id='%s'></span>",self.rightWidth,paraName)
table.insert(contentList,nodeStr)
table.insert(contentList,"</div>")
end
end
end
page.content = table.concat( contentList, "\n")
page.jsInfo = transJsInfo(jsConf)
local file = "../model/template/" .. self.tempFile
env.page = page
cgilua_lp.include(file, env, true)
end
function StatusPage:dataRun()
local FP_ACTION = cgilua.cgilua.POST.IF_ACTION
if FP_ACTION == nil then
FP_ACTION = "getValue"
end
local handleAction = self.RunAction[FP_ACTION];
if handleAction then
handleAction(self)
else
end
end
return StatusPage
