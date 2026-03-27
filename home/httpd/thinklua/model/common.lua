function removePara(para_list,name)
for i,v in ipairs(para_list) do
if para_list[i].name == name then
table.remove(para_list,i)
return
end
end
end
function disablePara(para_list,name)
for i,v in ipairs(para_list) do
if para_list[i].name == name then
para_list[i].mode = 0
return
end
end
end
function creatModel( ... )
local Model = {}
for i,v in ipairs(arg) do
table.insert(Model,v)
end
return Model
end
function dictionaryConver(table,para,type,dictionary,default)
local value
if type == "num" then
value = tonumber(table[para])
else
value = table[para]
end
if dictionary[value] then
table[para] = dictionary[value]
elseif default then
table[para] = default
end
end
function getWanLanInterfaceName()
local WanLanIFTbl = cmapi.ListIFByApp("ALLWANLAN")
local nvList = {}
for i,v in ipairs(WanLanIFTbl) do
nvList[v.InstID] = v.InstName
end
return nvList
end
function commonSendResponse(responseTab)
local cjson = require"common_lib.json"
local json_text = cjson.encode(responseTab)
cgilua.cgilua.contentheader ("application", "json; charset=" .. lang.CHARSET)
sapi.Response.write(json_text)
end
