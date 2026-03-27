local util = require("data_assemble.util")
local class = util.class
local instanceof = util.instanceof
local clone = util.clone
module(..., package.seeall)
Data = class()
function Data.__init__(self, compID, dataObjectID, dataField, dataRule, onGetData, onPostData)
self.compID = compID
self.dataObjctID = dataObjectID
self.dataField = dataField
self.dataRule = dataRule
self.onGetData = onGetData
self.onPostData = onPostData
self.dataValue = nil
end
function Data.setValue(self, dataValue)
self.dataValue = dataValue
end
