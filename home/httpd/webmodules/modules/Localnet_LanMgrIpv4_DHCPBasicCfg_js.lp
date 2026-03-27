<script type="text/javascript">
jQuery.validator.addMethod(
"OPTION66Check",
function(value, element, params)
{
if ( this.optional(element) )
{
return "dependency-mismatch";
}
if(value == "")
{
return true;
}
else if(checkIPv4Addr(value) == true)
{
return true;
}
else if(checkDomain(value) == true)
{
return true;
}
return false;
},
$.validator.format("&?L2TP_012;")
);
chanegeButtonByCustom = function(btn, ContainerOBJ){
var Obj = $("[id^='"+btn+"']",ContainerOBJ);
Obj.addClass("disableBtn");
};
function g_DnsServerSource_DNSCtrlDisp()
{
var HeadID = "DHCPBasicCfg";
var templateID = "template_"+ HeadID;
var template = $("#"+templateID);
var dnsDIVObj = $("#div_DNSServer1, #div_DNSServer2", template);
var dnsObj = $("#DNSServer1, #DNSServer2", template);
if ( $("#DnsServerSource1", template).is(':checked'))
{
dnsDIVObj.hide();
dnsObj.addClass("PostIgnore");
$.callModifier("DHCPBasicCfg/Ipv4DnsOrigin/displayConf");
}
else
{
dnsDIVObj.show();
dnsObj.removeClass("PostIgnore");
$("#div_Ipv4DnsOrigin").hide();
$("#Ipv4DnsOrigin").addClass("PostIgnore");
}
$.callModifier("DHCPBasicCfg/undisplayDNSConf");
}
function g_LeaseTimeMode_CtrlDisp()
{
var HeadID = "DHCPBasicCfg";
var templateID = "template_"+ HeadID;
var template = $("#"+templateID);
var LeaseTimeMode = $("#LeaseTimeMode", template).val();
var leaseTimeSelfDefineDIVObj = $("#div_LeaseTimeSelfDefine", template);
if ( "selfDefine" == LeaseTimeMode )
{
leaseTimeSelfDefineDIVObj.show();
}
else
{
leaseTimeSelfDefineDIVObj.hide();
}
}
function Customize_DHCPBasicCfg(paramsOBJ)
{
var TemplateOBJ = paramsOBJ["TemplateOBJ"];
var IPJSON = {
"IPAddr:DHCPBasicCfg":"sub_IPAddr",
"SubnetMask":"sub_SubMask",
"MinAddress:DHCPBasicCfg":"sub_MinAddress",
"MaxAddress:DHCPBasicCfg":"sub_MaxAddress",
"DNSServer1":"sub_DNSServer1",
"DNSServer2":"sub_DNSServer2"
};
for (var IPTmp in IPJSON)
{
var ipHiddenObj = $("[id^='"+IPTmp+"']", TemplateOBJ);
ipHiddenObj.FillIPorMacDataBySplit(IPJSON[IPTmp], ".", 4);
}
}
function initial_template_DHCPBasicCfg(templateID)
{
var template = $("#"+templateID);
var ipSegmentCheck = {
"required": true,
"integer": true,
"range": [0, 255]
};
var checkForm = $("form", template);
checkForm.validate({
"groups": {
IPAddr: "sub_IPAddr0:DHCPBasicCfg sub_IPAddr1:DHCPBasicCfg sub_IPAddr2:DHCPBasicCfg sub_IPAddr3:DHCPBasicCfg",
SubMask: "sub_SubMask0 sub_SubMask1 sub_SubMask2 sub_SubMask3",
MinAddress: "sub_MinAddress0:DHCPBasicCfg sub_MinAddress1:DHCPBasicCfg sub_MinAddress2:DHCPBasicCfg sub_MinAddress3:DHCPBasicCfg",
MaxAddress: "sub_MaxAddress0:DHCPBasicCfg sub_MaxAddress1:DHCPBasicCfg sub_MaxAddress2:DHCPBasicCfg sub_MaxAddress3:DHCPBasicCfg",
DNSServer1: "sub_DNSServer10 sub_DNSServer11 sub_DNSServer12 sub_DNSServer13",
DNSServer2: "sub_DNSServer20 sub_DNSServer21 sub_DNSServer22 sub_DNSServer23"
},
"rules": {
"sub_IPAddr0:DHCPBasicCfg": ipSegmentCheck,
"sub_IPAddr1:DHCPBasicCfg": ipSegmentCheck,
"sub_IPAddr2:DHCPBasicCfg": ipSegmentCheck,
"sub_IPAddr3:DHCPBasicCfg": ipSegmentCheck,
"sub_SubMask0": ipSegmentCheck,
"sub_SubMask1": ipSegmentCheck,
"sub_SubMask2": ipSegmentCheck,
"sub_SubMask3": ipSegmentCheck,
"sub_MinAddress0:DHCPBasicCfg": ipSegmentCheck,
"sub_MinAddress1:DHCPBasicCfg": ipSegmentCheck,
"sub_MinAddress2:DHCPBasicCfg": ipSegmentCheck,
"sub_MinAddress3:DHCPBasicCfg": ipSegmentCheck,
"sub_MaxAddress0:DHCPBasicCfg": ipSegmentCheck,
"sub_MaxAddress1:DHCPBasicCfg": ipSegmentCheck,
"sub_MaxAddress2:DHCPBasicCfg": ipSegmentCheck,
"sub_MaxAddress3:DHCPBasicCfg": ipSegmentCheck,
"sub_DNSServer10": ipSegmentCheck,
"sub_DNSServer11": ipSegmentCheck,
"sub_DNSServer12": ipSegmentCheck,
"sub_DNSServer13": ipSegmentCheck,
"sub_DNSServer20": ipSegmentCheck,
"sub_DNSServer21": ipSegmentCheck,
"sub_DNSServer22": ipSegmentCheck,
"sub_DNSServer23": ipSegmentCheck,
"LeaseTimeSelfDefine": {
"required": true,
"integer": true,
"range":[60, 157680000]
}
},
"messages": {
}
});
template.bind("fillDataByApplyResult", function(event,xml, template){
if ($("IF_ERRORID", $(xml)).text() == "-1381")
{
$("IF_ERRORSTR", $(xml)).text("SUCC");
$("#DHCPSpecialAddMgr_Refresh_button", $("#DHCPSpecialAddMgr")).click();
$("#DHCPStaticRule_Refresh_button", $("#DHCPStaticRule")).click();
}
if ( ActionByApplyResult(xml, template) == 0 )
{
var OBJID = ["OBJ_Br0AndDhcpsHosCfg_ID","OBJ_LANDNS_ID"
];
template.fillDataByOBJID(xml, OBJID, template, 0);
var CustomizeParams = {
"TemplateOBJ":template
};
Customize_DHCPBasicCfg(CustomizeParams);
g_DnsServerSource_DNSCtrlDisp();
var leaseTime = $("#LeaseTime", template).val();
if ( leaseTime == -1 )
{
$("#LeaseTimeMode", template).val("Infinity");
}
else
{
$("#LeaseTimeMode", template).val("selfDefine");
$("#LeaseTimeSelfDefine", template).val(leaseTime);
}
g_LeaseTimeMode_CtrlDisp();
}
});
<%
if "0" == env.getenv("DHCPConfigurable") then
%>
chanegeButtonByCustom("Btn_apply_DHCPBasicCfg", template)
<%
end
%>
template.bind("fillDataByCancelResult", function(event,xml, template){
var OBJID = ["OBJ_Br0AndDhcpsHosCfg_ID","OBJ_LANDNS_ID"
];
ActionByCancelResult(xml, template, OBJID);
var CustomizeParams = {
"TemplateOBJ":template
};
Customize_DHCPBasicCfg(CustomizeParams);
g_DnsServerSource_DNSCtrlDisp();
var leaseTime = $("#LeaseTime", template).val();
if ( leaseTime == -1 )
{
$("#LeaseTimeMode", template).val("Infinity");
}
else
{
$("#LeaseTimeMode", template).val("selfDefine");
$("#LeaseTimeSelfDefine", template).val(leaseTime);
}
g_LeaseTimeMode_CtrlDisp();
});
template.bind("hiddenValueChangeByCustom", function(event,template){
var IPJSON = {
"IPAddr:DHCPBasicCfg":"sub_IPAddr",
"SubMask":"sub_SubMask",
"MinAddress:DHCPBasicCfg":"sub_MinAddress",
"MaxAddress:DHCPBasicCfg":"sub_MaxAddress",
"DNSServer1":"sub_DNSServer1",
"DNSServer2":"sub_DNSServer2"
};
for (var IPTmp in IPJSON)
{
var ipHiddenObj = $("[id^='"+IPTmp+"']",template);
ipHiddenObj.FillIPorMacDataCombination(IPJSON[IPTmp], ".", 4);
}
var submask = $("#SubMask", template).val();
$("#SubnetMask", template).val(submask);
var LeaseTimeMode = $("#LeaseTimeMode", template).val();
var LeaseTimeSelfDefine = $("#LeaseTimeSelfDefine", template).val();
if ( LeaseTimeMode == "selfDefine" )
{
$("#LeaseTime", template).val(LeaseTimeSelfDefine);
}
else
{
$("#LeaseTime", template).val("-1");
}
});
}
$(document).ready(function(){
var HeadID = "DHCPBasicCfg";
var Head = $("#"+HeadID);
var templateID = "template_"+ HeadID;
var ServerAddr = $("address span", Head).text();
initial_template_DHCPBasicCfg(templateID);
var loginURL = document.URL;
var parts = loginURL.split("/");
var urlHostPart = parts[2];
var urlHostArr = urlHostPart.split(":");
var urlHost = urlHostArr[0];
$("#IF_URL_HOST", Head).val(urlHost);
$(":radio[name='DnsServerSource']").change(function(){
g_DnsServerSource_DNSCtrlDisp();
});
$("#LeaseTimeMode").change(function(){
g_LeaseTimeMode_CtrlDisp();
});
Head.chanegeDataByCustom =function(xml){
var OBJ = $(xml).find("OBJ_BRGRP_ID");
var instances = $("Instance ", OBJ);
instances.each(function(i){
var inst = $(this);
inst.find("ParaName").each(function(){
var ParaName = $(this).text();
var ParaValue = $(this).next().text();
if ( ParaName == "_InstID" )
{
$(this).text("_InstID_BRGRP");
}
});
});
};
Head.fillDataByCustom = function(suffix,TemplateOBJ){
var CustomizeParams = {
"TemplateOBJ":TemplateOBJ
};
Customize_DHCPBasicCfg(CustomizeParams);
};
Head.succfunction = function(xml){
var template = $("[id^='template_']", Head);
Head.hasError(xml,"externErrorHint");
Head.chanegeDataByCustom(xml);
var OBJID = ["OBJ_Br0AndDhcpsHosCfg_ID","OBJ_LANDNS_ID"
];
Head.fillDataByOBJID(xml, OBJID, template, 0);
Head.fillDataByCustom(0, template);
g_DnsServerSource_DNSCtrlDisp();
var leaseTime = $("#LeaseTime", template).val();
if ( leaseTime == -1 )
{
$("#LeaseTimeMode", template).val("Infinity");
}
else
{
$("#LeaseTimeMode", template).val("selfDefine");
$("#LeaseTimeSelfDefine", template).val(leaseTime);
}
g_LeaseTimeMode_CtrlDisp();
$.callModifier("DHCPBasicCfg/undisplayProCodeDNS");
};
if ( $(".collapBarWithDataTrans",Head).length <= 0 )
{
Head.dataTransfer(ServerAddr,
"GET",
Head.succfunction);
}
else
{
initial_collapBarWithDataTrans(Head);
}
});
</script>
