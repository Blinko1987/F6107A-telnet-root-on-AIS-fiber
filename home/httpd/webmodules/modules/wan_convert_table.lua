local clear = nil
local function convert_vlan(t, motion)
if "set" == motion then
if "0" == t.VlanEnable then
t.VLANID = clear
t.Priority = clear
end
if "PPPoA" == t.TransType or "IPoA" == t.ATMLinkType or "CIP" == t.ATMLinkType then
t.VlanEnable = clear
t.VLANID = clear
t.Priority = clear
end
elseif "get" == motion then
if "0" == t.VlanEnable then
t.VLANID = nil
t.Priority = nil
elseif "1" == t.VlanEnable then
if "" == t.VLANID then
t.VLANID = "0"
end
end
if "PPPoA" == t.TransType or "IPoA" == t.ATMLinkType or "CIP" == t.ATMLinkType then
t.VlanEnable = nil
t.VLANID = nil
t.Priority = nil
end
end
end
local function convert_dscp(t, motion)
if "set" == motion then
if "" == t.DSCP then
t.DSCP = "-1"
end
if "PPPoA" == t.TransType or "IPoA" == t.ATMLinkType or "CIP" == t.ATMLinkType then
t.DSCP = clear
end
elseif "get" == motion then
if "" == t.DSCP then
t.DSCP = "-1"
end
if "PPPoA" == t.TransType or "IPoA" == t.ATMLinkType or "CIP" == t.ATMLinkType then
t.DSCP = nil
end
end
end
local function convert_serverlist_link(t, motion)
if "set" == motion then
local st = {
['1'] = "INTERNET",
['2'] = "TR069",
['3'] = "INTERNET_TR069",
['4'] = "VoIP",
['5'] = "INTERNET_VoIP",
['6'] = "VoIP_TR069",
['7'] = "INTERNET_VoIP_TR069",
['8'] = "OTHER"
}
t.StrServList = st[t.ServList]
elseif "get" == motion then
end
end
local function convert_mode_link(t, motion)
if "set" == motion then
elseif "get" == motion then
if "bridge" == t.wantype then
t.mode = "bridge"
else
t.mode = "route"
end
end
end
local function convert_linkmode(t, motion)
if "set" == motion then
if "PPP" == t.linkMode then
convert_ppptype(t, motion)
elseif "IP" == t.linkMode then
convert_IPtype(t, motion)
end
elseif "get" == motion then
if "pppoe" == t.wantype then
t.linkMode = "PPP"
convert_ppptype(t, motion)
elseif "dhcp/static" == t.wantype then
t.linkMode = "IP"
convert_IPtype(t, motion)
end
end
end
function convert_IpMode(t, motion)
if "set" == motion then
if "IPv4" == t.IpMode then
convert_ipvf(t, motion)
elseif "IPv6" == t.IpMode then
convert_ipvs(t, motion)
elseif "Both" == t.IpMode then
convert_ipvf(t, motion)
convert_ipvs(t, motion)
end
elseif "get" == motion then
if "IPv4" == t.IpMode then
convert_ipvf(t, motion)
elseif "IPv6" == t.IpMode then
convert_ipvs(t, motion)
elseif "Both" == t.IpMode then
convert_ipvf(t, motion)
convert_ipvs(t, motion)
end
end
end
function convert_ppptype(t, motion)
if "set" == motion then
elseif "get" == motion then
end
end
function convert_IPtype(t, motion)
if "set" == motion then
if "IP" == t.linkMode then
if "IPoA" == t.Addressingtype or "CIP" == t.Addressingtype then
t.Addressingtype = "Static"
end
end
elseif "get" == motion then
if "IP" == t.linkMode then
if "Static" == t.Addressingtype then
if "IPoA" == t.ATMLinkType or "CIP" == t.ATMLinkType then
t.Addressingtype = t.ATMLinkType
end
end
end
end
end
function convert_aptm_param(t, motion)
if "set" == motion then
if "bridge" == t.mode then
if "1" == t.uplink then
if "1" == t.xdslMode then
t.ATMLinkType = "EoA"
elseif "2" == t.xdslMode then
t.PTMLinkType = "OE"
end
end
elseif "route" == t.mode then
if "1" == t.uplink then
if "PPP" == t.linkMode then
if "PPPoE" == t.TransType then
if "1" == t.xdslMode then
t.ATMLinkType = "EoA"
elseif "2" == t.xdslMode then
t.PTMLinkType = "OE"
end
elseif "PPPoA" == t.TransType then
t.ATMLinkType = "PPPoA"
end
elseif "IP" == t.linkMode then
if "Static" == t.Addressingtype or "DHCP" == t.Addressingtype then
if "1" == t.xdslMode then
t.ATMLinkType = "EoA"
elseif "2" == t.xdslMode then
t.PTMLinkType = "OE"
end
elseif "IPoA" == t.Addressingtype then
t.ATMLinkType = "IPoA"
elseif "CIP" == t.Addressingtype then
t.ATMLinkType = "CIP"
end
end
end
end
elseif "get" == motion then
end
end
function convert_ppp(t, motion)
if "set" == motion then
if "route" == t.mode and "PPP" == t.linkMode then
local strpass = string.format("%c%c%c%c%c%c", 9,9,9,9,9,9)
if strpass == t.Password then
t.Password = clear
else
if cgilua.POST.encode ~= nil then
local decodeKV = cmapi.nocsrf.rsa_decrypt(cgilua.POST.encode)
local key,iv = string.match(decodeKV,"(%d+)%+(%d+)")
if string.len(t.Password) > 0 then
t.Password = cmapi.nocsrf.aes_decrypt(t.Password, key, iv)
if t.Password == strpass then
t.Password = clear
end
end
end
end
if strpass == t.UserName then
t.UserName = clear
else
if cgilua.POST.encode ~= nil then
local decodeKV = cmapi.nocsrf.rsa_decrypt(cgilua.POST.encode)
local key,iv = string.match(decodeKV,"(%d+)%+(%d+)")
if string.len(t.UserName) > 0 then
t.UserName = cmapi.nocsrf.aes_decrypt(t.UserName, key, iv)
if t.UserName == strpass then
t.UserName = clear
end
end
end
end
if "OnDemand" == t.ConnTrigger then
if "" == t.IdleTime1 then
t.IdleTime1 = 0
end
if "" == t.IdleTime0 then
t.IdleTime0 = 0
end
t.IdleTime = tostring(t.IdleTime0 * 60 + t.IdleTime1)
end
if "PPPoA" == t.TransType then
t.EnablePassThrough = clear
end
else
t.Password = clear
t.UserName = clear
t.AuthType = clear
t.ConnTrigger = clear
t.IdleTime = clear
t.EnablePassThrough = clear
end
elseif "get" == motion then
if "route" == t.mode and "PPP" == t.linkMode then
if (env.getenv("ShowWanPassword")== "0") and (string.find(_G.commConf.passCanSee,"Pppoe") == nil) then
t.Password = nil
else
if _G.commConf.getEncode then
local sessmgr = require("user_mgr.session_mgr")
local key = sessmgr.GetCurrentSessAttr("sess_token")
local iv = string.reverse(key)
if t.Password ~= nil and string.len(t.Password) > 0 then
t.Password = cmapi.nocsrf.aes_encrypt(t.Password, key, iv)
end
end
end
if env.getenv("ShowWanUsername") == "0" then
t.UserName = nil
else
if _G.commConf.getEncode then
local sessmgr = require("user_mgr.session_mgr")
local key = sessmgr.GetCurrentSessAttr("sess_token")
local iv = string.reverse(key)
if t.UserName ~= nil and string.len(t.UserName) > 0 then
t.UserName = cmapi.nocsrf.aes_encrypt(t.UserName, key, iv)
end
end
end
if "OnDemand" == t.ConnTrigger then
t.IdleTime0 = tostring((t.IdleTime-t.IdleTime%60)/60)
t.IdleTime1 = tostring(t.IdleTime%60)
end
if "PPPoA" == t.TransType then
t.EnablePassThrough = nil
end
t.IdleTime = nil
else
t.Password = nil
t.UserName = nil
t.AuthType = nil
t.ConnTrigger = nil
t.IdleTime = nil
t.EnablePassThrough = nil
end
end
end
function convert_atm_param(t, motion)
if "set" == motion then
if "1" == t.uplink and "1" == t.xdslMode then
if "UBR" == t.ATMQoS then
t.ATMPeakCellRate = clear
t.ATMSCR = clear
t.ATMMaxBurstSize = clear
elseif "CBR" == t.ATMQoS then
t.ATMSCR = clear
t.ATMMaxBurstSize = clear
elseif "VBR-nrt" == t.ATMQoS or "VBR-rt" == t.ATMQoS then
t.ATMMinCellRate = "0"
end
elseif "1" == t.uplink and "2" == t.xdslMode then
t.ATMPeakCellRate = clear
t.ATMSCR = clear
t.ATMMaxBurstSize = clear
end
elseif "get" == motion then
if "1" == t.uplink and "1" == t.xdslMode then
if "UBR" == t.ATMQoS then
t.ATMPeakCellRate = nil
t.ATMSCR = nil
t.ATMMaxBurstSize = nil
elseif "CBR" == t.ATMQoS then
t.ATMSCR = nil
t.ATMMaxBurstSize = nil
elseif "VBR-nrt" == t.ATMQoS or "VBR-rt" == t.ATMQoS then
end
end
end
end
function convert_DestAddress(t, motion)
if "set" == motion then
if "1" == t.uplink and "1" == t.xdslMode then
t.DestAddress = t.sub_DestAddress0..'/'..t.sub_DestAddress1
elseif "1" == t.uplink and "2" == t.xdslMode then
t.DestAddress = clear
end
elseif "get" == motion then
if "1" == t.uplink and "1" == t.xdslMode then
t.sub_DestAddress0,t.sub_DestAddress1 = string.split(t.DestAddress,'/')
end
end
end
function convert_mtu(t, motion)
if "set" == motion then
if "bridge" == t.mode then
t.MTU = clear
end
elseif "get" == motion then
end
end
string.split = function(s, p)
local rt= {}
string.gsub(s, '[^'..p..']+', function(w) table.insert(rt, w) end)
return unpack(rt)
end
function convert_ipvf(t, motion)
local temp = "0.0.0.0"
local cWanName = ""
if _G.wanConf["staticIPIgnore"] ~= nil then
cWanName = _G.wanConf["staticIPIgnore"]
end
if "set" == motion then
if "route" == t.mode and "IP" == t.linkMode then
if "DHCP" ~= t.Addressingtype then
if ""==t.wanid or cWanName~=t.WANCName then
t.IPAddress = t.IPAddress0..'.'..t.IPAddress1..'.'..t.IPAddress2..'.'..t.IPAddress3
t.SubnetMask = t.SubnetMask0..'.'..t.SubnetMask1..'.'..t.SubnetMask2..'.'..t.SubnetMask3
t.GateWay = t.GateWay0..'.'..t.GateWay1..'.'..t.GateWay2..'.'..t.GateWay3
t.DNS1 = t.DNS10..'.'..t.DNS11..'.'..t.DNS12..'.'..t.DNS13
t.DNS2 = t.DNS20..'.'..t.DNS21..'.'..t.DNS22..'.'..t.DNS23
t.DNS3 = t.DNS30..'.'..t.DNS31..'.'..t.DNS32..'.'..t.DNS33
end
end
end
elseif "get" == motion then
if "route" == t.mode and "IP" == t.linkMode then
if t.WANCName == cWanName then
t.IPAddress = temp
t.SubnetMask = temp
t.GateWay = temp
t.DNS1 = temp
t.DNS2 = temp
t.DNS3 = temp
end
if "0" == t.pageType then
if "IPv4" == t.IpMode or "Both" == t.IpMode then
if "Static" == t.Addressingtype or
"IPoA" == t.Addressingtype or
"CIP" == t.Addressingtype then
local fillAttr = _G.wanConf["selfCfgIP"]
local ipFill, smFill, gwFill, dnsFill = string.split(fillAttr, ',')
if temp ~= t.IPAddress or ipFill == "0" then
t.IPAddress0,t.IPAddress1,t.IPAddress2,t.IPAddress3 = string.split(t.IPAddress, '.')
end
if temp ~= t.SubnetMask or smFill == "0" then
t.SubnetMask0,t.SubnetMask1,t.SubnetMask2,t.SubnetMask3 = string.split(t.SubnetMask,'.')
end
if temp ~= t.GateWay or gwFill == "0" then
t.GateWay0,t.GateWay1,t.GateWay2,t.GateWay3 = string.split(t.GateWay,'.')
end
if temp ~= t.DNS1 or dnsFill == "0" then
t.DNS10,t.DNS11,t.DNS12,t.DNS13 = string.split(t.DNS1,'.')
end
if temp ~= t.DNS2 or dnsFill == "0" then
t.DNS20,t.DNS21,t.DNS22,t.DNS23 = string.split(t.DNS2,'.')
end
if temp ~= t.DNS3 or dnsFill == "0" then
t.DNS30,t.DNS31,t.DNS32,t.DNS33 = string.split(t.DNS3,'.')
end
end
end
end
end
if "0" == t.pageType then
t.IPAddress = nil
t.SubnetMask = nil
t.GateWay = nil
t.DNS1 = nil
t.DNS2 = nil
t.DNS3 = nil
end
end
end
function convert_ipvs_gateway(t, motion)
if "set" == motion then
if "Manual" == t.IPv6AcquireMode then
if "PPP" == t.linkMode then
t.Gateway6 = nil
elseif "IP" == t.linkMode then
if "" == t.Gateway6 then
t.Gateway6 = "::"
end
end
elseif "Auto" == t.IPv6AcquireMode then
t.Gateway6 = nil
elseif "IPv6CPExtension" == t.IPv6AcquireMode then
t.Gateway6 = nil
end
elseif "get" == motion then
if "Manual" == t.IPv6AcquireMode then
if "PPP" == t.linkMode then
t.Gateway6 = ("1" == t.pageType) and t.Gateway6 or nil
elseif "IP" == t.linkMode then
if "::" == t.Gateway6 then
t.Gateway6 = ("1" == t.pageType) and t.Gateway6 or nil
end
end
elseif "Auto" == t.IPv6AcquireMode then
t.Gateway6 = ("1" == t.pageType) and t.Gateway6 or nil
elseif "IPv6CPExtension" == t.IPv6AcquireMode then
t.Gateway6 = ("1" == t.pageType) and t.Gateway6 or nil
end
end
end
function convert_ipvs_guasrc(t, motion)
if "set" == motion then
if "Manual" == t.IPv6AcquireMode then
if "" == t.Gua1 then
t.Gua1 = "::"
end
if "" == t.Gua1PrefixLen then
t.Gua1PrefixLen = "0"
end
elseif "Auto" == t.IPv6AcquireMode then
t.Gua1 = nil
t.Gua1PrefixLen = nil
elseif "IPv6CPExtension" == t.IPv6AcquireMode then
t.Gua1 = nil
t.Gua1PrefixLen = nil
end
elseif "get" == motion then
if "Manual" == t.IPv6AcquireMode then
if "::" == t.Gua1 then
t.Gua1 = ("1" == t.pageType) and t.Gua1 or nil
end
if "0" == t.Gua1PrefixLen then
t.Gua1PrefixLen = ""
end
t.Gua1PrefixLen = "128"
elseif "Auto" == t.IPv6AcquireMode then
t.Gua1 = ("1" == t.pageType) and t.Gua1 or nil
t.Gua1PrefixLen = ("1" == t.pageType) and t.Gua1PrefixLen or nil
elseif "IPv6CPExtension" == t.IPv6AcquireMode then
t.Gua1 = ("1" == t.pageType) and t.Gua1 or nil
t.Gua1PrefixLen = ("1" == t.pageType) and t.Gua1PrefixLen or nil
end
end
end
function convert_ipvs_dns(t, motion)
if "set" == motion then
if "Manual" == t.IPv6AcquireMode then
if "" == t.Dns1v6 then
t.Dns1v6 = "::"
end
if "" == t.Dns2v6 then
t.Dns2v6 = "::"
end
if "" == t.Dns3v6 then
t.Dns3v6 = "::"
end
elseif "Auto" == t.IPv6AcquireMode then
t.Dns1v6 = nil
t.Dns2v6 = nil
t.Dns3v6 = nil
elseif "IPv6CPExtension" == t.IPv6AcquireMode then
t.Dns1v6 = nil
t.Dns2v6 = nil
t.Dns3v6 = nil
end
elseif "get" == motion then
if "Manual" == t.IPv6AcquireMode then
if "::" == t.Dns1v6 then
t.Dns1v6 = ("1" == t.pageType) and t.Dns1v6 or nil
end
if "::" == t.Dns2v6 then
t.Dns2v6 = ("1" == t.pageType) and t.Dns2v6 or nil
end
if "::" == t.Dns3v6 then
t.Dns3v6 = ("1" == t.pageType) and t.Dns3v6 or nil
end
elseif "Auto" == t.IPv6AcquireMode then
t.Dns1v6 = ("1" == t.pageType) and t.Dns1v6 or nil
t.Dns2v6 = ("1" == t.pageType) and t.Dns2v6 or nil
t.Dns3v6 = ("1" == t.pageType) and t.Dns3v6 or nil
elseif "IPv6CPExtension" == t.IPv6AcquireMode then
t.Dns1v6 = ("1" == t.pageType) and t.Dns1v6 or nil
t.Dns2v6 = ("1" == t.pageType) and t.Dns2v6 or nil
t.Dns3v6 = ("1" == t.pageType) and t.Dns3v6 or nil
end
end
end
function convert_ipvs_ispd(t, motion)
if "set" == motion then
if "Manual" == t.IPv6AcquireMode then
if "" == t.Pd then
t.Pd = "::"
end
if "" == t.PdLen then
t.PdLen = "0"
end
elseif "Auto" == t.IPv6AcquireMode then
t.Pd = nil
t.PdLen = nil
elseif "IPv6CPExtension" == t.IPv6AcquireMode then
t.Pd = nil
t.PdLen = nil
end
elseif "get" == motion then
if "Manual" == t.IPv6AcquireMode then
if "::" == t.Pd then
t.Pd = ""
end
if "0" == t.PdLen then
t.PdLen = ""
end
elseif "Auto" == t.IPv6AcquireMode then
t.Pd = ("1" == t.pageType) and t.Pd or nil
t.PdLen = ("1" == t.pageType) and t.PdLen or nil
elseif "IPv6CPExtension" == t.IPv6AcquireMode then
t.Pd = nil
t.PdLen = nil
end
end
end
function convert_ipvs_switcher(t, motion)
if "Manual" == t.IPv6AcquireMode or "IPv6CPExtension" == t.IPv6AcquireMode then
t.IsSLAAC = nil
t.IsGUA = nil
t.IsPD = nil
t.IsPdAddr = nil
t.Unnumbered = nil
end
end
function convert_ipvs(t, motion)
convert_ipvs_gateway(t, motion)
convert_ipvs_guasrc(t, motion)
convert_ipvs_dns(t, motion)
convert_ipvs_ispd(t, motion)
convert_ipvs_switcher(t, motion)
end
function convert_clear_ipvf(t, motion)
if "IPv6" == t.IpMode then
if "set" == motion then
t.Addressingtype = nil
end
t.IPAddress = nil
t.SubnetMask = nil
t.GateWay = nil
t.DNS1 = nil
t.DNS2 = nil
t.DNS3 = nil
t.ConnError = nil
end
end
function convert_clear_ipvs(t, motion)
if "IPv4" == t.IpMode then
t.LLA = nil
t.IPv6AcquireMode = nil
t.GuaNum = nil
t.Gua1 = nil
t.Gua1PrefixLen = nil
t.Gua2 = nil
t.Gua2PrefixLen =nil
t.Gua3 = nil
t.Gua3PrefixLen = nil
t.Dns1v6 = nil
t.Dns2v6 = nil
t.Dns3v6 = nil
t.LLAStatus = nil
t.UpTimeV6 = nil
t.Gateway6 = nil
t.IsPd = nil
t.IsSLAAC = nil
t.IsGUA = nil
t.IsPD = nil
t.IsPdAddr = nil
t.Pd = nil
t.PdLen = nil
t.Unnumbered = nil
end
end
function convert_clear_noused(t, motion)
if "set" == motion then
t.GuaNum = "1"
elseif "get" == motion then
t.IPv6CPExt = nil
t.ConnType = nil
t.LANDViewName = nil
t.IsForward = nil
t.EnableProxy = nil
t.PTMLinkType = nil
t.ATMLinkType = nil
t.ATMMinCellRate = nil
t.ATMCDV = nil
t.ValidLANTx = nil
t.HostTrigger = nil
t.MRU = nil
t.MaxUser = nil
t.ValidWANRx = nil
t.ValidLANTx = nil
end
end
function convert_clear_status_configuration(t, motion)
if "set" == motion then
elseif "get" == motion then
if "0" == t.pageType then
t.ConnStatus6 = nil
t.UpTimeV6 = nil
t.UpTime = nil
t.RemainLeaseTime = nil
t.ConnStatus = nil
t.Gua2 = nil
t.Gua2PrefixLen = nil
t.Gua3 = nil
t.Gua3PrefixLen = nil
elseif "1" == t.pageType then
end
end
end
function deal_simple_detail_data(t, motion)
if "set" == motion then
if "0" == t.ControlType and "Apply" == t.action then
if "" == t.wanid then
if t.Priority then
t.Priority = "0"
end
if t.AuthType then
t.AuthType = "PAP,CHAP,MS-CHAP"
end
if t.ConnTrigger then
t.ConnTrigger = "AlwaysOn"
end
if t.IdleTime then
t.IdleTime = "1200"
end
if t.EnablePassThrough then
t.EnablePassThrough = "0"
end
if t.ATMEncapsulation then
t.ATMEncapsulation = "LLC"
end
else
t.Priority = clear
t.AuthType = clear
if "IPv4" == t.IpMode then
t.ConnTrigger = clear
end
t.IdleTime = clear
t.EnablePassThrough = clear
t.ATMEncapsulation = clear
end
end
elseif "get" == motion then
end
end
function convert_post_to_cmapi(tpost)
convert_DestAddress(tpost, "set")
convert_atm_param(tpost, "set")
convert_mode_link(tpost, "set")
convert_serverlist_link(tpost, "set")
convert_aptm_param(tpost, "set")
convert_linkmode(tpost, "set")
convert_IpMode(tpost, "set")
convert_vlan(tpost, "set")
convert_dscp(tpost, "set")
convert_ppp(tpost, "set")
convert_clear_noused(tpost, "set")
convert_clear_ipvf(tpost, "set")
convert_clear_ipvs(tpost, "set")
convert_clear_status_configuration(tpost, "set")
deal_simple_detail_data(tpost, "set")
end
function convert_cmapi_to_post(tcmapi)
convert_DestAddress(tcmapi, "get")
convert_atm_param(tcmapi, "get")
convert_mode_link(tcmapi, "get")
convert_serverlist_link(tcmapi, "get")
convert_aptm_param(tcmapi, "get")
convert_linkmode(tcmapi, "get")
convert_IpMode(tcmapi, "get")
convert_vlan(tcmapi, "get")
convert_dscp(tcmapi, "get")
convert_ppp(tcmapi, "get")
convert_clear_noused(tcmapi, "get")
convert_clear_ipvf(tcmapi, "get")
convert_clear_ipvs(tcmapi, "get")
convert_clear_status_configuration(tcmapi, "get")
end
