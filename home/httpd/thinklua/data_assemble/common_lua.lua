function applyOrNewOrDelInst(FP_OBJNAME, FP_ACTION, FP_IDENTITY, tData, tError)
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
elseif FP_ACTION == "DeleteMulti" then
local instArr = Split(FP_IDENTITY, "|")
for i,inst in ipairs(instArr) do
t = cmapi.delinst(FP_OBJNAME, inst)
if t.IF_ERRORID ~= 0 then
break
end
end
end
return t
end
function getXMLLabelStart(nodeName)
return table.concat({"<", nodeName, ">"})
end
function getXMLLabelEnd(nodeName)
return table.concat({"</", nodeName, ">"})
end
function getXMLNodeEntity(nodeName, nodeValue)
return table.concat({getXMLLabelStart(nodeName), nodeValue, getXMLLabelEnd(nodeName)})
end
function getParaXMLNodeEntity(nodeName, nodeValue)
if nodeValue == nil then
g_logger:warn("nodeName(" .. nodeName .. ")'s Value is nil")
end
return table.concat({"<ParaName>", nodeName, "</ParaName>", "<ParaValue>", nodeValue, "</ParaValue>"})
end
function encodeXML (value)
return cmapi.encodeXml(value)
end
function getInstParaXML(OBJNAME, ID, callback, getTParam, xmlTable)
local err = {
IF_ERRORID = 0,
IF_ERRORTYPE = "SUCC",
IF_ERRORSTR = "SUCC",
IF_ERRORPARAM = "SUCC"
}
local callret = true
local exitCycle = nil
local Instvaild = 0
local xmlStr = getParaXMLNodeEntity("_InstID", encodeXML(ID))
local retTable = cmapi.getinst(OBJNAME, ID)
local k, v
if type(retTable) ~= "table" then
g_logger:debug("retTable is not a table!")
return xmlTable, err
end
if xmlTable == nil then
g_logger:debug("xmlTable can not be nil")
return nil, retTable
end
if retTable.IF_ERRORID == 0 then
if callback and type(callback) == "function" then
callret, exitCycle= callback(retTable, ID)
end
if callret then
Instvaild = 1
end
else
return xmlTable, retTable
end
if Instvaild == 1 then
if _G.commConf.getEncode and getTParam and getTParam.encrypt then
local sessmgr = require("user_mgr.session_mgr")
local key = sessmgr.GetCurrentSessAttr("sess_token")
local iv = string.reverse(key)
for i,v in ipairs(getTParam.encrypt) do
if retTable[v] ~= nil and string.len(retTable[v]) > 0 then
retTable[v] = cmapi.nocsrf.aes_encrypt(retTable[v], key, iv)
end
end
end
table.insert(xmlTable, getXMLLabelStart("Instance"))
table.insert(xmlTable, xmlStr)
for k,v in pairs(retTable) do
if not getTParam or (type(getTParam) == "table" and getTParam[k]) then
v = encodeXML(v)
k = encodeXML(k)
table.insert(xmlTable, getParaXMLNodeEntity(k, v))
end
end
table.insert(xmlTable, getXMLLabelEnd("Instance"))
end
return xmlTable, err, exitCycle
end
function getAllInstTbl(FP_OBJNAME, ListBaseStr, tErr, callback, getTParam, xmlTable)
local xmlError = {
IF_ERRORID = 0,
IF_ERRORTYPE = "SUCC",
IF_ERRORSTR = "SUCC",
IF_ERRORPARAM = "SUCC"
}
if not tErr then
tErr = xmlError
end
local reTable = cmapi.querylist(FP_OBJNAME, ListBaseStr)
if reTable.IF_ERRORID ~= 0 then
g_logger:debug("querylist error")
if tErr.IF_ERRORID == 0 then
tErr = reTable
end
return xmlTable, tErr
end
local count = reTable.Count
if count ~= 888 then
for i=1, count do
local id = reTable[i].InstName or reTable[i]
if tErr.IF_ERRORID == 0 then
xmlTable, xmlError, exitCycle = getInstParaXML(FP_OBJNAME, id, callback, getTParam, xmlTable)
if xmlError.IF_ERRORID ~= 0 then
tErr = xmlError
end
else
xmlTable, _, exitCycle = getInstParaXML(FP_OBJNAME, id, callback, getTParam, xmlTable)
end
if exitCycle then
break
end
end
else
xmlTable,xmlError = getInstParaXML(FP_OBJNAME, "IGD", callback, getTParam,xmlTable)
if tErr.IF_ERRORID == 0 then
tErr = xmlError
end
end
return xmlTable,tErr
end
function getAllInstXML(FP_OBJNAME, ListBaseStr, tErr, callback, getTParam)
local xmlStr=""
local xmlTable = {}
xmlTable,tErr = getAllInstTbl(FP_OBJNAME, ListBaseStr, tErr, callback, getTParam, xmlTable)
xmlStr = table.concat(xmlTable)
xmlStr = getXMLNodeEntity(FP_OBJNAME, xmlStr)
if getTParam and getTParam.encrypt then
xmlStr = xmlStr .. getXMLNodeEntity("encode", table.concat(getTParam.encrypt,","))
end
return xmlStr,tErr
end
function getSpecificInstXML(FP_OBJNAME, FP_IDENTITY, tErr, callback, getTParam)
local xmlStr = ""
local xmlError = nil
local xmlTable = {}
xmlTable, xmlError= getInstParaXML(FP_OBJNAME, FP_IDENTITY, callback, getTParam, xmlTable)
xmlStr = table.concat(xmlTable)
xmlStr = getXMLNodeEntity(FP_OBJNAME, xmlStr)
if getTParam and getTParam.encrypt then
xmlStr = xmlStr .. getXMLNodeEntity("encode", table.concat(getTParam.encrypt,","))
end
if type(tErr) == "table" then
if tErr.IF_ERRORID ~= 0 then
xmlError = tErr
end
end
return xmlStr, xmlError
end
function outputErrorXML(tError)
local ErrorXML = ""
local errorTable = {}
if type(tError) ~= "table" then
return ""
end
if tError.IF_ERRORID ~= 0 then
if tError.IF_ERRORSTR ~= "FAIL" then
tError.IF_ERRORSTR = lang["cmret_"..tError.IF_ERRORSTR] or lang.cmret_001
end
end
tError.IF_ERRORTYPE = tError.IF_ERRORTYPE or "SUCC"
tError.IF_ERRORSTR = tError.IF_ERRORSTR or "SUCC"
tError.IF_ERRORPARAM = tError.IF_ERRORPARAM or "SUCC"
for k,v in pairs(tError) do
table.insert(errorTable, getXMLNodeEntity(k, encodeXML(tostring(v))))
end
ErrorXML = table.concat(errorTable)
return ErrorXML
end
function outputXML(xmlStr)
sapi.Response.write(getXMLNodeEntity("ajax_response_xml_root", xmlStr))
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
local strpass = string.format("%c%c%c%c%c%c", 9,9,9,9,9,9)
for i,v in ipairs(para_list) do
retTab[v] = cgilua.cgilua.POST[v]
if retTab[v] == strpass then
g_logger:info("para "..v.." value is 6 tab")
retTab[v] = nil
end
end
if array.ignore then
for i,v in ipairs(array.ignore) do
retTab[v] = nil
end
end
if array.encrypt == nil or _G.commConf.setEncode == false or cgilua.POST.encode == nil then
return retTab
end
local decodeKV = cmapi.nocsrf.rsa_decrypt(cgilua.POST.encode)
local key,iv = string.match(decodeKV,"(%d+)%+(%d+)")
for i,v in ipairs(array.encrypt) do
if retTab[v] ~= nil and string.len(retTab[v]) > 0 then
retTab[v] = cmapi.nocsrf.aes_decrypt(retTab[v], key, iv)
if retTab[v] == strpass then
g_logger:info("encode para "..v.." value is 6 tab")
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
function ManagerOBJ(FP_OBJNAME, FP_ACTION, FP_IDENTITY, t_PARA, tError, RetXmlTAB, callback, ListBaseStr)
local InstXML = ""
local need2Get = 1
if ListBaseStr == nil then
ListBaseStr = "IGD"
end
if type(tError) == "table" then
if tError.IF_ERRORID ~= 0 then
return "", tError
end
end
local ReturnIdentity = ""
if FP_ACTION == "Apply" or FP_ACTION == "Delete" or FP_ACTION == "DeleteMulti" then
need2Get = 0
tError = applyOrNewOrDelInst(FP_OBJNAME, FP_ACTION, FP_IDENTITY, transToPostTab(t_PARA))
ReturnIdentity = tError.INSTIDENTITY or ""
if RetXmlTAB ~= nil then
if RetXmlTAB.xmlType == 1 then
InstXML = getXMLNodeEntity("_InstID", encodeXML(ReturnIdentity))
elseif RetXmlTAB.xmlType == 2 and FP_ACTION == "Apply" then
if (RetXmlTAB.retCheck == nil) or (RetXmlTAB.retCheck == 1 and tError.IF_ERRORID ~= 0) or (RetXmlTAB.retCheck == 2 and tError.IF_ERRORID == 0) then
InstXML, tError = getSpecificInstXML(FP_OBJNAME, ReturnIdentity, tError, callback, transToFilterTab(t_PARA))
InstXML = getXMLNodeEntity("_InstID", encodeXML(ReturnIdentity)) .. InstXML
end
else
end
end
end
if FP_ACTION == "Cancel" then
need2Get = 0
InstXML, tError = getSpecificInstXML(FP_OBJNAME, FP_IDENTITY, nil, callback, transToFilterTab(t_PARA))
end
if need2Get == 1 then
InstXML, tError = getAllInstXML(FP_OBJNAME, ListBaseStr, nil, callback,transToFilterTab(t_PARA))
end
return InstXML,tError
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
local function getParamXML_MultiGet(tResult, paraName, i, tbParaXML)
local paraIndex = paraName .. i
if not tResult[paraIndex] then
return tbParaXML
end
local paraVal = tResult[paraIndex]
paraVal = encodeXML(paraVal)
local paraXML = getParaXMLNodeEntity(paraName, paraVal)
table.insert(tbParaXML, paraXML)
return tbParaXML
end
function getAllInstXML_MultiGet(FP_OBJNAME, PARA, preProcessInstData, queryCondition, tError)
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
return tError, ""
end
local FP_INSTNUM = tResult.MGET_INST_NUM
FP_INSTNUM = tonumber(FP_INSTNUM)
local tbInstXML = {}
for i=0, FP_INSTNUM-1 do
local tbParaXML = {}
local isOutPutXML = true
local isBreakLoop = false
if not preProcessInstData then
isOutPutXML = true
else
isOutPutXML, isBreakLoop = preProcessInstData(tResult, i)
end
if isOutPutXML then
for _,paraName in ipairs(PARA) do
tbParaXML = getParamXML_MultiGet(tResult, paraName, i, tbParaXML)
end
local instXMLStr = getXMLNodeEntity("Instance", table.concat(tbParaXML))
table.insert(tbInstXML, instXMLStr)
end
if isBreakLoop then
break
end
end
local OBJXML = getXMLNodeEntity(FP_OBJNAME, table.concat(tbInstXML));
return tError, OBJXML
end
function ChangePortName(PortName)
return PortName
end
