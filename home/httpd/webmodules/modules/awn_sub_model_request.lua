require "data_assemble.common_lua"
local jsonStr = cgilua.cgilua.POST["json"] or ""
print(jsonStr)
local out = {result="SUCCESS"}
local getTbl = cmapi.getinst("OBJ_DEVINFO_ID", "IGD")
if getTbl.IF_ERRORID == 0 then
out["sub_model"] = getTbl["ModelName"]
end
local cjson = require"common_lib.json"
cgilua.cgilua.contentheader ("application", "json; charset="..lang.CHARSET)
sapi.Response.sethc("linger","1")
sapi.Response.write(cjson.encode(out))
