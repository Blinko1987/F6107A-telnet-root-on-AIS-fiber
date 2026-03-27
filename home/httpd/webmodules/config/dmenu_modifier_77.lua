dmenu:addModifierLoader( function ()
dmenu:newPage(
{
id="conntracks",
name=lang.Conntracks_001,
right=3,
pageHelp=lang.Conntracks_002,
extData=lang.publichelp,
areas={
{area="firewall_conntrack_t.lp", backendFile="firewall_conntrack_lua.lua"},
}
})
:insertAfter("l2tpStatus")
if env.getenv("wifiSupport") ~= "0" then
dmenu:newPage(
{
id="BandSteerMesh",
right=3,
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
id="SmartWifi",
right=3,
name=lang.smartwifi_001,
pageHelp=lang.smartwifi_002,
areas={
{area="wlan_smartwifi_t.lp",backendFile="wlan_smartwifi_lua.lua"},
},
}
)
:insertAfter("wlanAdvanced")
dmenu:newArea({area="wlan_wps_btn_t.lp", backendFile="wlan_wps_btn_lua.lua"}):insertAfter("wps", "wlan_wps_t.lp")
end
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
dmenu:newPage(
{
id="masonumode",
name=lang.MasOnuMode_001,
right=3,
pageHelp=lang.MasOnuMode_007,
extData=lang.UPnP_100,
areas={
{area="masmovil_onuMode_t.lp", backendFile="masmovil_onuMode_lua.lua"},
}
}
)
:insertAfter("internetConfig")
dmenu:setRight('0',{
menuList = {'sipAdvanced'},
pageList = {
{'filterCriteria','firewall_macfilterv3_t.lp','firewall_urlfilter_m.lua'},
}
})
dmenu:setRight('3',{
menuList = {'ponopticalinfo'}
})
dmenu:setRight('1',{
menuList = {'localServiceCtrl'}
})
dmenu:removeList({
menuList = {'BandSteerMesh','clearlink','ftp'},
pageList = {
{"localServiceCtrl",'firewall_ipv6service_t.lp'}
}
})
local function TopologyMenu()
local retTable = nil
local MeshMode = "0"
retTable = cmapi.getinst("OBJ_NETSPHERE_MAP_ID", "")
if retTable.IF_ERRORID == 0 then
MeshMode = retTable["Enable"]
end
if MeshMode == "1" then
return false
end
return true
end
local masmoviltopo = dmenu:findMenu("mmTopology")
if masmoviltopo ~= nil then
masmoviltopo:setAttribute("filterFunc",TopologyMenu)
end
dmenu:replaceArea({
{
"localServiceCtrl",
"firewall_ipv4service_t.lp",
"masmovil_firewall_ipv4service_t.lp",
"masmovil_firewall_ipv4service_lua.lua"
},
{
"wlanBasic",
"wlan_wlanbasiconoff_t.lp",
"masmv_wlan_wlanbasiconoff_t.lp",
"masmv_wlan_wlanbasiconoff_lua.lua"
}
})
dmenu:newArea({area="remote_access_model.lua"}):insertBefore("localServiceCtrl", "masmovil_firewall_ipv4service_t.lp")
if env.getenv("OnuModeMas") == "0" then
dmenu:removeList({
menuList = {'homePage','ethWanStatus','tunnel4in6Status','tunnel6in4Status',
'l2tpStatus','conntracks','internetConfig','security','ddns','sntp','portBinding','rip',
'multicast','catv','lanConfig','route','upnp','bpdu','ftp','dms','usbfunccfg','Wan3gStatus',
'samba','remoteMgr','diagnosis','IPv6SwitchMgr','upnpportmapss','dns','parentCtrl','portlocate','voip','wlanConfig'},
pageList = {
{'localNetStatus','wlan_wlanstatus_t.lp','wlan_wlanstatuslowright_t.lp','wlan_client_stat_t.lp',
'accessdev_landevs_t.lp','usb_usbdevs_t.lp'}
}
})
dmenu:setRight('1',{
menuList = {'ponLoid'}
})
else
dmenu:setRight('3',{
menuList = {'alg','dmz','portForwarding','portTrigger','ddns','portBinding','lanMgrIpv6','upnp','dns','logMgr',
'networkDiag','loopbackDetect','arpTable','macTable','routeIpv4','routeIpv6'}
})
dmenu:removeList({
menuList = {'ponLoid'},
})
end
end)
