require "model.common"
local pageModel = require("model.singleConfigPage")
local func_model =
{
objname = "OBJ_Agent_Setting_ID",
mode = "single",
para =
{
{ type="input", name="URL", label="agentSetting_002", display="", tail="",disabled=false },
{ type="radio", name="Insecure", label="agentSetting_003", display="" },
}
}
local para_model = creatModel(func_model)
local page_attr =
{
pageId = "agentSetting",
collapBar = "agentSetting_001",
modelLeftWidth = "w200",
modelRightWidth = "",
modelStyle = "",
mode = "single",
modelFile = "agent_setting_model.lua",
option =
{
Insecure= { "0:" .. lang.Pinpublic_013,"1:" .. lang.Pinpublic_012 },
}
}
local curPage = pageModel:creat(para_model,page_attr)
function curPage.handleAfterGet(retTable)
if retTable.IF_ERRORID ~= 0 then
return
end
retTable.OBJ_Agent_Setting_ID.Instance[1].URL = ""
end
return curPage
