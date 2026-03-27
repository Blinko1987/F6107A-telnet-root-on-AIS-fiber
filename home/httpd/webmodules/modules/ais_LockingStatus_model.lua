require "model.common"
local pageModel = require("model.statusPage")
local func1_model =
{
objname = "OBJ_Locking_Status_ID",
mode = "single",
para =
{
{ name="LockingStatus", label="LockingStatus_001" },
}
}
local para_model = creatModel(func1_model)
local page_attr =
{
pageId = "LockStatus",
collapBar = "LockingStatus_001",
mode = "single",
modelFile = "ais_LockingStatus_model.lua",
leftWidth = "w330",
}
curPage = pageModel:creat(para_model,page_attr)
return curPage
