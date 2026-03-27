local ipairs, next, pairs, tonumber, type = ipairs, next, pairs, tonumber, type
local string = string
local table = table
module (...)
function unescape (str)
str = string.gsub (str, "+", " ")
str = string.gsub (str, "%%(%x%x)", function(h) return string.char(tonumber(h,16)) end)
str = string.gsub (str, "\r\n", "\n")
return str
end
function escape (str)
str = string.gsub (str, "\n", "\r\n")
str = string.gsub (str, "([^0-9a-zA-Z ])",
function (c) return string.format ("%%%02X", string.byte(c)) end)
str = string.gsub (str, " ", "+")
return str
end
function insertfield (args, name, value)
if not args[name] then
args[name] = value
else
local t = type (args[name])
if t == "string" then
args[name] = {
args[name],
value,
}
elseif t == "table" then
table.insert (args[name], value)
else
error ("CGILua fatal error (invalid args table)!")
end
end
end
function parsequery (query, args)
if type(query) == "string" then
local insertfield, unescape = insertfield, unescape
string.gsub (query, "([^&=]+)=([^&=]*)&?",
function (key, val)
insertfield (args, unescape(key), unescape(val))
end)
end
end
function encodetable (args)
if args == nil or next(args) == nil then
return ""
end
local strp = ""
for key, vals in pairs(args) do
if type(vals) ~= "table" then
vals = {vals}
end
for i,val in ipairs(vals) do
strp = strp.."&"..escape(key).."="..escape(val)
end
end
return string.sub(strp,2)
end
