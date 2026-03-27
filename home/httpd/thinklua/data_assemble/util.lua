local getmetatable, setmetatable = getmetatable, setmetatable
local rawget, rawset, unpack = rawget, rawset, unpack
local tostring, type, assert,print = tostring, type, assert,print
local ipairs, pairs, next, loadstring = ipairs, pairs, next, loadstring
local require, pcall, xpcall = require, pcall, xpcall
local io,table,string = io,table,string
local g_logger = g_logger
local math = math
local _G = _G
local lfs = require"lfs"
local collectgarbage= collectgarbage
module(...)
local function _instantiate(class, ...)
local inst = setmetatable({__class=class}, {__index = class})
if inst.__init__ then
inst:__init__(...)
end
return inst
end
function class(base)
return setmetatable({__parent = base}, {
__call = _instantiate,
__index = base
})
end
function instanceof(object, class)
local meta = getmetatable(object)
while meta and meta.__index do
if meta.__index == class then
return true
end
meta = getmetatable(meta.__index)
end
return false
end
