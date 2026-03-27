require "model.pageCommon"
local cgilua_lp = require("cgilua.lp")
function getOneValue(Page)
local id = cgilua.cgilua.POST["_InstID"]
if id == nil then
local Error = {
IF_ERRORID = -1,
IF_ERRORSTR = "no inst id",
}
sendJsonRespone(Error)
return
end
local ret = {
IF_ERRORID = 0,
IF_ERRORTYPE = "SUCC",
IF_ERRORSTR = "SUCC",
IF_ERRORPARAM = "SUCC"
}
local errorTbl, list = getValueFromModel(Page.ParaModel[1], id)
if errorTbl == nil then
list["_InstID"] = id
ret[Page.ParaModel[1].objname] = {Instance={}}
table.insert(ret[Page.ParaModel[1].objname].Instance,list)
else
transError(ret, errorTbl)
end
if type(Page.handleAfterGet) == "function" then
Page.handleAfterGet(ret)
end
sendJsonRespone(ret)
end
function setOneValue(Page)
local id = cgilua.cgilua.POST["_InstID"]
if id == nil then
local Error = {
IF_ERRORID = -1,
IF_ERRORSTR = "no inst id",
}
sendJsonRespone(Error)
return
end
if type(Page.handleBeforSet) == "function" then
Page.handleBeforSet(cgilua.cgilua.POST)
end
if id == "-1" then
id = ""
end
local result = {}
local ret = setValueFromModel(Page.ParaModel[1],id)
transError(result,ret)
sendJsonRespone(result)
end
function deleteInst(Page)
local id = cgilua.cgilua.POST["_InstID"]
if id == nil then
local Error = {
IF_ERRORID = -1,
IF_ERRORSTR = "no inst id",
}
sendJsonRespone(Error)
return
end
if type(Page.handleBeforDel) == "function" then
Page.handleBeforDel(cgilua.cgilua.POST)
end
local result = {}
local ret = deleteInstFromModel(Page.ParaModel[1],id)
transError(result,ret)
sendJsonRespone(result)
end
function buildInputDiv(paraNode)
local htmlList = {}
local htmlStr
if paraNode.type == "string" then
local class = "inputNorm"
if paraNode.style ~= nil then
class = "input" .. paraNode.style
end
htmlStr = string.format("<input type='text' class='%s' id='%s' name='%s'/>",class,paraNode.name,paraNode.name)
table.insert(htmlList,htmlStr)
htmlStr = string.format("<span style='display: none;'>%s</span>",lang.public_073)
table.insert(htmlList,htmlStr)
elseif paraNode.type == "number" then
htmlStr = string.format("<input type='text' class='inputLong' id='%s' name='%s'/>",paraNode.name,paraNode.name)
table.insert(htmlList,htmlStr)
htmlStr = string.format("<span style='display: none;'>%s</span>",lang.public_072)
table.insert(htmlList,htmlStr)
end
return table.concat(htmlList, "\n")
end
MultiConfigPage = {
pageType = "multi",
leftWidth = "w180",
tempFile = "multi_template_t.lp",
collapBar = "",
modelFile = "",
titleChange = "",
add = 1,
delete = 1,
modify = 1
}
function MultiConfigPage:creat(paraModel,pagepara)
o = setmetatable({}, { __index = self })
o.ParaModel = paraModel or {}
if pagepara then
for k,v in pairs(pagepara) do
o[k] = v
end
end
o.RunAction = {}
o.RunAction["getAll"] = getAllValue
o.RunAction["Cancel"] = getOneValue
o.RunAction["Apply"] = setOneValue
o.RunAction["Delete"] = deleteInst
return o
end
function MultiConfigPage:buildView(env)
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
jsConf.titleChange = self.titleChange
jsConf.add = self.add
jsConf.delete = self.delete
jsConf.modify = self.modify
jsConf.check = {}
for _,func in ipairs(self.ParaModel) do
table.insert(jsConf.objList,func.objname)
for _,para in ipairs(func.para) do
if para.label ~= nil then
nodeStr = string.format("<div id='%sDiv' class='row'>",para.name)
table.insert(contentList,nodeStr)
nodeStr = string.format("<label for='%s' id='%sLabel' class='cfgLabel %s'>%s</label>",para.name,para.name,self.leftWidth,lang[para.label])
table.insert(contentList,nodeStr)
table.insert(contentList,"<div class='right'>")
nodeStr = buildInputDiv(para)
table.insert(contentList,nodeStr)
table.insert(contentList,"</div>\n</div>")
jsConf.check[para.name] = {}
jsConf.check[para.name].type = para.type
jsConf.check[para.name].rule = para.check
jsConf.check[para.name].range = para.range
end
end
end
page.content = table.concat(contentList, "\n")
page.jsInfo = transJsInfo(jsConf)
local file = "../model/template/" .. self.tempFile
env.page = page
cgilua_lp.include(file, env, true)
end
function MultiConfigPage:dataRun()
local FP_ACTION = cgilua.cgilua.POST.IF_ACTION
if FP_ACTION == nil then
FP_ACTION = "getAll"
end
local handleAction = self.RunAction[FP_ACTION];
if handleAction then
handleAction(self)
else
end
end
return MultiConfigPage
