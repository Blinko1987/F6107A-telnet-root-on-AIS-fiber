local df = require("data_assemble.dataformat")
local DataFormat = df.DataFormat
require("data_assemble.common_lua")
local util = require("data_assemble.util")
local class = util.class
local instanceof = util.instanceof
local clone = util.clone
module(..., package.seeall)
XML = class(DataFormat)
function XML.__init__(self)
DataFormat.__init__(self)
end
function XML.encode(self, string)
return encodeXML(string)
end
function XML.transElement(self, elementName, elementValue)
return "<" ..elementName .. ">" .. elementValue .. "</" .. elementName .. ">"
end
function XML._transData(self, dataSet)
local parmName = nil
local tmpValue = nil
local dataContent = ""
for dataKey, dataValue in pairs(dataSet) do
if type(dataValue) == "table" then
if type(dataKey) == "number" then
tmpValue = self:_transData(dataValue)
dataContent = dataContent .. self:transElement("Instance", tmpValue)
else
self.dataObjID = dataKey
tmpValue = self:_transData(dataValue)
dataContent = dataContent .. self:transElement(dataKey, tmpValue)
end
else
parmName = self.dataObjID .. "." ..dataKey
dataContent = dataContent .. self:transParmAndValue(parmName, self:encode(dataValue))
end
end
return dataContent
end
function XML.output(self, content, outputFunc)
return outputFunc(self:transElement("ajax_response_xml_root", content))
end
