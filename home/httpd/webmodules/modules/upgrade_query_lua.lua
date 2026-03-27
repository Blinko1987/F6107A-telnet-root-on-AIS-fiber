require"data_assemble.common_lua"
local uploadStatusArray = {
status_SUCC = "SUCC",
status_CHECK_ERROR = "414",
status_UPLOAD_ERROR = "412",
status_NAME_ERROR = "404",
}
local uploadStateArray ={
state_INIT = "0",
state_UPLOADING = "1",
state_WRITING_FLASH = "2",
state_REBOOTING = "3",
state_DOWNLOADING = "4",
state_UPLOAD_FINISH = "5",
}
local percentArray = {
Percent_NO_ERROR = "500",
Percent_INTEGRITY_ERROR = "508",
}
local retinfoArray = {
Retinfo_DOWNLOAD_OK = "501",
Retinfo_FILECHECH_OK = "502",
Retinfo_FILEFLASH_OK = "503",
}
local function checkUpgradeStatus (upload_state, upgrade_msg)
local outTbl = {}
local upgradeStatus = upgrade_msg.UpgardeStatus
local upgradeStatusTbl =
{
SUCC = {
upgrDesc = lang.UpgradeQuery_010,
needRefresh = "true",
willReboot = "false",
},
UPLOAD_FINISH = {
upgrDesc = lang.UpgradeQuery_007,
needRefresh = "false",
willReboot = "false",
},
REBOOTING = {
upgrDesc = lang.UpgradeQuery_007,
needRefresh = "false",
willReboot = "false",
},
default = {
upgrDesc = function()
local percent = upgrade_msg.Percent
if percent == percentArray.Percent_INTEGRITY_ERROR then
return lang.UpgradeQuery_004
else
return lang.UpgradeQuery_003
end
end,
needRefresh = "false",
willReboot = "false",
}
}
if upload_state == uploadStateArray.state_WRITING_FLASH then
if upgradeStatusTbl[upgradeStatus] == nil then
upgradeStatus = "default"
end
if type(upgradeStatusTbl[upgradeStatus].upgrDesc) == "function" then
outTbl.upgrDesc = upgradeStatusTbl[upgradeStatus].upgrDesc()
else
outTbl.upgrDesc = upgradeStatusTbl[upgradeStatus].upgrDesc
end
outTbl.needRefresh = upgradeStatusTbl[upgradeStatus].needRefresh
outTbl.willReboot = upgradeStatusTbl[upgradeStatus].willReboot
end
return outTbl
end
local function checkUploadStatus(upload_status, upload_state, upgrade_msg)
local outTbl = {}
local refreshInterval = 2000
local upload_statusTbl =
{
[uploadStatusArray.status_SUCC] = checkUpgradeStatus,
[uploadStatusArray.status_CHECK_ERROR] = {
upgrDesc = lang.UpgradeQuery_001,
needRefresh = "false",
willReboot = "false",
},
default = {
upgrDesc = lang.UpgradeQuery_003,
needRefresh = "false",
willReboot = "false",
},
}
local upload_statusEntry = upload_statusTbl[upload_status]
if upload_statusEntry == nil then
upload_status = "default"
upload_statusEntry = upload_statusTbl[upload_status]
end
if type(upload_statusEntry) == "function" then
outTbl = upload_statusEntry(upload_state, upgrade_msg)
else
outTbl.upgrDesc = upload_statusEntry.upgrDesc
outTbl.needRefresh = upload_statusEntry.needRefresh
outTbl.willReboot = upload_statusEntry.willReboot
end
outTbl.refreshInterval = refreshInterval
return outTbl
end
local function clearUgradeEnv(upload_status, upload_state, upgradeStatus)
if upload_status ~= uploadStatusArray.status_SUCC then
env.unsetenv("status")
env.unsetenv("state")
env.unsetenv("type")
end
if upload_state == uploadStateArray.state_WRITING_FLASH then
if upgradeStatus ~= "SUCC"
or upgradeStatus == "UPLOAD_FINISH"
or upgradeStatus == "REBOOTING" then
env.unsetenv("status")
env.unsetenv("state")
env.unsetenv("type")
end
end
end
local function outUpdResult(outTbl)
local ErrorXML = ""
local InstXML = ""
local OutXML = ""
local xmlStrTmp = ""
if outTbl == nil then
g_logger:info("outTbl is nil")
return
end
for i,v in pairs(outTbl) do
xmlStrTmp = xmlStrTmp .. getParaXMLNodeEntity(i, encodeXML(v))
end
xmlStrTmp = getXMLNodeEntity("Instance", xmlStrTmp)
InstXML = getXMLNodeEntity("OBJ_FAKE_UPGR_ID", xmlStrTmp)
local xmlError = {
IF_ERRORID = 0,
IF_ERRORTYPE = "SUCC",
IF_ERRORSTR = "SUCC",
IF_ERRORPARAM = "SUCC"
}
ErrorXML = outputErrorXML(xmlError)
OutXML = ErrorXML .. InstXML
outputXML(OutXML)
end
local function doUpgradeQuery(callback)
local upload_status = env.getenv("status")
local upload_state = env.getenv("state")
local upgrade_msg = cmapi.getinst("OBJ_UPGRADE_ID", "IGD")
local outTbl = {}
local upgradeStatus = upgrade_msg.UpgardeStatus
clearUgradeEnv(upload_status, upload_state, upgradeStatus)
if callback and type(callback) == "function" then
outTbl = callback(upload_status, upload_state, upgrade_msg)
end
if next(outTbl) == nil then
outTbl = checkUploadStatus(upload_status, upload_state, upgrade_msg)
end
outUpdResult(outTbl)
end
return {
uploadStateArray = uploadStateArray,
retinfoArray = retinfoArray,
doUpgradeQuery = doUpgradeQuery,
}
