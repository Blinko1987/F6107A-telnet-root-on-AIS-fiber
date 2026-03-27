<script type="text/javascript">
var cver = <% =env.getenv("CountryCode")%>;
var uRight = <% =session_get(sess_id, "Right")%>;
var wanUrl = "";
function getUrl(objId, userRight)
{
var selectedUrl = "";
var urlLink = {
"FWUrl" : {
"1" : "firewall",
"2" : "firewall",
"3" : "",
"4" : ""
},
"forMacro": {
"1" : "",
"2" : "",
"3" : "",
"4" : ""
}
};
$.publish("/some/addLinkToFireWall", [urlLink]);
var data = {};
data.template = urlLink;
$.callModifier("home/FWUrl/jump", data);
if ( urlLink[objId] )
{
selectedUrl = urlLink[objId][userRight];
}
return selectedUrl;
}
function getWANUrl(userRight)
{
$.publish("/some/addLinkToWan", [0]);
if (userRight == 1)
{
wanUrl = "ethWanConfig";
}
return wanUrl;
}
function dealAjaxError()
{
var errContainer = $("#ajaxErrArea");
errContainer.showIt(true);
$("span", errContainer).text("&?Home_012;");
showWaitTip(false);
}
function dealWlanSwitch(xml)
{
var wlanVal = parseInt(0);
$(xml).find("OBJ_WLANRADIO_ID").find("ParaName").each(function(){
var paraName = $(this).text();
if (paraName == "RadioSwitch")
{
var radioSwitch = $(this).next().text();
wlanVal = parseInt(radioSwitch, 10);
return false;
}
});
if (wlanVal == 1)
{
$("#WLANDevsHeader").removeClass("wlanOff");
$("#WLANDevsHeader").addClass("wlanOn");
$("#WLANRadio").attr("class", "radioOn");
}
else
{
$("#WLANDevsHeader").removeClass("wlanOn");
$("#WLANDevsHeader").addClass("wlanOff");
$("#WLANRadio").attr("class", "radioOff");
}
}
function dealFwSwitch(xml)
{
var fwOBJ = $(xml).find("OBJ_FWLEVEL_ID").find("ParaName");
fwOBJ.each(function(){
var ParaName = $(this).text();
if (ParaName == "Level")
{
var ParaValue = $(this).next().text();
$("#fwSwitchVal").val(ParaValue);
if (ParaValue == 0)
{
$("#firewall").attr("class", "fwOff");
}
else
{
$("#firewall").attr("class", "fwOn");
}
return false;
}
});
}
function InitailHomeHandle()
{
var uRight = <%=Right%>;
$("#FWUrl, #WANUrl").each(function(){
var linkOBJ = $(this);
var linkId = linkOBJ.attr("id");
var linkUrl = "";
if (linkId == "WANUrl")
{
linkUrl = getWANUrl(uRight);
}
else
{
linkUrl = getUrl(linkId, uRight);
}
if (linkUrl != "" && menuTreeObj.findMenu(linkUrl))
{
linkOBJ.addClass("link2More");
linkOBJ.bind("click", function(event){
openLink(linkUrl);
});
}
else
{
linkOBJ.removeClass("emColor");
}
});
}
$(document).ready(function(){
var data = {};
data.right = "<%=Right%>";
$.callModifier("home/initCustom", data);
InitailHomeHandle();
var fwHead = $("#fwArea");
var fwServerAddr = "/?_type=menuData&_tag=firewall_homepage_lua.lua";
fwHead.succfunction = function(xml){
var cmapiErrorContainer = $("#fwErr");
if (cmapiErrorContainer.hasError(xml) == 0);
{
dealFwSwitch(xml);
}
};
fwHead.failfunction = function(){
dealAjaxError();
};
fwHead.dataTransfer( fwServerAddr,
"GET",
fwHead.succfunction,
fwHead.failfunction);
});
<%if env.getenv("wifiSupport") ~= "0" then%>
$(document).ready(function () {
function getWLANSetUrl(userRight)
{
var selectedUrl = "";
var urlLink = {
"1" : "wlanBasic",
"2" : "wlanBasic",
"3" : "wlanBasic",
"4" : ""
};
$.publish("/some/addLinkToWlanSetting", [urlLink]);
if ( urlLink[userRight] )
{
selectedUrl = urlLink[userRight];
}
return selectedUrl;
}
function getWLANStatusUrl(userRight)
{
var selectedUrl = "";
var urlLink = {
"1" : "localNetStatus",
"2" : "localNetStatus",
"3" : "localNetStatus",
"4" : "localNetStatus"
};
if ( urlLink[userRight] )
{
selectedUrl = urlLink[userRight];
}
return selectedUrl;
}
var wlanMenuObj = $("#home_category_wlan");
function UpdateWLANDevs()
{
var wlanServerAddr = "/?_type=menuData&_tag=wlan_homepage_lua.lua&InstNum=5";
wlanMenuObj.succfunction = function(xml){
var wlanCmapiErrorContainer = $("#wlanErr");
if (wlanCmapiErrorContainer.hasError(xml) == 0);
{
var categoryArea = $("#home_category_area");
categoryArea.trigger("set_current_category", ["home_category_wlan"]);
var devListCategory = $("#home_devlist_category");
var options = {
"categoryName": "&?Home_019;",
"setLinkName": "&?Home_020;",
"getLinkFunc": getWLANSetUrl
}
devListCategory.trigger("initialize", [options]);
var devListHead = $("#home_devlist_head");
var options = {
paraLangs: [
["HostName", "&?public_016;"],
["MACAddress", "&?public_010;"],
["IPAddress", "&?public_095;"],
["IPV6Address", "&?public_096;"]
]
};
devListHead.trigger("exec_data_binding", [options]);
var devListArea = $("#home_devitem");
devListArea.trigger("remove_instances");
var wlanOBJ = $(xml).find("OBJ_ACCESSDEV_ID");
var wlanADNum = $("Instance", wlanOBJ).length;
var renderNum = wlanADNum;
if (wlanADNum > 4)
{
renderNum = 4;
}
var OBJID = ["OBJ_ACCESSDEV_ID"];
devListArea.createPageDataByClone(renderNum, OBJID, xml);
$.publish("/some/softVersionModify", [0]);
var devListMore = $("#home_devlist_more");
var options = {
"instNum": wlanADNum,
"getLinkFunc": getWLANStatusUrl
}
devListMore.trigger("initialize", [options]);
dealWlanSwitch(xml);
}
};
wlanMenuObj.failfunction = function(){
showWaitTip(false);
};
wlanMenuObj.dataTransfer( wlanServerAddr,
"GET",
wlanMenuObj.succfunction,
wlanMenuObj.failfunction,
false);
var UpdateWlanDevTimer = new ContextBindingTimer(function () {
UpdateWLANDevs();
}, {timeout: 35*1000, contextDom: wlanMenuObj.get(0)});
UpdateWlanDevTimer.start();
wlanMenuObj.data("timer_object", UpdateWlanDevTimer);
}
wlanMenuObj.click(function(){
$("#home_category_area").trigger("clear_all_timer");
UpdateWLANDevs();
});
});
<%end%>
$(document).ready(function () {
function getLANSetUrl(userRight)
{
var selectedUrl = "";
var urlLink = {
"1" : "lanMgrIpv4",
"2" : "lanMgrIpv4",
"3" : "",
"4" : ""
};
$.publish("/some/addLinkToLanSetting", [urlLink]);
if ( urlLink[userRight] )
{
selectedUrl = urlLink[userRight];
}
return selectedUrl;
}
function getLANStatusUrl(userRight)
{
var selectedUrl = "";
var urlLink = {
"1" : "localNetStatus",
"2" : "localNetStatus",
"3" : "localNetStatus",
"4" : "localNetStatus"
};
if ( urlLink[userRight] )
{
selectedUrl = urlLink[userRight];
}
return selectedUrl;
}
var lanMenuObj = $("#home_category_lan");
function UpdateLanDev()
{
var lanServerAddr = "/?_type=menuData&_tag=accessdev_homepage_lua.lua&InstNum=5";
lanMenuObj.succfunction = function(xml){
var cmapiErrorContainer = $("#lanErr");
if (cmapiErrorContainer.hasError(xml) == 0);
{
var categoryArea = $("#home_category_area");
categoryArea.trigger("set_current_category", ["home_category_lan"]);
var devListCategory = $("#home_devlist_category");
var options = {
"categoryName": "&?Home_021;",
"setLinkName": "&?Home_022;",
"getLinkFunc": getLANSetUrl
}
devListCategory.trigger("initialize", [options]);
var devListHead = $("#home_devlist_head");
var options = {
paraLangs:[
["HostName", "&?public_016;"],
["MACAddress", "&?public_010;"],
["IPAddress", "&?public_095;"],
["IPV6Address", "&?public_096;"]
]
};
devListHead.trigger("exec_data_binding", [options]);
var devListArea = $("#home_devitem");
devListArea.trigger("remove_instances");
var lanOBJ = $(xml).find("OBJ_ACCESSDEV_ID");
var lanNum = $("Instance", lanOBJ).length;
var renderNum = lanNum;
if (lanNum > 4)
{
renderNum = 4;
}
var OBJID = ["OBJ_ACCESSDEV_ID"];
devListArea.createPageDataByClone(renderNum, OBJID, xml);
var devListMore = $("#home_devlist_more");
var options = {
"instNum": lanNum,
"getLinkFunc": getLANStatusUrl
}
devListMore.trigger("initialize", [options]);
}
};
lanMenuObj.failfunction = function(){
showWaitTip(false);
};
lanMenuObj.dataTransfer( lanServerAddr,
"GET",
lanMenuObj.succfunction,
lanMenuObj.failfunction,
false);
var UpdateLanDevTimer = new ContextBindingTimer(function () {
UpdateLanDev();
}, {timeout: 35*1000, contextDom: lanMenuObj.get(0)});
UpdateLanDevTimer.start();
lanMenuObj.data("timer_object", UpdateLanDevTimer);
}
lanMenuObj.click(function(){
$("#home_category_area").trigger("clear_all_timer");
UpdateLanDev();
});
});
<%if env.getenv("usbSupport") ~= "0" then%>
$(document).ready(function () {
var usbMenuObj = $("#home_category_usb");
function UpdateUsb()
{
var usbServerAddr = "/?_type=menuData&_tag=usb_homepage_lua.lua";
usbMenuObj.chanegeDataByCustom = function(xml){
var ToOperParaArr = {
"ClassInfoStr" : {
ValueOrigin: "",
setAction: function(ParaNameSel, ParaValSel, SelfVal){
if(SelfVal == "USB Mass Storage")
{
ParaValSel.text("&?Home_028;");
}
else if (SelfVal == "Print")
{
ParaValSel.text("&?Home_029;");
}
else
{
ParaValSel.text("&?public_006;");
}
}
}
};
var InstNum = $("Instance", $("OBJ_USBDEV_ID", $(xml))).length;
for (var i=0; i<InstNum; i++)
{
xmlParaInInstOperate(xml, "OBJ_USBDEV_ID", i, ToOperParaArr);
}
};
usbMenuObj.SetFtpEnable = function (xml) {
var FtpEnable = "";
var ftpOBJ = $(xml).find("OBJ_FMFTPSERVERCFG_ID").find("ParaName");
ftpOBJ.each(function(){
var ParaName = $(this).text();
if (ParaName == "FtpEnable")
{
FtpEnable = $(this).next().text();
return false;
}
});
$(this).data("FTP_ENABLE", FtpEnable);
}
usbMenuObj.SetFTPURL = function (xml) {
var ipAddr = "";
var ipOBJ = $(xml).find("OBJ_BRGRP_ID").find("ParaName");
ipOBJ.each(function(){
var ParaName = $(this).text();
if (ParaName == "IPAddr")
{
ipAddr = $(this).next().text();
return false;
}
});
ipAddr = "ftp://"+ipAddr;
$(this).data("FTP_URL", ipAddr);
}
function FillDataByCustom_USB(index, clone) {
var ftpEnable = usbMenuObj.data("FTP_ENABLE");
var ftpURL = usbMenuObj.data("FTP_URL");
var usbType = $("[id^='ClassInfoStr']", clone).text();
if ( "1" != ftpEnable )
{
return;
}
var ftpURLSpan = $("[id^='FTP_URL']", clone);
if (usbType == "&?Home_028;")
{
var usbLink = $("<a></a>");
usbLink.attr("href", ftpURL);
usbLink.attr("target", "_blank");
usbLink.text(ftpURL);
ftpURLSpan.append(usbLink);
}
}
usbMenuObj.succfunction = function(xml){
var cmapiErrorContainer = $("#usbErr");
if (cmapiErrorContainer.hasError(xml) == 0);
{
var categoryArea = $("#home_category_area");
categoryArea.trigger("set_current_category", ["home_category_usb"]);
var devListCategory = $("#home_devlist_category");
var options = {
"categoryName": "&?Home_023;"
}
devListCategory.trigger("initialize", [options]);
var devListHead = $("#home_devlist_head");
var options = {
paraLangs: [
["DevName", "&?public_016;"],
["ClassInfoStr", "&?Home_027;"],
["FTP_URL", "&?Home_030;"]
]
};
devListHead.trigger("exec_data_binding", [options]);
usbMenuObj.chanegeDataByCustom(xml);
usbMenuObj.SetFtpEnable(xml);
usbMenuObj.SetFTPURL(xml);
var devListArea = $("#home_devitem");
devListArea.trigger("remove_instances");
var usbOBJ = $(xml).find("OBJ_USBDEV_ID");
var usbNum = $("Instance", usbOBJ).length;
if(usbNum <= 0)
{
$("#Btn_apply_UsbEject").attr("disabled","true");
}
else
{
$("#Btn_apply_UsbEject").removeAttr("disabled");
}
var renderNum = usbNum;
if (usbNum > 4)
{
renderNum = 4;
}
var OBJID = ["OBJ_USBDEV_ID"];
devListArea.createPageDataByClone(renderNum, OBJID, xml,
FillDataByCustom_USB);
var devListMore = $("#devlist_more");
devListMore.hide();
}
};
usbMenuObj.failfunction = function(){
showWaitTip(false);
};
usbMenuObj.dataTransfer( usbServerAddr,
"GET",
usbMenuObj.succfunction,
usbMenuObj.failfunction,
false);
var UpdateUsbTimer = new ContextBindingTimer(function () {
UpdateUsb();
}, {timeout: 145*1000, contextDom: usbMenuObj.get(0)});
UpdateUsbTimer.start();
usbMenuObj.data("timer_object", UpdateUsbTimer);
usbMenuObj.bind("ejecthintshow", function(event,xml, template){
if (template.hasError(xml) == 0)
{
$("#Hint_ejectOK").fadeIn();
$("#Hint_ejectFAIL").hide();
$("#Hint_ejectOK").fadeOut(4000);
}
else
{
$("#Hint_ejectFAIL").fadeIn();
$("#Hint_ejectOK").hide();
$("#Hint_ejectFAIL").fadeOut(4000);
}
UpdateUsb();
});
$("#Btn_apply_UsbEject").click(function() {
var msg = "&?Home_031;";
var confirmLayerOBJ = IniConfirm(msg);
$("#confirmOK",confirmLayerOBJ).bind("click", function(event) {
showWaitTip(false);
var PostData = "IF_ACTION=EjectDev&EjectId=/mnt/usb1_1";
dataPost("EjectDev", "ejecthintshow",
usbServerAddr, usbMenuObj, PostData);
});
});
}
usbMenuObj.click(function(){
$("#home_category_area").trigger("clear_all_timer");
UpdateUsb();
});
});
<%end%>
<%if env.getenv("voipSupport") ~= "0" then%>
$(document).ready(function () {
function getVoIPSetUrl(userRight)
{
var voipProtocol = "<% cgilua.put(env.getenv('VoIPProtocal')) %>";
var selectedUrl = "";
var VoIPUrl ={
"SIP":{
"1" : "voipBasic",
"2" : "voipBasic",
"3" : "voipBasic",
"4" : ""
},
"H248":{
"1" : "h248Basic",
"2" : "",
"3" : "",
"4" : ""
},
"NoValidProtocol":{
"1" : "",
"2" : "",
"3" : "",
"4" : ""
}
};
if ( VoIPUrl[voipProtocol] )
{
selectedUrl = VoIPUrl[voipProtocol][userRight];
}
return selectedUrl;
}
function getVoIPStatusUrl(userRight)
{
var selectedUrl = "";
var urlLink = {
"1" : "voipStatus",
"2" : "voipStatus",
"3" : "voipStatus",
"4" : "voipStatus"
};
if ( urlLink[userRight] )
{
selectedUrl = urlLink[userRight];
}
return selectedUrl;
}
var voipMenuObj = $("#home_category_phone");
function UpdatevoipRegStat()
{
var voipServerAddr = "/?_type=menuData&_tag=voip_homepage_lua.lua";
voipMenuObj.chanegeDataByCustom = function(xml){
(function (xml) {
var ToOperParaArr = {
"IsOnline" : {
ValueOrigin: "",
setAction: function(ParaNameSel, ParaValSel, SelfVal){
if(SelfVal == 1)
{
ParaValSel.text("&?VoipStatus_017;");
}
else
{
ParaValSel.text("&?VoipStatus_018;");
}
}
}
};
var InstNum = $("Instance", $("OBJ_VOIPVPLINE_ID", $(xml))).length;
for (var i=0; i<InstNum; i++)
{
xmlParaInInstOperate(xml, "OBJ_VOIPVPLINE_ID", i, ToOperParaArr);
}
})(xml);
(function (xml) {
var OBJTag = xml.getElementsByTagName("OBJ_VOIPVPLINE_ID")[0];
if ( !OBJTag )
{
return;
}
var ParametersTag = OBJTag.getElementsByTagName("Instance");
for (var i=0; i<ParametersTag.length; i++)
{
var phoneNumParaName =xml.createElement("ParaName");
var phoneNumParaNameTextNode = xml.createTextNode("phoneName");
phoneNumParaName.appendChild(phoneNumParaNameTextNode);
var phoneID = parseInt(i) + 1;
var phoneNumParaValue =xml.createElement("ParaValue");
var phoneNumParaValueTextNode = xml.createTextNode("&?VoipStatus_016;"+ phoneID);
phoneNumParaValue.appendChild(phoneNumParaValueTextNode);
ParametersTag[i].appendChild(phoneNumParaName);
ParametersTag[i].appendChild(phoneNumParaValue);
}
})(xml);
};
voipMenuObj.succfunction = function(xml){
var cmapiErrorContainer = $("#voipErr");
if (cmapiErrorContainer.hasError(xml) == 0);
{
var categoryArea = $("#home_category_area");
categoryArea.trigger("set_current_category", ["home_category_phone"]);
var devListCategory = $("#home_devlist_category");
var options = {
"categoryName": "&?Home_024;",
"setLinkName": "&?Home_025;",
"getLinkFunc": getVoIPSetUrl
}
devListCategory.trigger("initialize", [options]);
var devListHead = $("#home_devlist_head");
var options = {
paraLangs: [
["phoneName", "&?VoipStatus_019;"]
]
};
<%
local voipProtocol = env.getenv("VoIPProtocal")
if voipProtocol == "SIP" then
%>
options.paraLangs.push(["AuthUserName", "&?VoipStatus_014;"])
<%
end
%>
options.paraLangs.push(["IsOnline", "&?public_001;"])
devListHead.trigger("exec_data_binding", [options]);
voipMenuObj.chanegeDataByCustom(xml);
var devListArea = $("#home_devitem");
devListArea.trigger("remove_instances");
var voipSipLineOBJ = $(xml).find("OBJ_VOIPVPLINE_ID");
var siplineNum = $("Instance", voipSipLineOBJ).length;
var renderNum = siplineNum;
if (siplineNum > 4)
{
renderNum = 4;
}
var OBJID = ["OBJ_VOIPSIPLINE_ID","OBJ_VOIPVPLINE_ID"];
devListArea.createPageDataByClone(renderNum, OBJID, xml);
$.callModifier("Home/VOIPSuccfunction");
var devListMore = $("#home_devlist_more");
var options = {
"instNum": siplineNum,
"getLinkFunc": getVoIPStatusUrl
}
devListMore.trigger("initialize", [options]);
}
};
voipMenuObj.failfunction = function(){
showWaitTip(false);
};
voipMenuObj.dataTransfer( voipServerAddr,
"GET",
voipMenuObj.succfunction,
voipMenuObj.failfunction,
false);
var UpdatevoipRegStatTimer = new ContextBindingTimer(function () {
UpdatevoipRegStat();
}, {timeout: 105*1000, contextDom: voipMenuObj.get(0)});
UpdatevoipRegStatTimer.start();
voipMenuObj.data("timer_object", UpdatevoipRegStatTimer);
}
voipMenuObj.click(function(){
$("#home_category_area").trigger("clear_all_timer");
UpdatevoipRegStat();
});
});
<%end%>
$(document).ready(function(){
if(cver == "41" && uRight != "1"){
$("#WANInfo").hide();
$("#fwArea").hide();
$("#HGWArea").hide();
}
$.publish("/some/hideWANUrl", [1]);
var categoryArea = $("#home_category_area");
var categoryItems = $(".home_category_item", categoryArea);
var devListArea = $("#home_devlist_area");
if ( categoryItems.length > 3 ) {
var menuHeight = categoryArea.height();
devListArea.height(menuHeight);
}
categoryArea.bind("set_current_category", function(event, menuid)
{
var menuObj = $("#"+menuid);
var menuObjBox = menuObj.parent();
var menuObjPos = menuObj.offset();
var left = menuObjPos.left + menuObj.width();
var top = menuObjPos.top + menuObj.height()/2 - 5;
var adevPointer = $("#home_adev_pointer");
adevPointer.show();
adevPointer.offset({left:left, top:top});
var tmpObj = $(this).next();
var devpopout = $("[id^='Btn_apply_UsbEject']", tmpObj);
if(menuid == "home_category_usb")
{
devpopout.show();
}
else
{
devpopout.hide();
}
});
categoryArea.bind("clear_all_timer", function(event) {
$(".home_categroy_name").each(function(){
var timer = $(this).data("timer_object");
if ( timer )
{
timer.stop();
}
});
});
var devListArea = $("#home_devitem");
devListArea.bind("remove_instances", function(){
$(this).find("[id^='template_home_devitem_']").each(function(){
$(this).remove();
});
});
$("#home_devlist_category").bind("initialize", function(event, options){
var categoryName = options.categoryName;
var setLinkName = options.setLinkName;
var getLinkFunc = options.getLinkFunc;
$("#home_category_name").text(categoryName);
var settingLinkDiv = $("#home_category_setting");
var settingLink = $("a", settingLinkDiv);
settingLink.unbind("click");
if ( setLinkName )
{
var uRight = <%=Right%>;
var linkUrl = getLinkFunc(uRight);
if ( "" != linkUrl && menuTreeObj.findMenu(linkUrl) )
{
settingLink.text(setLinkName);
settingLink.click(function(){
openLink(linkUrl);
});
settingLinkDiv.show();
}
else
{
settingLink.text("");
settingLinkDiv.hide();
}
}
else
{
settingLink.text("");
settingLinkDiv.hide();
}
});
$("#home_devlist_head").bind("exec_data_binding", function(event, options){
var paraNames = $(".home_devitem_para", "#home_devlist_head");
paraNames.removeAttr("title");
paraNames.text("");
var paraObjs = $(".home_devitem_para", "#template_home_devitem");
paraObjs.removeAttr("id");
var paraLangs = options.paraLangs;
for (var i = 0; i < paraLangs.length; i++) {
var paraLang = paraLangs[i];
var parameter = paraLang[0];
var lang = paraLang[1];
paraNames.eq(i).text(lang);
paraNames.eq(i).attr("title", lang);
paraObjs.eq(i).attr("id", parameter);
if ( i == 4 )
{
break;
}
}
});
var devListMore = $("#home_devlist_more");
devListMore.bind("initialize", function(event, options){
var instNum = options.instNum;
var getLinkFunc = options.getLinkFunc;
var moreObj = $(this);
var archorMore = moreObj.find("a");
archorMore.unbind("click");
if ( instNum > 4 )
{
var uRight = <%=Right%>;
var linkUrl = getLinkFunc(uRight);
if ( "" != linkUrl && menuTreeObj.findMenu(linkUrl) )
{
archorMore.show();
archorMore.bind("click", function(event){
openLink(linkUrl);
});
}
else
{
archorMore.hide();
}
}
else
{
archorMore.hide();
}
});
categoryItems.eq(0).find(".home_categroy_name").click();
});
</script>
