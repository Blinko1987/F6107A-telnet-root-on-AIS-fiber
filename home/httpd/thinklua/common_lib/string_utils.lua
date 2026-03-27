local function split(str, pat, max, regex)
pat = pat or "\n"
max = max or #str
local t = {}
local c = 1
if #str == 0 then
return {""}
end
if #pat == 0 then
return nil
end
if max == 0 then
return str
end
repeat
local s, e = str:find(pat, c, not regex)
max = max - 1
if s and max < 0 then
t[#t+1] = str:sub(c)
else
t[#t+1] = str:sub(c, s and s - 1)
end
c = e and e + 1 or #str + 1
until not s or max < 0
return t
end
local function stringIsEmpty(str)
if str == nil or str == "" then
return true
else
return false
end
end
local function trim(str)
return (str:gsub("^%s*(.-)%s*$", "%1"))
end
string.split = split
local function charCountInString(str)
local _,n=str:gsub("[\194-\244][\128-\191]*",'')
return #str-n*2
end
local utilModule = require("data_assemble.util")
utilModule.charCountInString = charCountInString
utilModule.split = split
utilModule.stringIsEmpty = stringIsEmpty
return {
charCountInString = charCountInString,
trim = trim,
split = split,
stringIsEmpty = stringIsEmpty,
}
