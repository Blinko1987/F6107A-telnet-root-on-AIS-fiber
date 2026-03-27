local util = require("data_assemble.util")
local class = util.class
local instanceof = util.instanceof
local clone = util.clone
local g_logger = g_logger
local template = require("data_assemble.template")
module(..., package.seeall)
RelationRule = class()
function RelationRule.__init__(self, tbRules)
if type(tbRules) ~= "table" then
g_logger:warn("tbRules must be table")
return
end
self.masterObjs = {}
self.masterIDs = {}
self.displayRule = tbRules.display or {}
self:translateRule(self.displayRule)
self.setOptionsRule = tbRules.setOptions or {}
self:translateRule(self.setOptionsRule)
self.setValueRule = tbRules.setValue or {}
self:translateRule(self.setValueRule)
self.rendered = false
end
function RelationRule.translateRule(self, tbRule)
if type(tbRule) ~= "table" then
g_logger:warn("tbRules must be table")
return
end
tbRule.IDVersion = {}
tbRule.masterObjs = {}
local lookup_table = {}
tbRule.masterIDs = {}
tbRule.slaveIDs = {}
for _,item in ipairs(tbRule) do
local event = {}
if item.event ~= "others" then
for _, objVals in ipairs(item.event) do
local obj = objVals[1]
local vals = objVals[2]
local ctrlID = obj.id
event[ctrlID] = vals
lookup_table = {}
if lookup_table[obj] == nil then
table.insert(tbRule.masterObjs, obj)
table.insert(self.masterObjs, obj)
table.insert(tbRule.masterIDs, obj.id)
table.insert(self.masterIDs, obj.id)
lookup_table[obj] = true
end
end
else
event = "others"
end
local action = {}
for _, objResult in ipairs(item.action) do
local obj = objResult[1]
local result = objResult[2]
local ctrlID = obj.id
action[ctrlID] = result
lookup_table = {}
if lookup_table[obj] == nil then
table.insert(tbRule.slaveIDs, obj.id)
lookup_table[obj] = true
end
end
local onerule = {["event"]=event, ["action"]=action}
table.insert(tbRule.IDVersion, onerule)
end
end
function RelationRule.renderRuleScript(self, env)
if self.rendered then
return;
end
self.template = "RelationRule"
self.temp = self.temp or template.Template(self.template)
env.__ClassScriptRenderTbl = env.__ClassScriptRenderTbl or {}
if not env.__ClassScriptRenderTbl[self.template] then
local classScript = self.temp:getScriptClass(self, env)
table.insert(env.__script, classScript)
env.__ClassScriptRenderTbl[self.template] = true
end
env.util = util
local tmpScript = self.temp:getScript(self, env)
table.insert(env.__script, tmpScript)
self.rendered = true
end
function ApplyRelationRule(tbRules)
local rules = RelationRule(tbRules)
for _, masterObj in ipairs(rules.masterObjs) do
masterObj:bindRelationRule(rules)
end
end
