dmenu:addModifierLoader( function ()
local upnp = dmenu:findMenu("upnp")
if upnp then
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
end
dmenu:setDisabled('2',{
menuList = {
'ethWanConfig',
'firewall',
'filterCriteria',
'sntp',
'lanMgrIpv4',
'ftp',
'dms',
'samba',
'usbfunccfg'
},
pageList = {
{'accountMgr','web_login_timeout_t.lp'}
}
})
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
end
dmenu:newPage(
{
id="RegisterSN",
name=lang.multilaser_registersn_001,
right=1,
pageHelp="",
extData=lang.publichelp,
areas={
{area="register_sn_model.lua"},
},
})
:appendTo("devMgr")
end)
