require"cgilua.readuntil"
require"cgilua.urlcode"
local assert, error, pairs, tonumber, tostring, type = assert, error, pairs, tonumber, tostring, type
local getn, tinsert, tconcat = table.getn, table.insert, table.concat
local format, gsub, strfind, strlower, strlen = string.format, string.gsub, string.find, string.lower, string.len
local min = math.min
local iterate = cgilua.readuntil.iterate
local urlcode = cgilua.urlcode
local tmpfile = cgilua.tmpfile
local boundary = nil
local maxfilesize = nil
local maxinput = nil
local inputfile = nil
local bytesleft = nil
local content_type = nil
local discardinput = nil
local readuntil = nil
local read = nil
local _open = io.open
local _G, sapi = _G, sapi
local cgilua = cgilua
module (...)
local function init (defs)
assert (defs.read)
read = defs.read
readuntil = iterate (function ()
if bytesleft then
if bytesleft <= 0 then return nil end
local n = min (bytesleft, 2^13)
local bytes = read (n)
bytesleft = bytesleft - #bytes
return bytes
end
end)
readfully = function ( nwant )
local nread = 0
local buffer = {}
local nleft = 0
local nmin = 0
local bytes = ""
local nbytes = 0
while true do
nleft = nwant - nread
if nleft <= 0 then
break
end
nmin = min (nleft, 2^13)
bytes = read (nmin)
nbytes = #bytes
tinsert( buffer, bytes )
nread = nread + nbytes
end
return tconcat(buffer)
end
if defs.discard_function then
discardinput = defs.discardinput
else
discardinput = function (inputsize)
readuntil ('\0', function()end)
end
end
content_type = defs.content_type
if defs.maxinput then
maxinput = defs.maxinput
end
if defs.maxfilesize then
maxfilesize = defs.maxfilesize
end
end
function parsedata (defs)
assert (type(defs.args) == "table", "field 'args' must be a table")
init (defs)
local contenttype = content_type
if not contenttype then
error("Undefined Media Type")
end
if strfind(contenttype, "multipart/form-data", 1, true) then
return
end
local inputsize = tonumber(defs.content_length) or 0
if inputsize > maxinput then
_G.g_logger:warn("content length("..inputsize..") exceed limit("..maxinput..")")
bytesleft = inputsize
return
end
if strfind(contenttype, "x-www-form-urlencoded", 1, true) then
urlcode.parsequery (readfully (inputsize), defs.args)
elseif strfind (contenttype, "application/xml", 1, true) or strfind (contenttype, "text/xml", 1, true) or strfind (contenttype, "text/plain", 1, true) then
tinsert (defs.args, readfully (inputsize))
elseif strfind (contenttype, "application/json", 1, true) then
defs.args["json"] = readfully (inputsize)
else
error("Unsupported Media Type: "..contenttype)
end
end
