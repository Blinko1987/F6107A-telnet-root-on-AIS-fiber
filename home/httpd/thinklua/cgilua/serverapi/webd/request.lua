local readHTTP = wsapi.read
local browerMode = wsapi.browserMode
local require = require
local string = string
local table = table
local ipairs = ipairs
local pairs = pairs
local logapi = logapi
module(...)
function translate_cookie( cookies, req )
if not cookies then
return nil
end
if req["SSL_FLAG"] == 0 then
return cookies
end
local cookie_map = {}
local stringutils = require "common_lib.string_utils"
local cookie_pairs = stringutils.split(cookies, ";")
for _, cookie_pair in ipairs(cookie_pairs) do
local nvpair = stringutils.split(cookie_pair, "=")
if #nvpair == 2 then
local name = nvpair[1]
local value = nvpair[2]
name = stringutils.trim(name)
value = stringutils.trim(value)
if name:match("_HTTPS_$") then
name = string.gsub(name, "_HTTPS_$", "")
cookie_map[name] = value
end
end
end
local cookie_pairs_trans = {}
for name,value in pairs(cookie_map) do
local nvpair = name.."="..value
table.insert(cookie_pairs_trans, nvpair)
end
local cookies_trans = table.concat(cookie_pairs_trans, "; ")
logapi.OssUserLogDebug("cookies_trans="..cookies_trans)
return cookies_trans
end
function open (req)
return {
getpostdata = function (n)
return readHTTP(req["SERVER_FD"], n)
end,
servervariable = function (n)
if n == "HTTP_COOKIE" then
return translate_cookie(req[n], req)
else
return req[n]
end
end,
browser_mode = function()
return browerMode(req["SERVER_FD"])
end
}
end
