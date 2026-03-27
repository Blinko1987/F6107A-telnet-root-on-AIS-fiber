<script type="text/javascript">
var g_UpdateTopoTimer = null;
var g_topoServerAddr = "/?_type=menuData&_tag=topo_lua.lua";
if (!g_isThinklua)
{
g_topoServerAddr = "getpage.lua?pid=1005&nextpage=topo_lua.lua";
}
function hiddenALLSlave()
{
$("[id*='-device-lan-dev']").removeClass("lan-dev-online").addClass("lan-dev");
$("[id*='-device-2G-dev']").removeClass("wlan-dev-online").addClass("wlan-dev");
$("[id*='-device-5G-dev']").removeClass("wlan-dev-online").addClass("wlan-dev");
$("[id*='-device-lan-dev']").attr("title","");
$("[id*='-device-2G-dev']").attr("title","");
$("[id*='-device-5G-dev']").attr("title","");
$("[id^='slave1']").css("visibility", "hidden");
$("[id^='slave2']").css("visibility", "hidden");
}
function setMasterTitle(jqSelector, jsonData)
{
var titleStr = "Device: " + jsonData.DeviceName + "\n" +
"SoftwareVer: " + jsonData.SoftwareVer +"\n" +
"MAC: " + jsonData.MacAddr + "\n" +
"IP: " + jsonData.IpAddr;
$(jqSelector).attr("title", titleStr);
}
function setSlaveTitle(jqSelector, jsonData)
{
var linkspeedStr = "\n" + "Link Speed: " + jsonData.LinkSpeed + "Mbps";
var titleStr = "Device: " + jsonData.DeviceName + "\n" +
"SoftwareVer: " + jsonData.SoftwareVer +"\n" +
"MAC: " + jsonData.MacAddr + "\n" +
"IP: " + jsonData.IpAddr + "\n" +
"Link Type: " + jsonData.AccessType +
linkspeedStr;
if(jsonData.AccessType != "ETH")
{
titleStr = titleStr + "\n" +
"Uplink: " + speed_change_auto("wlan",jsonData.BhStaDataUpBpsRate) + "\n" +
"Downlink: " + speed_change_auto("wlan",jsonData.BhStaDataDownBpsRate) + "\n" +
"RSSI: " + jsonData.BhStaRssi + "dBm";
}
$(jqSelector).attr("title", titleStr);
}
function setWlanAdevTitle(jqSelector, jsonData)
{
var titleStr = "Device: " + jsonData.HostName + "\n" +
"MAC: " + jsonData.MacAddr + "\n" +
"IP: " + jsonData.IpAddr + "\n" +
"&?pro_topo_002;: " + jsonData.AssocTime + "&?public_013;" + "\n" +
"&?pro_topo_003;: " + bps_speed_change_auto(jsonData.RxRateBps) + "\n" +
"&?pro_topo_004;: " + bps_speed_change_auto(jsonData.TxRateBps) + "\n" +
"RSSI: " + jsonData.Rssi + "&?public_110;" + "\n" +
"BTM: " + jsonData.Btm + "\n" +
"RRM: " + jsonData.Rrm + "\n" +
"&?pro_topo_010;: " + jsonData.WirelessMode;
$(jqSelector).attr("title", titleStr);
}
function setEthAdevTitle(jqSelector, jsonData)
{
var titleStr = "Device: " + jsonData.HostName + "\n" +
"MAC: " + jsonData.MacAddr + "\n" +
"IP: " + jsonData.IpAddr;
$(jqSelector).attr("title", titleStr);
}
function dealcascade(data)
{
if (data == null || data.master == null)
{
hiddenALLSlave();
return;
}
var master = data.master;
setMasterTitle("#master .router_big", master);
$("#master_InstID").val(master.instID);
var slave = data.slave;
var count = slave.length;
if (count > 3) {
count = 3;
}
if(count == 1)
{
$("[id*='left']").css("visibility", "hidden");
$("[id*='right']").css("visibility", "hidden");
$("#slave1_middle_InstID").val(slave[0].instID);
$("[id*='slave1-line-top']").css("visibility", "visible");
$("[id*='slave1-line-middle']").css("visibility", "visible");
$("[id*='slave1-middle']").css("visibility", "visible");
setSlaveTitle("#slave1-middle .router_small", slave[0]);
if(slave[0].slave3)
{
$("[id*='slave2-line-middle']").css("visibility", "visible");
$("[id*='slave2-middle']").css("visibility", "visible");
setSlaveTitle("#slave2-middle .router_small", slave[0].slave3);
$("#slave2_middle_InstID").val(slave[0].slave3.instID);
}
else
{
$("[id*='slave2-middle']").css("visibility", "hidden");
$("[id*='slave2-line-middle']").css("visibility", "hidden");
}
}
else if(count == 2)
{
$("[id*='middle']").css("visibility", "hidden");
$("[id*='slave1-line-top']").css("visibility", "visible");
$("[id*='slave1-line-left-1']").css("visibility", "visible");
$("[id*='slave1-line-left-2']").css("visibility", "visible");
$("[id*='left']").css("visibility", "visible");
$("[id*='slave1-line-right-1']").css("visibility", "visible");
$("[id*='slave1-line-right-2']").css("visibility", "visible");
$("[id*='right']").css("visibility", "visible");
setSlaveTitle("#slave1-left .router_small", slave[0]);
setSlaveTitle("#slave1-right .router_small", slave[1]);
$("#slave1_left_InstID").val(slave[0].instID);
$("#slave1_right_InstID").val(slave[1].instID);
if(slave[0].slave3)
{
$("[id*='slave2-line-left']").css("visibility", "visible");
$("[id*='slave2-left']").css("visibility", "visible");
setSlaveTitle("#slave2-left .router_small", slave[0].slave3);
$("#slave2_left_InstID").val(slave[0].slave3.instID);
}
else
{
$("[id*='slave2-left']").css("visibility", "hidden");
$("[id*='slave2-line-left']").css("visibility", "hidden");
}
if(slave[1].slave3)
{
$("[id*='slave2-line-right']").css("visibility", "visible");
$("[id*='slave2-right']").css("visibility", "visible");
setSlaveTitle("#slave2-right .router_small", slave[1].slave3);
$("#slave2_right_InstID").val(slave[1].slave3.instID);
}
else
{
$("[id*='slave2-right']").css("visibility", "hidden");
$("[id*='slave2-line-right']").css("visibility", "hidden");
}
}
else if(count == 3)
{
$("[id*='slave1-line-top']").css("visibility", "visible");
$("[id*='slave1-line-middle']").css("visibility", "visible");
$("[id*='middle']").css("visibility", "visible");
$("[id*='slave1-line-left-1']").css("visibility", "visible");
$("[id*='slave1-line-left-2']").css("visibility", "visible");
$("[id*='left']").css("visibility", "visible");
$("[id*='slave1-line-right-1']").css("visibility", "visible");
$("[id*='slave1-line-right-2']").css("visibility", "visible");
$("[id*='right']").css("visibility", "visible");
setSlaveTitle("#slave1-left .router_small", slave[0]);
setSlaveTitle("#slave1-middle .router_small", slave[1]);
setSlaveTitle("#slave1-right .router_small", slave[2]);
$("#slave1_left_InstID").val(slave[0].instID);
$("#slave1_middle_InstID").val(slave[1].instID);
$("#slave1_right_InstID").val(slave[2].instID);
if(slave[0].slave3)
{
$("[id*='slave2-line-left']").css("visibility", "visible");
$("[id*='slave2-left']").css("visibility", "visible");
setSlaveTitle("#slave2-left .router_small", slave[0].slave3);
$("#slave2_left_InstID").val(slave[0].slave3.instID);
}
else
{
$("[id*='slave2-left']").css("visibility", "hidden");
$("[id*='slave2-line-left']").css("visibility", "hidden");
}
if(slave[1].slave3)
{
$("[id*='slave2-line-middle']").css("visibility", "visible");
$("[id*='slave2-middle']").css("visibility", "visible");
setSlaveTitle("#slave2-middle .router_small", slave[1].slave3);
$("#slave2_middle_InstID").val(slave[1].slave3.instID);
}
else
{
$("[id*='slave2-middle']").css("visibility", "hidden");
$("[id*='slave2-line-middle']").css("visibility", "hidden");
}
if(slave[2].slave3)
{
$("[id*='slave2-line-right']").css("visibility", "visible");
$("[id*='slave2-right']").css("visibility", "visible");
setSlaveTitle("#slave2-right .router_small", slave[2].slave3);
$("#slave2_right_InstID").val(slave[2].slave3.instID);
}
else
{
$("[id*='slave2-right']").css("visibility", "hidden");
$("[id*='slave2-line-right']").css("visibility", "hidden");
}
}
else
{
$("[id^='slave1']").css("visibility", "hidden");
$("[id^='slave2']").css("visibility", "hidden");
}
dealAD(data);
var agentEvtTimeoutHandler = null;
$(".router_small")
.off("click").on("click", function(){
var clickObj = $(this);
clearTimeout(agentEvtTimeoutHandler);
agentEvtTimeoutHandler = setTimeout(function(){
visitAgentWeb(clickObj);
}, 250);
});
}
function dealAD(data)
{
var allAD = data.ad;
var num = allAD.MGET_INST_NUM;
$("[id*='InstID']").each(function(key,value){
var obj_ID = $(this).parent().attr("id");
var tempInst = $(this).val();
var lanCount = 0;
var w2GCount = 0;
var w5GCount = 0;
for(var i=1;i<=num;i++)
{
if(tempInst == allAD[i].parent)
{
if(allAD[i].AccessType =="0")
{
lanCount++;
if (lanCount > 3) {
continue;
}
setEthAdevTitle("#"+obj_ID+"-device-lan-dev"+lanCount, allAD[i]);
$("#"+obj_ID+"-device-lan-dev"+lanCount).removeClass("lan-dev").addClass("lan-dev-online");
}
else if(allAD[i].AccessType =="1")
{
w2GCount++;
if (w2GCount > 3) {
continue;
}
setWlanAdevTitle("#"+obj_ID+"-device-2G-dev"+w2GCount, allAD[i]);
$("#"+obj_ID+"-device-2G-dev"+w2GCount).removeClass("wlan-dev").addClass("wlan-dev-online");
}
else if(allAD[i].AccessType =="2")
{
w5GCount++;
if (w5GCount > 3) {
continue;
}
setWlanAdevTitle("#"+obj_ID+"-device-5G-dev"+w5GCount, allAD[i]);
$("#"+obj_ID+"-device-5G-dev"+w5GCount).removeClass("wlan-dev").addClass("wlan-dev-online");
}
}
}
$("#"+obj_ID+"-device-lan-count").val(lanCount);
$("#"+obj_ID+"-device-2G-count").val(w2GCount);
$("#"+obj_ID+"-device-5G-count").val(w5GCount);
if (lanCount > 0) {
$("#"+obj_ID+"-device-lan-dev4").removeClass("more-lan-dev").addClass("more-lan-dev-online");
} else {
$("#"+obj_ID+"-device-lan-dev4").removeClass("more-lan-dev-online").addClass("more-lan-dev");
}
if (w2GCount > 0) {
$("#"+obj_ID+"-device-2G-dev4").removeClass("more-wlan-dev").addClass("more-wlan-dev-online");
} else {
$("#"+obj_ID+"-device-2G-dev4").removeClass("more-wlan-dev-online").addClass("more-wlan-dev");
}
if (w5GCount > 0) {
$("#"+obj_ID+"-device-5G-dev4").removeClass("more-wlan-dev").addClass("more-wlan-dev-online");
} else {
$("#"+obj_ID+"-device-5G-dev4").removeClass("more-wlan-dev-online").addClass("more-wlan-dev");
}
});
}
function visitAgentWeb(evtTarget)
{
var titleStr = evtTarget.attr("title");
var patt1 = /\d+\.\d+\.\d+\.\d+/;
var IPString = titleStr.indexOf("IP:");
var LinkTypeString = titleStr.indexOf("Link Type:");
var titleIP = titleStr.substring(IPString + 3, LinkTypeString - 1);
var pathStr = titleIP.match(patt1);
var abs = window.top.location.href;
var patt2 = /\w+:/;
var protocolStr = abs.match(patt2);
var urlStr = protocolStr + "//" + pathStr;
window.open(urlStr);
}
function UpdateTopo()
{
hiddenALLSlave();
$.ajax({
url: g_topoServerAddr,
type: "GET",
dataType: "json",
timeout: 30000,
async: true,
cache:false,
error: function(){
hiddenALLSlave();
showWaitTip(false);
},
success: function(data){
var visibletype = $("#Non1905AccessDevDiv_copy").css("visibility");
if(visibletype == "visible")
{
showWaitTip(true);
}
else
{
showWaitTip(false);
}
dealcascade(data);
}
});
}
function dealmoredata(Head, data, accesstype)
{
var HeadID = Head.attr("id");
var ruleTemplate = $("#data_AccessDev",Head);
var TemplateOBJ = $("#template_"+HeadID,Head);
$("[id^='data_AccessDev_']", TemplateOBJ).remove();
if (data == null || data.master == null)
{
return;
}
var RuleNum = data.ad.MGET_INST_NUM;
$("#_InstNum", Head).val(RuleNum);
if (RuleNum == 0)
{
return;
}
for (var i=0; i<RuleNum; i++)
{
var j = i+1;
var hostname = data.ad[j].HostName;
var mac = data.ad[j].MacAddr;
var ip = data.ad[j].IpAddr;
var onlineduration = data.ad[j].AssocTime + "&?public_013;";
var realtimeupstream = bps_speed_change_auto(data.ad[j].RxRateBps);
var realtimedownstream = bps_speed_change_auto(data.ad[j].TxRateBps);
var rssi = data.ad[j].Rssi + "&?public_110;";
var btm = data.ad[j].Btm;
var rrm = data.ad[j].Rrm;
var wlm = data.ad[j].WirelessMode;
var clone = ruleTemplate.cloneWithSuffix(i, "_");
ruleTemplate.before(clone);
$("[id^='HostName_"+i+"']", clone).text(hostname).attr("title", hostname);
$("[id^='MAC_"+i+"']", clone).text(mac).attr("title", mac);
$("[id^='IP_"+i+"']", clone).text(ip).attr("title", ip);
$("[id^='OnlineDuration_"+i+"']", clone).text(onlineduration).attr("title", onlineduration);
$("[id^='RealTimeUpstream_"+i+"']", clone).text(realtimeupstream).attr("title", realtimeupstream);
$("[id^='RealTimeDownstream_"+i+"']", clone).text(realtimedownstream).attr("title", realtimedownstream);
$("[id^='Rssi_"+i+"']", clone).text(rssi).attr("title", rssi);
$("[id^='Btm_"+i+"']", clone).text(btm).attr("title", btm);
$("[id^='Rrm_"+i+"']", clone).text(rrm).attr("title", rrm);
$("[id^='WirelessMode_"+i+"']", clone).text(wlm).attr("title", wlm);
clone.showIt(true);
}
var wlanOnlyParas = $("span.wlan_only", Head);
if (0 == accesstype) {
wlanOnlyParas.showIt(false);
} else {
wlanOnlyParas.showIt(true);
}
reposition_box("Non1905AccessDevDiv_copy");
var TiplayerResize = window.onresize;
window.onresize = function()
{
TiplayerResize();
if ($("#Non1905AccessDevDiv_copy").css("display") != "none")
{
reposition_box("Non1905AccessDevDiv_copy");
}
}
}
function getAccessDev(accesstype, parentID, Head)
{
if (accesstype == 'LAN')
{
accesstype = 0;
}
else if(accesstype == '2G')
{
accesstype = 1;
}
else if(accesstype == '5G')
{
accesstype = 2;
}
var accessDevAddr = g_topoServerAddr + "&AccessType=" + accesstype + "&ParentID=" + parentID + "&Action=More";
$.ajax({
url:accessDevAddr,
type: "GET",
dataType: "json",
timeout: 30000,
async: true,
cache:false,
error: function(){
hiddenALLSlave();
},
success: function(data){
dealmoredata(Head, data, accesstype);
}
});
}
function TopoShowAccessDev(accesstype, moreid)
{
var accessDevCount = $("#"+moreid+"-count").val();
if(accessDevCount < 1)
{
return;
}
$("#blackMask").css("display", "block");
var source = $("#Non1905AccessDevDiv");
var clone = source.clone(true);
clone.attr("id", clone.attr("id")+"_copy");
clone.showIt(true);
clone.appendTo('body');
var moreobj = $("#"+moreid);
var templateobj = moreobj.parents(".topo-border-radius");
var mac = $(".DeviceMac",templateobj).val();
var AccessDevHead = $("#AccessDevDisplay", clone);
getAccessDev(accesstype, mac, AccessDevHead);
reposition_box("Non1905AccessDevDiv_copy");
$("#Non1905AccessDevDiv_copy").css("display", "block");
$("#"+"instDelete_AccessDev", AccessDevHead).bind("click", function(event){
showWaitTip(false);
$("#Non1905AccessDevDiv_copy").remove();
});
}
function setAliasEvt(evtTarget) {
g_UpdateTopoTimer.stop();
var title = evtTarget.attr("title");
var macMatch = title.match(/MAC:\s*[a-fA-F0-9]{2}(:[a-fA-F0-9]{1,2}){5}/);
var devMatch = title.match(/Device:.*/);
var oldAlias = devMatch != null ? devMatch[0].replace(/Device:\s*/,"") : "";
var temp = $(this);
var contxt = $("<p>&?pro_topo_011;<input type='text' id='alias' value='' class='w200'></p>");
contxt.find("#alias").val(oldAlias);
var confirmLayer = IniConfirm("");
$("#confirmMsg", confirmLayer).html(contxt);
$("#confirmCancel", confirmLayer).off("click").on("click", function(){
showWaitTip(false);
g_UpdateTopoTimer.start();
});
$("#confirmOK", confirmLayer).off("click").on("click", function(){
var InstIdentityVal = macMatch != null ? macMatch[0].replace(/MAC:\s*/,"") : "";
var AliasVal = $("#alias",confirmLayer).val();
var PostData = "InstIdentity="+InstIdentityVal+"&"
+ "Alias=" + AliasVal;
dataPost("SET_ALIAS", "callbackSetAlias", g_topoServerAddr+"&Action=SET_ALIAS", temp, PostData,false,undefined,"json");
});
temp.bind("callbackSetAlias", function(event,xml, temp){
UpdateTopo();
g_UpdateTopoTimer.start();
showWaitTip(false);
});
}
function modifyAccDev(btn) {
var template = $(btn).closest("div.colorTblRow");
$(btn).hide();
$("button.editing", template).show();
var hostNameObj = $("[id^=HostName]", template);
var oldName = hostNameObj.text();
hostNameObj.html("<input type='text' value='" + oldName + "' class='w80'>" +
"<input type='hidden' value='" + oldName + "'>");
}
function doModify(btn) {
var template = $(btn).closest("div.colorTblRow");
var hostNameObj = $("[id^=HostName]", template);
var inputVal = $("input[type=text]", hostNameObj).val();
var data = {};
var InstIdentityVal = $("[id^=MAC]", template).text();
var AliasVal = inputVal;
var PostData = "InstIdentity="+InstIdentityVal+"&"
+ "Alias=" + AliasVal;
dataPost("SET_ALIAS", "callbackdoModify", g_topoServerAddr+"&Action=SET_ALIAS", template, PostData, false,undefined,"json");
template.bind("callbackdoModify", function(event,xml, template){
UpdateTopo();
hostNameObj.text(inputVal).attr("title", inputVal);
$("button.notEditing", template).show();
$("button.editing", template).hide();
});
}
function cancelModify(btn) {
var template = $(btn).closest("div.colorTblRow");
$("button.notEditing", template).show();
$("button.editing", template).hide();
var hostNameObj = $("[id^=HostName]", template);
var inputVal = $("input[type=hidden]", hostNameObj).val();
hostNameObj.text(inputVal);
}
$(document).ready(function(){
var topoImgs = ['./img/master.png', './img/router_big.png', './img/more_online.png', './img/wlan.png',
'./img/lan-icon.png', './img/lap-top.png', './img/iphone_offline.png', './img/iphone.png',
'./img/laptop_offline.png', './img/more.png', './img/slave.png', './img/router_small.png'];
function preload(imgSrcArr)
{
var imgTmp = [];
for (var i = 0; i < imgSrcArr.length; i++)
{
imgTmp[i] = new Image();
imgTmp[i].src = imgSrcArr[i];
}
}
preload(topoImgs);
var timeIntervalTOPO = 15;
var TopoOBJ = $("#master-area");
g_UpdateTopoTimer = new ContextBindingTimer(function () {
UpdateTopo();
}, {interval: timeIntervalTOPO*1000, contextDom: TopoOBJ.get(0)});
UpdateTopo();
g_UpdateTopoTimer.start();
});
</script>
