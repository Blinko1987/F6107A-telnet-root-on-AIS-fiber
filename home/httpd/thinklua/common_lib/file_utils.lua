local PathSeparatorChar = [[/]]
local function remove_suffix_filename(name)
local i = string.len(name)
local tmp = string.sub(name, i - 3,i)
if string.lower(tmp) == ".lua" then
return string.sub(name,1, i - 4)
end
return name
end
local function filterIllegalPath(redirect_script)
if not redirect_script then
return nil
end
local chkPathStart=0
local chkPathEnd=0
local realPathStart=0
local scriptRequest
while true do
chkPathStart, chkPathEnd = string.find(redirect_script, "%.%.%/", chkPathStart+1)
if chkPathStart == nil then break end
chkPathStart = chkPathEnd
realPathStart = chkPathEnd
end
scriptRequest = string.sub(redirect_script, realPathStart+1)
return scriptRequest
end
local function readfile(filename)
local fh = assert (io.open (filename))
local src = fh:read("*a")
fh:close()
return src
end
local function isFileExist(fullFilePath)
if fullFilePath == nil then
return false
end
return lfs.attributes (fullFilePath, "mode") ~= nil
end
local function stripfilename(filename)
return string.match(filename, "(.+)"..PathSeparatorChar.."[^".. PathSeparatorChar.."]*%.%w+$")
end
local function strippath(filename)
return string.match(filename, table.concat({".+", PathSeparatorChar, "([^", PathSeparatorChar, "]*%.%w+)$"}))
end
local function stripextension(filename)
local stripped = filename:match("(.+)%.%w+$")
if stripped then
return stripped
else
return filename
end
end
local function splitRootFromDirPath(dirPath)
return dirPath:match("(.-)%"..PathSeparatorChar), dirPath:match(".-%"..PathSeparatorChar.."(.+)")
end
local function getextension(filename)
return filename:match(".+%.(%w+)$")
end
local function luaPath2LocalPath(filename)
if filename ~= nil then
local localPath = string.gsub(filename, "%.", PathSeparatorChar)
return localPath .. ".lua"
else
return nil
end
end
local function localPath2LuaPath(filename)
if string.lower(getextension(filename)) ~= "lua" then
return nil
else
local luaPath = string.gsub(stripextension(filename), PathSeparatorChar, ".")
return luaPath
end
end
local function mkdir(path)
local tbPath = string.split(path, PathSeparatorChar)
local curPath = ""
for _, v in ipairs(tbPath) do
curPath = curPath .. PathSeparatorChar .. v
if not lfs.attributes (curPath, "mode") then
lfs.mkdir(curPath)
end
end
return true
end
local utilModule = require("data_assemble.util")
utilModule.isFileExist = isFileExist
utilModule.stripfilename = stripfilename
utilModule.strippath = strippath
utilModule.stripextension = stripextension
utilModule.splitRootFromDirPath = splitRootFromDirPath
utilModule.getextension = getextension
utilModule.luaPath2LocalPath = luaPath2LocalPath
utilModule.localPath2LuaPath = localPath2LuaPath
utilModule.mkdir = mkdir
utilModule.PathSeparatorChar = PathSeparatorChar
return {
remove_suffix_filename = remove_suffix_filename,
filterIllegalPath = filterIllegalPath,
isFileExist = isFileExist,
readfile = readfile,
isFileExist = isFileExist,
stripfilename = stripfilename,
strippath = strippath,
stripextension = stripextension,
splitRootFromDirPath = splitRootFromDirPath,
getextension = getextension,
luaPath2LocalPath = luaPath2LocalPath,
localPath2LuaPath = localPath2LuaPath,
mkdir = mkdir,
PathSeparatorChar = PathSeparatorChar,
}
