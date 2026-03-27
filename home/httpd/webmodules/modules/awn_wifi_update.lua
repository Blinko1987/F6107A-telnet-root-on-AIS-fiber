require "data_assemble.common_lua"
local cjson = require"common_lib.json_v2"
if env.getenv("Mode") == "Slave" then
local jsonStr = cgilua.cgilua.POST["json"] or ""
local para = cjson.decode(jsonStr)
local agentFunc = require "modules.awn_agent_set_wifi"
agentFunc.setwifi(para)
end
cgilua.cgilua.contentheader ("application", "json; charset="..lang.CHARSET)
sapi.Response.sethc("linger","1")
sapi.Response.write(cjson.encode({result="SUCCESS"}))
