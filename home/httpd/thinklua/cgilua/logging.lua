local type, table, string, _tostring, tonumber = type, table, string, tostring, tonumber
local select = select
local error = error
local format = string.format
local debug = debug
local _G = _G
module(...)
_COPYRIGHT = "Copyright (C) 2004-2011 Kepler Project"
_DESCRIPTION = "A simple API to use logging features in Lua"
_VERSION = "LuaLogging 1.2.0"
EMERG = "EMERG"
ALERT = "ALERT"
CRIT = "CRIT"
ERROR = "ERROR"
WARN = "WARN"
NOTICE = "NOTICE"
INFO = "INFO"
DEBUG = "DEBUG"
local LEVEL = {"DEBUG","INFO","NOTICE", "WARN","ERROR","CRIT", "ALERT", "EMERG","CUSTOM"}
local MAX_LEVELS = #LEVEL
for i=1,MAX_LEVELS do
LEVEL[LEVEL[i]] = i
end
local function LOG_MSG(self, level, fmt, ...)
local f_type = type(fmt)
if f_type == 'string' then
if select('#', ...) > 0 then
if level == "CUSTOM" then
return self:append(level, fmt, ...)
else
return self:append(level, format(fmt, ...))
end
else
return self:append(level, fmt)
end
elseif f_type == 'function' then
return self:append(level, fmt(...))
end
return self:append(level, tostring(fmt))
end
local LEVEL_FUNCS = {}
for i=1,MAX_LEVELS do
local level = LEVEL[i]
LEVEL_FUNCS[i] = function(self, ...)
return LOG_MSG(self, level, ...)
end
end
local function disable_level() end
local function assert(exp, ...)
if exp then return exp, ... end
error(format(...), 2)
end
function new(append)
if type(append) ~= "function" then
return nil, "Appender must be a function."
end
local logger = {}
logger.append = append
logger.setLevel = function (self, level)
local order = LEVEL[level]
assert(order, "undefined level `%s'", _tostring(level))
self.level = level
self.level_order = order
for i=1,MAX_LEVELS do
local name = LEVEL[i]:lower()
if i >= order then
self[name] = LEVEL_FUNCS[i]
else
self[name] = disable_level
end
end
end
logger.log = function (self, level, ...)
local order = LEVEL[level]
assert(order, "undefined level `%s'", _tostring(level))
if order < self.level_order then
return
end
return LOG_MSG(self, level, ...)
end
logger:setLevel(_G.LOG_LEVEL)
return logger
end
function prepareLogMsg(pattern, level, message)
local logMsg = pattern or "%detail %message\n"
message = string.gsub(message, "%%", "%%%%")
local detail = debug.getinfo(5)
local name = detail.name
if name == nil then
name = "NIL"
end
logMsg = string.gsub(logMsg, "%%detail", "[" ..
string.gsub(string.gsub(detail.source, "@", ""),
".*[\\/]", "") .. "(" .. detail.currentline ..")" .. name ..
"]")
logMsg = string.gsub(logMsg, "%%message", message)
return logMsg
end
function tostring(value)
local str = ''
if (type(value) ~= 'table') then
if (type(value) == 'string') then
str = string.format("%q", value)
else
str = _tostring(value)
end
else
local auxTable = {}
table.foreach(value, function(i, v)
if (tonumber(i) ~= i) then
table.insert(auxTable, i)
else
table.insert(auxTable, tostring(i))
end
end)
table.sort(auxTable)
str = str..'{'
local separator = ""
local entry = ""
table.foreachi (auxTable, function (i, fieldName)
if ((tonumber(fieldName)) and (tonumber(fieldName) > 0)) then
entry = tostring(value[tonumber(fieldName)])
else
entry = fieldName.." = "..tostring(value[fieldName])
end
str = str..separator..entry
separator = ", "
end)
str = str..'}'
end
return str
end
