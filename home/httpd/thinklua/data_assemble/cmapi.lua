local cgilua = cgilua.cgilua
local tSUCC = {
IF_ERRORID = 0,
IF_ERRORSTR = "SUCC",
IF_ERRORPARAM = "SUCC",
IF_ERRORTYPE = "-1"
}
local function checkSessionToken()
local tErrorCSRF = {
IF_ERRORID = -1452,
IF_ERRORSTR = "1452",
IF_ERRORPARAM = "SUCC",
IF_ERRORTYPE = "-1"
}
local sess_id = cgilua.getCurrentSessID()
local clientToken = cgilua.POST._sessionTOKEN
clientToken = clientToken or cgilua.QUERY._sessionTOKEN
local serverToken = session_get(sess_id, "sess_token")
if clientToken ~= nil then
if clientToken == serverToken then
return tSUCC
end
end
g_logger:debug("serverToken="..tostring(serverToken).."&clientToken="..tostring(clientToken))
return tErrorCSRF
end
local function makeSafefunc(f)
local function safeFunc (...)
local tCheck = checkSessionToken()
if tCheck.IF_ERRORID ~= 0 then
_G.g_logger:warn("csrf checkSessionToken failed or this function is not need to check csrf")
return tCheck
end
return f(...)
end
return safeFunc
end
cmapi = {
getinst = cmapi_inner_cmapi.getinst,
querylist = cmapi_inner_cmapi.querylist,
queryobj = cmapi_inner_cmapi.queryobj,
queryiModType = cmapi_inner_cmapi.queryiModType,
login = cmapi_inner_cmapi.login,
undoDBSave = cmapi_inner_cmapi.undoDBSave,
get_IPMode = cmapi_inner_cmapi.get_IPMode,
IsWANAccess = cmapi_inner_cmapi.IsWANAccess,
file_exists = cmapi_inner_cmapi.file_exists,
set_webParams = cmapi_inner_cmapi.set_webParams,
ListIFByApp = cmapi_inner_cmapi.ListIFByApp,
show_log = cmapi_inner_cmapi.show_log,
timestamp = cmapi_inner_cmapi.timestamp,
wlanswitch = cmapi_inner_cmapi.wlanswitch,
get_real_path = cmapi_inner_cmapi.get_real_path,
get_uplink = cmapi_inner_cmapi.get_uplink,
encodeXml = cmapi_inner_cmapi.encodeXml,
md5 = cmapi_inner_cmapi.md5,
decodebase64 = cmapi_inner_cmapi.decodebase64,
ListServCtlByMode= cmapi_inner_cmapi.ListServCtlByMode,
ListFwProtByAppMode = cmapi_inner_cmapi.ListFwProtByAppMode,
ListSntpTimeZoneMAp = cmapi_inner_cmapi.ListSntpTimeZoneMAp,
ListServlist = cmapi_inner_cmapi.ListServlist,
randomseed = cmapi_inner_cmapi.randomseed
}
cmapi.nocsrf = cmapi_inner_cmapi
for k,v in pairs(cmapi.nocsrf) do
if cmapi[k] == nil and v then
cmapi[k] = makeSafefunc(v)
end
end
