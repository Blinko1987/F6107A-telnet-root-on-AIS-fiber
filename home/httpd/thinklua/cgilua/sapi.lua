local date = os.date
local gsub,format = string.gsub,string.format
local info = require"cgilua.serverapi.webd.info"
local req = require"cgilua.serverapi.webd.request"
local res = require"cgilua.serverapi.webd.response"
sapi = {
Info = info.open (REQUEST),
Request = req.open (REQUEST),
Response = res.open (REQUEST),
}
require "lfs"
require("cgilua.erroutput")
local cgilua = require "cgilua.cgilua"
setmetatable(_G.cgilua, {__index=_G.cgilua.cgilua})
cgilua.seterroroutput(my_default_erroroutput)
cgilua.main()
collectgarbage("collect")
