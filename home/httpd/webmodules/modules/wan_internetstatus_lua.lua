require "data_assemble.common_lua"
require "modules/wan_comm_lua"
local cgilua = cgilua.cgilua
local InstXML = ""
local InstXMLTMP = ""
local ErrorXML = ""
local tError = {IF_ERRORID = 0}
local OutXML = nil
local InstZeroXML = "<ID_WAN_COMFIG><Instance><ParaName>xdslMode</ParaName><ParaValue>NULL</ParaValue>"..
"<ParaName>_InstID</ParaName><ParaValue>FakeXMLID</ParaValue><ParaName>IsNAT</ParaName><ParaValue>1</ParaValue>"..
"<ParaName>ConnError</ParaName><ParaValue>ERROR_NONE</ParaValue><ParaName>linkMode</ParaName><ParaValue>IP</ParaValue>"..
"<ParaName>MTU</ParaName><ParaValue>1500</ParaValue><ParaName>wantype</ParaName><ParaValue>dhcp/static</ParaValue>"..
"<ParaName>Addressingtype</ParaName><ParaValue>DHCP</ParaValue><ParaName>WorkIFMac</ParaName><ParaValue>00:00:00:00:00:00</ParaValue>"..
"<ParaName>ServList</ParaName><ParaValue>1</ParaValue><ParaName>IpMode</ParaName><ParaValue>IPv4</ParaValue>"..
"<ParaName>pageType</ParaName><ParaValue>0</ParaValue><ParaName>mode</ParaName><ParaValue>route</ParaValue>"..
"<ParaName>uplink</ParaName><ParaValue>20</ParaValue><ParaName>WANCName</ParaName><ParaValue>WRT</ParaValue>"..
"<ParaName>VlanEnable</ParaName><ParaValue>0</ParaValue><ParaName>StrServList</ParaName><ParaValue>INTERNET</ParaValue>"..
"</Instance></ID_WAN_COMFIG>"
local tErrorZero = {
IF_ERRORID = 0,
IF_ERRORTYPE = "SUCC",
IF_ERRORSTR = "SUCC",
IF_ERRORPARAM = "SUCC"
}
local want = {}
local sess_id = cgilua.getCurrentSessID()
local uRight = session_get(sess_id, "Right")
local cver = env.getenv("CountryCode")
local wanConf = _G.wanConf[uRight]
local wanHidden = nil
if wanConf ~= nil then
wanHidden = wanConf.hidden
end
local actionTmp = cgilua.POST.IF_ACTION
if actionTmp == "Apply" or actionTmp == "Delete" then
cgilua.POST.IF_ACTION = nil
end
want.action = cgilua.POST.IF_ACTION
want.wanid = cgilua.POST._InstID
want.xdslMode = cgilua.POST.xdslMode
want.TypeFlag = cgilua.POST.TypeFlag
want.uplink = cgilua.QUERY.TypeUplink
want.pageType = encodeXML(cgilua.QUERY.pageType)
local function get_wantype(t)
local wanttype = ""
if "bridge" == t.mode then
wanttype = "bridge"
elseif "route" == t.mode then
if "PPP" == t.linkMode then
wanttype = "pppoe"
elseif "IP" == t.linkMode then
wanttype = "dhcp/static"
end
end
return wanttype
end
local function filter_ipmode(id)
local bsave = true
local ipmode = cmapi.get_IPMode(id)
return bsave
end
local function get_xdsl_type(up, id)
if "1" == up then
local ret_XDSL = cmapi.getinst("OBJ_XDSLMODE_ID", id)
return ret_XDSL.xdslModeValue
end
return "NULL"
end
if "108" == env.getenv("CountryCode") and want.action == "Cancel" then
local retTab = cmapi.querylist("OBJ_ETHWANC_ID", "IGD")
for i, v in ipairs(retTab) do
want.wantype = v.WANCType
end
else
want.wantype = get_wantype(cgilua.POST)
end
local function display_wan(inst,t)
if wanHidden == nil then
return true
end
if wanHidden.inst ~= nil then
if string.find(wanHidden.inst,inst) ~= nil then
return false
else
return true
end
else
local count = 0
local matchCount =0
for k,v in pairs(wanHidden) do
if v == t[k] then
matchCount = matchCount + 1
end
count = count + 1
end
if count == matchCount then
return false
else
return true
end
end
end
if not want.wanid then
want.wanid = ""
local object = classbase:new(want)
local retTab = cmapi.querylist(object:get_up_obj(), "IGD")
local t = nil
local err = {IF_ERRORID = 0}
for i, v in ipairs(retTab) do
want.wanname = v.WANCName
want.wanid = v.InstName
want.wantype = v.WANCType
want.xdslMode = get_xdsl_type(want.uplink, want.wanid)
t, err = object:get_wan_table(err)
if filter_ipmode(want.wanid) then
want.action = "Cancel"
object:reset_want(want)
if display_wan(v.InstName,t) then
InstXMLTMP, tError = object:action(tError)
InstXML = InstXML .. InstXMLTMP
end
end
end
if "OBJ_STAWANC_ID" == object:get_up_obj() and 0 == retTab.Count and "0" == want.pageType then
InstXML = InstZeroXML
tError = tErrorZero
end
else
if "-1" == want.wanid then
want.wanid = ""
end
if "FakeXMLID" == want.wanid and "Apply" == want.action then
want.wanid = ""
end
if "FakeXMLID" == want.wanid and "Cancel" == want.action then
else
local object = classbase:new(want)
InstXML, tError = object:action(tError)
end
end
if "Cancel" == want.action then
if "FakeXMLID" == want.wanid then
InstXML = InstZeroXML
tError = tErrorZero
else
InstXML = getXMLNodeEntity("ID_WAN_COMFIG", InstXML)
end
end
ErrorXML = outputErrorXML(tError)
OutXML = ErrorXML .. InstXML
outputXML(OutXML)
