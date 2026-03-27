local utilsString = require("common_lib.string_utils")
function buildTextDiv(paraNode, selfNode)
local htmlList = {}
local htmlStr
local labelName
local labelStyle
if paraNode.label ~= nil then
labelName = lang[paraNode.label]
end
if selfNode.modelLeftWidth ~= nil or selfNode.modelRightWidth ~= nil then
labelStyle = selfNode.modelLeftWidth .. " " .. selfNode.modelRightWidth
end
if paraNode.type == "text" then
if paraNode.style == "label" then
htmlStr = string.format("<label class='cfgLabel %s'>%s</label>", labelStyle, labelName)
table.insert(htmlList, htmlStr)
end
if paraNode.style == "bold" then
htmlStr = string.format("<b>%s</b>", labelName)
table.insert(htmlList, htmlStr)
end
if paraNode.class == "OperationWarn" then
htmlStr = string.format("<div class='OperationWarn'>")
table.insert(htmlList, htmlStr)
if selfNode.option[paraNode.class] ~= nil then
local optionStr = selfNode.option[paraNode.class]
for key,value in pairs(optionStr) do
htmlStr = string.format("<p class='row'>%s</p>", optionStr[key])
table.insert(htmlList, htmlStr)
end
end
table.insert(htmlList, "</div>")
end
else
htmlStr = string.format("<label for='%s' class='cfgLabel %s' style='%s'>%s</label>", paraNode.name, labelStyle, selfNode.modelStyle, labelName)
table.insert(htmlList, htmlStr)
end
return table.concat(htmlList, "\n")
end
function buildRadioDiv(paraNode, selfNode)
local htmlList = {}
local htmlStr
if paraNode.type ~= "radio" then
return ""
end
htmlStr = string.format("<div class='right' id='%s'>", paraNode.name)
table.insert(htmlList, htmlStr)
if selfNode.option[paraNode.name] ~= nil then
local optionStr = selfNode.option[paraNode.name]
for key,value in pairs(optionStr) do
local splitStr = utilsString.split(value, ":")
htmlStr = string.format("<input type='radio' id='%s%s' name='%s' value='%s' ",paraNode.name, splitStr[1], paraNode.name, splitStr[1])
table.insert(htmlList, htmlStr)
if paraNode.disabled == true then
htmlStr = string.format("<input type='radio' id='%s%s' name='%s' value='%s' class='PostIgnore' disabled='disabled'/><label for='%s%s'>%s</label>&nbsp;&nbsp;",paraNode.name, splitStr[1], paraNode.name, splitStr[1], paraNode.name, splitStr[1], splitStr[2])
else
htmlStr = string.format("<input type='radio' id='%s%s' name='%s' value='%s'/><label for='%s%s'>%s</label>&nbsp;&nbsp;", paraNode.name, splitStr[1], paraNode.name, splitStr[1], paraNode.name, splitStr[1], splitStr[2])
end
table.insert(htmlList, htmlStr)
end
end
table.insert(htmlList, "</div>")
return table.concat(htmlList, "\n")
end
function buildSelectDiv(paraNode, selfNode)
local htmlList = {}
local htmlStr
if paraNode.type ~= "select" then
return ""
end
htmlStr = string.format("<div class='right'>")
table.insert(htmlList, htmlStr)
if paraNode.disabled == true then
htmlStr = string.format("<select class='selectNorm PostIgnore' id='%s' name='%s' disabled='disabled'>", paraNode.name, paraNode.name)
else
htmlStr = string.format("<select class='selectNorm' id='%s' name='%s'>", paraNode.name, paraNode.name)
end
table.insert(htmlList, htmlStr)
if selfNode.option[paraNode.name] ~= nil then
local optionStr = selfNode.option[paraNode.name]
for key,value in pairs(optionStr) do
local splitStr = utilsString.split(value, ":")
if splitStr[1] ~= "CreateIFOpStr" then
if key == 1 then
htmlStr = string.format("<option value='%s' title='%s' selected='selected'>%s</option>", splitStr[1], splitStr[2], splitStr[2])
table.insert(htmlList, htmlStr)
else
htmlStr = string.format("<option value='%s' title='%s'>%s</option>", splitStr[1], splitStr[2], splitStr[2])
table.insert(htmlList, htmlStr)
end
else
htmlStr = string.format(splitStr[2])
table.insert(htmlList, htmlStr)
end
end
end
table.insert(htmlList, "</select>")
table.insert(htmlList, "</div>")
return table.concat(htmlList, "\n")
end
function buildInputDiv(paraNode)
local htmlList = {}
local htmlStr
if paraNode.type ~= "input" then
return ""
end
htmlStr = string.format("<div class='right'>")
table.insert(htmlList, htmlStr)
if paraNode.disabled == true then
htmlStr = string.format("<input type='text' class='inputNorm PostIgnore' id='%s' name='%s' value='' disabled='disabled'/>&nbsp;%s", paraNode.name, paraNode.name, paraNode.tail)
else
htmlStr = string.format("<input type='text' class='inputNorm' id='%s' name='%s' value='' />&nbsp;%s", paraNode.name, paraNode.name, paraNode.tail)
end
table.insert(htmlList, htmlStr)
if paraNode.dTipName ~= nil then
htmlStr = string.format("<span class='dTip' style='display: none;'>%s%s</span>", paraNode.dTipName, paraNode.dTipStr)
table.insert(htmlList, htmlStr)
end
table.insert(htmlList, "</div>")
return table.concat(htmlList, "\n")
end
