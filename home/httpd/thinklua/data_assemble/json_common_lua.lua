function applyOrNewOrDelInst_json(FP_OBJNAME, FP_ACTION, FP_IDENTITY, tData, tError)
if type(tData) ~= "table" then
g_logger:debug("Data is no a table!")
return false
end
if type(tError) == "table" then
if tError.IF_ERRORID ~= 0 then
return tError
end
end
local t = {IF_ERRORID = 0}
if FP_ACTION == "Apply" then
t = cmapi.setinst(FP_OBJNAME, FP_IDENTITY, tData)
elseif FP_ACTION == "Delete" then
t = cmapi.delinst(FP_OBJNAME, FP_IDENTITY)
end
return t
end
function getInstPara_json(OBJNAME, ID, callback, getTParam, instTable)
local err = {
IF_ERRORID = 0,
IF_ERRORTYPE = "SUCC",
IF_ERRORSTR = "SUCC",
IF_ERRORPARAM = "SUCC"
}
local callret = true
local exitCycle = nil
local Instvaild = 0
local instNode = {}
instNode["_InstID"] = ID
local retTable = cmapi.getinst(OBJNAME, ID)
local k, v
if type(retTable) ~= "table" then
g_logger:debug("retTable is not a table!")
err["IF_ERRORID"] = -1
return err, nil
end
if instTable == nil then
g_logger:debug("instTable can not be nil")
return retTable, nil
end
if retTable.IF_ERRORID == 0 then
if callback and type(callback) == "function" then
callret, exitCycle= callback(retTable, ID)
end
if callret then
Instvaild = 1
end
else
return retTable, nil
end
if Instvaild == 1 then
if getTParam.encrypt then
local sessmgr = require("user_mgr.session_mgr")
local key = sessmgr.GetCurrentSessAttr("sess_token")
local iv = string.reverse(key)
for i,v in ipairs(getTParam.encrypt) do
if retTable[v] ~= nil and string.len(retTable[v]) > 0 then
retTable[v] = cmapi.nocsrf.aes_encrypt(retTable[v], key, iv)
end
end
end
for k,v in pairs(retTable) do
if not getTParam or (type(getTParam) == "table" and getTParam[k]) then
instNode[k] = v
end
end
table.insert(instTable, instNode)
end
return err, exitCycle
end
function getAllInstTbl_json(FP_OBJNAME, listBaseID, tErr, callback, getTParam, instTable)
local tmpError = {
IF_ERRORID = 0,
IF_ERRORTYPE = "SUCC",
IF_ERRORSTR = "SUCC",
IF_ERRORPARAM = "SUCC"
}
if not tErr then
tErr = tmpError
end
local reTable = cmapi.querylist(FP_OBJNAME, listBaseID)
if reTable.IF_ERRORID ~= 0 then
g_logger:debug("querylist error")
if tErr.IF_ERRORID == 0 then
tErr = reTable
end
return tErr
end
local count = reTable.Count
if count ~= 888 then
for i=1, count do
local id = reTable[i].InstName or reTable[i]
if tErr.IF_ERRORID == 0 then
tmpError, exitCycle = getInstPara_json(FP_OBJNAME, id, callback, getTParam, instTable)
if tmpError.IF_ERRORID ~= 0 then
tErr = tmpError
end
else
_, exitCycle = getInstPara_json(FP_OBJNAME, id, callback, getTParam, instTable)
end
if exitCycle then
break
end
end
else
tmpError = getInstPara_json(FP_OBJNAME, "IGD", callback, getTParam,instTable)
if tErr.IF_ERRORID == 0 then
tErr = tmpError
end
end
return tErr
end
function getAllInst_json(FP_OBJNAME, listBaseID, tErr, callback, getTParam)
local instTable = {}
local objTable = {}
tErr = getAllInstTbl_json(FP_OBJNAME, listBaseID, tErr, callback, getTParam, instTable)
objTable["Instance"] = instTable
if getTParam.encrypt then
objTable["encode"] = table.concat(getTParam.encrypt,",")
end
return objTable,tErr
end
function getSpecificInst_json(FP_OBJNAME, FP_IDENTITY, tErr, callback, getTParam)
local errorTable = nil
local instTable = {}
local objTable = {}
errorTable = getInstPara_json(FP_OBJNAME, FP_IDENTITY, callback, getTParam, instTable)
objTable["Instance"] = instTable
if getTParam.encrypt then
objTable["encode"] = table.concat(getTParam.encrypt,",")
end
if type(tErr) == "table" then
if tErr.IF_ERRORID ~= 0 then
errorTable = tErr
end
end
return objTable, errorTable
end
function convertErrorStr_json(jsonTbl,tError)
if type(tError) ~= "table" then
return
end
if tError.IF_ERRORID ~= 0 then
if tError.IF_ERRORSTR ~= "FAIL" then
tError.IF_ERRORSTR = lang["cmret_"..tError.IF_ERRORSTR] or lang.cmret_001
end
end
jsonTbl["IF_ERRORID"] = tError.IF_ERRORID
jsonTbl["IF_ERRORTYPE"] = tError.IF_ERRORTYPE or "SUCC"
jsonTbl["IF_ERRORSTR"] = tError.IF_ERRORSTR or "SUCC"
jsonTbl["IF_ERRORPARAM"] = tError.IF_ERRORPARAM or "SUCC"
end
function outputJson(jsonTbl)
local cjson = require"common_lib.json"
cgilua.cgilua.contentheader ("application", "json; charset="..lang.CHARSET)
sapi.Response.write(cjson.encode(jsonTbl))
end
function transToPostTab(array)
if type(array) ~= "table" then
return
end
local para_list = array
if array.para then
para_list = array.para
end
local retTab = {}
for i,v in ipairs(para_list) do
retTab[v] = cgilua.cgilua.POST[v]
end
if array.ignore then
for i,v in ipairs(array.ignore) do
retTab[v] = nil
end
end
if array.encrypt == nil or cgilua.POST.encode == nil then
return retTab
end
local decodeKV = cmapi.nocsrf.rsa_decrypt(cgilua.POST.encode)
local strpass = string.format("%c%c%c%c%c%c", 9,9,9,9,9,9)
local key,iv = string.match(decodeKV,"(%d+)%+(%d+)")
for i,v in ipairs(array.encrypt) do
if retTab[v] ~= nil and string.len(retTab[v]) > 0 then
retTab[v] = cmapi.nocsrf.aes_decrypt(retTab[v], key, iv)
if retTab[v] == strpass then
g_logger:info("para "..v.." value is 6 tab")
retTab[v] = nil
end
end
end
return retTab
end
function transToFilterTab(array)
if type(array) ~= "table" then
return
end
local retTab = {}
local para_list = array
if array.para then
para_list = array.para
if array.encrypt then
retTab["encrypt"] = array.encrypt
end
end
for i,v in ipairs(para_list) do
retTab[v] = ""
end
return retTab
end
function ManagerOBJ_json(jsonTbl, FP_OBJNAME, FP_ACTION, FP_IDENTITY, t_PARA, tError, RetTAB, callback, listBaseID)
local objTble = {}
local need2Get = 1
if listBaseID == nil then
listBaseID = "IGD"
end
if type(tError) == "table" then
if tError.IF_ERRORID ~= 0 then
return "", tError
end
end
local ReturnIdentity = ""
if FP_ACTION == "Apply" or FP_ACTION == "Delete" then
need2Get = 0
tError = applyOrNewOrDelInst_json(FP_OBJNAME, FP_ACTION, FP_IDENTITY, transToPostTab(t_PARA))
ReturnIdentity = tError.INSTIDENTITY or ""
if RetTAB ~= nil then
if RetTAB.xmlType == 1 then
jsonTbl["_InstID"] = ReturnIdentity
elseif RetTAB.xmlType == 2 and FP_ACTION == "Apply" then
if (RetTAB.retCheck == nil) or (RetTAB.retCheck == 1 and tError.IF_ERRORID ~= 0) or (RetTAB.retCheck == 2 and tError.IF_ERRORID == 0) then
objTble, tError = getSpecificInst_json(FP_OBJNAME, ReturnIdentity, tError, callback, transToFilterTab(t_PARA))
jsonTbl["_InstID"] = ReturnIdentity
jsonTbl[FP_OBJNAME] = objTble
end
else
end
end
end
if FP_ACTION == "Cancel" then
need2Get = 0
objTble, tError = getSpecificInst_json(FP_OBJNAME, FP_IDENTITY, nil, callback, transToFilterTab(t_PARA))
jsonTbl[FP_OBJNAME] = objTble
end
if need2Get == 1 then
objTble, tError = getAllInst_json(FP_OBJNAME, listBaseID, nil, callback,transToFilterTab(t_PARA))
jsonTbl[FP_OBJNAME] = objTble
end
return tError
end
function identity2name(listTab, identity)
if type(listTab) ~= "table" then
return ""
end
for i ,v in ipairs(listTab) do
if v.InstName == identity then
return v.WANCName
end
end
return ""
end
function read_file(fname)
local INF = io.open(fname, "rb")
if not INF then error("cannot open \""..fname.."\" for reading") end
local dat = INF:read("*a")
if not dat then error("cannot read from \""..fname.."\"") end
INF:close()
return dat
end
function encodeHTML(value)
local typeVal = type(value)
if typeVal ~= "string" and typeVal ~= "number" then
g_logger:debug("string or number expected, but got "..typeVal)
return ""
end
local htmlTbl = {}
local htmlStr = ""
local slen = string.len(value)
local char = ""
local charInt = ""
local charEntity = ""
local i = 1
for i=1,slen do
charInt = string.byte(value,i)
char = string.char(charInt)
if charInt >= 0 and charInt <= 127 then
charEntity = "&#"..charInt..";"
else
charEntity = char
end
table.insert(htmlTbl, charEntity)
end
htmlStr = table.concat(htmlTbl)
return htmlStr
end
function encodeJS(value)
local typeVal = type(value)
if typeVal ~= "string" and typeVal ~= "number" then
g_logger:debug("string or number expected, but got "..typeVal)
return ""
end
local jsTbl = {}
local jsStr = ""
local slen = string.len(value)
local char = ""
local charInt = ""
local charEntity = ""
local i = 1
for i=1,slen do
charInt = string.byte(value,i)
char = string.char(charInt)
if charInt >= 0 and charInt <= 127 then
charEntity = "\\x"..string.format("%x", charInt)
else
charEntity = char
end
table.insert(jsTbl, charEntity)
end
jsStr = table.concat(jsTbl)
return jsStr
end
function Split(szFullString, szSeparator)
local nFindStartIndex = 1
local nSplitIndex = 1
local nSplitArray = {}
while true do
local nFindLastIndex = string.find(szFullString, szSeparator, nFindStartIndex)
if not nFindLastIndex then
nSplitArray[nSplitIndex] = string.sub(szFullString, nFindStartIndex, string.len(szFullString))
break
end
nSplitArray[nSplitIndex] = string.sub(szFullString, nFindStartIndex, nFindLastIndex - 1)
nFindStartIndex = nFindLastIndex + string.len(szSeparator)
nSplitIndex = nSplitIndex + 1
end
return nSplitArray
end
local function getParam_MultiGet_json(tResult, paraName, i, tbPara)
local paraIndex = paraName .. i
if not tResult[paraIndex] then
return
end
tbPara[paraName] = tResult[paraIndex]
end
function getAllInst_MultiGet_json(jsonTbl, FP_OBJNAME, PARA, preProcessInstData, queryCondition, tError)
local tNoError = {
IF_ERRORID = 0,
IF_ERRORTYPE = "SUCC",
IF_ERRORSTR = "SUCC",
IF_ERRORPARAM = "SUCC"
}
if not tError then
tError = tNoError
end
if not queryCondition then
queryCondition = {}
end
local tResult = cmapi.getinst(FP_OBJNAME, "MGet", queryCondition)
if tResult.IF_ERRORID ~= 0 then
g_logger:debug("multi getinst fail")
if tError.IF_ERRORID == 0 then
tError = tResult
end
return tError
end
local FP_INSTNUM = tResult.MGET_INST_NUM
FP_INSTNUM = tonumber(FP_INSTNUM)
local instTbl = {}
for i=0, FP_INSTNUM-1 do
local tbPara = {}
local isOutPut = true
local isBreakLoop = false
if not preProcessInstData then
isOutPut = true
else
isOutPut, isBreakLoop = preProcessInstData(tResult, i)
end
if isOutPut then
for _,paraName in ipairs(PARA) do
getParam_MultiGet_json(tResult, paraName, i, tbPara)
end
table.insert(instTbl, tbPara)
end
if isBreakLoop then
break
end
end
local objTbl = {Instance=instTbl}
jsonTbl[FP_OBJNAME] = objTbl
return tError
end
