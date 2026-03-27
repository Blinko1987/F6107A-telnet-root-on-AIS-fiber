dmenu:addModifierLoader( function ()
if "124" == env.getenv("CountryCode") then
dmenu:setRight('3',{
menuList = {
'portForwarding',
'ddns',
'lanMgrIpv6',
'localServiceCtrl',
'networkDiag'
},
pageList = {
{'filterCriteria','firewall_macfilterv3_t.lp','firewall_urlfilter_m.lua'},
{'localServiceCtrl','firewall_ipv4service_t.lp'}
}
})
dmenu:setRight('1',{
pageList = {
{'localServiceCtrl','firewall_portservice_t.lp'}
}
})
dmenu:removeList({
menuList = {
'usrCfgMgr',
'usbrestore',
'usbbackup'
},
pageList = {
{'localServiceCtrl','firewall_ipv6service_t.lp'}
}
})
dmenu:replaceArea({
{
"wlanBasic",
"wlan_wlanbasiconoff_t.lp",
"osn_wlan_wlanbasiconoff_t.lp",
{"osn_wlan_wlanbasiconoff_lua.lua"}
}
})
dmenu:setDisabled('1:support',{
menuList = {
'firewall',
'filterCriteria',
'alg',
'dmz',
'portForwarding',
'smPCP',
'portTrigger'
}
})
end
end)
