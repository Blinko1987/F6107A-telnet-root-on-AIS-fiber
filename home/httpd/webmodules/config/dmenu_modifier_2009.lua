dmenu:addModifierLoader( function ()
dmenu:setRight('1',{
menuList={
'tunnel4in6Status',
'l2tpStatus',
'usrCfgMgr'
}
})
dmenu:setRight('0',{
menuList={
'dmz',
'portForwarding',
'ddns',
'lanMgrIpv6',
'upnp',
'dns',
'wifibandsteer'
}
})
local wps = dmenu:findMenu("wps")
if wps then
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
},
}
)
:insertAfter("wps")
end
dmenu:removeList({
menuList = {'usrCfgMgr','usbrestore','usbbackup'}
})
end)
