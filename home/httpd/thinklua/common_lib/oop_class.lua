local _M = {}
local function _instantiate(class, ...)
local asbtract = class.__prototype.__abstract
if asbtract then
error("asbtract class cannot be instantiated.")
end
local singleton = class.__prototype.__singleton
if singleton then
if _G[class] then
return _G[class]
end
end
local inst = setmetatable({__class=class}, {__index=class})
if inst.__init__ then
inst:__init__(...)
end
if singleton then
if not _G[class] then
_G[class] = inst
class.__prototype.getInstance = function ( self )
return _G[class]
end
class.__prototype.destroyInstance = function ( self )
_G[class] = nil
end
end
end
return inst
end
function _M.class(base)
local metatable = {
__call = _instantiate,
}
metatable.__index=function(t, k)
local v = t.__prototype[k]
if v then
return v
end
local parent = t.__parent
if parent then
return parent[k]
end
return nil
end
metatable.__newindex=function (t,k,v)
t.__prototype[k] = v
end
local _class = {}
_class.__parent = base or {}
_class.__prototype = {}
_class.__metatable = metatable
_class.freeze = function ( self )
local mt = getmetatable(self)
mt.__newindex=function (t,k,v)
error("class is frozen, cannot revise")
end
end
return setmetatable(_class, metatable)
end
function _M.instanceof(object, class)
local objClass = object.__class
if not objClass then
return false
end
while objClass do
if objClass == class then
return true
end
objClass = objClass.__parent
end
return false
end
return _M
