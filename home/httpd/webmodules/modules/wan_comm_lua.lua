require "data_assemble.common_lua"
require "modules/wan_wancbridge_lua"
require "modules/wan_wancip_lua"
require "modules/wan_wancppp_lua"
require "modules/wan_convert_table"
classbase = {
uplinks = {
["1"] = {
["1"] = "atm",
["2"] = "ptm"
},
["2"] = {
["1"] = "eth"
},
["20"] = {
["1"] = "sta"
}
},
objvalues = {
atm = {
pppoe = "OBJ_DSLWANCPPP_ID",
["dhcp/static"] = "OBJ_DSLWANCIP_ID",
bridge = "OBJ_DSLWANCBRIDGE_ID",
},
ptm = {
pppoe = "OBJ_PTMWANCPPP_ID",
["dhcp/static"] = "OBJ_PTMWANCIP_ID",
bridge = "OBJ_PTMWANCBRIDGE_ID"
},
eth = {
pppoe = "OBJ_ETHWANCPPP_ID",
["dhcp/static"] = "OBJ_ETHWANCIP_ID",
bridge = "OBJ_ETHWANCBRIDGE_ID"
},
sta = {
["dhcp/static"] = "OBJ_STAWANCIP_ID",
}
},
para = {
pppoe = get_ppp_array(),
["dhcp/static"] = get_ip_array(),
bridge = get_bridge_array()
},
upobjs = {
atm = "OBJ_DSLWANC_ID",
ptm = "OBJ_DSLWANC_ID",
eth = "OBJ_ETHWANC_ID",
sta = "OBJ_STAWANC_ID"
}
}
classbase.__index = classbase
function classbase:new(t)
local temp = {}
setmetatable(temp, classbase)
temp.want = t
return temp
end
function classbase:reset_want(t)
self.want = t
self.uplink = nil
end
function classbase:set_up_type()
if not self.uplink then
local xdslmode = self.want.xdslMode
if not xdslmode or "NULL" == xdslmode then
xdslmode = "1"
end
self.uplink = self.uplinks[self.want.uplink][xdslmode]
end
end
function classbase:get_up_obj()
self:set_up_type()
return self.upobjs[self.uplink]
end
function classbase:get_param_array()
self:set_up_type()
return self.para[self.want.wantype][self.uplink]
end
function classbase:get_inst_obj_name()
self:set_up_type()
return self.objvalues[self.uplink][self.want.wantype]
end
function classbase:get_wan_table(err)
local wantable = {}
local array = self:get_param_array()
local obj = self:get_inst_obj_name()
local id = self.want.wanid
local t = cmapi.getinst(obj, id)
if t.IF_ERRORID ~= 0 then
if type(err) == "table" then
if err.IF_ERRORID ~= 0 then
return nil, err
end
end
return nil, t
end
for _, v in ipairs(array) do
wantable[v] = t[v]
end
return wantable, err
end
function classbase:get_button_stat()
local Status = ""
local retTab = cmapi.querylist("OBJ_CurUpType_ID", "IGD")
for i, v in ipairs(retTab) do
local id = v .. ".WDCommCfg"
local t = cmapi.getinst("OBJ_CurUpType_ID", id)
local curr_wanType = t.WANAccessType
Status = t.PhysicalLinkStatus
if curr_wanType == "DSL" and
("atm" == self.uplink or "ptm" == self.uplink ) then
break
elseif curr_wanType == "Ethernet" and "eth" == self.uplink then
break
elseif curr_wanType == "STA" and "sta" == self.uplink then
break
end
end
return Status
end
function classbase:get_inst_head_xml()
local InstXMLTMP = ""
local InstXML = ""
local Status = self:get_button_stat()
if self.want.wanid then
InstXMLTMP = getXMLNodeEntity("_InstID", encodeXML(self.want.wanid))
end
InstXML = InstXML .. InstXMLTMP
if self.want.wantype then
InstXMLTMP = getXMLNodeEntity("wantype", self.want.wantype)
end
InstXML = InstXML .. InstXMLTMP
if self.want.xdslMode then
InstXMLTMP = getXMLNodeEntity("XMODE" , self.want.xdslMode)
end
InstXML = InstXML .. InstXMLTMP
InstXMLTMP = getXMLNodeEntity("Status" , Status)
InstXML = InstXML .. InstXMLTMP
return InstXML
end
function classbase:delete()
local obj = self:get_inst_obj_name()
local id = self.want.wanid
local tError = cmapi.delinst(obj, id)
return "", tError
end
function classbase:apply()
if env.getenv("Bridge") == "0" and cgilua.cgilua.POST.mode == "bridge" then
if cgilua.cgilua.POST._InstID == "-1" then
if cgilua.cgilua.POST.linkMode == "PPP" then
self.want.wantype = "pppoe"
elseif cgilua.cgilua.POST.linkMode == "IP" then
self.want.wantype = "dhcp/static"
end
end
end
local obj = self:get_inst_obj_name()
local action = self.want.action
local id = self.want.wanid
local para = self:get_param_array()
cgilua.cgilua.POST.action = self.want.action
cgilua.cgilua.POST.xdslMode = self.want.xdslMode
cgilua.cgilua.POST.uplink = self.want.uplink
cgilua.cgilua.POST.wantype = self.want.wantype
cgilua.cgilua.POST.wanid = self.want.wanid
convert_post_to_cmapi(cgilua.cgilua.POST)
local tError = applyOrNewOrDelInst(obj, action, id, transToPostTab(para))
self.want.wanid = tError.INSTIDENTITY
local strxml = self:get_inst_head_xml()
return strxml, tError
end
function classbase:cancel(tError)
local t = nil
local err = nil
local strxml = ""
t, err = self:get_wan_table(tError)
if t then
t._InstID = self.want.wanid
t.xdslMode = self.want.xdslMode
t.uplink = self.want.uplink
t.wantype = self.want.wantype
t.pageType = self.want.pageType
convert_cmapi_to_post(t)
for k, v in pairs(t) do
strxml = strxml..getParaXMLNodeEntity(k, encodeXML(v))
end
end
return strxml, err
end
function classbase:dhcp_release()
local tError = cmapi.dev_action({CmdId = "cmd_dhcpdisconnect", Identity = self.want.wanid})
self.want.action = "Cancel"
return self:cancel(tError)
end
function classbase:dhcp_renew()
local tError = cmapi.dev_action({CmdId = "cmd_dhcpconnect", Identity = self.want.wanid})
self.want.action = "Cancel"
return self:cancel(tError)
end
function classbase:ppp_connect()
local tError = cmapi.dev_action({CmdId = "cmd_pppconnect", Identity = self.want.wanid})
self.want.action = "Cancel"
return self:cancel(tError)
end
function classbase:ppp_desconnect()
local tError = cmapi.dev_action({CmdId = "cmd_pppdisconnect", Identity = self.want.wanid})
self.want.action = "Cancel"
return self:cancel(tError)
end
function classbase:ppp_viettel_connect()
local tError = cmapi.dev_action({CmdId = "ppp_viettel_connect", Identity = self.want.wanid})
self.want.action = "Cancel"
return self:cancel(tError)
end
function classbase:ppp_viettel_disconnect()
local tError = cmapi.dev_action({CmdId = "ppp_viettel_disconnect", Identity = self.want.wanid})
self.want.action = "Cancel"
return self:cancel(tError)
end
function classbase:ppp_ctc_connect()
local tError = cmapi.dev_action({CmdId = "ppp_ctc_connect", Identity = self.want.wanid})
self.want.action = "Cancel"
return self:cancel(tError)
end
function classbase:ppp_ctc_disconnect()
local tError = cmapi.dev_action({CmdId = "ppp_ctc_disconnect", Identity = self.want.wanid})
self.want.action = "Cancel"
return self:cancel(tError)
end
function classbase:ros_clear_wanstate()
local tError = cmapi.dev_action({CmdId = "ros_clear_wanstate", Identity = self.want.wanid})
return "", tError
end
function classbase:action(tError)
local xml = ""
local err = nil
local action_types = {
Apply = self.apply,
Delete = self.delete,
Cancel = self.cancel,
DHCPRELEASE = self.dhcp_release,
DHCPRENEW = self.dhcp_renew,
PPPCONNECT = self.ppp_connect,
PPPDISCONNECT = self.ppp_desconnect,
PPPVIETCONNECT = self.ppp_viettel_connect,
PPPVIETDISCONNECT = self.ppp_viettel_disconnect,
PPPCTCCONNECT = self.ppp_ctc_connect,
PPPCTCDISCONNECT = self.ppp_ctc_disconnect,
WAN_CLEAR = self.ros_clear_wanstate
}
if not tError then
tError = {IF_ERRORID = 0}
end
xml, err = action_types[self.want.action](self, tError)
if "Cancel" == self.want.action then
xml = getXMLNodeEntity("Instance", xml)
end
return xml, err
end
