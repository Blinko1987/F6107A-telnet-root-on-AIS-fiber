return (
{
{
id="homePage",
name=lang.Home_001,
right=0,
pageHelp="",
extData=lang.Home_100,
areas={
{area="home_t.lp", backendFile={"wlan_homepage_lua.lua","accessdev_homepage_lua.lua","firewall_homepage_lua.lua", "usb_homepage_lua.lua", "voip_homepage_lua.lua", "wlan_qrcode_data.lua"}, needSessUpdate=false}
},
},
{
id="internet",
name=lang.mmMenu_001,
children={
{
id="internetStatus",
name=lang.public_001,
children={
{
id="ponopticalinfo",
right=1,
name=lang.PonInfoOptical_001,
pageHelp=lang.PonInfoOptical_002,
extData=lang.PonInfoOptical_100,
areas={
{area="poninfo_status_t.lp", backendFile="optical_info_lua.lua"},
},
},
{
id="ethWanStatus",
right=0,
name=lang.InternetAIS_094,
pageHelp=lang.InternetAIS_095,
extData=lang.InternetAIS_200,
areas={
{area="wan_eth_status_t.lp", backendFile="wan_internetstatus_lua.lua"},
},
},
{
id="dslWanStatus",
right=0,
name=lang.public_005,
pageHelp=lang.InternetAIS_089,
extData=lang.publichelp,
areas={
{area="dsl_interface_status_t.lp", backendFile="dsl_interface_status_lua.lua"},
{area="wan_dsl_status_t.lp", backendFile="wan_internetstatus_lua.lua"},
},
},
{
id="Wan3gStatus",
right=0,
name=lang.Internet3GStatus_012,
pageHelp=lang.Internet3GStatus_013,
extData=lang.publichelp,
areas={
{area="wwan_mobile_status_t.lp", backendFile="wwan_mobile_status_lua.lua"},
{area="wan_3g_status_t.lp", backendFile="wan_3g_status_lua.lua"},
},
},
{
id="tunnel4in6Status",
right=0,
name=lang.Tnl4in6Status_001,
pageHelp=lang.Tnl4in6Status_002,
extData=lang.Tnl4in6Status_100,
areas={
{area="tunnel_4in6_status_t.lp", backendFile="tunnel_4in6_status_lua.lua"},
},
},
{
id="tunnel6in4Status",
right=0,
name=lang.Tnl6in4Status_001,
pageHelp=lang.Tnl6in4Status_002,
extData=lang.Tnl6in4Status_100,
areas={
{area="tunnel_6in4_status_t.lp", backendFile="tunnel_6in4_status_lua.lua"},
},
},
{
id="l2tpStatus",
right=0,
name=lang.L2tpStatus_001,
pageHelp=lang.L2tpStatus_002,
extData=lang.publichelp,
areas={
{area="l2tp_status_t.lp", backendFile="l2tp_lua.lua"},
},
},
{
id="wanStaStatus",
right=0,
name=lang.STAStatus_001,
pageHelp=lang.STAStatus_002,
extData=lang.publichelp,
areas={
{area="wlan_sta_wireless_status_t.lp", backendFile="wlan_sta_wireless_status_lua.lua"},
{area="wan_sta_status_t.lp", backendFile="wan_internetstatus_lua.lua"},
},
},
{
id="pptpConfigStat",
right=0,
name=lang.haikui_PPTP_001,
pageHelp=lang.haikui_PPTPStatus_001,
extData=lang.publichelp,
areas={
{area="Internet_PPTP_Status_t.lp", backendFile="Internet_PPTP_Status_lua.lua"},
},
},
},
},
{
id="internetConfig",
name=lang.InternetAIS_074,
right=1,
children={
{
id="ethWanConfig",
right=1,
name=lang.InternetDE_114,
pageHelp=lang.InternetDE_115,
extData=lang.InternetDE_200,
areas={
{area="wan_eth_config_t.lp", backendFile="wan_internet_lua.lua"},
},
},
{
id="dslWanConfig",
right=1,
name=lang.public_005,
pageHelp=lang.InternetAIS_089,
extData=lang.publichelp,
areas={
{area="wan_dsl_config_t.lp", backendFile="wan_internet_lua.lua"},
{area="dsl_interface_config_t.lp", backendFile="dsl_interface_config_lua.lua"},
{area="dsl_bonding_t.lp", backendFile="dsl_bonding_lua.lua"},
},
},
{
id="Wan3gConfig",
right=1,
name=lang.Internet3G_001,
pageHelp=lang.Internet3G_002,
extData=lang.publichelp,
areas={
{area="wwan_pin_t.lp", backendFile="wwan_pin_lua.lua", needSessUpdate=false},
{area="wan_3g_config_t.lp", backendFile="wan_3g_config_lua.lua"},
{area="wan_3gLTE_config_t.lp", backendFile="wan_3gLTE_config_lua.lua"},
{area="wwan_backup_t.lp", backendFile="wwan_backup_lua.lua"},
},
},
{
id="tunnel4in6Config",
right=1,
name=lang.Internet4in6_001,
pageHelp=lang.Internet4in6_002,
extData=lang.Internet4in6_100,
areas={
{area="tunnel_4in6_config_t.lp",backendFile="tunnel_4in6_config_lua.lua"},
},
},
{
id="tunnel6in4Config",
right=1,
name=lang.Tunnel6in4_001,
pageHelp=lang.Tunnel6in4_002,
extData=lang.Tunnel6in4_100,
areas={
{area="tunnel_6in4_config_t.lp",backendFile="tunnel_6in4_config_lua.lua"},
},
},
{
id="l2tpConfig",
right=1,
name=lang.L2TP_001,
pageHelp=lang.L2TP_002,
extData=lang.publichelp,
areas={
{area="l2tp_config_t.lp", backendFile="l2tp_lua.lua"},
},
},
{
id="wanStaConfig",
right=1,
name=lang.STA_001,
pageHelp=lang.STA_002,
extData=lang.publichelp,
areas={
{area="wan_sta_config_t.lp", backendFile="wan_internet_lua.lua"},
{area="wlan_sta_switch_t.lp", backendFile="wlan_sta_switch_lua.lua"},
{area="wlan_sta_inputap_t.lp", backendFile="wlan_sta_wlanprofile_lua.lua"},
{area="wlan_sta_ssid_t.lp", backendFile="wlan_sta_wlanprofile_lua.lua"},
},
},
{
id="pptpConfig",
right=3,
name=lang.haikui_PPTP_001,
pageHelp=lang.haikui_PPTP_002,
extData=lang.publichelp,
areas={
{area="Internet_PPTP_t.lp", backendFile="Internet_PPTP_lua.lua"},
},
},
},
},
{
id="clearlink",
right=1,
name=lang.ClearLink_001,
pageHelp=lang.ClearLink_002,
extData=lang.publichelp,
areas={
{area="clearlink_t.lp", backendFile="clearlink_lua.lua"},
},
},
{
id="qos",
name=lang.AdminQos_001,
children={
{
id="qosBasic",
right=1,
name=lang.QosBasic_001,
pageHelp=lang.QosBasic_002,
extData=lang.publichelp,
areas={
{area="qos_basic_m.lua"},
},
},
{
id="qosType",
right=1,
name=lang.QosType_001,
pageHelp=lang.QosType_002,
extData=lang.publichelp,
areas={
{area="qos_type_m.lua"},
},
},
{
id="qosQueue",
right=1,
name=lang.QosCongestion_001,
pageHelp=lang.QosCongestion_001,
extData=lang.publichelp,
areas={
{area="qos_queue_t.lp", backendFile="qos_queue_lua.lua"},
{area="qos_statistics_t.lp", backendFile="qos_statistics_lua.lua"},
},
},
{
id="qosSpeed",
right=1,
name=lang.QosSpeed_001,
pageHelp=lang.QosSpeed_002,
extData=lang.publichelp,
areas={
{area="qos_speed_t.lp", backendFile="qos_speed_lua.lua"},
},
},
{
id="qosShaper",
right=1,
name=lang.QosShaper_001,
pageHelp=lang.QosShaper_002,
extData=lang.publichelp,
areas={
{area="qos_shaper_t.lp", backendFile="qos_shaper_lua.lua"},
},
},
},
},
{
id="security",
name=lang.Security_001,
children={
{
id="firewall",
right=3,
name=lang.Security_061,
pageHelp=lang.Security_002,
extData=lang.Security_100,
areas={
{area="firewall_config_t.lp", backendFile="firewall_config_lua.lua"},
},
},
{
id="filterCriteria",
right=3,
name=lang.Security_062,
pageHelp=lang.Security_064,
extData=lang.Security_200,
areas={
{area="firewall_filterglobal_t.lp", backendFile="firewall_filterglobal_lua.lua"},
{area="firewall_ipfilter_t.lp", backendFile="firewall_ipfilter_lua.lua"},
{area="firewall_macfilterv3_t.lp", backendFile="firewall_macfilterv3_lua.lua", right = 1},
{area="firewall_urlfilter_m.lua", right = 1},
},
},
{
id="localServiceCtrl",
right=1,
name=lang.Security_063,
pageHelp=lang.Security_065,
extData=lang.Security_201,
areas={
{area="firewall_ipv4service_t.lp", backendFile="firewall_ipv4service_lua.lua"},
{area="firewall_ipv6service_t.lp", backendFile="firewall_ipv6service_lua.lua"},
{area="firewall_portservice_t.lp", backendFile="firewall_portservice_lua.lua"},
},
},
{
id="alg",
right=1,
name=lang.Alg_001,
pageHelp=lang.Alg_002,
extData=lang.Alg_100,
areas={
{area="firewall_alg_t.lp",backendFile="firewall_alg_lua.lua"},
},
},
{
id="dmz",
right=1,
name=lang.Dmz_001,
pageHelp=lang.Dmz_002,
extData=lang.Dmz_100,
areas={
{area="firewall_dmz_t.lp", backendFile="firewall_dmz_lua.lua"},
{area="firewall_dmz6_t.lp" ,backendFile="firewall_dmz6_lua.lua"},
},
},
{
id="portForwarding",
right=1,
name=lang.PortForwarding_001,
pageHelp=lang.PortForwarding_002,
extData=lang.PortForwarding_100,
areas={
{area="firewall_portforwarding_t.lp", backendFile="firewall_portforwarding_lua.lua"},
},
},
{
id="portTrigger",
right=1,
name=lang.PortTrigger_001,
pageHelp=lang.PortTrigger_002,
extData=lang.PortTrigger_100,
areas={
{area="firewall_porttrigger_m.lua"},
},
},
},
},
{
id="parentCtrl",
right=3,
name=lang.ParentCtrl_001,
pageHelp=lang.ParentCtrl_002,
extData=lang.ParentCtrl_100,
areas={
{area="firewall_parentctrl_t.lp", backendFile="firewall_parentctrl_lua.lua"},
},
},
{
id="ddns",
right=1,
name=lang.Ddns_001,
pageHelp=lang.Ddns_002,
extData=lang.Ddns_100,
areas={
{area="ddns_t.lp", backendFile="ddns_lua.lua"},
},
},
{
id="sntp",
right=3,
name=lang.SNTP_001,
pageHelp=lang.SNTP_002,
extData=lang.SNTP_200,
areas={
{area="sntp_t.lp", backendFile="sntp_lua.lua"},
},
},
{
id="portBinding",
right=1,
name=lang.PortBinding_001,
pageHelp=lang.PortBinding_002,
extData=lang.PortBinding_100,
areas={
{area="portbinding_t.lp", backendFile="portbinding_lua.lua"},
},
},
{
id="rip",
right=1,
name=lang.RIP_001,
pageHelp=lang.RIP_002,
extData=lang.RIP_100,
areas={
{area="route_rip_t.lp", backendFile="rip_lua.lua"},
{area="route_ripng_m.lua"},
},
},
{
id="multicast",
name=lang.IGMP_005,
children={
{
id="multicastmode",
right=1,
name=lang.MulticastMode_001,
pageHelp=lang.MulticastMode_100,
extData=lang.MulticastMode_100,
areas={
{area="multicast_mode_t.lp", backendFile="multicast_mode_lua.lua"},
},
},
{
id="igmp",
right=1,
name=lang.IGMP_001,
pageHelp=lang.IGMP_002,
extData=lang.IGMP_100,
areas={
{area="multicast_igmp_config_t.lp", backendFile="multicast_igmp_config_lua.lua"},
{area="multicast_igmpwan_t.lp", backendFile="multicast_igmpwan_lua.lua"},
},
},
{
id="mld",
right=1,
name=lang.MLD_001,
pageHelp=lang.MLD_002,
extData=lang.MLD_100,
areas={
{area="multicast_mldwan_t.lp", backendFile="multicast_mldwan_lua.lua"},
},
},
{
id="multicastbasic",
right=1,
name=lang.public_002,
pageHelp=lang.Multicast_001,
extData=lang.Multicast_100,
areas={
{area="multicast_basic_t.lp", backendFile="igmp_lua.lua"},
},
},
{
id="multicastvlan",
right=1,
name=lang.Multicast_005,
pageHelp=lang.Multicast_004,
extData=lang.Multicast_101,
areas={
{area="multicast_vlan_t.lp", backendFile="multicast_vlan_lua.lua"},
},
},
{
id="multicastaddress",
right=1,
name=lang.Multicast_007,
pageHelp=lang.Multicast_008,
extData=lang.Multicast_102,
areas={
{area="multicast_address_t.lp", backendFile="multicast_address_lua.lua"},
},
},
},
},
{
id="portlocate",
right=1,
name=lang.PortLocate_001,
pageHelp=lang.PortLocate_002,
extData=lang.PortLocate_100,
areas={
{area="Internet_PortLocate_t.lp", backendFile="Internet_PortLocate_lua.lua"},
},
},
{
id="ponInfo",
name=lang.PON_001,
children={
{
id="ponLoid",
right=1,
name=lang.PON_003,
pageHelp=lang.PON_002,
areas={
{area="poninfo_loid_t.lp", backendFile="poninfo_loid_lua.lua"},
},
},
{
id="ponSn",
right=1,
name=lang.PON_005,
pageHelp=lang.PON_008,
areas={
{area="poninfo_sn_t.lp", backendFile="poninfo_sn_lua.lua"},
},
},
},
},
{
id="catv",
right=1,
name=lang.poncatv005,
pageHelp=lang.poncatv002,
extData=lang.poncatv002,
areas={
{area="pon_catv_t.lp", backendFile="pon_catv_lua.lua"},
},
},
},
},
{
id="localnet",
name=lang.mmMenu_002,
children={
{
id="localNetStatus",
name=lang.public_001,
right=0,
pageHelp=lang.LocalnetStatus_001,
extData=lang.LocalnetStatus_100,
areas={
{area="status_lan_info_t.lp", backendFile="status_lan_info_lua.lua", right=3},
{area="wlan_wlanstatus_t.lp", backendFile="wlan_wlanstatus_lua.lua", right=3},
{area="wlan_wlanstatuslowright_t.lp", backendFile="wlan_wlanstatuslowright_lua.lua", right=12},
{area="wlan_client_stat_t.lp", backendFile="wlan_client_stat_lua.lua", right=0},
{area="accessdev_landevs_t.lp", backendFile="accessdev_landevs_lua.lua", right=0},
{area="usb_usbdevs_t.lp", backendFile="usb_usbdevs_lua.lua", right=0},
{area="miniolt_roompon_info_model.lua", right=3},
},
},
{
id="wlanConfig",
name=lang.public_083,
children={
{
id="wlanBasic",
name=lang.WlanBasic_001,
right=7,
pageHelp=lang.WlanBasic_002,
extData=lang.WlanBasicAd_100,
areas={
{area="wlan_wlanbasictogether_t.lp", backendFile="wlan_wlanbasictogether_lua.lua", right=3},
{area="wlan_wlanbasiconoff_t.lp", backendFile="wlan_wlanbasiconoff_lua.lua", right=7},
{area="wlan_wlanbasicadconf_t.lp", backendFile="wlan_wlanbasicadconf_lua.lua", right=3},
{area="wlan_wlansssidconf_t.lp", backendFile="wlan_wlansssidconf_lua.lua", right=3},
{area="wlan_wlansssidconflowright_t.lp", backendFile="wlan_wlansssidconf_lua.lua", right=4},
},
},
{
id="wlanAdvanced",
name=lang.WlanAdvanced_001,
right=3,
pageHelp=lang.WlanAdvanced_012,
extData=lang.WlanAdvanced_100,
areas={
{area="wlan_macfilteraclpolicy_t.lp", backendFile="wlan_macfilteraclpolicy_lua.lua"},
{area="wlan_macfilterrule_t.lp", backendFile="wlan_macfilterrule_lua.lua"},
},
},
{
id="wds",
name=lang.WDS_001,
right=3,
pageHelp=lang.WDS_002,
extData=lang.publichelp,
areas={
{area="wlan_wds_t.lp", backendFile="wlan_wds_lua.lua"},
},
},
{
id="wps",
name=lang.WPS_001,
right=3,
pageHelp=lang.WPS_002,
extData=lang.WPS_100,
areas={
{area="wlan_wps_t.lp", backendFile="wlan_wps_lua.lua"},
},
},
{
id="wifibutton",
name=lang.WlanButton_001,
right=3,
pageHelp=lang.WlanButton_002,
extData=lang.WlanButton_100,
areas={
{area="wlan_wlanbutton_t.lp", backendFile="wlan_wlanbutton_lua.lua"},
},
},
{
id="wifibandsteer",
name=lang.wlan_bandsteering_001,
right=1,
pageHelp=lang.wlan_bandsteering_002,
extData=lang.wlan_bandsteering_002,
areas={
{area="wlan_BandSteering_t.lp", backendFile="wlan_BandSteering_lua.lua"},
},
},
},
},
{
id="lanConfig",
name=lang.public_084,
children={
{
id="lanMgrIpv4",
name=lang.LanMgrIpv4_001,
right=3,
pageHelp=lang.LanMgrIpv4_002,
extData=lang.LanMgrIpv4_100,
areas={
{area="Localnet_LanMgrIpv4_t.lp",backendFile={"Localnet_LanMgrIpv4_DHCPBasicCfg_lua.lua","Localnet_LanMgrIpv4_DHCPHostInfo_lua.lua","Localnet_LanMgrIpv4_DHCPSpecialAddMgr_lua.lua","Localnet_LanMgrIpv4_DHCPStaticRule_lua.lua","Localnet_LanMgrIpv4_SecondIP_lua.lua"}},
{area="Localnet_LanMgrIpv4_DHCPPortService_t.lp", backendFile="Localnet_LanMgrIpv4_DHCPPortService_lua.lua"},
{area="Localnet_LanDevDHCPSource_t.lp", backendFile="Localnet_LanDevDHCPSource_lua.lua"},
},
},
{
id="lanMgrIpv6",
name=lang.LanMgrIpv6_001,
right=1,
pageHelp=lang.LanMgrIpv6_002,
extData=lang.LanMgrIpv6_100,
areas={
{area="dhcp6s_hostinfo_t.lp", backendFile="dhcp6s_hostinfo_lua.lua"},
{area="addr6_lanaddr_t.lp", backendFile="addr6_lanaddr_lua.lua"},
{area="prefix_ulaprefix_t.lp", backendFile="prefix_ulaprefix_lua.lua"},
{area="prefix_staticprefix_t.lp", backendFile="prefix_staticprefix_lua.lua"},
{area="dhcp6s_dhcpserver_t.lp", backendFile="dhcp6s_dhcpserver_lua.lua"},
{area="ra_raservice_t.lp", backendFile="ra_raservice_lua.lua"},
{area="prefix_prefixpool_t.lp", backendFile="prefix_prefixpool_lua.lua"},
{area="radhcp6s_portctrl_t.lp", backendFile="radhcp6s_portctrl_lua.lua"},
},
},
},
},
{
id="route",
name=lang.public_049,
children={
{
id="routeIpv4",
name=lang.RouteIpv4_001,
right=1,
pageHelp=lang.RouteIpv4_002,
extData=lang.RouteIpv4_100,
areas={
{area="route_routedefault_t.lp", backendFile="route_routedefault_lua.lua"},
{area="route_routetableipv4_t.lp", backendFile="route_routetableipv4_lua.lua"},
{area="route_routestaticipv4_t.lp", backendFile="route_routestaticipv4_lua.lua"},
{area="route_routepolicyipv4_t.lp", backendFile="route_routepolicyipv4_lua.lua"},
},
},
{
id="routeIpv6",
name=lang.RouteIpv6_001,
right=1,
pageHelp=lang.RouteIpv6_002,
extData=lang.RouteIpv4_100,
areas={
{area="route_routedefaultipv6_t.lp", backendFile="route_routedefaultipv6_lua.lua"},
{area="route_routetableipv6_t.lp", backendFile="route_routetableipv6_lua.lua"},
{area="route_routestaticipv6_t.lp", backendFile="route_routestaticipv6_lua.lua"},
{area="route_routepolicyipv6_t.lp", backendFile="route_routepolicyipv6_lua.lua"},
},
},
},
},
{
id="ftp",
name=lang.FTP_001,
right=3,
pageHelp=lang.FTP_002,
extData=lang.FTP_100,
areas={
{area="Localnet_ftp_t.lp", backendFile="Localnet_ftp_lua.lua"},
},
},
{
id="upnp",
name=lang.UPnP_001,
right=1,
pageHelp=lang.UPnP_002,
extData=lang.UPnP_100,
areas={
{area="upnp_upnp_t.lp", backendFile="upnp_upnp_lua.lua"},
},
},
{
id="bpdu",
name=lang.BPDU_001,
right=1,
pageHelp=lang.BPDU_002,
extData=lang.BPDU_002,
areas={
{area="bpdu_t.lp", backendFile="bpdu_lua.lua"},
},
},
{
id="dms",
name=lang.DMS_001,
right=3,
pageHelp=lang.DMS_014,
extData=lang.DMS_100,
areas={
{area="dms_dms_t.lp", backendFile={"dms_dms_lua.lua", "dms_querydir_lua.lua"}},
},
},
{
id="samba",
name=lang.Samba_001,
right=3,
pageHelp=lang.Samba_006,
extData=lang.publichelp,
areas={
{area="Localnet_Samba_t.lp",backendFile={"Samba_lua.lua"}},
},
},
{
id="telnet",
name=lang.Telnet_001,
right=3,
pageHelp=lang.Telnet_002,
extData=lang.publichelp,
areas={
{area="telnet_t.lp", backendFile="telnet_lua.lua"},
},
},
{
id="dns",
name=lang.DNS_001,
right=1,
pageHelp=lang.DNS_002,
extData=lang.DNS_100,
areas={
{area="dns_localdns_t.lp", backendFile="dns_localdns_lua.lua"},
{area="dns_hostname_t.lp", backendFile="dns_hostname_lua.lua"},
{area="dns_dnsserver_t.lp", backendFile="dns_localdns_lua.lua"},
},
},
{
id="usbfunccfg",
name=lang.public_140,
right=3,
pageHelp=lang.USBFuncCfg_001,
extData=lang.publichelp,
areas={
{area="usb_usbfunccfg_t.lp", backendFile="usb_usbfunccfg_lua.lua"},
},
},
},
},
{
id="voip",
name=lang.mmMenu_003,
children={
{
id="voipStatus",
name=lang.public_001,
right=0,
pageHelp=lang.VoipStatus_001,
extData=lang.VoipStatus_100,
areas={
{area="Voip_lineStatus_t.lp", backendFile="voipRegStatus_lua.lua"},
{area="Voip_phoneStatus_t.lp", backendFile="voipVpPhyinterface_lua.lua"},
},
},
{
id="voipBasic",
name=lang.public_002,
right=1,
pageHelp=lang.VoipBasic_001,
extData=lang.VoipBasic_100,
areas={
{area="voip_voipbasic_t.lp", backendFile="voip_voipbasic_lua.lua"},
},
},
{
id="voipServices",
name=lang.SipServices_001,
right=1,
pageHelp=lang.SipServices_002,
extData=lang.SipServices_002,
areas={
{area="voip_services_t.lp", backendFile={"Voip_SipService_lua.lua","voipDmtTimer_lua.lua"}},
},
},
{
id="sipIf",
name=lang.SipIf_002,
right=1,
pageHelp=lang.SipIf_001,
extData=lang.SipIf_100,
areas={
{area="Voip_SipIf_t.lp", backendFile="Voip_SipIf_lua.lua"},
},
},
{
id="sipAdvanced",
name=lang.SipAdvanced_001,
right=1,
pageHelp=lang.SipAdvanced_002,
extData=lang.SipAdvanced_100,
areas={
{area="voip_sipadvanced_t.lp", backendFile="voip_sipadvanced_lua.lua"},
{area="voip_voiceproc_t.lp", backendFile="voip_voiceproc_lua.lua"},
},
},
{
id="sip",
name=lang.VoipSip_001,
right=1,
pageHelp=lang.VoipSip_014,
extData=lang.publichelp,
areas={
{area="voip_voipsip_t.lp", backendFile="voip_voipsip_lua.lua"},
},
},
{
id="sipDigitmap",
name=lang.SipDigitMap_001,
right=1,
pageHelp=lang.SipDigitMap_002,
extData=lang.SipDigitMap_002,
areas={
{area="voip_sipdigitmap_t.lp", backendFile="Voip_sipdigitmap_lua.lua"},
},
},
{
id="sipMedia",
name=lang.SIPMedia_001,
right=1,
pageHelp=lang.SIPMedia_004,
extData=lang.SIPMedia_100,
areas={
{area="voip_sipmedia_t.lp", backendFile="voip_sipmedia_lua.lua"},
},
},
{
id="sipslc",
name=lang.proc_sipslc_009,
right=1,
pageHelp=lang.proc_sipslc_008,
extData=lang.proc_sipslc_004,
areas={
{area="voip_sipslc_t.lp", backendFile="voip_sipslc_lua.lua"},
},
},
{
id="sipCallerID",
name=lang.voip_dtmf_001,
right=1,
pageHelp=lang.voip_dtmf_0015,
extData=lang.voip_dtmf_0015,
areas={
{area="voip_cid_sip_t.lp", backendFile="voip_cid_sip_lua.lua"},
},
},
{
id="fax",
name=lang.Fax_001,
right=1,
pageHelp=lang.Fax_002,
extData=lang.Fax_100,
areas={
{area="voip_fax_t.lp", backendFile="voip_fax_lua.lua"},
},
},
{
id="voipqos",
name=lang.VoipQoS_001,
right=1,
pageHelp=lang.VoipQoS_002,
extData=lang.VoipQoS_100,
areas={
{area="Voip_Voip_QoS_t.lp", backendFile="Voip_Voip_QoS_lua.lua"},
{area="Voip_Voip_QoSMedia_t.lp", backendFile="Voip_Voip_QoS_Media_lua.lua"},
},
},
{
id="dialPlan",
name=lang.DialPlan_001,
right=1,
pageHelp=lang.DialPlan_002,
extData=lang.publichelp,
areas={
{area="voip_dialplan_t.lp", backendFile="voip_dialplan_lua.lua"},
},
},
{
id="mgcpBasic",
name=lang.MgcpBasic_001,
right=1,
pageHelp=lang.MgcpBasic_002,
extData=lang.publichelp,
areas={
{area="voip_mgcpbasic_t.lp", backendFile="voip_mgcpbasic_lua.lua"},
},
},
{
id="mgcpAuth",
name=lang.MgcpAuth_001,
right=1,
pageHelp=lang.MgcpAuth_002,
extData=lang.publichelp,
areas={
{area="voip_mgcpauth_t.lp", backendFile="voip_mgcpauth_lua.lua"},
},
},
{
id="h248Basic",
name=lang.H248Basic_001,
right=1,
pageHelp=lang.H248Basic_002,
extData=lang.publichelp,
areas={
{area="voip_h248basic_t.lp", backendFile="voip_h248basic_lua.lua"},
},
},
{
id="h248Auth",
name=lang.H248Auth_001,
right=1,
pageHelp=lang.H248Auth_002,
extData=lang.publichelp,
areas={
{area="voip_h248auth_t.lp", backendFile="voip_h248auth_lua.lua"},
},
},
{
id="voipSwithPtcl",
name=lang.VoIPPtclSwitch_001,
right=1,
pageHelp=lang.VoIPPtclSwitch_002,
extData=lang.publichelp,
areas={
{area="voip_protocolswitch_t.lp", backendFile="voip_protocolswitch_lua.lua"},
},
},
},
},
{
id="mgrAndDiag",
name=lang.mmMenu_004,
children={
{
id="statusMgr",
right=0,
name=lang.public_001,
pageHelp=lang.StatusManag_008,
extData=lang.StatusManag_100,
areas={
{area = "devmgr_statusmgr_t.lp",backendFile="devmgr_statusmgr_lua.lua"},
},
},
{
id="devMgr",
name=lang.MenuManag_001,
children={
{
id="rebootAndReset",
right=0,
name=lang.DeviceManag_001,
pageHelp=lang.DeviceManag_014,
extData=lang.DeviceManag_100,
areas={
{area = "devmgr_restartmgr_t.lp", backendFile="devmgr_restartmgr_lua.lua"},
{area = "db_resetmgr_t.lp", backendFile="db_resetmgr_lua.lua"},
},
},
{
id="firmwareUpgr",
right=1,
name=lang.FirmwareUpgr_001,
pageHelp=lang.FirmwareUpgr_002,
extData=lang.FirmwareUpgr_100,
areas={
{area = "upgrade_firmware_t.lp", backendFile={"upgrade_firmware_query_lua.lua","updownload_prevent_ctl.lua", "do_firmware_upgrade.lua"
}},
},
},
{
id="usrCfgMgr",
right=3,
name=lang.UsrCfgMgr_001,
pageHelp=lang.UsrCfgMgr_002,
extData=lang.UsrCfgMgr_100,
areas={
{area = "db_usrcfg_download_t.lp", backendFile={"updownload_prevent_ctl.lua", "do_download_usercfg.lua"}},
{area = "db_usrcfg_upload_t.lp", backendFile={"db_usrcfg_upgrade_query_lua.lua","updownload_prevent_ctl.lua","do_restore_usrcfg.lua"}},
},
},
{
id="usbrestore",
right=1,
name=lang.Usbrestore_001,
pageHelp=lang.Usbrestore_002,
extData=lang.publichelp,
areas={
{area="usb_usbrestore_t.lp", backendFile="usb_usbrestore_lua.lua"},
},
},
{
id="usbbackup",
right=1,
name=lang.Usbbackup_001,
pageHelp=lang.Usbbackup_002,
extData=lang.publichelp,
areas={
{area="usb_usbbackup_t.lp", backendFile="usb_usbrestore_lua.lua"},
},
},
},
},
{
id="accountMgr",
right=0,
name=lang.AccountManag_001,
pageHelp=lang.AccountManag_010,
extData=lang.AccountManag_100,
areas={
{area = "devauth_accountmgr_t.lp", backendFile="devauth_accountmgr_lua.lua"},
{area = "web_login_timeout_t.lp", backendFile="web_login_timeout_lua.lua", right=3},
},
},
{
id="logMgr",
right=1,
name=lang.LogManag_001,
pageHelp=lang.LogManag_002,
extData=lang.LogManag_100,
areas={
{area = "log_syslogmgr_t.lp", backendFile={"log_syslogmgr_lua.lua","updownload_prevent_ctl.lua", "do_download_syslog.lua"}},
{area = "log_syslogmgr2_t.lp", backendFile={"log_syslogmgr2_lua.lua","updownload_prevent_ctl.lua", "do_download_syslog.lua"}},
{area = "LogManag_Syslog_t.lp", backendFile={"LogManag_Syslog_lua.lua","updownload_prevent_ctl.lua", "do_download_syslog.lua"}},
{area = "log_seclogmgr_t.lp", backendFile={"log_seclogmgr_lua.lua","updownload_prevent_ctl.lua", "do_download_seclog.lua"}},
},
},
{
id="remoteMgr",
right=1,
name=lang.RemoteManag_001,
pageHelp=lang.RemoteManag_003,
extData=lang.publichelp,
areas={
{area = "tr069_remotemgr_t.lp", backendFile="tr069_remotemgr_lua.lua"},
{area = "tr069_uploadcert_t.lp", backendFile={"tr069_cert_upgrade_query_lua.lua",
"updownload_prevent_ctl.lua",
"do_cert_upload.lua",
"do_chain1_cert_upload.lua",
"do_chain2_cert_upload.lua",
"do_client_cert_upload.lua",
"do_upgrade_cert_upload.lua"}},
},
},
{
id="diagnosis",
name=lang.DiagnosisManag_050,
children={
{
id="networkDiag",
right=1,
name=lang.DiagnosisManag_001,
pageHelp=lang.DiagnosisManag_015,
extData=lang.DiagnosisManag_100,
areas={
{area = "networkdiag_diagmgr_t.lp", backendFile={"networkdiag_traceroute_lua.lua",
"networkdiag_svcsimulation_lua.lua",
"networkdiag_ping_lua.lua"}},
},
},
{
id="mirror",
right=1,
name=lang.MirroManag_001,
pageHelp=lang.MirroManag_005,
areas={
{area = "mirror_mirrormgr_t.lp", backendFile="mirror_mirrormgr_lua.lua"},
},
},
{
id="loopbackDetect",
right=1,
name=lang.LoopbackDetect_001,
pageHelp=lang.LoopbackDetect_002,
extData=lang.LoopbackDetect_100,
areas={
{area = "loopback_basic_t.lp", backendFile="loopback_basic_lua.lua"},
{area = "loopback_enable_t.lp", backendFile="loopback_enable_lua.lua"},
{area = "loopback_vlan_t.lp", backendFile="loopback_vlan_lua.lua"},
},
},
{
id="arpTable",
right=1,
name=lang.ArpTable_001,
pageHelp=lang.ArpTable_007,
extData=lang.ArpTable_100,
areas={
{area = "arp_arptable_t.lp", backendFile="arp_arptable_lua.lua"},
},
},
{
id="macTable",
right=1,
name=lang.MacTable_001,
pageHelp=lang.MacTable_007,
extData=lang.MacTable_100,
areas={
{area = "macinfo_mactable_t.lp", backendFile="macinfo_mactable_lua.lua"},
},
},
},
},
{
id="IPv6SwitchMgr",
right=1,
name=lang.IPV6Switch_001,
pageHelp=lang.IPV6Switch_003,
extData=lang.IPV6Switch_003,
areas={
{area = "ipv6_enable_t.lp",backendFile="ipv6_enable_lua.lua"},
},
},
{
id="Ethconfig",
right=1,
name=lang.DeviceManag_015,
pageHelp=lang.DeviceManag_016,
extData=lang.DeviceManag_016,
areas={
{area = "devmgr_eth_conf_t.lp", backendFile={"devmgr_eth_conf_lua.lua"}
},
},
},
},
},
}
)
