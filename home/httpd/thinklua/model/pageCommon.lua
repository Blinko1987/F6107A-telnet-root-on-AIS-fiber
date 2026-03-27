local cjson = require"common_lib.json"
function debugSend(string)
end
function sendJsonRespone(responseTab)
local json_text = cjson.encode(responseTab)
cgilua.cgilua.contentheader ("application", "json; charset=" .. lang.CHARSET)
sapi.Response.write(json_text)
end
function transJsInfo(jsTable)
local json_text = cjson.encode(jsTable)
return _G.encodeJS(json_text)
end
function returnModel(Page)
sendJsonRespone(Page.PageModel)
end
function transError(retTbl, tError)
if type(tError) ~= "table" then
return
end
if tError.IF_ERRORID ~= 0 then
if tError.IF_ERRORSTR ~= "FAIL" then
tError.IF_ERRORSTR = lang["cmret_" .. tError.IF_ERRORSTR] or lang.cmret_001
end
end
retTbl["IF_ERRORID"] = tError.IF_ERRORID
retTbl["IF_ERRORTYPE"] = tError.IF_ERRORTYPE or "SUCC"
retTbl["IF_ERRORSTR"] = tError.IF_ERRORSTR or "SUCC"
retTbl["IF_ERRORPARAM"] = tError.IF_ERRORPARAM or "SUCC"
end
function getValueFromModel(model, id)
local nvList = {}
local retTable = cmapi.getinst(model.objname, id)
if retTable.IF_ERRORID ~= 0 then
return retTable, nil
end
for i,attr in ipairs(model.para) do
if attr.name and retTable[attr.name] then
nvList[attr.name] = retTable[attr.name]
end
end
return nil, nvList
end
function getSingleValue(ret, model)
local rootInst = "IGD"
if model.root then
rootInst = model.root
end
local errorTbl, list = getValueFromModel(model, rootInst)
local result = 0
if errorTbl == nil then
ret[model.objname] = {Instance={}}
table.insert(ret[model.objname].Instance, list)
else
transError(ret, errorTbl)
result = -1
end
return result
end
function getIdList(objname, id)
local rootInst = nil
local reTable = cmapi.querylist(objname, id)
if reTable.IF_ERRORID == 0 then
if reTable.Count == 888 then
reTable.IF_ERRORID = -1
reTable.IF_ERRORSTR = "single"
rootInst = id
else
reTable.IF_ERRORSTR = "multi"
for i=1,reTable.Count do
rootInst = reTable[i].InstName or reTable[i]
end
end
else
rootInst = id
end
return reTable, rootInst
end
function getMultiValue(ret, model)
local rootInst = "IGD"
if model.idList then
idList = model.idList
else
if model.root then
rootInst = model.root
end
idList = getIdList(model.objname, rootInst)
if idList.IF_ERRORID ~= 0 then
transError(ret, idList)
return -1
end
end
local nodeList = {}
for i = 1,idList.Count do
local id = idList[i].InstName or idList[i]
local errorTbl, list = getValueFromModel(model, id)
if errorTbl == nil then
list["_InstID"] = id
table.insert(nodeList, list)
end
end
ret[model.objname] = {}
ret[model.objname].Instance = nodeList
return 0
end
function getAllValue(Page)
local ret = {
IF_ERRORID = 0,
IF_ERRORTYPE = "SUCC",
IF_ERRORSTR = "SUCC",
IF_ERRORPARAM = "SUCC"
}
for i,m in ipairs(Page.ParaModel) do
local result = 0
if m.mode and m.mode == "multi" then
if type(Page.getIdSelf) == "function" then
Page.getIdSelf(m)
end
result = getMultiValue(ret, m)
else
result = getSingleValue(ret, m)
end
if result == -1 then
break
end
end
if type(Page.handleAfterGet) == "function" then
Page.handleAfterGet(ret)
end
sendJsonRespone(ret)
end
function getSingleConfigValue(Page)
local ret = {
IF_ERRORID = 0,
IF_ERRORTYPE = "SUCC",
IF_ERRORSTR = "SUCC",
IF_ERRORPARAM = "SUCC"
}
for i,m in ipairs(Page.ParaModel) do
local result = 0
result = getSingleValue(ret, m)
if result == -1 then
break
end
end
if type(Page.handleAfterGet) == "function" then
Page.handleAfterGet(ret)
end
sendJsonRespone(ret)
end
function runCmd(Page)
local ret = {
IF_ERRORID = 0,
IF_ERRORTYPE = "SUCC",
IF_ERRORSTR = "SUCC",
IF_ERRORPARAM = "SUCC"
}
local result = 0
if Page.cmdAccess == null then
ret.IF_ERRORID = -1
ret.IF_ERRORSTR = "action forbidden"
else
cmapi.dev_action({CmdId = Page.cmdAccess})
end
if ret.IF_ERRORID ~= 0 then
result = -1
end
if type(Page.handleAfterGet) == "function" then
Page.handleAfterGet(ret)
end
sendJsonRespone(ret)
end
function setValueFromModel(model, id)
local nvList = {}
for i,attr in ipairs(model.para) do
if attr.name and cgilua.cgilua.POST[attr.name] then
nvList[attr.name] = cgilua.cgilua.POST[attr.name]
end
end
local retTable = {IF_ERRORID = 0}
local retTable = cmapi.setinst(model.objname, id, nvList)
return retTable
end
function setSingleValue(ret, model)
local rootInst = "IGD"
if model.root then
rootInst = model.root
end
local errorTbl = setValueFromModel(model, rootInst)
local result = 0
if errorTbl.IF_ERRORID ~= 0 then
transError(ret, errorTbl)
result = -1
end
return result
end
function setSingleConfigValue(Page)
local ret = {
IF_ERRORID = 0,
IF_ERRORTYPE = "SUCC",
IF_ERRORSTR = "SUCC",
IF_ERRORPARAM = "SUCC"
}
if type(Page.handleBeforSet) == "function" then
Page.handleBeforSet(cgilua.cgilua.POST)
end
for i,m in ipairs(Page.ParaModel) do
local result = 0
result = setSingleValue(ret, m)
if result == -1 then
break
end
end
sendJsonRespone(ret)
end
function deleteInstFromModel(model, id)
local t = {IF_ERRORID = 0}
t = cmapi.delinst(model.objname, id)
return t
end
