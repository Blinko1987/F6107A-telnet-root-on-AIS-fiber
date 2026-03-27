dmenu:addModifierLoader( function ()
dmenu:setRight('3',{
menuList = {
'ponopticalinfo','alg', 'dmz', 'portForwarding', 'portTrigger', 'ddns', 'networkDiag', 'arpTable',
'macTable', 'upnp', 'lanMgrIpv6'},
pageList = {
{'localNetStatus','wlan_client_stat_t.lp','accessdev_landevs_t.lp','usb_usbdevs_t.lp'},
{'filterCriteria','firewall_macfilterv3_t.lp','firewall_urlfilter_m.lua','firewall_macfilter_t.lp','firewall_urlfilter_t.lp'}
}
})
dmenu:setRight('1',{
pageList = {
{'filterCriteria','firewall_ip4filter_t.lp','firewall_ip6filter_t.lp','firewall_ipfilter_t.lp'}
}
})
dmenu:newArea({area="upnp_portmap_t.lp", backendFile={"upnp_portmap_lua.lua"}})
:insertAfter("upnp", "upnp_upnp_t.lp")
end)
