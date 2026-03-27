local assert, error, getfenv, loadstring, setfenv = assert, error, getfenv, loadstring, setfenv
local find, format, gsub, strsub, char = string.find, string.format, string.gsub, string.sub, string.char
local concat, tinsert = table.concat, table.insert
local open = io.open
local print=print
local ipairs = ipairs
local _G = _G
local os = os
local string = string
module(...)
local outfunc = "io.write"
local compatmode = true
local function out (s, i, f)
s = strsub(s, i, f or -1)
if s == "" then return s end
s = gsub(s, "([\\\n\'])", "\\%1")
s = gsub(s, "\r", "\\r")
return format(" %s('%s'); ", outfunc, s)
end
function translate (s)
if compatmode then
s = gsub(s, "$|(.-)|%$", "<?lua = %1 ?>")
s = gsub(s, "<!%-%-$$(.-)$$%-%->", "<?lua %1 ?>")
end
s = gsub(s, "<%%(.-)%%>", "<?lua %1 ?>")
s = gsub(s, "&%?(.-);", "<?lua =lang.%1 ?>")
local res = {}
local start = 1
while true do
local ip, fp, target, exp, code = find(s, "<%?(%w*)[ \t]*(=?)(.-)%?>", start)
if not ip then break end
tinsert(res, out(s, start, ip-1))
if target ~= "" and target ~= "lua" then
tinsert(res, out(s, ip, fp))
else
if exp == "=" then
tinsert(res, format(" %s(%s);", outfunc, code))
else
tinsert(res, format(" %s ", code))
end
end
start = fp + 1
end
tinsert(res, out(s, start))
return concat(res)
end
function getoutfunc ()
return outfunc
end
function setoutfunc (f)
outfunc = f
end
function setcompatmode (c)
compatmode = c
end
local cache = {}
function compile (string, chunkname, lpcache)
local f
local err
if lpcache == true then
f, err = cache[string]
if f then return f end
end
f, err = loadstring (translate (string), chunkname)
if not f then error (err, 3) end
if lpcache == true then
cache[string] = f
end
return f
end
local BOM = char(239) .. char(187) .. char(191)
function readfile(filename)
local fh = assert (open (filename))
local src = fh:read("*a")
fh:close()
return src
end
function include4lp(filename, env, lpcache)
local prog = _G.loadfile(filename)
if not prog then
prog = compile (readfile(filename), '@'..filename, lpcache)
end
if env then
setfenv (prog, env)
end
prog ()
end
function include (filename, env, lpcache)
for _, v in ipairs({"css", "js"}) do
if find(filename, v .. "$") then
_G.sapi.Response.write(readfile(filename))
return
end
end
include4lp(filename, env, lpcache)
end
