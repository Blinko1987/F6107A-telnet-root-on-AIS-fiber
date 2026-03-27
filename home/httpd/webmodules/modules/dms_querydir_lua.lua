local lfs = require"lfs"
local urlcode = require"cgilua.urlcode"
local querydir = cgilua.cgilua.QUERY.querydir
if querydir == nil or querydir == "" then
return
end
local list = ""
for file in lfs.dir(querydir,"/mnt") do
if file ~= ".." and file ~= "." then
local f = querydir.."/"..file
local attr = lfs.attributes(f)
if attr ~= nil and attr.mode == "directory" then
list = list..file.."/"
end
end
end
cgilua.cgilua.contentheader ("text", "plain; charset="..lang.CHARSET)
cgilua.cgilua.put(querydir.."|"..list)
