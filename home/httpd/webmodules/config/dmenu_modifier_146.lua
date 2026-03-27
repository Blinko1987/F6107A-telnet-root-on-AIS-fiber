dmenu:addModifierLoader( function ()
dmenu:setRight('3',{
menuList = {
'homePage',
'mmTopology',
'ethWanStatus',
'Wan3gStatus',
'tunnel4in6Status',
'tunnel6in4Status',
'l2tpStatus',
'wanStaStatus',
'portBinding',
'voipStatus',
'statusMgr',
'lanMgrIpv6',
'filterCriteria',
'alg',
'localServiceCtrl',
'ethWanConfig',
'remoteMgr'
},
pageList = {
{'localNetStatus','accessdev_landevs_t.lp'},
{'wlanBasic','wlan_wlanbasiconoff_t.lp'}
}
})
dmenu:setRight('0',{
menuList = {
'portForwarding',
'firewall'
},
pageList = {
{'localNetStatus','wlan_client_stat_t.lp'},
{'wlanBasic','wlan_wlanbasicadconf_t.lp','wlan_wlansssidconf_t.lp'}
}
})
dmenu:setRight('1',{
menuList = {
'sntp',
'rebootAndReset',
'usrCfgMgr',
'IPv6SwitchMgr'
},
pageList = {
{'localNetStatus','usb_usbdevs_t.lp'}
}
})
dmenu:removeList({
pageList = {
{'localNetStatus','wlan_wlanstatuslowright_t.lp'},
{'wlanBasic','wlan_wlansssidconflowright_t.lp'}
}
})
end)
