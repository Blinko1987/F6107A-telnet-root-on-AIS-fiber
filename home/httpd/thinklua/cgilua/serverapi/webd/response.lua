local writeHTTP = wsapi.write
local writeHeader = wsapi.writeHeader
local set_cookie = wsapi.set_cookie
local set_hc = wsapi.set_hc
local errorLog = wsapi.errlog
local string = string
module(...)
function open (req)
return {
contenttype = function (s)
writeHeader (req["SERVER_FD"],"Content-Type: "..s)
end,
redirect = function (s)
writeHTTP (req["SERVER_FD"],"Location: "..s.."\n\n")
end,
header = function (h, v)
writeHeader (req["SERVER_FD"],string.format ("%s: %s", h, v))
end,
setcookie = function(cookie_name, cookie_value, expire, path)
if req["SSL_FLAG"] == 1 then
cookie_name = cookie_name .. "_HTTPS_"
end
set_cookie(req["SERVER_FD"], string.format("%s", cookie_name), string.format("%s", cookie_value),
expire, string.format("%s", path))
end,
statusline = function (s)
writeHeader (req["SERVER_FD"],s)
end,
write = function (s)
writeHTTP (req["SERVER_FD"],s)
end,
sethc = function (p,v)
set_hc (req["SERVER_FD"],p,v)
end,
errorlog = function (s)
errorLog (s)
end
}
end
