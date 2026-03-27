dmenu:addModifierLoader( function ()
dmenu:replaceArea({
{
"homePage",
"home_t.lp",
"ais_home_t.lp",
{"home_ais_lua.lua"}
}
})
dmenu:newPage(
{
id="lanPortconf",
name=lang.lanPortconf_001,
right=3,
pageHelp=lang.lanPortconf_002,
extData=lang.lanPortconf_003,
areas={
{area="eth_interface_config_t.lp", backendFile="eth_interface_config_lua.lua"},
},
}
)
:insertAfter("lanMgrIpv6")
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
dmenu:newPage(
{
id="telnet",
name=lang.Telnet_001,
right=1,
pageHelp=lang.Telnet_002,
extData=lang.publichelp,
areas={
{area="telnet_t.lp", backendFile="telnet_lua.lua"},
},
}
)
:insertBefore("dns")
local networkDiag = dmenu:findMenu("networkDiag")
if networkDiag then
dmenu:newArea({
area="ManagDiag_DiagnosisManag_NsLookupDiagnosis_t.lp", backendFile={"DiagnosisNsLookupReq_lua.lua"}
})
:insertAfter("networkDiag", "networkdiag_diagmgr_t.lp")
end
local localWLANCfg = dmenu:findMenu("wlanBasic")
if localWLANCfg then
dmenu:newPage({
id="wlan_interference",
right=1,
name=lang.pro_Interference_001,
pageHelp=lang.pro_Interference_002,
areas={
{area="wlan_interference_t.lp", backendFile="wlan_interference_lua.lua"},
}
})
:insertAfter("wps")
end
dmenu:newArea({area="devmgr_systemInfo_t.lp", backendFile={"devmgr_systemInfo_lua.lua"}}):insertAfter("statusMgr", "devmgr_statusmgr_t.lp")
dmenu:newArea({area="devmgr_ScheReboot_t.lp", backendFile={"devmgr_ScheReboot_lua.lua"},right=3})
:insertAfter("rebootAndReset", "devmgr_restartmgr_t.lp")
dmenu:newArea({area="ManagDiag_DeviceManag_ClearConfig_t.lp", backendFile={"ManagDiag_DeviceManag_ClearConfig_lua.lua"}, right=3})
:insertAfter("rebootAndReset", "db_resetmgr_t.lp")
dmenu:newPage({
id="ChangeOPMode",
right=3,
name=lang.pro_OPMode_001,
pageHelp=lang.pro_OPMode_002,
areas={
{area="Manag_Operation_Mode_t.lp", backendFile="Manag_Operation_Mode_lua.lua"},
}
})
:insertAfter("usrCfgMgr")
dmenu:newArea({area="upnp_portmap_t.lp", backendFile={"upnp_portmap_lua.lua"}})
:insertAfter("upnp", "upnp_upnp_t.lp")
dmenu:newPage({
id="SSubVersion",
right=3,
name=lang.StatusManag_022,
pageHelp=lang.sub_version,
areas={
{area="sub_version_model.lua"},
}
})
:appendTo("mgrAndDiag")
dmenu:newPage({
id="WifiAgent",
right=1,
name=lang.pro_CPEAgent_001,
pageHelp=lang.pro_CPEAgent_002,
areas={
{area="CPEAgent_t.lp", backendFile="CPEAgent_lua.lua"},
}
})
:insertAfter("IPv6SwitchMgr")
dmenu:newPage({
id="SetModel",
right=1,
name=lang.agentSetting_004,
pageHelp=lang.agentSetting_005,
areas={
{area="agent_setting_model.lua"},
}
})
:insertAfter("remoteMgr")
dmenu:newPage({
id="Aisbandsteer",
name=lang.wlan_bandsteering_001,
right=3,
pageHelp=lang.wlan_bandsteering_002,
extData=lang.wlan_bandsteering_002,
areas={
{area="ais_wlan_wlanbandsteering_t.lp", backendFile="ais_wlan_wlanbandsteering_lua.lua"},
}
})
:appendTo("wlanConfig")
dmenu:newPage({
id="LockSta",
right=1,
name=lang.LockingStatus_001,
pageHelp=lang.LockingStatus_002,
areas={
{area="ais_LockingStatus_model.lua"},
}
})
:insertAfter("SetModel")
local function ModeMenu()
local mode = env.getenv("OperationMode")
if mode == "0" then
return true
end
return false
end
local function ReuseCPE_status()
local Rstatus = env.getenv("RCPE_status")
local mode = env.getenv("OperationMode")
if Rstatus == "1" or mode ~= "0" then
return true
end
return false
end
local function ModeAuAp()
local mode = env.getenv("OperationMode")
if mode == "0" or mode == "3" then
return true
end
return false
end
local function ModeMenuAp()
local mode = env.getenv("OperationMode")
if mode == "3" then
return true
end
return false
end
dmenu:findMenu("ponopticalinfo"):setAttribute("right","3")
dmenu:setRight("1",{
menuList = {
"Wan3gStatus"
}
})
dmenu:findMenu("routeIpv4"):findArea("route_routedefault_t.lp"):remove()
dmenu:findMenu("routeIpv6"):findArea("route_routedefaultipv6_t.lp"):remove()
dmenu:findMenu("filterCriteria"):findArea("firewall_macfilterv3_t.lp"):setAttribute("right","3")
dmenu:findMenu("filterCriteria"):findArea("firewall_urlfilter_m.lua"):setAttribute("right","3")
dmenu:findMenu("alg"):setAttribute("right","3"):setAttribute("filterFunc",ModeMenu)
dmenu:findMenu("dmz"):setAttribute("right","3"):setAttribute("filterFunc",ModeMenu)
dmenu:findMenu("portForwarding"):setAttribute("right","3"):setAttribute("filterFunc",ModeMenu)
dmenu:findMenu("portTrigger"):setAttribute("right","3"):setAttribute("filterFunc",ModeMenu)
dmenu:findMenu("ddns"):setAttribute("right","3"):setAttribute("filterFunc",ModeAuAp)
dmenu:findMenu("sntp"):setAttribute("right","1"):setAttribute("filterFunc",ModeAuAp)
dmenu:findMenu("rebootAndReset"):findArea("db_resetmgr_t.lp"):setAttribute("right","3")
if env.getenv("usbSupport") ~= "0" then
dmenu:findMenu("usbfunccfg"):setAttribute("filterFunc",ModeAuAp)
dmenu:findMenu("usbrestore"):setAttribute("right","3"):setAttribute("filterFunc",ModeMenuAp)
dmenu:findMenu("usbbackup"):setAttribute("right","3"):setAttribute("filterFunc",ModeMenuAp)
dmenu:findMenu("Wan3gStatus"):setAttribute("filterFunc",ModeMenuAp)
dmenu:findMenu("Wan3gConfig"):setAttribute("filterFunc",ModeMenuAp)
end
dmenu:findMenu("networkDiag"):setAttribute("right","3"):setAttribute("filterFunc",ModeMenu)
dmenu:findMenu("SSubVersion"):setAttribute("filterFunc",ReuseCPE_status)
dmenu:findMenu("mmTopology"):setAttribute("filterFunc",ModeAuAp)
dmenu:findMenu("upnp"):setAttribute("right","3"):setAttribute("filterFunc",ModeAuAp)
dmenu:findMenu("bpdu"):setAttribute("right","3"):setAttribute("filterFunc",ModeAuAp)
dmenu:findMenu("dns"):setAttribute("right","3"):setAttribute("filterFunc",ModeAuAp)
dmenu:findMenu("routeIpv4"):setAttribute("right","3"):setAttribute("filterFunc",ModeAuAp)
dmenu:findMenu("routeIpv6"):setAttribute("right","3"):setAttribute("filterFunc",ModeAuAp)
dmenu:findMenu("homePage"):setAttribute("filterFunc",ModeMenuAp)
dmenu:findMenu("wlanAdvanced"):setAttribute("filterFunc",ModeMenuAp)
dmenu:findMenu("lanMgrIpv4"):setAttribute("filterFunc",ModeMenuAp)
dmenu:findMenu("lanMgrIpv6"):setAttribute("filterFunc",ModeMenuAp)
dmenu:findMenu("mirror"):setAttribute("filterFunc",ModeMenuAp)
dmenu:findMenu("clearlink"):setAttribute("filterFunc",ModeMenuAp)
dmenu:findMenu("parentCtrl"):setAttribute("filterFunc",ModeMenuAp)
dmenu:findMenu("portBinding"):setAttribute("filterFunc",ModeMenuAp)
dmenu:findMenu("rip"):setAttribute("filterFunc",ModeMenuAp)
dmenu:findMenu("portlocate"):setAttribute("filterFunc",ModeMenuAp)
dmenu:findMenu("ponopticalinfo"):setAttribute("filterFunc",ModeMenuAp)
dmenu:findMenu("ethWanStatus"):setAttribute("filterFunc",ModeMenuAp)
dmenu:findMenu("tunnel4in6Status"):setAttribute("filterFunc",ModeMenuAp)
dmenu:findMenu("l2tpStatus"):setAttribute("filterFunc",ModeMenuAp)
dmenu:findMenu("ethWanConfig"):setAttribute("filterFunc",ModeMenuAp)
dmenu:findMenu("tunnel4in6Config"):setAttribute("filterFunc",ModeMenuAp)
dmenu:findMenu("l2tpConfig"):setAttribute("filterFunc",ModeMenuAp)
dmenu:findMenu("firewall"):setAttribute("filterFunc",ModeMenuAp)
dmenu:findMenu("filterCriteria"):setAttribute("filterFunc",ModeMenuAp)
dmenu:findMenu("localServiceCtrl"):setAttribute("filterFunc",ModeMenuAp)
dmenu:findMenu("alg"):setAttribute("filterFunc",ModeMenuAp)
dmenu:findMenu("dmz"):setAttribute("filterFunc",ModeMenuAp)
dmenu:findMenu("portForwarding"):setAttribute("filterFunc",ModeMenuAp)
dmenu:findMenu("portTrigger"):setAttribute("filterFunc",ModeMenuAp)
dmenu:findMenu("multicastmode"):setAttribute("filterFunc",ModeMenuAp)
dmenu:findMenu("igmp"):setAttribute("filterFunc",ModeMenuAp)
dmenu:findMenu("mld"):setAttribute("filterFunc",ModeMenuAp)
dmenu:findMenu("multicastbasic"):setAttribute("filterFunc",ModeMenuAp)
dmenu:findMenu("multicastbasic"):setAttribute("filterFunc",ModeMenuAp)
dmenu:findMenu("multicastaddress"):setAttribute("filterFunc",ModeMenuAp)
dmenu:findMenu("multicastvlan"):setAttribute("filterFunc",ModeMenuAp)
dmenu:findMenu("ponLoid"):setAttribute("filterFunc",ModeMenuAp)
dmenu:findMenu("ponSn"):setAttribute("filterFunc",ModeMenuAp)
local function ModeUser()
local mode = env.getenv("OperationMode")
local uRight = env.getenv("right")
if uRight == "2" and mode ~= "3"then
return true
end
return false
end
dmenu:findMenu("rebootAndReset"):findArea("db_resetmgr_t.lp"):setAttribute("filterFunc",ModeUser)
local function ModeApuser()
local mode = env.getenv("OperationMode")
local uRight = env.getenv("right")
if mode == "3" and uRight == "2" then
return true
end
return false
end
dmenu:findMenu("rebootAndReset"):findArea("ManagDiag_DeviceManag_ClearConfig_t.lp"):setAttribute("filterFunc",ModeApuser)
dmenu:findMenu("networkDiag"):setAttribute("filterFunc",ModeApuser)
dmenu:replaceArea({
{
"wlanBasic",
"wlan_wlansssidconf_t.lp",
"ais_wlan_wlansssidconf_t.lp",
"ais_wlan_wlansssidconf_lua.lua"
}
})
dmenu:replaceArea({
{
"wlanBasic",
"wlan_wlanbasicadconf_t.lp",
"ais_wlan_wlanbasicadconf_t.lp",
"wlan_wlanbasicadconf_lua.lua"
}
})
dmenu:newMenuItem({
id="standardcfg",
name=lang.pro_standard_001,
children={
{
id="Backupcfg",
name=lang.pro_standard_003,
right=3,
pageHelp=lang.pro_standard_002,
areas={
{area="backupdownloadcfg_t.lp",backendFile={"backupdownloadcfg_lua.lua","updownload_prevent_ctl.lua"},right=3},
{area="db_usrcfg_download_t.lp", backendFile={"do_download_usercfg.lua","updownload_prevent_ctl.lua"},right=3},
{area="backupCfg_to_server_t.lp", backendFile={"backupCfg_to_server_lua.lua"},right=1},
},
},
{
id="Restorecfg",
name=lang.pro_standard_004,
right=3,
pageHelp=lang.pro_standard_012,
areas={
{area="restorecfg_t.lp", backendFile={"db_standardusrcfg_upgrade_query_lua.lua","standardcfg_updownload_prevent_ctl.lua","restorecfg_lua.lua"},right=3},
{area="db_usrcfg_upload_t.lp", backendFile={"db_usrcfg_upgrade_query_lua.lua","updownload_prevent_ctl.lua","do_restore_usrcfg.lua"},right=3},
{area="restoreCfg_from_server_t.lp", backendFile={"restoreCfg_from_server_lua.lua"},right=1},
},
}
}
})
:insertAfter("IPv6SwitchMgr")
dmenu:findMenu("usrCfgMgr"):remove()
end)
