dmenu:addModifierLoader( function ()
local sipslc = dmenu:findMenu("sipslc")
if sipslc then
dmenu:newArea({area="Columbia_voip_slctime_t.lp", backendFile="voip_slctime_lua.lua", right=1}):appendTo("sipslc")
end
dmenu:replaceArea({
{
"wlanBasic",
"wlan_wlansssidconf_t.lp",
"claro_wlan_wlansssidconf_t.lp",
},
{
"homePage",
"home_t.lp",
"claro_home_t.lp",
{"wlan_homepage_lua.lua","accessdev_homepage_lua.lua","firewall_homepage_lua.lua", "home_userid_lua.lua", "usb_homepage_lua.lua", "voip_homepage_lua.lua", "wlan_qrcode_data.lua"},
},
{
"accountMgr",
"devauth_accountmgr_t.lp",
"claro_devauth_accountmgr_t.lp",
},
{
"wlanBasic",
"wlan_wlanbasicadconf_t.lp",
"claro_wlan_wlanbasicadconf_t.lp",
},
})
dmenu:setRight('3',{
menuList = {
'ethWanConfig',
'Wan3gConfig',
'tunnel4in6Config',
'tunnel6in4Config',
'l2tpConfig',
}
})
dmenu:setRight('7',{
menuList = {
'parentCtrl',
'firewall',
'filterCriteria',
'sntp',
'lanMgrIpv4',
'ftp',
'dms',
'samba',
'usbfunccfg',
'usrCfgMgr',
'localNetGuestwifi',
'wlanAdvanced',
'wps',
},
pageList = {
{'wlanBasic','claro_wlan_wlanbasicadconf_t.lp'},
{'accountMgr','web_login_timeout_t.lp'},
}
})
dmenu:removeList({
menuList = {
'wifibandsteer'
},
})
dmenu:replaceArea({
{
"localNetStatus",
"wlan_wlanstatus_t.lp",
"claro_wlan_wlanstatus_t.lp",
"claro_wlan_wlanstatus_lua.lua"
}
})
dmenu:newPage(
{
id="localNetGuestwifi",
name=lang.GuestWifi_04,
right=3,
pageHelp=lang.GuestWifi_05,
areas={
{area="claro_wlan_guestwifi_t.lp", backendFile="claro_wlan_guestwifi_lua.lua"},
}
})
:insertAfter("wlanBasic")
if dmenu:findMenu("ddns") ~= nil then
dmenu:newPage({
id="TimerMACFilter",
right=0,
name=lang.TimerMACFilter_003,
pageHelp=lang.TimerMACFilter_002,
areas={
{area="timer_mac_filter_model.lua"},
{area="timer_mac_filter_rules_t.lp", backendFile="timer_mac_filter_rules_lua.lua"},
},
})
:insertBefore("ddns")
end
end)
