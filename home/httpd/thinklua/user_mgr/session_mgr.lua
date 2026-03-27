local cgilua = cgilua.cgilua
local lfs, print, gsub, _open = require"lfs", print, string.gsub, io.open
local attributes, dir, mkdir = lfs.attributes, lfs.dir, lfs.mkdir
local remove, time = os.remove, os.time
local fileutils = require"common_lib.file_utils"
local remove_suffix_filename = fileutils.remove_suffix_filename
local assertlib = require("common_lib.assert_utils")
local typeAssert = assertlib.typeAssert
local SESSION_TABLE = {}
local SESSION_DEL_TIME = 0
local SESSION_DIR_NAME = "lua_session"
local SESSION_PATH
local SESSION_TIMEOUT = nil
local currentRequestSessIDCache
local function setSessionDir (path)
SESSION_PATH = path .. SESSION_DIR_NAME
if not attributes (SESSION_PATH, "mode") then
assert (fileutils.mkdir (SESSION_PATH))
end
end
local function setSessionTimeout(timeout)
SESSION_TIMEOUT = timeout or 600
end
local function writestring(file, str, iskey)
if iskey then
file:write(str)
else
file:write(string.format("%q", str))
end
end
local function serialize(file,o, iskey)
if type(o) == "number" then
file:write(o)
elseif type(o) == "string" then
writestring(file,o,iskey)
elseif type(o) == "table" then
for k,v in pairs(o) do
serialize(file,k, true)
file:write(" = ")
serialize(file,v, false)
file:write(",\n")
end
else
error("cannot serialize a " .. type(o))
end
end
local function writefile(filename,o)
local file = io.open(filename, "w")
if file ~= nil then
file:write("return {\n")
serialize(file, o, false)
file:write("}\n")
file:close()
end
end
local function writeSessionFile(filename,o)
o.timestamp = cmapi.timestamp()
writefile(SESSION_PATH .. "/" .. filename .. ".lua", o)
end
local function getSessionfile(sessionID)
if not sessionID then
g_logger:warn("sessionID is nil")
return
end
return string.gsub(sessionID, "%p", "_")
end
local function getSessionByFile(sessionfilename)
return remove_suffix_filename(sessionfilename)
end
local function session_checktimeout(sessionID)
local sessionfile = getSessionfile(sessionID)
if SESSION_TABLE[sessionfile] ~= nil then
local stamp = session_get(sessionID, "timestamp")
if stamp then
local timerun = cmapi.timestamp() - stamp - SESSION_TIMEOUT
if timerun > 0 then
if timerun > SESSION_DEL_TIME then
os.remove(SESSION_PATH .. "/" .. sessionfile .. ".lua")
return 98
end
return 99
end
end
return 0
else
return 100
end
end
local function isUnique( sess_id )
for i, v in pairs(SESSION_TABLE) do
if sess_id == v["sess_id"] then
return false
end
end
return true
end
local function genUniqueSessId()
local sess_id = ""
repeat
sess_id = cmapi.nocsrf.sha256(cgilua.remote_addr .. ","..cmapi.timestamp() ..",".. math.random(10000000,99999999))
until isUnique(sess_id)
g_logger:debug("new sess_id == ".. sess_id)
return sess_id
end
local function getSessionId()
local hdrCookie = cgilua.servervariable("HTTP_COOKIE")
if hdrCookie == nil or hdrCookie == "" then
g_logger:info("HTTP_COOKIE is nil, will generate a new session id")
return genUniqueSessId()
end
local iBegin, iEnd = string.find(hdrCookie, "SID=")
if iBegin == nil then
g_logger:info("SID is not in HTTP_COOKIE, will generate a new session id")
return genUniqueSessId()
else
local iPos = string.find(hdrCookie, ";", iEnd+1)
local cookieValue = ""
if iPos == nil then
cookieValue = string.sub(hdrCookie, iEnd+1)
else
cookieValue = string.sub(hdrCookie, iEnd+1, iPos-1)
end
if cookieValue==nil or string.len(cookieValue) ~= 64 then
g_logger:info("cookieValue is nok, will generate a new session id")
cookie_value = genUniqueSessId()
end
return cookieValue
end
end
local function session_checkactive(sessionID)
local ret = 0
local sessionfile = getSessionfile(sessionID)
if SESSION_TABLE[sessionfile] == nil then
ret = 100
else
if SESSION_TABLE[sessionfile]["status_login"] == nil then
ret = 100
elseif SESSION_TABLE[sessionfile]["status_login"] == "timedout" then
ret = 99
else
ret = 0
end
end
return ret
end
local function set_sess_client_cookie(cookie_name, cookie_value)
if cookie_name == nil or cookie_value == nil then
return
end
g_logger:info("cookie_name == "..cookie_name.."&& cookie_value == "..cookie_value)
sapi.Response.setcookie(cookie_name, cookie_value, 0, "/")
end
local function remove_sess_client_cookie(cookie_name)
if cookie_name == nil then
return
end
if REQUEST["SSL_FLAG"] == 1 then
cookie_name = cookie_name .. "_HTTPS_"
end
g_logger:info("cookie_name == "..cookie_name)
local cookieinfo = cookie_name .. "=;expires=Thu, 01-Jan-1970 00:00:00 GMT;path=/;"
sapi.Response.header("Set-Cookie", cookieinfo)
end
local function session_get(sessionID, key)
local sessionfile = getSessionfile(sessionID)
if SESSION_TABLE[sessionfile] ~= nil then
return SESSION_TABLE[sessionfile][key]
end
end
local function session_set(sessionID, key, value)
typeAssert(key, "string")
typeAssert(value, "string","number","nil")
local sessionfile = getSessionfile(sessionID)
if SESSION_TABLE[sessionfile] ~= nil and SESSION_TABLE[sessionfile][key] ~= value then
SESSION_TABLE[sessionfile][key] = value
writeSessionFile(sessionfile, SESSION_TABLE[sessionfile])
end
end
local function session_unset(sessionID, key, value)
session_set(sessionID, key, nil)
end
local function session_start(sessionID)
local sessionfile = getSessionfile(sessionID)
if SESSION_TABLE[sessionfile] == nil then
SESSION_TABLE[sessionfile] = {
sess_id = sessionID,
client_ip = cgilua.remote_addr
}
writeSessionFile(sessionfile, SESSION_TABLE[sessionfile])
end
end
local function session_update(sessionID)
local sessionfile = getSessionfile(sessionID)
if SESSION_TABLE[sessionfile] ~= nil then
writeSessionFile(sessionfile, SESSION_TABLE[sessionfile])
end
end
local function GetCurrentSessID()
return currentRequestSessIDCache
end
local function GetCurrentSessAttr(attrName)
local sess_id = GetCurrentSessID()
if not sess_id then
g_logger:warn("session do not exist")
return nil
end
local attrValue = session_get(sess_id, attrName)
return attrValue
end
local function SetCurrentSessAttr(attrName, attrValue)
local sess_id = GetCurrentSessID()
if not sess_id then
g_logger:warn("session do not exist")
return nil
end
session_set(sess_id, attrName, attrValue)
end
local function UnsetCurrentSessAttr(attrName)
local sess_id = GetCurrentSessID()
if not sess_id then
g_logger:warn("session do not exist")
return nil
end
session_unset(sess_id, attrName)
end
local function UpdateCurrentSess()
local sess_id = GetCurrentSessID()
if not sess_id then
g_logger:warn("session do not exist")
return nil
end
session_update(sess_id)
end
local function session_destroy(sess_id)
local sessionfile = getSessionfile(sess_id)
os.remove(SESSION_PATH .. "/" .. sessionfile .. ".lua")
SESSION_TABLE[sessionfile] = nil
if sess_id == GetCurrentSessID() then
remove_sess_client_cookie("SID")
end
end
local function filterSession(filterTbl, excludeSelf)
local outputTbl = {}
local inputTbl = filterTbl or {key="all"}
local index = 1
if inputTbl.key == "all" then
for i, v in pairs(SESSION_TABLE) do
outputTbl[index] = v["sess_id"]
index = index + 1
end
elseif inputTbl.key == "status_login"
or inputTbl.key == "client_ip" then
for i, v in pairs(SESSION_TABLE) do
if v[inputTbl.key] == inputTbl.value then
outputTbl[index] = v["sess_id"]
index = index + 1
end
end
elseif inputTbl.key == "login_right" then
for i, v in pairs(SESSION_TABLE) do
if not v.login_right
or v.status_login ~= "logined"
or session_checkactive(v.sess_id) ~= 0 then
else
local cmp, cmpReslt = inputTbl.cmp, false
if cmp == ">" then
cmpReslt = tonumber(v.login_right) > tonumber(inputTbl.value)
elseif cmp == "<" then
cmpReslt = tonumber(v.login_right) < tonumber(inputTbl.value)
elseif cmp == "=" then
cmpReslt = tonumber(v.login_right) == tonumber(inputTbl.value)
elseif cmp == ">=" then
cmpReslt = tonumber(v.login_right) >= tonumber(inputTbl.value)
elseif cmp == "<=" then
cmpReslt = tonumber(v.login_right) <= tonumber(inputTbl.value)
else
cmpReslt = false
end
g_logger:debug("cmpReslt == "..tostring(cmpReslt))
if cmpReslt then
outputTbl[index] = v["sess_id"]
index = index + 1
end
end
end
else
g_logger:debug("Unsupport inputTbl.key:  "..tostring(inputTbl.key))
end
if excludeSelf then
for i ,v in ipairs(outputTbl) do
if currentRequestSessIDCache == v then
outputTbl[i] = nil
break
end
end
end
return outputTbl, #outputTbl
end
local function session_replace(sessionID)
local oldSessionfile = getSessionfile(sessionID)
if SESSION_TABLE[oldSessionfile] ~= nil then
local newSessionID = genUniqueSessId()
local newSessionfile = getSessionfile(newSessionID)
SESSION_TABLE[newSessionfile] = SESSION_TABLE[oldSessionfile]
SESSION_TABLE[oldSessionfile] = nil
local oldSessionFilename = table.concat({SESSION_PATH, "/", oldSessionfile, ".lua"})
local newSessionFilename = table.concat({SESSION_PATH, "/", newSessionfile, ".lua"})
os.rename(oldSessionFilename, newSessionFilename)
session_set(newSessionID, "sess_id" , newSessionID)
set_sess_client_cookie("SID", newSessionID)
sessionID = newSessionID
currentRequestSessIDCache= newSessionID
end
return sessionID
end
local function session_delete()
local _, existSessNum = filterSession({key="all"}, true)
if tonumber(existSessNum) >= 99 then
local index = 0
for i, v in pairs(SESSION_TABLE) do
if (not v.login_right or (v.status_login ~= "logined" and v.status_login ~= "locked")) and index < 30 then
session_destroy(v.sess_id)
index = index + 1
end
end
end
end
local function session_init(sess_id)
local sessionfile = ""
local sessionID = sess_id
for file in dir(SESSION_PATH, SESSION_PATH) do
if file ~= "." and file ~= ".." then
sessionfile = remove_suffix_filename(file)
SESSION_TABLE[sessionfile] = dofile(SESSION_PATH .. "/" .. file)
sessionID = getSessionByFile(file)
local ret = session_checktimeout(sessionID)
if ret == 99 then
SESSION_TABLE[sessionfile]["status_login"] = "timedout"
writeSessionFile(sessionfile, SESSION_TABLE[sessionfile])
elseif ret == 98 and SESSION_TABLE[sessionfile]["status_login"] ~= "locked" then
SESSION_TABLE[sessionfile] = nil
end
end
end
session_delete()
end
local function initsession()
local sess_id = getSessionId()
if sess_id == nil or sess_id == "" then
g_logger:warn("sess_id error")
return
end
g_logger:debug("sess_id == " .. sess_id)
currentRequestSessIDCache= sess_id
setSessionDir(_G.CGILUA_TMP)
local timeout = 300
local t = cmapi.getinst("OBJ_USERIF_ID", "")
if t.IF_ERRORID == 0 then
timeout = tonumber(t.Timeout) * 60
end
setSessionTimeout(timeout)
session_init(sess_id)
return sess_id
end
local function setCaptchaImgDir(path)
path = gsub (path, "[/\\]$", "")
if not attributes (path, "mode") then
assert (mkdir (path))
end
end
cgilua.getCurrentSessID = GetCurrentSessID
cgilua.getCurrentSessAttr = GetCurrentSessAttr
cgilua.setCurrentSessAttr = SetCurrentSessAttr
_G.session_get = session_get
_G.session_set = session_set
return{
initsession = initsession,
session_start = session_start,
session_destroy = session_destroy,
session_replace = session_replace,
session_checkactive = session_checkactive,
filterSession = filterSession,
set_sess_client_cookie = set_sess_client_cookie,
remove_sess_client_cookie = remove_sess_client_cookie,
GetCurrentSessID = GetCurrentSessID,
GetCurrentSessAttr = GetCurrentSessAttr,
SetCurrentSessAttr = SetCurrentSessAttr,
UnsetCurrentSessAttr = UnsetCurrentSessAttr,
UpdateCurrentSess = UpdateCurrentSess,
setCaptchaImgDir = setCaptchaImgDir,
}
