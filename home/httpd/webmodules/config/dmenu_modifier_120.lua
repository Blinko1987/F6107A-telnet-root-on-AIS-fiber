dmenu:addModifierLoader( function ()
dmenu:newArea({area="upnp_portmap_t.lp", backendFile={"upnp_portmap_lua.lua"}}):insertAfter("upnp", "upnp_upnp_t.lp")
dmenu:setRight('3',{
menuList = {
'ddns',
'dmz',
'ponopticalinfo',
"portForwarding",
"portTrigger",
"dns",
"logMgr",
"networkDiag",
"lanMgrIpv6",
"upnp",
},
pageList = {
{'filterCriteria','firewall_macfilterv3_t.lp'}
}
})
dmenu:newPage(
{
id="voipdiagnose",
name=lang.voipdiag_02,
right=1,
pageHelp=lang.voipdiag_03,
extData=lang.voipdiag_03,
areas={
{area="voip_diag_t.lp", backendFile="voip_diag_lua.lua"},
}
}):insertAfter("networkDiag")
end)
