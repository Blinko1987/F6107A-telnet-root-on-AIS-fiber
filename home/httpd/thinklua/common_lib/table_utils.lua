local function clone(object, deep)
local copy = {}
for k, v in pairs(object) do
if deep and type(v) == "table" then
v = clone(v, deep)
end
copy[k] = v
end
return setmetatable(copy, getmetatable(object))
end
local function writestring(file, str, iskey)
if iskey then
file:write(" [\"")
file:write(str)
file:write("\"]")
else
file:write(string.format([[%q]], str))
end
end
local function serialize(file, o, iskey)
if type(o) == "number" then
file:write(o)
elseif type(o) == "string" then
writestring(file,o,iskey)
elseif type(o) == "table" then
file:write("{")
for k,v in pairs(o) do
if type(k) == "string" then
serialize(file,k, true)
file:write("=")
end
serialize(file,v, false)
file:write(",")
end
file:write("}")
else
g_logger:warn("cannot serialize a " .. type(o))
end
end
local function serializeIndexTable(file, o, iskey)
if type(o) == "number" then
file:write(o)
elseif type(o) == "string" then
writestring(file,o,iskey)
elseif type(o) == "nil" then
file:write(type(o))
elseif type(o) == "table" then
file:write("{")
for i=1,table.maxn(o) do
serializeIndexTable(file,o[i], false)
file:write(",")
end
for k,v in pairs(o) do
if type(k) == "string" or type(k) == "number" then
writestring(file, k, true)
file:write("=")
serializeIndexTable(file, v, false)
file:write(",")
end
end
file:write("}")
else
g_logger:warn("cannot serialize a " .. type(o))
end
end
local function _write(self, content)
print(content)
self:write(content)
end
local function writeIndexTablefile(filename,o)
local file = io.open(filename, "w")
file:write("return \n")
serializeIndexTable(file, o, false)
file:write("\n")
file:close()
end
local function writefile(filename,o)
local file = io.open(filename, "w")
file:write("return \n")
serialize(file, o, false)
file:write(" \n")
file:close()
end
local function printTable(tb, deep)
if type(tb) ~= "table" then
return
end
print("{")
for k,v in pairs(tb) do
print("  K:" .. tostring(k ).."\n  V:")
if type(v) == "table" then
if type(deep) == "boolean" and deep then
printTable(v, deep)
elseif type(deep) == "number" then
deep = deep - 1
if deep > 0 then
printTable(v, deep)
else
print(tostring(v)," <--- It still have nested sub_tables.")
end
end
else
print(tostring(v))
end
end
print("}")
end
local function merge(destTb, srcTb)
for k, v in pairs(srcTb) do
if type(v) == "table" then
destTb[k] = clone(v, true)
else
destTb[k] = v
end
end
return destTb
end
local function mergeByVal(destTb, srcTb)
for k, v in pairs(srcTb) do
if type(v) == "table" then
local tbl = clone(v, true)
table.insert(destTb, tbl)
else
table.insert(destTb, v)
end
end
return destTb
end
local function removeTableOfLuaPath( path )
if type(path) ~= "string" then
return false
end
local util = require("common_lib.string_utils")
local pathSeqArr = util.split(path, ".")
if not pathSeqArr then
return false
end
local arrLen = #pathSeqArr
local tableName = pathSeqArr[arrLen]
table.remove(pathSeqArr, arrLen)
arrLen = #pathSeqArr
local env = _G
local pathName
for i=1,arrLen do
pathName = pathSeqArr[i]
env = env[pathName]
if not env then
return false
end
end
env[tableName] = nil
return true
end
local utilModule = require("data_assemble.util")
utilModule.mergeByVal = mergeByVal
utilModule.merge = merge
utilModule.printTable = printTable
utilModule.writefile = writefile
utilModule.writeIndexTablefile = writeIndexTablefile
utilModule.serializeIndexTable = serializeIndexTable
utilModule.serialize = serialize
utilModule.clone = clone
return {
mergeByVal = mergeByVal,
merge = merge,
printTable = printTable,
writefile = writefile,
writeIndexTablefile = writeIndexTablefile,
serializeIndexTable = serializeIndexTable,
serialize = serialize,
clone = clone,
removeTableOfLuaPath = removeTableOfLuaPath
}
