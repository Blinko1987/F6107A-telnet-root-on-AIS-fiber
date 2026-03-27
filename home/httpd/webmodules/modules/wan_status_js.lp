<script type="text/javascript">
var globalTmp = "";
var isShowReleaseBtns = true;
var isShowRenewBtns = true;
var pppGw = "";
<% if _G.wanConf.status.pppGw ~= nil then %>
pppGw = "<%=_G.wanConf.status.pppGw%>";
<% end %>
<% if _G.wanConf.status.dhcpBtn[Right] ~= nil and _G.wanConf.status.dhcpBtn[Right] == false then %>
isShowRenewBtns = false;
<% elseif _G.wanConf.status.dhcpBtn["-1"] ~= nil and _G.wanConf.status.dhcpBtn["-1"] == false then %>
isShowRenewBtns = false;
<% end %>
(function(){
var g_routOrBridge = {
route : get_route_html,
bridge : get_bridge_html
};
var g_route={
PPP : ppp_html_string,
IP : ip_html_string
};
var g_ip = {
"Static" : local_static_html_string,
"IPoA" : local_static_html_string,
"CIP" : local_static_html_string,
"DHCP" : local_dhcp_html_string
};
var g_dhcp = [local_xdls_html_string,
local_ipmode_html_string,
local_ipvf_dhcp_html_string,
local_ipvs_dhcp_html_string,
local_wanmac_html_string
];
var g_static = [local_xdls_html_string,
local_ipmode_html_string,
local_ipvf_static_html_string,
local_ipvs_static_html_string,
local_wanmac_html_string
];
var g_ppp = [local_xdls_html_string,
local_ipmode_html_string,
local_ipvf_ppp_html_string,
local_ipvs_ppp_html_string,
local_wanmac_html_string
];
var g_dhcpIpvs = [local_lla_html_string,
local_gua_html_string,
local_xdns_html_string,
local_gatways_html_string,
local_pd_html_string,
local_dhcp_connstatuss_html_string,
local_uptimes_html_string
];
var g_dhcpIpvf = [local_nat_html_string,
local_ipaddr_html_string,
local_dnss_html_string,
local_gatway_html_string,
local_RemainLeaseTime_html_string,
local_connstatus_html_string,
local_uptime_html_string,
local_iperror_html_string
];
var g_staticIpvs = [local_lla_html_string,
local_gua_html_string,
local_xdns_html_string,
local_gatways_html_string,
local_pd_html_string,
local_dhcp_connstatuss_html_string,
local_uptimes_html_string
];
var g_staticIpvf = [local_nat_html_string,
local_ipaddr_html_string,
local_dnss_html_string,
local_gatway_html_string,
local_connstatus_html_string,
local_iperror_html_string
];
var g_pppIpvf = [local_nat_html_string,
local_ipaddr_html_string,
local_dnss_html_string,
local_connstatus_html_string,
local_uptime_html_string,
local_ppperror_html_string
];
if(pppGw.indexOf("v4") != -1){
g_pppIpvf = [local_nat_html_string,
local_ipaddr_html_string,
local_dnss_html_string,
local_gatway_html_string,
local_connstatus_html_string,
local_uptime_html_string,
local_ppperror_html_string
];
}
var g_pppIpvs = [local_lla_html_string,
local_gua_html_string,
local_xdns_html_string,
local_pd_html_string,
local_connstatuss_html_string,
local_uptimes_html_string
];
if(pppGw.indexOf("v6") != -1){
g_pppIpvs = [local_lla_html_string,
local_gua_html_string,
local_xdns_html_string,
local_remotella_html_string,
local_pd_html_string,
local_connstatuss_html_string,
local_uptimes_html_string
];
}
function get_next_html_obj(obj, id, index, namef, namee, conarray)
{
var strtemp = "";
if(conarray)
{
if(conarray.ipdhcp)
{
strtemp = local_dhcp_release_renew(conarray, index);
}
if (conarray.pppmode){
var data = {};
data.index = index;
$.callModifier("/wanmanual/manualDial", data);
if(strtemp == ""){
strtemp = globalTmp;
}
}
}
var strhtml = '<div class=\"colorTblRow\"  id = \"Prefix_sub_' + id + ":" + index +
'\"> <span class=\"w250 emFont\" title=\"' + namef + '\">' + namef +
'</span><span class=\"w250\" id=\"' + id + ":" + index +
'\" title=\"'+ namee +'\">' + namee + '</span>' + strtemp + '</div>';
var objret = obj.after(strhtml);
$.callModifier("/wanmanual/IPv6ConnectBtns");
return objret.next();
}
function local_dhcp_release_renew(conarray, index)
{
var temp = "";
if (conarray.ipdhcp)
{
var ret = ["", ""];
temp = '<span class=\"Btn_Renew emColor ctrlFont ' + ret[0] +'\" id=\"renew:' + index + '\">&?InternetAIS_068;</span>' +
'<span id=\"wLine \"> | </span>' +
'<span class=\"Btn_Release emColor ctrlFont ' + ret[1] + '\" id=\"release:' + index + '\">&?InternetAIS_069;</span>'
}
$.publish("/some/controlReleaseBtnsShow", [index]);
var data = {};
data.template = $("#Internet");
$.callModifier("WanStatus/hideReleaseBtns", data);
if(!isShowReleaseBtns){
temp = "";
isShowReleaseBtns = true;
}
if(!isShowRenewBtns){
temp = "";
}
return temp;
}
function local_ppp_up_down(conarray, index)
{
var temp = "";
if (conarray.pppmode)
{
var ret = ["", ""];
temp = '<span class=\"Btn_Connect emColor ctrlFont ' + ret[0] + '\" id=\"connect:' + index + '\">&?InternetAIS_104;</span>'
}
return temp;
}
function local_bind_release_renew (Head, temp, ServerAddr)
{
temp.unbind("fillDataByRenewReleaseDiagnosisResult");
temp.bind("fillDataByRenewReleaseDiagnosisResult", function(event, xml, template){
if (template.hasError(xml) == 0)
{
}
$("div", temp).each(function(){
if (!$(this).hasClass("titleRow") && !$(this).hasClass("errorHint"))
{
$(this).remove();
}
});
var OBJID = ["ID_WAN_COMFIG"];
template.fillDataByOBJID(xml ,OBJID, template, 0);
var CustomizeParams = {
"ContainerOBJ":template
};
customize_internet(CustomizeParams);
local_bind_release_renew(Head, template, ServerAddr);
colorTblRow(".colorTbl", "even", Head);
});
$(".Btn_Renew, .Btn_Release", temp).bind("click", function(event){
var buttonOBJ = $(this);
var action = "DHCPRENEW";
if ( buttonOBJ.hasClass("disableFont"))
{
return;
}
if (buttonOBJ.hasClass("Btn_Release"))
{
action = "DHCPRELEASE";
}
var template = $(this).parents("[id^='template']");
Head.find("textarea").val("");
dataPost(action, "fillDataByRenewReleaseDiagnosisResult", ServerAddr, template);
});
}
function local_bind_connect_disconnect(Head, temp, ServerAddr)
{
temp.unbind("fillDataByConnectOrDisconnect");
temp.bind("fillDataByConnectOrDisconnect", function(event, xml, template){
if (template.hasError(xml) == 0)
{
}
$("div", temp).each(function(){
if (!$(this).hasClass("titleRow") && !$(this).hasClass("errorHint"))
{
$(this).remove();
}
});
var OBJID = ["ID_WAN_COMFIG"];
template.fillDataByOBJID(xml ,OBJID, template, 0);
var CustomizeParams = {
"ContainerOBJ":template
};
customize_internet(CustomizeParams);
local_bind_connect_disconnect(Head, template, ServerAddr);
colorTblRow(".colorTbl", "even", Head);
});
$(".Btn_Connect, .Btn_Disconnect", temp).bind("click", function(event){
var buttonOBJ = $(this);
var template = $(this).parents("[id^='template']");
Head.find("textarea").val("");
var action = "PPPCONNECT";
if ( buttonOBJ.hasClass("disableFont"))
{
return;
}
if (buttonOBJ.hasClass("Btn_Disconnect"))
{
action = "PPPDISCONNECT";
}
if(buttonOBJ.attr("id").indexOf("ctc_connect") != -1)
{
action = "PPPCTCCONNECT";
}
if(buttonOBJ.attr("id").indexOf("ctc_disconnect") != -1)
{
action = "PPPCTCDISCONNECT";
}
if(buttonOBJ.attr("id").indexOf("viet_connect") != -1)
{
action = "PPPVIETCONNECT";
}
else if(buttonOBJ.attr("id").indexOf("viet_disconnect") != -1)
{
action = "PPPVIETDISCONNECT";
}
dataPost(action, "fillDataByConnectOrDisconnect", ServerAddr, template);
});
}
function local_pvc_html_string(prevobj, conarray, index, temp)
{
var objret = prevobj;
if ("1" == conarray.xdslMode)
{
var obj = $("[id^='DestAddress']", temp);
objret = get_next_html_obj(prevobj, "CDestAddress", index, "&?InternetAIS_004;", obj.val());
}
return objret;
}
function local_xdls_html_string(prevobj, conarray, index, temp)
{
var objret = prevobj;
if ("1" == conarray.uplink )
{
var values = {
"1" : "ATM",
"2" : "PTM"
};
objret = get_next_html_obj(prevobj, "cXdslMode", index, "&?InternetAIS_005;", values[conarray.xdslMode]);
objret = local_pvc_html_string(objret, conarray, index, temp)
}
return objret;
}
function local_connstatus_html_string(prevobj, conarray, index, temp)
{
var value = $("[id^='ConnStatus']", temp).val();
conarray.state = value;
var stat = "&?InternetAIS_012;";
var values = {
Connected: "&?InternetAIS_006;",
Demand: "&?InternetAIS_007;",
Unconfigured: "&?InternetAIS_008;",
Connecting: "&?InternetAIS_009;",
Authenticating: "&?InternetAIS_010;",
PendingDisconnect: "&?InternetAIS_011;",
Disconnecting:"&?InternetAIS_072;"
};
if (values[value])
{
stat = values[value];
}
return get_next_html_obj(prevobj, "cConnStatus", index, "&?InternetAIS_013;", stat, conarray);
}
function local_dnss_html_string(prevobj, conarray, index, temp)
{
var value1 = $("[id^='DNS1']", temp).val();
var value2 = $("[id^='DNS2']", temp).val();
var value3 = $("[id^='DNS3']", temp).val();
return get_next_html_obj(prevobj, "cDNS", index, "&?public_107;", value1 + "/" + value2 + "/" + value3);
}
function local_ipaddr_html_string(prevobj, conarray, index, temp)
{
var value = $("[id^='IPAddress']", temp).val();
var maskValue = $("[id^='SubnetMask']", temp).val();
return get_next_html_obj(prevobj, "cIPAddress", index, "&?public_007;", value + "/" + maskValue);
}
function local_nat_html_string(prevobj, conarray, index, temp)
{
var value = $("[id^='IsNAT']", temp).val();
var values = {
"1" : "&?public_033;",
"0" : "&?public_034;"
};
return get_next_html_obj(prevobj, "cIsNAT", index, "&?InternetAIS_018;", values[value]);
}
function local_uptime_html_string(prevobj, conarray, index, temp)
{
var value = $("[id^='UpTime']", temp).val();
value = sec2HrMinSec(value);
return get_next_html_obj(prevobj, "cUpTime", index, "&?InternetAIS_019;", value);
}
function local_gatway_html_string(prevobj, conarray, index, temp)
{
var value = $("[id^='GateWay']", temp).val();
return get_next_html_obj(prevobj, "cGateWay", index, "&?InternetAIS_020;", value);
}
function local_RemainLeaseTime_html_string(prevobj, conarray, index, temp)
{
var value = $("[id^='RemainLeaseTime']", temp).val();
value = sec2HrMinSec(value);
return get_next_html_obj(prevobj, "cRemainLeaseTime", index, "&?InternetAIS_021;", value);
}
function local_lla_html_string(prevobj, conarray, index, temp)
{
var value = $("[id^='LLA']", temp).val();
return get_next_html_obj(prevobj, "cLLA", index, "&?InternetAIS_022;", value);
}
function local_gua_html_string(prevobj, conarray, index, temp)
{
var objret = prevobj;
var value = $("[id^='GuaNum']", temp).val();
var values = [$("[id^='Gua1']", temp).val(),
$("[id^='Gua2']", temp).val(),
$("[id^='Gua3']", temp).val()];
var valStr = "";
for (var i = 0; i < value; i++)
{
valStr += (i > 0) ? ("/" + values[i]) : values[i];
}
if (valStr == "")
{
valStr = "::";
}
objret = get_next_html_obj(objret, "cGuaNum", index, "&?InternetAIS_023;", valStr);
return objret;
}
function local_xdns_html_string(prevobj, conarray, index, temp)
{
var value1 = $("[id^='Dns1v6']", temp).val();
var value2 = $("[id^='Dns2v6']", temp).val();
var value3 = $("[id^='Dns3v6']", temp).val();
return get_next_html_obj(prevobj, "cDnsv6", index, "&?public_107;", value1 + "/" + value2 + "/" + value3);
}
function local_connstatuss_html_string(prevobj, conarray, index, temp)
{
var value = $("[id^='ConnStatus6']", temp).val();
var strret = "&?InternetAIS_012;";
var values = {
Connected: "&?InternetAIS_006;",
Demand: "&?InternetAIS_007;",
Unconfigured : "&?InternetAIS_008;",
Connecting: "&?InternetAIS_009;",
Authenticating: "&?InternetAIS_010;",
PendingDisconnect: "&?InternetAIS_011;"
};
if (values[value])
{
strret = values[value];
}
return get_next_html_obj(prevobj, "cConnStatus6", index, "&?InternetAIS_028;", strret);
}
function local_dhcp_connstatuss_html_string(prevobj, conarray, index, temp)
{
var value = $("[id^='LLAStatus']", temp).val();
var strret = "&?InternetAIS_012;";
var values = {
Connected: "&?InternetAIS_006;"
};
if (values[value])
{
strret = values[value];
}
return get_next_html_obj(prevobj, "cLLAStatus", index, "&?InternetAIS_028;", strret);
}
function local_uptimes_html_string(prevobj, conarray, index, temp)
{
var value = $("[id^='UpTimeV6']", temp).val();
value = sec2HrMinSec(value);
return get_next_html_obj(prevobj, "cUpTimeV6", index, "&?InternetAIS_029;", value);
}
function local_gatways_html_string(prevobj, conarray, index, temp)
{
var value = $("[id^='Gateway6']", temp).val();
return get_next_html_obj(prevobj, "cGateway6", index, "&?InternetAIS_030;", value);
}
function local_remotella_html_string(prevobj, conarray, index, temp)
{
var value = $("[id^='RemoteLLA']", temp).val();
return get_next_html_obj(prevobj, "cRemoteLLA", index, "&?InternetAIS_030;", value);
}
function local_wanmac_html_string(prevobj, conarray, index, temp)
{
var objret = prevobj;
var Addressingtype = $("[id^='Addressingtype']", temp).val();
var transt = $("[id^='TransType']", temp).val();
if ("PPPoE" == transt || "Static" == Addressingtype || "DHCP" == Addressingtype)
{
var value = $('#WorkIFMac\\:' + index, temp).val();
objret = get_next_html_obj(prevobj, "cWorkIFMac", index, "&?InternetAIS_031;", value);
}
return objret;
}
function local_ppperror_html_string(prevobj, conarray, index, temp)
{
var objret = prevobj;
var errarray = {
"ERROR_NONE" : "&?public_074;",
"ERROR_ISP_TIME_OUT" : "&?InternetAIS_077;",
"ERROR_USER_DISCONNECT" : "&?InternetAIS_078;",
"ERROR_ISP_DISCONNECT" : "&?InternetAIS_079;",
"ERROR_IDLE_DISCONNECT" : "&?InternetAIS_080;",
"ERROR_FORCED_DISCONNECT" : "&?InternetAIS_081;",
"ERROR_AUTHENTICATION_FAILURE" : "&?InternetAIS_082;",
"ERROR_UNKNOWN" : "&?InternetAIS_083;",
"ERROR_IP_CONFIGURATION" : "&?InternetAIS_084;",
"ERROR_NOT_ENABLED_FOR_INTERNET" : "&?InternetAIS_085;",
"ERROR_NO_CARRIER" : "&?InternetAIS_086;"
};
var value = "&?InternetAIS_087;";
var errvalue = $("[id^='ConnError']", temp).val();
if (errarray[errvalue])
{
value = errarray[errvalue];
}
objret = get_next_html_obj(prevobj, "cConnError", index, "&?InternetAIS_088;", value);
return objret;
}
function local_ipvs_ppp_html_string(prevobj, conarray, index, temp)
{
if ("IPv4" == conarray.ipmode )
{
return prevobj;
}
var objret = prevobj;
for (var i = 0; i < g_pppIpvs.length; i++)
{
objret = g_pppIpvs[i](objret, conarray, index, temp);
}
return objret;
}
function local_ipvf_ppp_html_string(prevobj, conarray, index, temp)
{
if ("IPv6" == conarray.ipmode )
{
return prevobj;
}
conarray.pppmode = true;
var objret = prevobj;
for (var i = 0; i < g_pppIpvf.length; i++)
{
objret = g_pppIpvf[i](objret, conarray, index, temp, conarray);
}
return objret;
}
function local_iperror_html_string(prevobj, conarray, index, temp)
{
var objret = prevobj;
var errarray = {
"ERROR_NONE" : "&?public_074;",
"ERROR_USER_DISCONNECT" : "&?InternetAIS_078;",
"ERROR_NOT_ENABLED_FOR_INTERNET" : "&?InternetAIS_085;",
"ERROR_NO_CARRIER" : "&?InternetAIS_086;",
"ERROR_SEND_DHCPMSG_FAIL" : "&?InternetAIS_201;",
"ERROR_NO_RESPONSE_TO_DISCOVER" : "&?InternetAIS_202;",
"ERROR_SERVERDENY" : "&?InternetAIS_203;",
"ERROR_ERROR_ACCESS_FAIL" : "&?InternetAIS_204;",
"ERROR_NO_RESPONSE_TO_REQUEST" : "&?InternetAIS_205;"
};
var value = "&?InternetAIS_087;";
var errvalue = $("[id^='ConnError']", temp).val();
if (errarray[errvalue])
{
value = errarray[errvalue];
}
objret = get_next_html_obj(prevobj, "cConnError", index, "&?InternetAIS_088;", value);
return objret;
}
function local_ipvf_static_html_string(prevobj, conarray, index, temp)
{
if ("IPv6" == conarray.ipmode )
{
return prevobj;
}
var objret = prevobj;
for (var i = 0; i < g_staticIpvf.length; i++)
{
objret = g_staticIpvf[i](objret, conarray, index, temp);
}
return objret;
}
function local_ipvs_static_html_string(prevobj, conarray, index, temp)
{
if ("IPv4" == conarray.ipmode )
{
return prevobj;
}
var objret = prevobj;
for (var i = 0; i < g_staticIpvs.length; i++)
{
objret = g_staticIpvs[i](objret, conarray, index, temp);
}
return objret;
}
function local_ipvf_dhcp_html_string(prevobj, conarray, index, temp)
{
if ("IPv6" == conarray.ipmode )
{
return prevobj;
}
var objret = prevobj;
for (var i = 0; i < g_dhcpIpvf.length; i++)
{
objret = g_dhcpIpvf[i](objret, conarray, index, temp);
}
return objret;
}
function local_ipvs_dhcp_html_string(prevobj, conarray, index, temp)
{
if ("IPv4" == conarray.ipmode )
{
return prevobj;
}
var objret = prevobj;
for (var i = 0; i < g_dhcpIpvs.length; i++)
{
objret = g_dhcpIpvs[i](objret, conarray, index, temp);
}
return objret;
}
function local_ipmode_html_string(prevobj, conarray, index, temp)
{
return get_next_html_obj(prevobj, "cIpMode", index, "&?InternetAIS_032;", conarray.ipmode);
}
function local_pd_html_string(prevobj, conarray, index, temp)
{
<%
if "66" == CountryCode or "1" == CountryCode or "77" == CountryCode or "85" == CountryCode or "48" == CountryCode then
%>
var value1 = $("[id^='Pd']", temp).val();
var value2 = $("[id^='PdLen']", temp).val();
return get_next_html_obj(prevobj, "cPrefix_Pd", index, "&?InternetDE_030;", value1 + "/" + value2);
<%
end
%>
return prevobj;
}
function local_static_html_string(prevobj, conarray, index, temp)
{
var Addressingtype = $("[id^='Addressingtype']", temp).val();
var atmlik = $("[id^='ATMLinkType']", temp).val();
var mode = "IP";
var objret = prevobj;
var values = {
"IPoA" : "IPoA",
"CIP" : "CLIP"
};
var value = values[Addressingtype];
if (value)
{
Addressingtype = value;
}
if ("IPv4" == conarray.ipmode)
{
mode = Addressingtype;
}
objret = get_next_html_obj(prevobj, "cRouteMode", index, "&?InternetAIS_033;", mode);
for (var i = 0; i < g_static.length; i++)
{
objret = g_static[i](objret, conarray, index, temp);
}
return objret;
}
function local_dhcp_html_string(prevobj, conarray, index, temp)
{
var Addressingtype = $("[id^='Addressingtype']", temp).val();
var mode = "IP";
var objret = prevobj;
if ("IPv4" == conarray.ipmode)
{
mode = Addressingtype;
}
objret = get_next_html_obj(prevobj, "cRouteMode", index, "&?InternetAIS_033;", mode);
for (var i = 0; i < g_dhcp.length; i++)
{
objret = g_dhcp[i](objret, conarray, index, temp);
}
return objret;
}
function ppp_html_string(prevobj, conarray, index, temp)
{
var objtmp = prevobj;
var strtmp = $("[id^='TransType']", temp).val();
objtmp = get_next_html_obj(prevobj, "cRouteMode", index, "&?InternetAIS_033;", strtmp);
for (var i = 0; i < g_ppp.length; i++)
{
objtmp = g_ppp[i](objtmp, conarray, index, temp);
}
}
function ip_html_string(prevobj, conarray, index, temp)
{
var objtmp = prevobj;
var Addressingtype = $("[id^='Addressingtype']", temp).val();
conarray.ipdhcp = false;
if ("DHCP" == Addressingtype)
{
conarray.ipdhcp = true;
}
if (g_ip[Addressingtype])
{
objtmp = g_ip[Addressingtype](prevobj, conarray, index, temp);
}
}
function get_bridge_html(prevobj, conarray, index, temp)
{
var objtmp = prevobj;
objtmp = get_next_html_obj(prevobj, "cBridgeMode", index, "&?InternetAIS_033;", "&?InternetAIS_034;");
objtmp = local_xdls_html_string(objtmp, conarray, index, temp);
}
function get_route_html(prevobj, conarray, index, temp)
{
if (g_route[conarray.linkMode])
{
g_route[conarray.linkMode](prevobj, conarray, index, temp);
}
}
function get_major_params(temp, index)
{
var objUplink = $("[id^='IF_UPLINK']", temp);
var objIpMode = $("[id^='IpMode']", temp);
var objLinkmode = $("[id^='linkMode']", temp);
var objMode = $("[id^='mode']", temp);
var objStatus = $("[id^='Status']", temp);
var xmode = "-1";
var ipmode = objIpMode.val();
if ("Both" == ipmode)
{
ipmode = "IPv4/v6";
}
if ("1" == objUplink.val())
{
var objdsl = $("[id^='xdslMode']", temp);
xmode = objdsl.val();
}
var objStrServList = $("[id^='StrServList']", temp);
return {uplink : objUplink.val(),
xdslMode : xmode,
ipmode : ipmode,
mode : objMode.val(),
linkMode : objLinkmode.val(),
ipdhcp : false,
state : "none",
status : objStatus.val(),
StrServList : objStrServList.val()
};
}
function customize_internet(paramsOBJ)
{
var ContainerOBJ = paramsOBJ["ContainerOBJ"];
var reg = /[_:]/;
var id = ContainerOBJ.attr("id").split(reg);
var index = id[id.length - 1];
var myarray = get_major_params(ContainerOBJ, index);
var obj ;
if("1" == myarray.uplink)
{
obj = $("[id^='DslStateDev_title']", ContainerOBJ);
}
else if ("2" == myarray.uplink)
{
obj = $("[id^='EthStateDev_title']", ContainerOBJ);
}
g_routOrBridge[myarray.mode](obj, myarray, index, ContainerOBJ);
var data = {};
data.template = ContainerOBJ;
$.callModifier("EthStateDev/paramsCtr",data);
}
function DPOG_Didisplay(conarray,temp)
{
if(conarray.StrServList == "VOIP" )
{
$("[id^='Prefix_sub_cIPAddress']", temp).hide();
$("[id^='Prefix_sub_cDNS']", temp).hide();
$("[id^='Prefix_sub_cGateWay']", temp).hide();
}
}
$(document).ready(function(){
var HeadID = "EthStateDev";
var Head = $("#"+HeadID);
var template = $("#template_"+ HeadID);
var ServerAddr = $("address span", Head).text();
RefreshClickHandle(Head);
Head.fillDataByCustom = function(suffix,ContainerOBJ){
var CustomizeParams = {
"ContainerOBJ":ContainerOBJ
};
customize_internet(CustomizeParams);
local_bind_release_renew(Head, ContainerOBJ, ServerAddr);
local_bind_connect_disconnect(Head, ContainerOBJ, ServerAddr);
var data = {};
data.template = ContainerOBJ;
$.callModifier("EthStateDev/templateCtr", data);
};
Head.succfunction = function(xml){
Head.hasError(xml,"externErrorHint");
var FWIPOBJ = $(xml).find("ID_WAN_COMFIG");
var RuleNum = $("Instance", FWIPOBJ).length;
if (0 == RuleNum)
{
$(".noDataHint",Head).showIt(true);
}
else
{
$(".noDataHint",Head).showIt(false);
var OBJID = ["ID_WAN_COMFIG"];
Head.createPageDataByClone(RuleNum,OBJID,xml,
Head.fillDataByCustom);
colorTblRow(".colorTbl", "even", Head);
}
$.publish("/some/specialWANHide", [$("#EthStateDev")]);
};
if ( $(".collapBarWithDataTrans",Head).length <= 0 )
{
Head.dataTransfer(ServerAddr, "GET", Head.succfunction);
}
else
{
initial_collapBarWithDataTrans(Head);
}
});
$(document).ready(function(){
var dslHeadID = "DslStateDev";
var dslHead = $("#"+dslHeadID);
var dslServerAddr = $("address span", dslHead).text();
RefreshClickHandle(dslHead);
dslHead.fillDataByCustom = function(suffix,ContainerOBJ){
var CustomizeParams = {
"ContainerOBJ":ContainerOBJ
};
customize_internet(CustomizeParams);
local_bind_release_renew(dslHead, ContainerOBJ, dslServerAddr);
local_bind_connect_disconnect(dslHead, ContainerOBJ, dslServerAddr);
};
dslHead.succfunction = function(xml){
dslHead.hasError(xml,"externErrorHint");
var OBJ = $(xml).find("ID_WAN_COMFIG");
var RuleNum = $("Instance", OBJ).length;
if (0 == RuleNum)
{
$(".noDataHint",dslHead).showIt(true);
}
else
{
$(".noDataHint",dslHead).showIt(false);
var OBJID = ["ID_WAN_COMFIG"];
dslHead.createPageDataByClone(RuleNum,OBJID,xml,
dslHead.fillDataByCustom);
colorTblRow(".colorTbl", "even", dslHead);
}
};
if ( $(".collapBarWithDataTrans",dslHead).length <= 0 )
{
dslHead.dataTransfer(dslServerAddr, "GET", dslHead.succfunction);
}
else
{
initial_collapBarWithDataTrans(dslHead);
}
});
})();
</script>
