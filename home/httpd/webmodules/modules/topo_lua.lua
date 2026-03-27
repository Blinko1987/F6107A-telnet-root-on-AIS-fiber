require "data_assemble.common_lua"
local json = require("common_lib.json")
local cgilua = require("cgilua.cgilua")
local topoComm = require("modules.topo_common_lua")
if env.getenv("TopoPageVer") == "v2" then
topo_ver = "v2"
topoComm = require("modules.topo_v2_common_lua")
end
cgilua.contentheader ("application", "json; charset="..lang.CHARSET)
local outData
local AccessType = cgilua.QUERY.AccessType
local ParentID = cgilua.QUERY.ParentID
local Action = cgilua.QUERY.Action
if topo_ver == "v2" then
if Action == "GetPopData" then
outData = topoComm.getPopDataBaseParentID(ParentID)
elseif Action == "GetALLAP" then
outData = topoComm.getALLAP()
elseif Action == "GetALLClients" then
outData = topoComm.getALLClients()
elseif Action == "SET_ALIAS" then
outData = topoComm.setAlias()
else
outData = topoComm.getTopoSvgData()
end
else
if Action == "More" then
outData = topoComm.getAccessDevInfoByType(ParentID, AccessType)
elseif Action == "SET_ALIAS" then
outData = topoComm.setAlias()
else
outData = topoComm.getTopoCascade()
end
end
outData = json.encode(outData)
sapi.Response.write(outData)
