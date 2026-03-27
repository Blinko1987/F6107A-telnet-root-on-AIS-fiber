require("cgilua.config.config")
local luaTemplate = require("data_assemble.template")
local UIType =
{
["venus"] = {["module"]="template.luquid_template.venus",
["tempPath"] = "venus"}
}
local currentStyleType = LUQUID_STYLE_TYPE
if (UIType[currentStyleType] == nil) then
currentStyleType = "venus"
end
luaTemplate.setTemplatePath(UIType[currentStyleType]["tempPath"])
return require(UIType[currentStyleType]["module"])
