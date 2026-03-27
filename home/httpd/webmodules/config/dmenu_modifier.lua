dmenu:addModifierLoader( function ()
local function checkVoIPProtocal(...)
for i,v in ipairs({...}) do
if env.getenv("VoIPProtocal") == v then
return true
end
end
return false
end
if env.getenv("voipSupport") ~= "0" then
dmenu:findMenu("voipBasic"):setAttribute("filterFunc", function() return checkVoIPProtocal("H248","MGCP") end)
dmenu:findMenu("sip"):setAttribute("filterFunc", function() return checkVoIPProtocal("H248","MGCP") end)
dmenu:findMenu("sipMedia"):setAttribute("filterFunc", function() return checkVoIPProtocal("H248","MGCP") end)
dmenu:findMenu("dialPlan"):setAttribute("filterFunc", function() return checkVoIPProtocal("H248","MGCP") end)
dmenu:findMenu("voipServices"):setAttribute("filterFunc", function() return checkVoIPProtocal("H248","MGCP") end)
dmenu:findMenu("sipDigitmap"):setAttribute("filterFunc", function() return checkVoIPProtocal("H248","MGCP") end)
dmenu:findMenu("h248Basic"):setAttribute("filterFunc", function() return checkVoIPProtocal("SIP","MGCP") end)
dmenu:findMenu("h248Auth"):setAttribute("filterFunc", function() return checkVoIPProtocal("SIP","MGCP") end)
dmenu:findMenu("mgcpBasic"):setAttribute("filterFunc", function() return checkVoIPProtocal("SIP","H248") end)
dmenu:findMenu("mgcpAuth"):setAttribute("filterFunc", function() return checkVoIPProtocal("SIP","H248") end)
end
if env.getenv("voipSupport") == "0" then
dmenu:findMenu("voip"):remove()
end
if env.getenv("usbSupport") == "0" then
dmenu:findMenu("usbfunccfg"):remove()
dmenu:findMenu("usbrestore"):remove()
dmenu:findMenu("usbbackup"):remove()
dmenu:findMenu("Wan3gStatus"):remove()
dmenu:findMenu("Wan3gConfig"):remove()
dmenu:findMenu("ftp"):remove()
dmenu:findMenu("samba"):remove()
dmenu:findMenu("dms"):remove()
dmenu:findMenu("localNetStatus"):findArea("usb_usbdevs_t.lp"):remove()
else
dmenu:findMenu("Wan3gConfig"):setAttribute("name", lang.Internet3G_001_LTE)
dmenu:findMenu("Wan3gConfig"):setAttribute("pageHelp", lang.Internet3G_002_LTE)
dmenu:findMenu("Wan3gStatus"):setAttribute("name", lang.Internet3G_001_LTE)
dmenu:findMenu("Wan3gStatus"):setAttribute("pageHelp", lang.Internet3GStatus_013_LTE)
end
if env.getenv("wifiSupport") == "0" then
dmenu:findMenu("wanStaStatus"):remove()
dmenu:findMenu("wanStaConfig"):remove()
dmenu:findMenu("wlanConfig"):remove()
dmenu:findMenu("localNetStatus"):findArea("wlan_wlanstatus_t.lp"):remove()
dmenu:findMenu("localNetStatus"):findArea("wlan_wlanstatuslowright_t.lp"):remove()
dmenu:findMenu("localNetStatus"):findArea("wlan_client_stat_t.lp"):remove()
end
if env.getenv("catvSupport") == "0" then
dmenu:findMenu("catv"):remove()
end
function filterSpecialAddr()
local filterThisModel = true
local specailPool = cmapi.querylist("OBJ_DHCPPOOL_ID", "IGD");
local poolCount = 0
if specailPool.IF_ERRORID == 0 then
poolCount = specailPool.Count
end
if poolCount > 0 then
filterThisModel = false
end
return filterThisModel
end
if env.getenv("CountryCode") ~= "31" then
dmenu:findMenu("telnet"):remove()
end
end)
dmenu:addModifierLoader( function ()
if env.getenv("CountryCode") == "130" or env.getenv("CountryCode") == "41" then
dmenu:newArea({area="voip_slctime_t.lp", backendFile={"voip_slctime_lua.lua"}}):insertAfter("sipAdvanced", "voip_voiceproc_t.lp")
end
if env.getenv("voipSupport") ~= "0" then
if env.getenv("VoIPTR104V2") == "1" then
dmenu:newPage(
{
id="sipMediaTr104V2",
name=lang.SIPMedia_001,
right=1,
pageHelp=lang.SIPMedia_004,
extData=lang.SIPMedia_100,
areas={
{area="voip_sipmedia_tr104v2_t.lp",backendFile="voip_sipmedia_tr104v2_lua.lua"},
},
}
)
:insertAfter("sipMedia")
dmenu:findMenu("sipMedia"):remove()
end
end
end)
dmenu:addModifierLoader( function ()
dmenu:newPage({
id="mmTopology",
right=0,
name=lang.pro_topo_001,
pageHelp="",
areas={
{area="topo_t.lp", backendFile="topo_lua.lua"},
}
})
:insertAfter("homePage")
local function filterIfNotMaster()
if env.getenv("Mode") == "Master" and env.getenv("MeshEnable") == "1" then
return false
end
return true
end
dmenu:newPage({
id="smNetSphereMAP",
right=1,
name=lang.pro_MAP_001,
pageHelp=lang.pro_MAP_002,
areas={
{area="Localnet_NetSphere_Mode_t.lp", backendFile="Localnet_NetSphere_Mode_lua.lua"},
{area="roam_t.lp", backendFile="roam_lua.lua",filterFunc=filterIfNotMaster},
}
})
:appendTo("wlanConfig")
end)
dmenu:addModifierLoader( function ()
dmenu:newArea({area="firewall_dos_t.lp", backendFile={"firewall_dos_lua.lua"}}):insertAfter("firewall", "firewall_config_t.lp")
end)
dmenu:addModifierLoader( function ()
end)
dmenu:addModifierLoader( function ()
if env.getenv("CountryCode") == "1" then
dmenu:findMenu("localServiceCtrl"):setAttribute("right", "3")
dmenu:findMenu("portForwarding"):setAttribute("right", "3")
dmenu:newPage(
{
id="upnpportmapss",
name=lang.upnpPortMap_001,
right=3,
pageHelp=lang.upnpPortMap_004,
extData=lang.UPnP_100,
areas={
{area="upnp_portmap_t.lp", backendFile="upnp_portmap_lua.lua"},
}
}
)
:insertAfter("upnp")
if env.getenv("wifiSupport") ~= "0" then
dmenu:newPage(
{
id="wlanStaScanAP",
name=lang.WlanScan_001,
right=3,
pageHelp=lang.WlanScan_011,
extData=lang.publichelp,
areas={
{area="wlan_sta_scanap2g_t.lp", backendFile="wlan_sta_wlan_profile_lua.lua"},
{area="wlan_sta_scanap5g_t.lp", backendFile="wlan_sta_wlan_profile_lua.lua"},
}
}
)
:insertAfter("wps")
dmenu:newArea({area="wlan_wps_btn_t.lp", backendFile="wlan_wps_btn_lua.lua"}):insertAfter("wps", "wlan_wps_t.lp")
dmenu:newPage(
{
id="wlanRateLimit",
name=lang.ratelimit_001,
right=3,
pageHelp=lang.ratelimit_002,
extData=lang.publichelp,
areas={
{area="wlan_ratelimit_t.lp", backendFile="wlan_ratelimit_lua.lua"},
}
}
)
:insertAfter("wlanStaScanAP")
dmenu:newPage(
{
id="guestwifi",
name=lang.guestwifi_001,
right=3,
pageHelp=lang.guestwifi_002,
extData=lang.publichelp,
areas={
{area="mgts_wlan_guestwifi_t.lp", backendFile="mgts_wlan_guestwifi_lua.lua"},
}
}
)
:insertAfter("wlanRateLimit")
dmenu:findMenu("smNetSphereMAP"):remove()
dmenu:newPage({
id="smNetSphereMAP",
right=3,
name=lang.roaming_010,
pageHelp=lang.roaming_011,
areas={
{area="Localnet_NetSphere_Mode_t.lp", backendFile="Localnet_NetSphere_Mode_lua.lua"},
{area="mgts_roam_t.lp", backendFile="mgts_roam_lua.lua"},
}
})
:appendTo("wlanConfig")
dmenu:newPage({
id="smBandSteer",
right=3,
name=lang.bandsteer_001,
pageHelp=lang.bandsteer_013,
areas={
{area="mgts_bandsteer_t.lp", backendFile="mgts_bandsteer_lua.lua"},
}
})
:insertAfter("smNetSphereMAP")
end
if env.getenv("voipSupport") ~= "0" then
dmenu:newArea({area="mgts_Voip_lineStatus_t.lp", backendFile="mgts_voipRegStatus_lua.lua"}):insertBefore("voipStatus", "Voip_phoneStatus_t.lp")
dmenu:findMenu("voipStatus"):findArea("Voip_lineStatus_t.lp"):remove()
dmenu:findMenu("voipServices"):remove()
dmenu:newPage({
id="voipServices",
right=1,
name=lang.SipServices_001,
pageHelp=lang.SipServices_002,
areas={
{area="mgts_voip_services_t.lp", backendFile={"mgts_Voip_SipService_lua.lua","voipDmtTimer_lua.lua"}},
}
})
:insertAfter("voipBasic")
dmenu:findMenu("voipSwithPtcl"):remove()
end
dmenu:findMenu("lanMgrIpv6"):setAttribute("right", "3")
dmenu:findMenu("routeIpv4"):setAttribute("right", "3")
dmenu:findMenu("routeIpv6"):setAttribute("right", "3")
dmenu:findMenu("upnp"):setAttribute("right", "3")
dmenu:findMenu("bpdu"):setAttribute("right", "3")
dmenu:findMenu("dns"):setAttribute("right", "3")
dmenu:findMenu("ponopticalinfo"):setAttribute("right", "3")
end
end)
dmenu:addModifierLoader( function ()
end)
dmenu:addModifierLoader( function ()
end)
if "79" == env.getenv("CountryCode") then
dmenu:addModifierLoader( function ()
dmenu:replaceArea({
{
"ponSn",
"poninfo_sn_t.lp",
"ekt_poninfo_snhex_t.lp",
"ekt_poninfo_snhex_lua.lua"
}
})
dmenu:newPage(
{
id="upnpportmapss",
name=lang.upnpPortMap_001,
right=7,
pageHelp=lang.upnpPortMap_004,
extData=lang.UPnP_100,
areas={
{area="upnp_portmap_t.lp", backendFile="upnp_portmap_lua.lua"},
}
}
)
:insertAfter("upnp")
dmenu:newPage(
{
id="wlanStaScanAP",
name=lang.WlanScan_001,
right=7,
pageHelp=lang.WlanScan_011,
extData=lang.publichelp,
areas={
{area="wlan_scanap2g_t.lp", backendFile="wlan_wlan_profile_lua.lua"},
{area="wlan_scanap5g_t.lp", backendFile="wlan_wlan_profile_lua.lua"},
},
}
)
:insertAfter("wps")
dmenu:newPage(
{
id="BandSteerMesh",
right=1,
name=lang.pro6640_MAP_001,
pageHelp=lang.pro6640_MAP_002,
areas={
{area="NetSphere_Mode_t.lp",backendFile="NetSphere_Mode_lua.lua"},
},
}
)
:insertAfter("wlanAdvanced")
dmenu:newPage(
{
id="ftptest",
right=3,
name=lang.ftp_test_001,
pageHelp=lang.ftp_test_002,
areas={
{area="ftp_test_t.lp",backendFile="ftp_test_lua.lua"},
},
}
)
:insertAfter("lanConfig")
if env.getenv("voipSupport") == "2" then
dmenu:newPage(
{
id="SIPVPMapping",
name=lang.VoipVPMap_001,
right=1,
pageHelp=lang.VoipVPMap_002,
extData=lang.publichelp,
areas={
{area="voip_vpmapping_t.lp", backendFile="voip_vpmapping_lua.lua"}
}
}
)
:insertAfter("voipBasic")
end
local function ModeMenu()
local mode = env.getenv("NetSphereMAPMode")
if mode == "0" then
return true
end
return false
end
dmenu:findMenu("mmTopology"):setAttribute("filterFunc",ModeMenu)
dmenu:removeList({
menuList = {'mirror','smNetSphereMAP','multicastvlan','multicastaddress'},
})
dmenu:setRight('0',{
menuList = {'ponopticalinfo'
},
})
dmenu:setRight('3',{
menuList = {'rebootAndReset','localServiceCtrl','alg',
'rip','multicastmode','igmp','mld','multicastbasic',
'portlocate','routeIpv4','routeIpv6','bpdu','firmwareUpgr',
'logMgr','networkDiag','arpTable','loopbackDetect','macTable','usbrestore','usbbackup','wps'
},
})
dmenu:setRight('7',{
menuList = {'dmz','portForwarding','portTrigger','parentCtrl',
'ddns','lanMgrIpv4','upnp','dns','lanMgrIpv6','wlanAdvanced'},
pageList = {
{'wlanBasic','wlan_wlanbasicadconf_t.lp'}
}
})
dmenu:newPage(
{
id="pmAppList",
name=lang.PMAppList_001,
right=7,
pageHelp=lang.PMAppList_002,
areas={
{area="firewall_pfapplist_t.lp", backendFile="firewall_pfapplist_lua.lua"},
},
}
)
:insertAfter("portForwarding")
dmenu:newPage(
{
id="fwAppList",
name=lang.AppList_001,
right=7,
pageHelp=lang.AppList_002,
areas={
{area="firewall_applist_t.lp", backendFile="firewall_applist_lua.lua"},
{area="firewall_appport_t.lp", backendFile="firewall_appport_lua.lua"},
},
}
)
:insertAfter("pmAppList")
dmenu:replaceArea({
{
"wlanBasic",
"wlan_wlansssidconflowright_t.lp",
"wlan_wlansssidconf_t.lp",
"wlan_wlansssidconf_lua.lua"
}
})
end)
end
dmenu:addModifierLoader( function ()
if env.getenv("CountryCode") == "163" then
dmenu:setRight('3',{
menuList = {'dmz','ddns','ponopticalinfo','portTrigger','portForwarding','ethWanConfig','lanMgrIpv6'},
pageList = {
{'filterCriteria','firewall_macfilterv3_t.lp'},
}
})
dmenu:setRight('1',{
menuList = {'multicastvlan','tunnel4in6Status','tunnel6in4Status','l2tpStatus','sntp',
'Wan3gStatus','ftp','dms','samba','usbfunccfg'},
pageList = {
{'accountMgr','web_login_timeout_t.lp'},
{'lanMgrIpv4','Localnet_LanDevDHCPSource_t.lp'},
{'lanMgrIpv6','addr6_lanaddr_t.lp','prefix_ulaprefix_t.lp','prefix_staticprefix_t.lp',
'dhcp6s_dhcpserver_t.lp','ra_raservice_t.lp','prefix_prefixpool_t.lp',
'radhcp6s_portctrl_t.lp'}
}
})
dmenu:removeList({
menuList = {'wlanAdvanced','wds','wps'},
pageList = {
{'localNetStatus','Localnet_GREStatus_t.lp','Localnet_WLAN_ClientStatus_t.lp','usb_usbdevs_t.lp'},
{'firewall','firewall_dos_t.lp'}
}
})
dmenu:newPage(
{
id="globalCtr",
right=3,
name=lang.BClaro_002,
pageHelp=lang.BClaro_003,
extData=lang.BClaro_003,
areas={
{area = "claro_globalcontrol_t.lp",backendFile="claro_globalcontrol_lua.lua"},
},
}
)
:insertAfter("ddns")
end
end)
dmenu:addModifierLoader( function ()
if "39" == env.getenv("CountryCode") then
dmenu:findMenu("ddns"):setAttribute("right","3")
dmenu:findMenu("dmz"):setAttribute("right","3")
dmenu:findMenu("rebootAndReset"):findArea("db_resetmgr_t.lp"):setAttribute("right", "1")
dmenu:removeList({
menuList = {'usbbackup','localServiceCtrl'}
})
end
end)
dmenu:addModifierLoader( function ()
if env.getenv("CountryCode") == "14" then
dmenu:findMenu("ponopticalinfo"):setAttribute("right","3")
dmenu:findMenu("portBinding"):setAttribute("right","3")
dmenu:findMenu("portlocate"):setAttribute("right","3")
dmenu:findMenu("localServiceCtrl"):setAttribute("right","3")
dmenu:findMenu("alg"):setAttribute("right","3")
dmenu:findMenu("dmz"):setAttribute("right","3")
dmenu:findMenu("portForwarding"):setAttribute("right","3")
dmenu:findMenu("portTrigger"):setAttribute("right","3")
dmenu:findMenu("ddns"):setAttribute("right","3")
dmenu:findMenu("upnp"):setAttribute("right","3")
dmenu:findMenu("dns"):setAttribute("right","3")
dmenu:findMenu("logMgr"):setAttribute("right","3")
dmenu:findMenu("networkDiag"):setAttribute("right","3")
dmenu:findMenu("loopbackDetect"):setAttribute("right","3")
dmenu:findMenu("lanMgrIpv6"):setAttribute("right","3")
dmenu:findMenu("lanMgrIpv6"):findArea("dhcp6s_hostinfo_t.lp"):setAttribute("right","1")
dmenu:findMenu("lanMgrIpv6"):findArea("addr6_lanaddr_t.lp"):setAttribute("right","1")
dmenu:findMenu("lanMgrIpv6"):findArea("prefix_ulaprefix_t.lp"):setAttribute("right","1")
dmenu:findMenu("lanMgrIpv6"):findArea("prefix_staticprefix_t.lp"):setAttribute("right","1")
dmenu:findMenu("lanMgrIpv6"):findArea("prefix_prefixpool_t.lp"):setAttribute("right","3")
dmenu:findMenu("routeIpv4"):setAttribute("right","3")
dmenu:findMenu("routeIpv6"):setAttribute("right","3")
dmenu:findMenu("arpTable"):setAttribute("right","3")
dmenu:findMenu("macTable"):setAttribute("right","3")
dmenu:findMenu("accountMgr"):findArea("web_login_timeout_t.lp"):setAttribute("right","1")
dmenu:findMenu("filterCriteria"):findArea("firewall_macfilterv3_t.lp"):setAttribute("right","3")
dmenu:findMenu("filterCriteria"):findArea("firewall_urlfilter_m.lua"):setAttribute("right","3")
if env.getenv("usbSupport") ~= "0" then
dmenu:findMenu("usbrestore"):setAttribute("right","3")
dmenu:findMenu("usbbackup"):setAttribute("right","3")
dmenu:findMenu("Wan3gConfig"):setAttribute("right","3")
end
dmenu:newPage(
{
id="wpsbutton",
name=lang.WPS_018,
right=3,
pageHelp=lang.WPS_019,
extData=lang.WPS_020,
areas={
{area="true_wlan_wpsbtn_t.lp", backendFile="true_wlan_wpsbtn_lua.lua"},
},
}
)
:insertAfter("wps")
local NetSphereMAP = dmenu:findMenu("smNetSphereMAP")
NetSphereMAP:setAttribute("name", "EasyMesh"):setAttribute("right", "3"):setAttribute("pageHelp",lang.pro_MAP_016)
NetSphereMAP:findArea("Localnet_NetSphere_Mode_t.lp"):setAttribute("area", "wlan_NetSphere_Mode_t.lp"):setAttribute("backendFile", "wlan_NetSphere_Mode_lua.lua")
end
end)
dmenu:addModifierLoader( function ()
if env.getenv("CountryCode") == "118" then
dmenu:findMenu("dmz"):setAttribute("right","3")
dmenu:findMenu("portForwarding"):setAttribute("right","3")
dmenu:findMenu("portTrigger"):setAttribute("right","3")
end
end)
dmenu:addModifierLoader( function ()
if env.getenv("CountryCode") == "77" then
if env.getenv("voipSupport") ~= "0" then
dmenu:setRight('0',{
menuList = {'sipAdvanced'}
})
end
end
end)
dmenu:addModifierLoader( function ()
if env.getenv("CountryCode") == "106" then
end
end)
dmenu:addModifierLoader( function ()
if env.getenv("CountryCode") == "138" then
dmenu:replaceArea({
{
"wlanBasic",
"wlan_wlanbasiconoff_t.lp",
"oci_wlan_wlanbasiconoff_t.lp",
{"oci_wlan_wlanbasiconoff_lua.lua"}
}
})
dmenu:removeList({
menuList = {'usrCfgMgr','usbrestore','usbbackup'},
pageList = {
{'localServiceCtrl','firewall_ipv6service_t.lp'}
}
})
dmenu:setRight('3',{
menuList = {
},
})
end
end)
dmenu:addModifierLoader( function ()
if env.getenv("CountryCode") == "174" then
dmenu:removeList({
menuList = {'usrCfgMgr','usbrestore','usbbackup'}
})
end
end)
dmenu:addModifierLoader( function ()
if env.getenv("CountryCode") == "68" then
dmenu:findMenu("lanMgrIpv4"):setAttribute("right","1")
dmenu:findMenu("usrCfgMgr"):findArea("db_usrcfg_download_t.lp"):setAttribute("right","1")
dmenu:replaceArea({
{
"wlanAdvanced",
"wlan_macfilterrule_t.lp",
"meg_wlan_macfilterrule_t.lp"
}
})
dmenu:newArea({area="wlan_isolate_t.lp", backendFile={"wlan_isolate_lua.lua"}}):insertAfter("filterCriteria", "firewall_urlfilter_m.lua")
dmenu:findMenu("upnp"):setAttribute("right","3")
dmenu:findMenu("dmz"):setAttribute("right","3")
dmenu:findMenu("portForwarding"):setAttribute("right","3")
dmenu:newPage(
{
id="LogTraceM",
name=lang.LogTrace_001,
right=1,
pageHelp=lang.LogTrace_003,
extData=lang.LogTrace_001,
areas={
{area="logTrace_t.lp", backendFile="logTrace_lua.lua"},
{area = "log_syslogdown_t.lp", backendFile={"updownload_prevent_ctl.lua", "do_download_syslog.lua"}},
{area = "log_ttylogdown_t.lp", backendFile={"updownload_prevent_ctl.lua", "do_download_ttylog.lua", "do_delete_ttylog.lua"}},
{area = "log_tcplogdown_t.lp", backendFile={"updownload_prevent_ctl.lua", "do_download_tcplog.lua", "do_delete_tcplog.lua"}},
}
}
)
:insertAfter("logMgr")
end
end)
dmenu:addModifierLoader( function ()
if env.getenv("CountryCode") == "131" then
dmenu:findMenu("firewall"):setAttribute("right","1")
dmenu:findMenu("filterCriteria"):setAttribute("right","1")
dmenu:findMenu("sntp"):setAttribute("right","1")
if env.getenv("usbSupport") ~= "0" then
dmenu:findMenu("ftp"):setAttribute("right","1")
dmenu:findMenu("dms"):setAttribute("right","1")
dmenu:findMenu("samba"):setAttribute("right","1")
dmenu:findMenu("usbfunccfg"):setAttribute("right","1")
end
dmenu:findMenu("rebootAndReset"):setAttribute("right","1")
dmenu:findMenu("usrCfgMgr"):setAttribute("right","1")
dmenu:findMenu("accountMgr"):setAttribute("right","1")
dmenu:setRight('1',{
menuList = {
'wps'
}
})
local account = dmenu:findMenu("accountMgr")
if account then
dmenu:newPage(
{
id="MSSHEnable",
right=1,
name=lang.malay_SSH_02,
pageHelp=lang.malay_SSH_03,
areas={
{area="malay_ssh_enable_model.lua"},
}
}
)
:insertAfter("accountMgr")
dmenu:newPage(
{
id="telnet",
name=lang.TelnetManag_001,
right=1,
pageHelp=lang.Telnet_002,
extData=lang.publichelp,
areas={
{area="telnet_t.lp", backendFile="telnet_lua.lua"},
},
}
)
:insertAfter("accountMgr")
end
end
end)
dmenu:addModifierLoader( function ()
if env.getenv("CountryCode") == "103" then
dmenu:findMenu("filterCriteria"):findArea("firewall_macfilterv3_t.lp"):setAttribute("right","3")
dmenu:findMenu("filterCriteria"):findArea("firewall_urlfilter_m.lua"):setAttribute("right","3")
dmenu:findMenu("alg"):setAttribute("right","3")
dmenu:findMenu("ddns"):setAttribute("right","3")
dmenu:findMenu("dmz"):setAttribute("right","3")
dmenu:findMenu("upnp"):setAttribute("right","3")
end
end)
dmenu:addModifierLoader( function ()
if env.getenv("CountryCode") == "170" then
dmenu:newPage(
{
id="wlanStaScanAP",
name=lang.WlanScan_001,
right=3,
pageHelp=lang.WlanScan_011,
extData=lang.publichelp,
areas={
{area="wlan_sta_scanap2g_t.lp", backendFile="wlan_sta_wlan_profile_lua.lua"},
{area="wlan_sta_scanap5g_t.lp", backendFile="wlan_sta_wlan_profile_lua.lua"},
}
}
)
:insertAfter("wps")
end
end)
dmenu:addModifierLoader( function ()
if "128" == env.getenv("CountryCode") or "185" == env.getenv("CountryCode") or "204" == env.getenv("CountryCode") then
dmenu:newPage(
{
id="fwtimectrl",
right=1,
name=lang.fwtimectrl_001,
pageHelp=lang.fwtimectrl_002,
extData=lang.fwtimectrl_002,
areas={
{area="fw_timectrl_t.lp",backendFile="fw_timectrl_lua.lua"},
},
}
)
:insertAfter("portTrigger")
dmenu:findMenu("portForwarding"):setAttribute("right", "3")
dmenu:findMenu("ddns"):setAttribute("right", "3")
dmenu:findMenu("networkDiag"):setAttribute("right", "3")
dmenu:findMenu("lanMgrIpv6"):setAttribute("right", "3")
dmenu:findMenu("filterCriteria"):findArea("firewall_macfilterv3_t.lp"):setAttribute("right", "3")
dmenu:findMenu("filterCriteria"):findArea("firewall_urlfilter_m.lua"):setAttribute("right", "3")
dmenu:removeList({
menuList = {'usrCfgMgr','usbrestore','usbbackup'}
})
end
if "128" == env.getenv("CountryCode") then
dmenu:setRight('3',{
menuList = {'dmz','upnp'},
})
end
end)
dmenu:addModifierLoader( function ()
if env.getenv("CountryCode") ~= "66" and env.getenv("CountryCode") ~= "2007" and env.getenv("CountryCode") ~= "165" then
dmenu:findMenu("qos"):remove()
end
end)
dmenu:addModifierLoader( function ()
if env.getenv("CountryCode") == "14" or env.getenv("CountryCode") == "48" then
dmenu:findMenu("ponLoid"):setAttribute("right","3")
end
if env.getenv("CountryCode") == "68" then
dmenu:findMenu("portlocate"):remove()
end
if env.getenv("CountryCode") == "131" or env.getenv("CountryCode") == "112"
or env.getenv("CountryCode") == "48" or env.getenv("CountryCode") == "1"
or env.getenv("CountryCode") == "21" then
dmenu:findMenu("ponSn"):setAttribute("right","3")
end
if env.getenv("CountryCode") == "154" then
dmenu:findMenu("ponLoid"):setAttribute("right","5")
dmenu:findMenu("ponSn"):setAttribute("right","5")
end
if env.getenv("CountryCode") == "2021" then
if dmenu:findMenu("upnp") ~= nil then
dmenu:newArea({area="upnp_portmap_t.lp", backendFile={"upnp_portmap_lua.lua"}}):insertAfter("upnp", "upnp_upnp_t.lp")
end
end
if env.getenv("CountryCode") == "36" then
dmenu:setRight('1',{
menuList = {
'remoteMgr'
}
})
end
if env.getenv("CountryCode") == "163" then
dmenu:replaceArea({
{
"ponSn",
"poninfo_sn_t.lp",
"poninfo_snhex_t.lp",
"poninfo_snhex_lua.lua"
}
})
end
end)
