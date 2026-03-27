local util = require("data_assemble.util")
local class = util.class
local instanceof = util.instanceof
local clone = util.clone
module(..., package.seeall)
DataFormat = class()
function DataFormat.__init__(self)
end
function DataFormat.transParmAndValue(self, dataKey, dataValue)
return self:transElement("ParaName", dataKey) .. self:transElement("ParaValue", dataValue)
end
function DataFormat.encode(self, string)
return string
end
function DataFormat.transElement(self, elementName, elementValue)
return elementName .. ":" .. elementValue
end
function DataFormat._transData(self, dataSet)
local tmpValue = nil
local dataContent = {}
for dataKey, dataValue in pairs(dataSet) do
if type(dataValue) == "table" then
if type(dataKey) == "number" then
tmpValue = self:_transData(dataValue)
table.insert(dataContent, self:transElement("Instance", tmpValue))
else
tmpValue = self:_transData(dataValue)
table.insert(dataContent, self:transElement(dataKey, tmpValue))
end
else
table.insert(dataContent, self:transParmAndValue(dataKey, dataValue))
end
end
dataContent = table.concat(dataContent)
return dataContent
end
function DataFormat.transData(self, dataSet)
return self:_transData(dataSet)
end
function DataFormat.transRet(self, retTable)
local retContent = ""
local retTmpTable = {}
if type(retTable) ~= "table" then
return retContent
end
if retTable.IF_ERRORID ~= 0 then
if retTable.IF_ERRORSTR ~= "FAIL" then
retTable.IF_ERRORSTR = lang["cmret_"..retTable.IF_ERRORSTR] or lang.cmret_001
end
end
for k,v in pairs(retTable) do
table.insert(retTmpTable, self:transElement(k, self:encode(tostring(v))))
end
retContent = table.concat(retTmpTable)
return retContent
end
function DataFormat.output(self, content, outputFunc)
return outputFunc(content)
end
