require "model.common"
local pageModel = require "model.singleConfigPage"
local func_model =
{
objname = "OBJ_SSH_ENABLE_ID",
mode = "single",
para =
{
{ type="radio", name="Enable", label="malay_SSH_01", display="" },
}
}
local para_model = creatModel(func_model)
local page_attr =
{
pageId = "mSSHCfg",
collapBar = "malay_SSH_02",
modelLeftWidth = "w150",
modelRightWidth = "",
modelStyle = "",
mode = "single",
modelFile = "malay_ssh_enable_model.lua",
option =
{
Enable = { "1:" .. lang.public_033, "0:" .. lang.public_034 },
}
}
local curPage = pageModel:creat(para_model, page_attr)
function curPage.handleAfterGet(retTable)
if retTable.IF_ERRORID ~= 0 then
return
end
end
return curPage
