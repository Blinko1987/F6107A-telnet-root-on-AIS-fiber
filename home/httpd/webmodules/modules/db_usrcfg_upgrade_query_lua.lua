local usrcfgQuery = require"modules.upgrade_query_lua"
local function callback_usrcfg(upload_status, upload_state, upgrade_msg)
local upgradeStatus = upgrade_msg.UpgardeStatus
local outTbl = {}
local upgradeStatusTbl = {
REBOOTING = {
upgrDesc = lang.UpgradeQuery_008,
needRefresh = "false",
willReboot = "true",
refreshInterval = 2000,
}
}
if "SUCC" == upload_status and upload_state == usrcfgQuery.uploadStateArray.state_WRITING_FLASH then
if upgradeStatusTbl[upgradeStatus] ~= nil then
outTbl.upgrDesc = upgradeStatusTbl[upgradeStatus].upgrDesc
outTbl.needRefresh = upgradeStatusTbl[upgradeStatus].needRefresh
outTbl.willReboot = upgradeStatusTbl[upgradeStatus].willReboot
outTbl.refreshInterval = upgradeStatusTbl[upgradeStatus].refreshInterval
end
end
return outTbl
end
usrcfgQuery.doUpgradeQuery(callback_usrcfg)
