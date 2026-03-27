local function typeAssert(target, argtype, ...)
local types = {argtype, ...}
local targetType = type(target)
for _, v in ipairs(types) do
if targetType == v then
return
end
end
assert(false, "target ("..tostring(target)..")'s type(".. targetType ..") is wrong!")
end
local function valueAssert(target, argvalue, ...)
local values = {argvalue, ...}
local legalVal = {}
for _, v in ipairs(values) do
if target == v then
return
end
table.insert(legalVal, v)
end
assert(false, "target ("..tostring(target)..") value is wrong! It should be one of: "..table.concat(legalVal,', '))
end
return {
typeAssert = typeAssert,
valueAssert = valueAssert
}
