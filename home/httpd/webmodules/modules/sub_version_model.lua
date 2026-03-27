require "model.common"
local pageModel = require "model.singleConfigPage"
local func_model =
{
objname = "OBJ_SSUBVERSION_ID",
mode = "single",
para =
{
{ type="radio", name="ReuseCPE_status", label="StatusManag_022", display="" },
}
}
local para_model = creatModel(func_model)
local page_attr =
{
pageId = "SSVersion",
collapBar = "StatusManag_022",
modelLeftWidth = "w150",
modelRightWidth = "",
modelStyle = "",
mode = "single",
modelFile = "sub_version_model.lua",
pageCtrl = "refresh",
option =
{
ReuseCPE_status = { "1:" .. lang.Pinpublic_013, "0:" .. lang.Pinpublic_012 },
}
}
local curPage = pageModel:creat(para_model, page_attr)
function curPage.handleAfterGet(retTable)
if retTable.IF_ERRORID ~= 0 then
return
end
end
return curPage
