local math = require('math')
local string = require("string")
local table = require("table")
local base = _G
module(...)
local decode_scanArray
local decode_scanComment
local decode_scanConstant
local decode_scanNumber
local decode_scanObject
local decode_scanString
local decode_scanWhitespace
local encodeString
local isArray
local isEncodable
function encode (v)
if v==nil then
return "null"
end
local vtype = base.type(v)
if vtype=='string' then
return '"' .. encodeString(v) .. '"'
end
if vtype=='number' or vtype=='boolean' then
return base.tostring(v)
end
if vtype=='table' then
local rval = {}
local bArray, maxCount = isArray(v)
if bArray then
for i = 1,maxCount do
table.insert(rval, encode(v[i]))
end
else
for i,j in base.pairs(v) do
if isEncodable(i) and isEncodable(j) then
table.insert(rval, '"' .. encodeString(i) .. '":' .. encode(j))
end
end
end
if bArray then
return '[' .. table.concat(rval,',') ..']'
else
return '{' .. table.concat(rval,',') .. '}'
end
end
if vtype=='function' and v==null then
return 'null'
end
base.assert(false,'encode attempt to encode unsupported type ' .. vtype .. ':' .. base.tostring(v))
end
function decode(s, startPos)
startPos = startPos and startPos or 1
startPos = decode_scanWhitespace(s,startPos)
base.assert(startPos<=string.len(s), 'Unterminated JSON encoded object found at position in [' .. s .. ']')
local curChar = string.sub(s,startPos,startPos)
if curChar=='{' then
return decode_scanObject(s,startPos)
end
if curChar=='[' then
return decode_scanArray(s,startPos)
end
if string.find("+-0123456789.e", curChar, 1, true) then
return decode_scanNumber(s,startPos)
end
if curChar==[["]] or curChar==[[']] then
return decode_scanString(s,startPos)
end
if string.sub(s,startPos,startPos+1)=='/*' then
return decode(s, decode_scanComment(s,startPos))
end
return decode_scanConstant(s,startPos)
end
function null()
return null
end
function encodeString(s)
s = string.gsub(s,'\\','\\\\')
s = string.gsub(s,'"','\\"')
s = string.gsub(s,'\n','\\n')
s = string.gsub(s,'\t','\\t')
return s
end
-- Determines whether the given Lua type is an array or a table / dictionary.
-- We consider any table an array if it has indexes 1..n for its n items, and no
-- other data in the table.
-- I think this method is currently a little 'flaky', but can't think of a good way around it yet...
-- @param t The table to evaluate as an array
-- @return boolean, number True if the table can be represented as an array, false otherwise. If true,
-- the second returned value is the maximum
-- number of indexed elements in the array.
function isArray(t)
-- Next we count all the elements, ensuring that any non-indexed elements are not-encodable
-- (with the possible exception of 'n')
local maxIndex = 0
for k,v in base.pairs(t) do
if (base.type(k)=='number' and math.floor(k)==k and 1<=k) then -- k,v is an indexed pair
if (not isEncodable(v)) then return false end -- All array elements must be encodable
maxIndex = math.max(maxIndex,k)
else
if (k=='n') then
if v ~= table.getn(t) then return false end -- False if n does not hold the number of elements
else -- Else of (k=='n')
if isEncodable(v) then return false end
end -- End of (k~='n')
end -- End of k,v not an indexed pair
end -- End of loop across all pairs
return true, maxIndex
end
--- Determines whether the given Lua object / table / variable can be JSON encoded. The only
-- types that are JSON encodable are: string, boolean, number, nil, table and json.null.
-- In this implementation, all other types are ignored.
-- @param o The object to examine.
-- @return boolean True if the object should be JSON encoded, false if it should be ignored.
function isEncodable(o)
local t = base.type(o)
return (t=='string' or t=='boolean' or t=='number' or t=='nil' or t=='table') or (t=='function' and o==null)
end
