local fmQuery = require"modules.upgrade_query_lua"
local function callback_fm(upload_status, upload_state, upgrade_msg)
local upgradeStatus = upgrade_msg.UpgardeStatus
local outTbl = {}
local upgradeStatusTbl = {
SUCC = function(upgrade_msg)
local retinfo = upgrade_msg.Retinfo
if retinfo == fmQuery.retinfoArray.Retinfo_FILECHECH_OK then
return {
upgrDesc = lang.UpgradeQuery_005,
needRefresh = "true",
willReboot = "true",
refreshInterval = 2000
}
else
return {}
end
end,
REBOOTING = {
upgrDesc = lang.UpgradeQuery_009,
needRefresh = "false",
willReboot = "true",
refreshInterval = 2000,
}
}
if "SUCC" == upload_status and upload_state == fmQuery.uploadStateArray.state_WRITING_FLASH then
local upgradeStatusEntry = upgradeStatusTbl[upgradeStatus]
if upgradeStatusEntry == nil then
return {}
end
if type(upgradeStatusEntry) == "function" then
outTbl = upgradeStatusEntry(upgrade_msg)
elseif type(upgradeStatusEntry) == "table" then
outTbl = upgradeStatusEntry
else
return {}
end
end
return outTbl
end
fmQuery.doUpgradeQuery(callback_fm)
