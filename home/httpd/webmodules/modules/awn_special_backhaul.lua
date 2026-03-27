require "data_assemble.common_lua"
local jsonStr = cgilua.cgilua.POST["json"] or ""
print(jsonStr)
local cjson = require"common_lib.json"
cgilua.cgilua.contentheader ("application", "json; charset="..lang.CHARSET)
sapi.Response.sethc("linger","1")
sapi.Response.write(cjson.encode({result="SUCCESS"}))
