local cbi = require("data_assemble.comapi")
local dataruleModel = require("data_assemble.datarule")
local relationruleModel = require("template.luquid_template.relationrule")
local util = require("data_assemble.util")
module(..., package.seeall)
local FunctionArea = cbi.FunctionArea
local SetArea = cbi.SetArea
local ParVerticalRadio = cbi.ParVerticalRadio
local ParRadio = cbi.ParRadio
local ParTextBox = cbi.ParTextBox
local ParPasswordText = cbi.ParPasswordText
local DataRuleRangeLength = dataruleModel.DataRuleRangeLength
local DataRuleASCII = dataruleModel.DataRuleASCII
local DataRulePasswordASCII = dataruleModel.DataRulePasswordASCII
local ApplyRelationRule = relationruleModel.ApplyRelationRule
local BrowersHideComponent = cbi.BrowersHideComponent
local functionId = "Samba"
local FP_OBJNAME = "OBJ_SAMBACFG_ID"
modelArea = FunctionArea(functionId, nil, lang.Samba_001)
g_logger:debug("_NAME ".. _NAME)
setArea = SetArea(functionId, 0, util.PathSeparatorChar.. util.luaPath2LocalPath(_NAME))
setArea.dataModel = "IGD"
EnableSmb = ParVerticalRadio(functionId, FP_OBJNAME, "EnableSmb", lang.Samba_001, {{value="on", text=lang.public_033}, {value="off", text=lang.public_034}, {value="auto", text=lang.Samba_004}})
setArea:append(EnableSmb)
AutoRun = BrowersHideComponent(functionId, FP_OBJNAME, "AutoRun")
setArea:append(AutoRun)
function modSmbGETData(self, instTable)
if instTable["AutoRun"] and instTable["AutoRun"] == "1" then
instTable["EnableSmb"] = "auto"
else
if instTable["EnableSmb"] and instTable["EnableSmb"] == "1" then
instTable["EnableSmb"] = "on"
else
instTable["EnableSmb"] = "off"
end
end
end
function modSmbPOSTData(self, instTable)
for pName,pVal in pairs(instTable) do
if pName == "EnableSmb" then
if pVal == "off" then
instTable["EnableSmb"] = 0
instTable["AutoRun"] = 0
elseif pVal == "on" then
instTable["EnableSmb"] = 1
instTable["AutoRun"] = 0
else
instTable["EnableSmb"] = 0
instTable["AutoRun"] = 1
end
end
if pName == "AuthType" and pVal == "0" then
instTable["UserName"] = nil
instTable["PassWord"] = nil
end
end
end
setArea.modInstGetData = modSmbGETData
setArea.modInstPostData = modSmbPOSTData
NetbiosName = ParTextBox(functionId, FP_OBJNAME, "NetbiosName", lang.Samba_005)
NetbiosNameValidRule=DataRuleRangeLength(true, 2, 15)
NetbiosNameValidRule:appendValidator("HostName", "true")
NetbiosNameValidRule.getTip =function(self)
return lang.public_073.. self.minLength .. " ~ " .. self.maxLength
end
NetbiosName:bindDataRule(NetbiosNameValidRule)
setArea:append(NetbiosName)
AuthType = ParRadio(functionId, FP_OBJNAME, "AuthType", lang.Samba_007, {{value="0", text=lang.public_033}, {value="1", text=lang.public_034}})
setArea:append(AuthType)
UserName = ParTextBox(functionId, FP_OBJNAME, "UserName", lang.Samba_008)
UserNameValidRule = DataRuleASCII(true, 1, 8)
UserNameValidRule.getTip =function(self)
return lang.Samba_010 .. lang.public_073.. self.minLength .. " ~ " .. self.maxLength
end
UserName:bindDataRule(UserNameValidRule)
setArea:append(UserName)
PassWord = ParPasswordText(functionId, FP_OBJNAME, "PassWord", lang.Samba_009)
PassWordValidRule = DataRulePasswordASCII(false, 0, 32)
PassWord:bindDataRule(PassWordValidRule)
setArea:append(PassWord)
local jsFunc = [[
new CheckPwdStrengthClass("OBJ_SAMBACFG_ID\\.PassWord", "OBJ_SAMBACFG_ID\\.UserName", "template_Samba");
]]
PassWord.NeedScript = true
function PassWord.getScript(self, env)
self:appendDocumentReadyScript(jsFunc)
end
ApplyRelationRule({
display = {
{
event = {
{AuthType, {"1"}},
},
action = {
{UserName, {show=true}},
{PassWord, {show=true}},
}
}
}
})
modelArea:append(setArea)
g_logger:debug("return  ".. modelArea.id .. " title " .. modelArea.title)
