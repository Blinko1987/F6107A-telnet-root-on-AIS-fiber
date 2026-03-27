local logging = require"cgilua.logging"
local logapi = logapi
local function logconsole(logPattern)
return logging.new( function(self, level, message, ...)
local prepareLogMsg = logging.prepareLogMsg
if logapi ~= nil then
if level == "DEBUG" then
logapi.OssUserLogDebug(prepareLogMsg(logPattern, level, message))
elseif level == "INFO" then
logapi.OssUserLogInfo(prepareLogMsg(logPattern, level, message))
elseif level == "NOTICE" then
logapi.OssUserLogNotice(prepareLogMsg(logPattern, level, message))
elseif level == "WARN" then
logapi.OssUserLogWarn(prepareLogMsg(logPattern, level, message))
elseif level == "ERROR" then
logapi.OssUserLogError(prepareLogMsg(logPattern,level, message))
elseif level == "CRIT" then
logapi.OssUserLogCrit(prepareLogMsg(logPattern,level, message))
elseif level == "ALERT" then
logapi.OssUserLogAlert(prepareLogMsg(logPattern,level, message))
elseif level == "EMERG" then
logapi.OssUserLogEmerg(prepareLogMsg(logPattern,level, message))
elseif level == "CUSTOM" then
logapi.OssUserLogType(prepareLogMsg(logPattern,level, message), ...)
end
else
io.stdout:write(prepareLogMsg(logPattern, level, message))
end
return true
end
)
end
return logconsole
