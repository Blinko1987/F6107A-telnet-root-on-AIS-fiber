local _G, sapi = _G, sapi
local urlcode = require"cgilua.urlcode"
local lp = require"cgilua.lp"
local lfs = require"lfs"
local debug = require"debug"
local assert, error, ipairs, select, tostring, type, unpack, xpcall = assert, error, ipairs, select, tostring, type, unpack, xpcall
local pairs = pairs
local gsub, format, strfind, strlower, strsub, match = string.gsub, string.format, string.find, string.lower, string.sub, string.match
local setmetatable = setmetatable
local _open = io.open
local tinsert, tremove, concat = table.insert, table.remove, table.concat
local foreachi = table.foreachi
local date = os.date
local os_tmpname = os.tmpname
local getenv = os.getenv
local remove = os.remove
local seeall = package.seeall
local setfenv = setfenv
lp.setoutfunc ("cgilua.put")
lp.setcompatmode (false)
module (...)
_COPYRIGHT = "Copyright (C) 2003 Kepler Project"
_DESCRIPTION = "CGILua is a tool for creating dynamic Web pages and manipulating input data from forms"
_VERSION = "CGILua 5.1.3"
local _default_errorhandler = debug.traceback
local _errorhandler = _default_errorhandler
local _default_erroroutput = function (msg)
if type(msg) ~= "string" and type(msg) ~= "number" then
msg = format ("bad argument #1 to 'error' (string expected, got %s)", type(msg))
end
sapi.Response.errorlog (msg)
sapi.Response.errorlog (" ")
sapi.Response.errorlog (sapi.Request.servervariable"REMOTE_ADDR")
sapi.Response.errorlog (" ")
sapi.Response.errorlog (date())
sapi.Response.errorlog ("\n")
msg = gsub (gsub (msg, "\n", "<br>\n"), "\t", "&nbsp;&nbsp;")
sapi.Response.contenttype ("text/html")
sapi.Response.write ("<html><head><title>CGILua Error</title></head><body>" .. msg .. "</body></html>")
end
local _erroroutput = _default_erroroutput
local _default_maxfilesize = 1024 * 1024
local _maxfilesize = _default_maxfilesize
local _default_maxinput = 2048 * 1024
local _maxinput = _default_maxinput
script_path = false
function header(...)
return sapi.Response.header(...)
end
function contentheader (type, subtype)
__content_type_cache = type..'/'..subtype
end
function htmlheader()
sapi.Response.contenttype ("text/html; charset=".._G.CHARSET)
end
local htmlheader = htmlheader
function redirect (url, args)
if strfind(url,"^https?:") then
local params=""
if args then
params = "?"..urlcode.encodetable(args)
end
return sapi.Response.redirect(url..params)
else
return sapi.Response.redirect(mkabsoluteurl(mkurlpath(url,args)))
end
end
function servervariable(...)
return sapi.Request.servervariable(...)
end
function errorlog (msg, level)
local t = type(msg)
if t == "string" or t == "number" then
sapi.Response.errorlog (msg, level)
else
error ("bad argument #1 to `cgilua.errorlog' (string expected, got "..t..")", 2)
end
end
function print (...)
local args = { ... }
for i = 1, select("#",...) do
args[i] = tostring(args[i])
end
sapi.Response.write (concat(args,"\t"))
sapi.Response.write ("\n")
end
function put (...)
return sapi.Response.write(...)
end
function _geterrorhandler(msg)
return _errorhandler(msg)
end
function pcall (f)
local results = {xpcall (f, _geterrorhandler)}
local ok = results[1]
tremove(results, 1)
if ok then
if #results == 0 then results = { true } end
return unpack(results)
else
_erroroutput (unpack(results))
end
end
local function buildscriptenv()
local env = { print = _G.print, write = _M.put }
setmetatable(env, { __index = _G, __newindex = _G })
return env
end
function doscript (filename)
local f, err = _G.loadfile(filename)
if not f then
error (format ("Cannot execute `%s'. Exiting.\n%s", filename, err))
else
local env = buildscriptenv()
setfenv(f, env)
return pcall(f)
end
end
function doif (filename)
if not filename then return end
local f, err = _open(filename)
if not f then return nil, err end
f:close()
return doscript (filename)
end
function setmaxinput(nbytes)
_maxinput = nbytes
end
function setmaxfilesize(nbytes)
_maxfilesize = nbytes
end
tmp_path = _G.CGILUA_TMP or getenv("TEMP") or getenv ("TMP") or "/tmp"
tmpname = function()
local tempname = os_tmpname()
tempname = gsub(tempname, "(/tmp/)", "")
return tempname
end
local _tmpfiles = {}
function tmpfile(dir, namefunction)
dir = dir or tmp_path
namefunction = namefunction or tmpname
local tempname = namefunction()
local filename = dir.."/"..tempname
local file, err = _open(filename, "wb+")
if file then
tinsert(_tmpfiles, {name = filename, file = file})
end
return file, err
end
function handlelp (filename, env)
env = env or buildscriptenv()
htmlheader ()
lp.include (filename, env)
end
function buildplainhandler (type, subtype)
return function (filename)
local fh, err = _open (filename, "rb")
local contents = ""
if fh then
contents = fh:read("*a")
fh:close()
else
error(err)
end
header("Content-Length", #contents)
contentheader (type, subtype)
put (contents)
end
end
function buildprocesshandler (type, subtype)
return function (filename)
local env = buildscriptenv()
contentheader (type, subtype)
lp.include (filename, env)
end
end
local function buildhandlers()
local mime = _G.require "cgilua.mime"
for ext, mediatype in pairs(mime) do
local t, st = match(mediatype, "([^/]*)/([^/]*)")
addscripthandler(ext, buildplainhandler(t, st))
end
end
function mkurlpath (script, args)
local params = ""
if args then
params = "?"..urlcode.encodetable(args)
end
if strsub(script,1,1) == "/" then
return urlpath .. script .. params
else
return urlpath .. script_vdir .. script .. params
end
end
function mkabsoluteurl (path, protocol)
protocol = protocol or "http"
if path:sub(1,1) ~= '/' then
path = '/'..path
end
return format("%s://%s:%s%s",
protocol,
servervariable"SERVER_NAME",
servervariable"SERVER_PORT",
path)
end
function splitonlast (path, sep)
local dir,file = match(path,"^(.-)([^:/\\]*)$")
return dir,file
end
splitpath = splitonlast
function splitonfirst(path, sep)
local first, rest = match(path, "^/([^:/\\]*)(.*)")
return first, rest
end
local function getparams ()
local requestmethod = servervariable"REQUEST_METHOD"
POST = {}
if requestmethod == "POST" then
_G.cgilua.post.parsedata {
read = sapi.Request.getpostdata,
discardinput = ap and ap.discard_request_body,
content_type = servervariable"CONTENT_TYPE",
content_length = servervariable"CONTENT_LENGTH",
maxinput = _maxinput,
maxfilesize = _maxfilesize,
args = POST,
}
end
QUERY = {}
urlcode.parsequery (servervariable"QUERY_STRING", QUERY)
end
local _script_handlers = {}
local function default_handler (filename)
local fh, err = _open (filename, "rb")
local contents
if fh then
contents = fh:read("*a")
fh:close()
else
error(err)
end
header("Content-Length", #contents)
put ("\n")
put (contents)
end
function addscripthandler (file_extension, func)
assert (type(file_extension) == "string", "File extension must be a string")
if strfind (file_extension, '%.', 1) then
file_extension = strsub (file_extension, 2)
end
file_extension = strlower(file_extension)
assert (type(func) == "function", "Handler must be a function")
_script_handlers[file_extension] = func
end
function getscripthandler (path)
local i,f, ext = strfind (path, "%.([^.]+)$")
return _script_handlers[strlower(ext or '')]
end
function handle (path)
local h = getscripthandler (path) or default_handler
return h (path)
end
function seterrorhandler (f)
local tf = type(f)
if tf == "function" then
_errorhandler = f
else
error (format ("Invalid type: expected `function', got `%s'", tf))
end
end
function seterroroutput (f)
local tf = type(f)
if tf == "function" then
_erroroutput = f
else
error (format ("Invalid type: expected `function', got `%s'", tf))
end
end
local _close_functions = {
}
function addclosefunction (f)
local tf = type(f)
if tf == "function" then
tinsert (_close_functions, f)
else
error (format ("Invalid type: expected `function', got `%s'", tf))
end
end
local function close()
for i = #_close_functions, 1, -1 do
_close_functions[i]()
end
end
local _open_functions = {
}
function addopenfunction (f)
local tf = type(f)
if tf == "function" then
tinsert (_open_functions, f)
else
error (format ("Invalid type: expected `function', got `%s'", tf))
end
end
local function open()
for i = #_open_functions, 1, -1 do
_open_functions[i]()
end
end
local function reset ()
script_path = false
script_vpath, pdir, use_executable_name, urlpath, script_vdir, script_pdir,
script_file, authentication, app_name =
nil, nil, nil, nil, nil, nil, nil, nil, nil
_maxfilesize = _default_maxfilesize
_maxinput = _default_maxinput
_errorhandler = _default_errorhandler
_erroroutput = _default_erroroutput
_script_handlers = {}
_open_functions = {}
_close_functions = {}
foreachi(_tmpfiles, function (i, v)
v.file:close()
local _, err = remove(v.name)
if err then
error(err)
end
end)
end
function main ()
sapi = _G.sapi
addscripthandler ("lua", doscript)
addscripthandler ("lp", handlelp)
pcall (function () _G.require"cgilua.loader" end)
pcall (function () _G.require"cgilua.post" end)
if _G.cgilua.loader then
_G.cgilua.loader.init()
end
local logconsole = _G.require("cgilua.logconsole")
_G.g_logger = logconsole()
if not pcall (getparams) then return nil end
local result
if _G.cgilua.loader then
_G.cgilua.loader.run()
end
local curr_dir = lfs.currentdir ()
pcall (function () lfs.chdir (script_pdir) end)
pcall (open)
result, err = pcall (function () return handle (script_file) end)
pcall (close)
pcall (function () lfs.chdir (curr_dir) end)
reset ()
if result then
return result
end
end
