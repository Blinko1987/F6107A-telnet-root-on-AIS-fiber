local function GetETH_WAN_ID()
local t = cmapi.querylist("OBJ_ETHINTERFACE_ID", "IGD.WD")
local ETH_WAN_ID = ""
if t.IF_ERRORID ~= 0 then
g_logger:warn("querylist fail.")
else
if t.Count ~= 888 then
ETH_WAN_ID = t[1].InstName or t[1]
end
end
return ETH_WAN_ID
end
return {
GetETH_WAN_ID = GetETH_WAN_ID
}
