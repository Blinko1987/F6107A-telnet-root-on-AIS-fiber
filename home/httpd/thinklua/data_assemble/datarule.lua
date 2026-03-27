local util = require("data_assemble.util")
local class = util.class
local instanceof = util.instanceof
local clone = util.clone
local g_logger = g_logger
module(..., package.seeall)
DataRule = class()
function DataRule.__init__(self, isRequired)
self.isRequired = isRequired or false
self.validatorList = {}
if(self.isRequired == true) then
self:appendValidator("required", "true")
end
end
function DataRule.appendValidator(self, validatorName, validatorValue)
table.insert(self.validatorList, {[validatorName]= validatorValue or ""})
end
function DataRule.getRuleScript(self, env, dataObject)
local ruleCache = {[["]], dataObject.compID, [[": {]]}
local vldtCache = {}
for n, validator in pairs(self.validatorList) do
for validatorName, validatorValue in pairs(validator) do
table.insert(vldtCache, table.concat({[["]], validatorName, [[":]], tostring(validatorValue)}))
end
end
table.insert(ruleCache, table.concat(vldtCache, ","))
table.insert(ruleCache, "}")
return table.concat(ruleCache)
end
function DataRule.getTip(self)
return ""
end
local function Split(szFullString, szSeparator)
local nFindStartIndex = 1
local nSplitIndex = 1
local nSplitArray = {}
while true do
local nFindLastIndex = string.find(szFullString, szSeparator, nFindStartIndex,true)
if not nFindLastIndex then
nSplitArray[nSplitIndex] = string.sub(szFullString, nFindStartIndex, string.len(szFullString))
break
end
nSplitArray[nSplitIndex] = string.sub(szFullString, nFindStartIndex, nFindLastIndex - 1)
nFindStartIndex = nFindLastIndex + string.len(szSeparator)
nSplitIndex = nSplitIndex + 1
end
return nSplitArray,nSplitIndex
end
local function isNumber(str)
local p="([^0-9])"
local s,e,c=string.find(str,p)
if (s) then
if c == "-" or c == "+" then
if s == 1 then
local subS,count = string.gsub(str,"[+-]","")
if count > 1 then
return false
else
if not isNumber(subS) then
return false
end
end
else
return false
end
elseif c=="." then
if e == #str then
return false
else
local subS,count = string.gsub(str,"[.]","")
if count > 1 then
return false
else
if not isNumber(subS) then
return false
end
end
end
else
return false
end
end
return true
end
function isNumberWithComma(str)
local t = Split(str,",")
for k,v in pairs(t) do
if k == 1 then
if #t == 1 then
if not isNumber(v) then
return false
end
else
local subS,count = string.gsub(v,"[-+]","")
if count > 1 or #subS > 3 then
return false
end
_,count = string.gsub(subS,"[^0-9]","")
if count > 0 then
return false
end
end
elseif k == #t then
local _,count = string.gsub(v,"[^0123456789.]","")
if count > 0 then
return false
end
local dotIndex = string.find(v,"[.]")
if dotIndex and dotIndex ~= 4 then
return false
elseif not dotIndex and #v ~= 3 then
return false
end
if not isNumber(v) then
return false
end
else
if not string.find(v,"^%d%d%d$") then
return false
end
end
end
return true
end
function isRequired(value)
if value and value ~= "" then
return true
else
return false
end
end
function integer(int)
if string.find(int,"^-?%d+$") then
return true
end
return false
end
function minlength(str,mnl)
if type(str) ~= "string" then
if type(str) == "number" then
str = tostring(num)
end
else
return false
end
if #str >= mnl then
return true
else
return false
end
end
function maxlength(str,mxl)
if type(str) ~= "string" then
if type(str) == "number" then
str = tostring(num)
end
else
return false
end
if #str <= mxl then
return true
else
return false
end
end
function rangelength(str,rangeval)
if type(str) ~= "string" then
str = tostring(str)
end
local _,_,mn,mx = string.find(rangeval,"%[%s*(%d+)%s*,%s*(%d+)%s*%]")
if not mn or not mx then return true end
if #str >= tonumber(mn) and #str <= tonumber(mx) then
return true
else
return false
end
end
function min(value,mnv)
if tonumber(value) >= tonumber(mnv) then
return true
else
return false
end
end
function max(value,mxv)
if tonumber(value) <= tonumber(mxv) then
return true
else
return false
end
end
function range(value,rangeVal)
local r = string.gsub(rangeVal,"[%[%]%s]","")
local i = string.find(r,",")
if not i then
print("range is wrong. but still return true")
return true
end
local mn,mx= tonumber(string.sub(r,1,i-1)), tonumber(string.sub(r,i+1))
value = tonumber(value)
if min(value,mn) and max(value,mx) then
return true
else
return false
end
end
function isDigits(str)
local p = "^%d+$"
if string.find(str,p) then
return true
else
return false
end
end
function AsciiPasswordCheck(str)
local tabKey = string.find(str,"    ")
if tabKey then
return false
end
return true
end
function AsciiCheck(str)
if string.find(str,"^[%w%p ]+$") then
return true
else
return false
end
end
function AsciiCheckWithLen(str,limit)
if #str ~= limit then
return false
end
if not AsciiCheck(str) then
return false
end
return true
end
function HexCheck(str)
local s,e = string.find(str,"^[0-9a-fA-F]+$")
if s then
return true
else
return false
end
end
function HexCheckWithLen(str, limit)
if #str ~= limit then
return false
end
if not HexCheck(str) then
return false
end
return true
end
function checkIPv4Addr(str)
local p = "^%d%d?%d?%.%d%d?%d?%.%d%d?%d?%.%d%d?%d?$"
local s,e = string.find(str,p)
if s then
for subIP in string.gmatch(str, "%d+") do
if subIP ~= "0" and string.find(subIP,"0") == 1 then
return false
end
if tonumber(subIP) < 0 or tonumber(subIP) > 255 then
return false
end
end
else
return false
end
return true
end
function IPv4Addr(str)
if checkIPv4Addr(str) then
return true
end
return false
end
function IPv6Addr(str)
local p="[^0-9a-fA-F:%.]+"
if string.find(str,p) then
print("illegal char")
return false
end
local addrParts,doubleColon,ipv4Parts,tripleColon = Split(str,':'),Split(str,'::'),Split(str,'%.'),Split(str,':::')
if #addrParts < 3 or #addrParts > 8 then
print("#addrParts < 3 or #addrParts > 8 ")
return false
elseif #doubleColon == 1 and #ipv4Parts == 1 and #addrParts ~= 8 then
print("#doubleColon == 1 and #ipv4Parts == 1 and #addrParts ~= 8")
return false
elseif #doubleColon == 1 and #ipv4Parts > 1 and #addrParts ~= 6 then
print(#ipv4Parts)
print("#doubleColon == 1 and #ipv4Parts > 1 and #addrParts ~= 6")
return false
elseif #doubleColon > 1 and #ipv4Parts > 1 and #addrParts > 6 then
print("#doubleColon > 1 and #ipv4Parts > 1 and #addrParts > 6")
return false
elseif #doubleColon > 2 or #tripleColon > 1 then
print("#doubleColon > 2 or #tripleColon > 1")
return false
else
if addrParts[1] == "" and addrParts[2] ~= "" then
print("addrParts[1] ==  and addrParts[2] ~= ")
return false
end
for k,v in pairs(addrParts) do
if k == #addrParts and v == "" and addrParts[k-1] ~= "" then
print("k == #addrParts and v ==  and addrParts[k-1] ~= ")
return false
end
if #v > 4 and not string.find(v,"%.") then
print("#v > 4 and not string.find(v,)")
return false
end
end
end
if string.find(str,"%.") then
local s = string.find(str,"%:%d%d?%d?%.")
if not s then
print("not s")
return false
end
local ipv4 = string.sub(str,s+1)
if not checkIPv4Addr(ipv4) then
print("not ipv4")
return false
end
end
return true
end
function HostName(str)
if string.find(str,"[^0-9a-zA-Z%.-]") then
return false
end
local firstChar = string.find(str,"[^%w]")
local lastChar = string.find(str,"[^%w]",#str-1)
if firstChar == 1 or lastChar then
return false
end
if not string.find(str,"[%.]") then
if string.find(str,"[%D]") then
return true
else
return false
end
else
local _,_,c=string.find(str,"%.([0-9a-zA-Z%-]+)$")
if string.find(c,"[%D]") then
return true
else
return false
end
end
end
function DomainName(str)
if #str < 1 or #str > 64 then
return false
end
return HostName(str)
end
function url(str)
if #str < 1 or #str > 256 then
return false
end
if string.find(str,"[^%w%.:;,!@%%#%?_/&=%+%*'%$%(%)%[%]%-]") then
return false
end
return true
end
function PasswordASCII(pwd)
if string.find(pwd,"^                       $") then
return true
end
if not AsciiPasswordCheck(pwd) then
return false
end
if not AsciiCheck(pwd) then
return false
end
return true
end
function ASCII(str)
if not AsciiCheck(str) then
return false
end
return true
end
function utf8(str)
return true
end
function WEPKey128Bit(str)
local AsciiLenLimit,HexLenLimit = 13,26;
if not AsciiCheckWithLen(str, AsciiLenLimit) and
not HexCheckWithLen(str, HexLenLimit) then
return false
end
return true
end
function WEPAsciiOrHexLen(str)
local AsciiLenLimit,HexLenLimit,AsciiLenLimit13,HexLenLimit26 = 5,10,13,26
if not AsciiCheckWithLen(str,AsciiLenLimit) and
not HexCheckWithLen(str, HexLenLimit) and
not AsciiCheckWithLen(str, AsciiLenLimit13) and
not HexCheckWithLen(str, HexLenLimit26) then
return false
end
return true
end
function HEX(str)
if not HexCheck(str) then
return false
end
return true
end
function fixedlength(str,length)
if #str ~= length then
return false
end
return true
end
function fixedValue(str, value)
if str ~= length then
return false
end
return true
end
function hexCompare(hexNum, hexRefer)
local p = "^0*([a-fA-F0-9]+)$"
local _,_,trimedNum = string.find(hexNum,p)
if not trimedNum then trimedNum = hexNum end
local _,_,trimedRefer = string.find(hexRefer,p)
if not trimedRefer then trimedRefer = hexRefer end
if #trimedNum > #trimedRefer then
return 1
elseif #trimedNum < #trimedRefer then
return -1
else
if string.lower(trimedNum) > string.lower(trimedRefer) then
return 1
elseif string.lower(trimedNum) < string.lower(trimedRefer) then
return -1
else
return 0
end
end
end
function hexRange(str,rangeVal)
local p = [[%[%s*'?"?([a-fA-F0-9]+)'?"?%s*,%s*'?"?([a-fA-F0-9]+)'?"?%s*]]
for mn,mx in string.gmatch(rangeVal, p) do
if hexCompare(str, mn) ~= -1 and hexCompare(str, mx) ~= 1 then
return true
end
end
return false
end
function ranges(str, rangeVals)
local str = tonumber(str)
local p = "%d+"
for scatter in string.gmatch(rangeVals, p) do
if str == tonumber(scatter) then
return true
end
end
local p2 = [[%[%s*([%d]+)%s*,%s*([%d]+)%s*]].."%]"
for mn,mx in string.gmatch(rangeVals, p2) do
if str >= tonumber(mn) and str <= tonumber(mx) then
return true
end
end
return false
end
function hybridCharRangeLength(str,rangeVal)
local strLen = #str
local p = [[%[%s*([%d]+)%s*,%s*([%d]+)%s*]].."%]"
for mn,mx in string.gmatch(rangeVal, p) do
if strLen < tonumber(mn) or strLen > tonumber(mx) then
return false
end
end
return true
end
function banValue(str,bans)
local p = [[%[%s*'?"?([%a%d]+)'?"?%s*,%s*'?"?([%a%d]+)'?"?%s*]].."%]"
if type(str) == "number" then
for c in string.gmatch(bans, "[%a%d]+") do
if tonumber(c) == str then
return false
end
end
for mn,mx in string.gmatch(bans, p) do
if tonumber(mn) <= str and tonumber(mx) >= str then
return false
end
end
elseif type(str) == "string" then
for c in string.gmatch(bans, "[%a%d]+") do
if c == str then
return false
end
end
for mn,mx in string.gmatch(bans, p) do
if mn <= str and mx >= str then
return false
end
end
end
return true
end
function utf8LengthRange(str,rangeval)
local strLen = util.charCountInString(str)
local _,_,mn,mx = string.find(rangeval,"%[%s*(%d+)%s*,%s*(%d+)%s*%]")
if not mn or not mx then return true end
if tonumber(mx) < 3 then
print("utf8LengthRange rangeVal is invalid.")
return true
end
mn,mx = math.ceil(tonumber(mn)/3),math.floor(tonumber(mx)/3)
if mn <= mx then
if strLen >= mn and strLen <= mx then
return true
end
else
print("utf8LengthRange rangeVal is invalid.")
return true
end
return false
end
local validateMethod =
{
required = isRequired,
integer = integer,
number = isNumber,
minlength = minlength,
maxlength = maxlength,
rangelength = rangelength,
min = min,
max = max,
range = range,
digits = isDigits,
AsciiPasswordCheck = AsciiPasswordCheck,
AsciiCheck = AsciiCheck,
AsciiCheckWithLen = AsciiCheckWithLen,
HexCheck = HexCheck,
HexCheckWithLen = HexCheckWithLen,
checkIPv4Addr = checkIPv4Addr,
IPv4Addr = IPv4Addr,
IPv6Addr = IPv6Addr,
HostName = HostName,
DomainName = DomainName,
url = url,
PasswordASCII = PasswordASCII,
ASCII = ASCII,
utf8 = utf8,
WEPKey128Bit = WEPKey128Bit,
WEPAsciiOrHexLen = WEPAsciiOrHexLen,
HEX = HEX,
fixedlength = fixedlength,
fixedValue = fixedValue,
hexCompare = hexCompare,
hexRange = hexRange,
ranges = ranges,
hybridCharRangeLength = hybridCharRangeLength,
banValue = banValue,
utf8LengthRange = utf8LengthRange,
}
function DataRule.postValidate(self, dataValue)
local pvRuleList = self.validatorList
local pvResult = true
if not pvRuleList.isRequired and dataValue == "" then
return true
end
for k,v in pairs(pvRuleList) do
if type(v) == "table" then
for m,n in pairs(v) do
local doValidate = validateMethod[m]
if doValidate then
pvResult = doValidate(dataValue,n)
else
pvResult = true
g_logger:info("DataRule.postValidate return true. Because of no this validateMethod->"..tostring(m))
end
if not pvResult then
return pvResult
end
end
end
end
return pvResult
end
DataRuleEmail = class(DataRule)
function DataRuleEmail.__init__(self, isRequired)
DataRule.__init__(self, isRequired)
self:appendValidator("email", "true")
end
DataRuleUrl = class(DataRule)
function DataRuleUrl.__init__(self, isRequired)
DataRule.__init__(self, isRequired)
self:appendValidator("url", "true")
end
DataRuleDate = class(DataRule)
function DataRuleDate.__init__(self, isRequired)
DataRule.__init__(self, isRequired)
self:appendValidator("date", "true")
end
DataRuleDateISO = class(DataRule)
function DataRuleDateISO.__init__(self, isRequired)
DataRule.__init__(self, isRequired)
self:appendValidator("dateISO", "true")
end
DataRuleNumber = class(DataRule)
function DataRuleNumber.__init__(self, isRequired)
DataRule.__init__(self, isRequired)
self.supportCompare = true
self:appendValidator("number", "true")
end
DataRuleDigits = class(DataRule)
function DataRuleDigits.__init__(self, isRequired)
DataRule.__init__(self, isRequired)
self.supportCompare = true
self:appendValidator("digits", "true")
end
DataRuleCreditcard = class(DataRule)
function DataRuleCreditcard.__init__(self, isRequired)
DataRule.__init__(self, isRequired)
self:appendValidator("creditcard", "true")
end
DataRuleIPv6Addr = class(DataRule)
function DataRuleIPv6Addr.__init__(self, isRequired)
DataRule.__init__(self, isRequired)
self:appendValidator("IPv6Addr", "true")
end
function DataRuleIPv6Addr.getGroupScript(self, env, dataObject)
if dataObject.prefix then
local groupScript = [["]] .. "PrefixIPv6" .. dataObject.compID .. [[" : "]]
.. dataObject.compID .. " " .. dataObject.prefix.id .. [["]]
return groupScript
else
return nil
end
end
DataRuleDomainName = class(DataRule)
function DataRuleDomainName.__init__(self, isRequired)
DataRule.__init__(self, isRequired)
self:appendValidator("DomainName", "true")
end
DataRuleHostName = class(DataRule)
function DataRuleHostName.__init__(self, isRequired)
DataRule.__init__(self, isRequired)
self:appendValidator("HostName", "true")
end
DataRuleRangeLength = class(DataRule)
function DataRuleRangeLength.__init__(self, isRequired, minLength, maxLength)
DataRule.__init__(self, isRequired)
self.minLength = minLength
self.maxLength = maxLength
self:appendValidator("rangelength", "[".. self.minLength.."," .. self.maxLength .. "]")
end
function DataRuleRangeLength.getTip(self)
return lang.public_073.. self.minLength .. " ~ " .. self.maxLength
end
DataRulePasswordASCII = class(DataRuleRangeLength)
function DataRulePasswordASCII.__init__(self, isRequired, minLength, maxLength)
DataRuleRangeLength.__init__(self, isRequired, minLength, maxLength)
self:appendValidator("PasswordASCII", "true")
end
function DataRulePasswordASCII.getTip(self)
return lang.public_073.. self.minLength .. " ~ " .. self.maxLength
end
DataRuleASCII = class(DataRule)
function DataRuleASCII.__init__(self, isRequired, minLength, maxLength)
DataRule.__init__(self, isRequired)
self.minLength = minLength
self.maxLength = maxLength
if self.minLength and self.maxLength then
DataRuleRangeLength.__init__(self, isRequired, minLength, maxLength)
end
self:appendValidator("ASCII", "true")
end
function DataRuleASCII.getTip(self)
if self.minLength and self.maxLength then
return lang.public_073.. self.minLength .. " ~ " .. self.maxLength
else
return ""
end
end
DataRuleUtf8 = class(DataRule)
function DataRuleUtf8.__init__(self, isRequired, minLength, maxLength)
DataRule.__init__(self, isRequired)
self.minLength = minLength
self.maxLength = maxLength
self:appendValidator("utf8", "true")
if self.minLength and self.maxLength then
self:appendValidator("utf8LengthRange", "[".. self.minLength.."," .. self.maxLength .. "]")
end
end
function DataRuleUtf8.getTip(self)
if not self.minLength or not self.maxLength then
return ""
end
local min = self.minLength
local max = self.maxLength
min = math.ceil(tonumber(self.minLength)/3)
max = math.floor(tonumber(self.maxLength)/3)
return lang.public_073.. min .. " ~ " .. max
end
DataRuleRangeBox = class(DataRule)
function DataRuleRangeBox.__init__(self, startComp, rangeType, endComp, inOneRow, maxGap )
DataRule.__init__(self, true)
self.startComp = startComp
self.endComp = endComp
self.inOneRow = inOneRow
self.compare = rangeType:sub(1,1)
if self.compare ~= ">" and self.compare ~= "<" then
g_logger:warn("rangeType " .. rangeType .. " is error")
return
end
self.equal = (rangeType:sub(2,2) == "=")
self.maxGap = maxGap
if self.maxGap and type(self.maxGap) ~= "number" then
g_logger:warn(string.format("DataRuleRangeBox param maxGap %s should be number!",self.maxGap))
end
self:appendValidatorRange()
if self.inOneRow then
self:appendRangeGroup()
end
end
function DataRuleRangeBox._getValidatorValue(self, compareComp, compare, isStart)
local cache = {"", "", ""}
table.insert(cache, [[["]])
table.insert(cache, compare)
table.insert(cache, [[","]])
table.insert(cache, compareComp.id)
table.insert(cache, [[",{]])
if self.equal ~= nil then
table.insert(cache, [["equal":]])
table.insert(cache, tostring(self.equal))
table.insert(cache, [[,]])
end
if self.maxGap ~= nil then
table.insert(cache, [["discrepantMode":]])
table.insert(cache, tostring(self.maxGap))
table.insert(cache, [[,]])
end
if type(self.inOneRow) == "boolean" then
local separate = not self.inOneRow
table.insert(cache, [["separate":]])
table.insert(cache, tostring(separate))
table.insert(cache, [[,]])
end
if isStart then
table.insert(cache, [["objPosition":"first"]])
else
table.insert(cache, [["objPosition":"second"]])
end
table.insert(cache, "}\]")
return table.concat(cache)
end
function DataRuleRangeBox.appendValidatorRange(self)
local validatorValue
local compareComp
if self.compare == "<" then
compareComp = self.endComp
startCompare = "lessThan"
endCompare = "greatThan"
elseif self.compare == ">" then
compareComp = self.startComp
startCompare = "greatThan"
endCompare = "lessThan"
else
g_logger:warn("RangeBox bind DataRule failed! param rangeType not support!")
return
end
if self.startComp.dataRule and
not(instanceof(self.startComp.dataRule, DataRuleIPv4Addr) or
instanceof(self.startComp.dataRule, DataRuleMACSegment)) then
self.startComp.dataRule:appendValidator("compareRange", self:_getValidatorValue(self.endComp, startCompare, false))
end
if self.endComp.dataRule and
not(instanceof(self.endComp.dataRule, DataRuleIPv4Addr) or
instanceof(self.endComp.dataRule, DataRuleMACSegment)) then
self.endComp.dataRule:appendValidator("compareRange", self:_getValidatorValue(self.startComp, endCompare, true))
end
end
function DataRuleRangeBox.appendRangeGroup(self)
if self.startComp.dataRule and self.endComp.dataRule then
local endCompRule = self.endComp.dataRule
endCompRule.compareID = self.startComp.id
if endCompRule.getGroupScript then
if instanceof(endCompRule, DataRuleIPv4Addr) then
endCompRule.isIPv4 = true
elseif instanceof(endCompRule, DataRuleMACSegment) then
endCompRule.isMAC = true
end
end
endCompRule.getGroupScript = self.getGroupScript
end
end
function DataRuleRangeBox.getGroupScript(self, env, dataObject)
local cache = {"", "", ""}
local loopCount = 0
if self.isIPv4 then
loopCount = 3
elseif self.isMAC then
loopCount = 5
else
loopCount = 0
end
table.insert(cache, [["]])
table.insert(cache, [[RangeBox_]])
table.insert(cache, dataObject.compID)
table.insert(cache, [[": "]])
if loopCount == 0 then
table.insert(cache, self.compareID)
table.insert(cache, [[ ]])
table.insert(cache, dataObject.compID)
else
for i=0,loopCount do
table.insert(cache, [[sub_]])
table.insert(cache, self.compareID)
table.insert(cache, i)
table.insert(cache, [[ ]])
end
for i=0,loopCount do
table.insert(cache, [[sub_]])
table.insert(cache, dataObject.compID)
table.insert(cache, i)
table.insert(cache, [[ ]])
end
end
table.insert(cache, [["]])
return table.concat(cache)
end
DataRuleWEPKey128Bit = class(DataRule)
function DataRuleWEPKey128Bit.__init__(self, isRequired)
DataRule.__init__(self, isRequired)
self:appendValidator("WEPKey128Bit", "true")
end
DataRuleWEPAsciiOrHexLen = class(DataRule)
function DataRuleWEPAsciiOrHexLen.__init__(self, isRequired)
DataRule.__init__(self, isRequired)
self:appendValidator("WEPAsciiOrHexLen", "true")
end
DataRuleHEX = class(DataRule)
function DataRuleHEX.__init__(self, isRequired)
DataRule.__init__(self, isRequired)
self:appendValidator("HEX", "true")
end
DataRuleMACSegment = class(DataRuleHEX)
function DataRuleMACSegment.__init__(self, isRequired)
DataRuleHEX.__init__(self, isRequired)
self:appendValidator("fixedlength", "2")
end
function DataRuleMACSegment.getRuleScript(self, env, dataObject)
local oriCompID = dataObject.compID
local cache = {"", "", "", "", "", ""}
for i=0,5 do
dataObject.compID = "sub_"..oriCompID .. i
cache[i+1] = DataRuleInteger.getRuleScript(self, env, dataObject)
end
return table.concat(cache, ",")
end
function DataRuleMACSegment.getGroupScript(self, env, dataObject)
local cache = {[["]], dataObject.compID, [[" : "]]}
for i=0,5 do
table.insert(cache, [[sub_]])
table.insert(cache, dataObject.compID)
table.insert(cache, i)
table.insert(cache, [[ ]])
end
table.insert(cache, [["]])
return table.concat(cache)
end
function DataRuleMACSegment.getCommScript(self, env, dataObject)
end
DataRuleAbstrarctRange = class(DataRule)
function DataRuleAbstrarctRange.__init__(self, isRequired, ...)
DataRule.__init__(self, isRequired)
end
function DataRuleAbstrarctRange._getHexRange(self, ...)
local cache = {"", "", ""}
table.insert(cache, "[")
for i, v in ipairs{...} do
if i > 1 then
table.insert(cache, ",")
rangeString = rangeString .. ","
end
if i % 2 == 0 then
table.insert(cache, "\"")
table.insert(cache, tostring(v))
table.insert(cache, "\"")
table.insert(cache, "]")
else
table.insert(cache, "[")
table.insert(cache, "\"")
table.insert(cache, tostring(v))
table.insert(cache, "\"")
end
end
table.insert(cache, "]")
return table.concat(cache)
end
DataRuleHexRange = class(DataRuleAbstrarctRange)
function DataRuleHexRange.__init__(self, isRequired, ...)
DataRule.__init__(self, isRequired)
self.hexRange = self:fetchHexRange(...)
self:appendValidator("HEX", "true")
self:appendValidator("hexRange", self:_getHexRange(...))
end
function DataRuleHexRange.fetchHexRange(self, ...)
local cache = {"", "", ""}
local length = #({...})
for i, v in ipairs{...} do
if i % 2 == 0 then
table.insert(cache, " ~ ")
table.insert(cache, tostring(v))
if i ~= length then
table.insert(cache, ", ")
end
else
table.insert(cache, tostring(v))
end
end
return table.concat(cache)
end
function DataRuleHexRange._getHexRange(self, ...)
local cache = {"", "", ""}
table.insert(cache, "[")
for i, v in ipairs{...} do
if i > 1 then
table.insert(cache, ",")
end
if i % 2 == 0 then
table.insert(cache, "\"")
table.insert(cache, tostring(v))
table.insert(cache, "\"")
table.insert(cache, "]")
else
table.insert(cache, "[")
table.insert(cache, "\"")
table.insert(cache, tostring(v))
table.insert(cache, "\"")
end
end
table.insert(cache, "]")
return table.concat(cache)
end
function DataRuleHexRange.getTip(self)
return lang.public_154 .. lang.public_072 .. self.hexRange
end
DataRuleInteger = class(DataRuleAbstrarctRange)
function DataRuleInteger.__init__(self, isRequired, minValue, maxValue)
DataRuleAbstrarctRange.__init__(self, isRequired)
self.minValue = minValue
self.maxValue = maxValue
self.supportCompare = true
self:appendValidator("integer", "true")
self:appendValidator("range", "["..minValue..",".. maxValue.."]")
end
function DataRuleInteger.getTip(self)
return lang.public_072 .. self.minValue .. "~" .. self.maxValue
end
DataRuleIPv4Addr = class(DataRuleInteger)
function DataRuleIPv4Addr.__init__(self, isRequired)
DataRuleInteger.__init__(self, isRequired, 0, 255)
end
function DataRuleIPv4Addr.getRuleScript(self, env, dataObject)
local oriCompID = dataObject.compID
local cache = {"", "", "", ""}
for i=0,3 do
dataObject.compID = "sub_"..oriCompID .. i
cache[i+1] = DataRuleInteger.getRuleScript(self, env, dataObject)
end
return table.concat(cache, ",")
end
function DataRuleIPv4Addr.getGroupScript(self, env, dataObject)
local cache = {"", "", ""}
table.insert(cache, [["]])
table.insert(cache, dataObject.compID)
table.insert(cache, [[" : "]])
for i=0,3 do
table.insert(cache, "sub_")
table.insert(cache, dataObject.compID)
table.insert(cache, i)
table.insert(cache, " ")
end
table.insert(cache, [["]])
return table.concat(cache)
end
function DataRuleIPv4Addr.getCommScript(self, env, dataObject)
end
DataRuleUserURL = class(DataRule)
function DataRuleUserURL.__init__(self, isRequired)
DataRule.__init__(self, isRequired)
self:appendValidator("URL", "true")
end
