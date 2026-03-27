<script type="text/javascript">
var ServerAddr = "/?_type=menuData&_tag=home_ais_lua.lua";
var UpdateAttaDev;
var UpdateAttaDevId = "";
var UpdateInterStatus;
var UpdateInterStatusId = "";
var UpdateEasyDiagID;
var UpdateEasyDiagIDId = "";
var UpdateReEasyDiag;
var UpdateReEasyDiagId = "";
var SpeedTestServer;
var SpeedTestServerid = "";
var SpeedTestDiag;
var SpeedTestDiagId = "";
var SpeedTestDiagMaxTime = 120;
var homeWrapperHead;
var SpeedTestHead;
var IsFillPingResult = 1;
var DiagFinish = 1;
var IsInterReConnect = 0;
function IfServerLive() {
var HeadID = "homeWrapper";
var Head = $("#" + HeadID);
Head.succfunction = function (xml) {
Head.hasError(xml);
showWaitTip(false);
return;
};
Head.failfunction = function (XMLHttpRequest, textStatus) {
setTimeout("IfServerLive()", 30000);
};
Head.dataTransfer(ServerAddr, "GET", Head.succfunction, Head.failfunction, false);
}
function ReGetPingDiagnosis(xml) {
clearInterval(UpdateEasyDiagIDId);
UpdateEasyDiagIDId = "";
clearInterval(UpdateReEasyDiagId);
UpdateReEasyDiagId = ""
var Head = $("#homeWrapper");
var ToOperParaArr = {
"DNS1IP": {
ValueOrigin: ""
},
"DNS2IP": {
ValueOrigin: ""
},
"LANIP": {
ValueOrigin: ""
},
"WANIP": {
ValueOrigin: ""
},
"DefaultGWIP": {
ValueOrigin: ""
},
"LAN1IP": {
ValueOrigin: ""
},
"LAN2IP": {
ValueOrigin: ""
},
"LAN3IP": {
ValueOrigin: ""
},
"LAN4IP": {
ValueOrigin: ""
},
"DiagFinish": {
ValueOrigin: "",
setAction: function (ParaNameSel, ParaValSel, SelfVal) {
if (SelfVal == 1 || SelfVal == "1") {
$("#DiagFinish").val(1);
DiagFinish = 1;
IsFillPingResult = 1;
} else {
$("#DiagFinish").val(0);
DiagFinish = 0;
UpdateEasyDiagID.start();
UpdateEasyDiagIDId = UpdateEasyDiagID.getTimerID();
}
}
},
"LANIPCheck": {
ValueOrigin: ""
},
"WANIPCheck": {
ValueOrigin: ""
},
"DNSCheck": {
ValueOrigin: "",
setAction: function (ParaNameSel, ParaValSel, SelfVal) {
if (SelfVal == "1") {
$("#DNSCheck", Head).css("width", "100%");
$("#DNSCheck_Pic", Head).attr("src", "img/Path_231.png");
$("#DNS1IP_Data", Head).text(ToOperParaArr["DNS1IP"].ValueOrigin);
$("#DNS2IP_Data", Head).text(ToOperParaArr["DNS2IP"].ValueOrigin);
} else {
$("#DNSCheck", Head).css("width", "0%");
$("#DNSCheck_Pic", Head).attr("src", "img/ico_home_no.png");
$("#DNS1IP_Data", Head).text("0.0.0.0");
$("#DNS2IP_Data", Head).text("0.0.0.0");
}
}
},
"PingCheck": {
ValueOrigin: "",
setAction: function (ParaNameSel, ParaValSel, SelfVal) {
if (SelfVal > "0" && ToOperParaArr["DefaultGWIP"].ValueOrigin != "0.0.0.0") {
$("#PingCheck", Head).css("width", "100%");
$("#PingCheck_Pic", Head).attr("src", "img/Path_231.png");
$("#DefaultGWIP_Data", Head).text(ToOperParaArr["DefaultGWIP"].ValueOrigin);
} else {
$("#PingCheck", Head).css("width", "0%");
$("#PingCheck_Pic", Head).attr("src", "img/ico_home_no.png");
$("#DefaultGWIP_Data", Head).text("0.0.0.0");
}
}
},
"LAN1IPCheck": {
ValueOrigin: ""
},
"LAN2IPCheck": {
ValueOrigin: ""
},
"LAN3IPCheck": {
ValueOrigin: ""
},
"LAN4IPCheck": {
ValueOrigin: ""
},
};
xmlParaInInstOperate(xml, "OBJ_EASY_DIAG_ID", 0, ToOperParaArr);
if (IsFillPingResult == 0) {
return;
}
var Checks = [{
"name": "LAN1IP",
"check": ToOperParaArr["LAN1IPCheck"].ValueOrigin,
"value": ToOperParaArr["LAN1IP"].ValueOrigin
},
{
"name": "LAN2IP",
"check": ToOperParaArr["LAN2IPCheck"].ValueOrigin,
"value": ToOperParaArr["LAN2IP"].ValueOrigin
},
{
"name": "LAN3IP",
"check": ToOperParaArr["LAN3IPCheck"].ValueOrigin,
"value": ToOperParaArr["LAN3IP"].ValueOrigin
},
{
"name": "LAN4IP",
"check": ToOperParaArr["LAN4IPCheck"].ValueOrigin,
"value": ToOperParaArr["LAN4IP"].ValueOrigin
},
{
"name": "WANIP",
"check": ToOperParaArr["WANIPCheck"].ValueOrigin,
"value": ToOperParaArr["WANIP"].ValueOrigin
},
{
"name": "LANIP",
"check": ToOperParaArr["LANIPCheck"].ValueOrigin,
"value": ToOperParaArr["LANIP"].ValueOrigin
}
]
for (var c = 0; c < Checks.length; c++) {
var Data_C = "#" + Checks[c].name + "_Data";
var Check_C = "#" + Checks[c].name + "Check";
var Check_Pic_C = "#" + Checks[c].name + "Check_Pic";
$(Data_C, Head).text(Checks[c].value);
if (Checks[c].check == "1") {
$(Check_C, Head).css("width", "100%");
$(Check_Pic_C, Head).attr("src", "img/Path_231.png");
} else {
$(Check_C, Head).css("width", "0%");
$(Check_Pic_C, Head).attr("src", "img/ico_home_no.png");
}
}
if (ToOperParaArr["DiagFinish"].ValueOrigin == 1 || ToOperParaArr["DiagFinish"].ValueOrigin == "1") {
UpdateReEasyDiag.start();
UpdateReEasyDiagId = UpdateReEasyDiag.getTimerID();
IsFillPingResult = 0;
}
}
function clearEasyDiagStatus() {
var Head = $("#homeWrapper");
$("#LANIPCheck", Head).css("width", "0%");
$("#LANIPCheck_Pic", Head).attr("src", "img/ico_home_no.png");
$("#LANIPCheck_Data", Head).text("0.0.0.0");
$("#WANIPCheck", Head).css("width", "0%");
$("#WANIPCheck_Pic", Head).attr("src", "img/ico_home_no.png");
$("#WANIP_Data", Head).text("0.0.0.0");
$("#DNSCheck", Head).css("width", "0%");
$("#DNSCheck_Pic", Head).attr("src", "img/ico_home_no.png");
$("#DNS1IP_Data", Head).text("0.0.0.0");
$("#DNS2IP_Data", Head).text("0.0.0.0");
$("#PingCheck", Head).css("width", "0%");
$("#PingCheck_Pic", Head).attr("src", "img/ico_home_no.png");
$("#DefaultGWIP_Data", Head).text("0.0.0.0");
$("#LAN1IPCheck", Head).css("width", "0%");
$("#LAN1IPCheck_Pic", Head).attr("src", "img/ico_home_no.png");
$("#LAN2IPCheck", Head).css("width", "0%");
$("#LAN2IPCheck_Pic", Head).attr("src", "img/ico_home_no.png");
$("#LAN3IPCheck", Head).css("width", "0%");
$("#LAN3IPCheck_Pic", Head).attr("src", "img/ico_home_no.png");
$("#LAN4IPCheck", Head).css("width", "0%");
$("#LAN4IPCheck_Pic", Head).attr("src", "img/ico_home_no.png");
}
function ReGetInterStatus(xml) {
var Head = $("#homeWrapper");
var ToOperParaArr = {
"IPAddress": {
ValueOrigin: "",
setAction: function (ParaNameSel, ParaValSel, SelfVal) {
if (SelfVal != "0.0.0.0") {
$("#InternetStatus", Head).attr("src", "img/Path_231.png");
$("#IPAddress", Head).text(SelfVal);
} else {
$("#InternetStatus", Head).attr("src", "img/ico_home_no.png");
$("#IPAddress", Head).text("0.0.0.0");
}
}
},
"DNS": {
ValueOrigin: "",
setAction: function (ParaNameSel, ParaValSel, SelfVal) {
if (SelfVal != "0.0.0.0") {
$("#DNS", Head).text(SelfVal);
} else {
$("#InternetStatus", Head).attr("src", "img/ico_home_no.png");
$("#DNS", Head).text("0.0.0.0");
}
}
},
}
xmlParaInInstOperate(xml, "OBJ_INTERNET_STATUS_ID", 0, ToOperParaArr);
}
function ReGetAttaDev(xml) {
var template = $("#homeWrapper");
var OBJID = ["OBJ_ACCESSDEV_NUM_ID"];
template.fillDataByOBJID(xml, OBJID, $("#homeWrapper"), 0);
}
function ReGetDevInfo(xml) {
var ToOperParaArr = {
"CpuUsage1": {
ValueOrigin: "",
setAction: function (ParaNameSel, ParaValSel, SelfVal) {
if (SelfVal != 0) {
$("#LedCPU").css("width", ParaValSel.text() + "%");
}
}
},
"MemUsage": {
ValueOrigin: "",
setAction: function (ParaNameSel, ParaValSel, SelfVal) {
if (SelfVal != 0) {
$("#LedMemory").css("width", ParaValSel.text() + "%");
}
}
},
"TotalFlash":{
ValueOrigin: "",
setAction: function (ParaNameSel, ParaValSel, SelfVal) {
}
},
"Flash_Percent_Used": {
ValueOrigin:"",
setAction: function (ParaNameSel, ParaValSel, SelfVal) {
var totalSize = parseInt(ToOperParaArr["TotalFlash"].ValueOrigin)/1024/1024;
var flashusage = SelfVal+"%";
$("#FlashSizeUsage").prop("textContent",flashusage + " of " + totalSize + "MB");
$("#LedFlash").css("width", flashusage);
}
}
};
xmlParaInInstOperate(xml, "OBJ_CPUMEMUSAGE_ID", 0, ToOperParaArr);
xmlParaInInstOperate(xml, "OBJ_FLASHINFO_ID", 0, ToOperParaArr);
}
function toDecimalAdPercent(x) {
var f = parseFloat(x);
if (isNaN(f)) {
return;
}
f = Math.round(x * 100);
return f + "%";
}
function initial_Click() {
var template = $("#homeWrapper");
template.unbind("RefershSuccHandler");
template.bind("RefershSuccHandler", function (event, xml, template) {
if (template.hasError(xml) == 0) {
$("#Btn_Refresh>button").css("background", "#E8E8E8");
ReGetAttaDev(xml);
}
});
}
function ReconnectClick() {
var template_reconnect = $("#homeWrapper");
$("#Btn_PingReconnect").unbind("click");
$("#Btn_PingReconnect").bind("click", {
templateOBJ: template_reconnect
}, function (event) {
$("#DiagFinish").val(1);
DiagFinish = 1;
IsFillPingResult = 1;
clearEasyDiagStatus();
$("#Btn_PingReconnect>button").css("background", "#D0D0D0");
UpdateEasyDiagHandle();
});
$("#Btn_InterReconnect").unbind("click");
$("#Btn_InterReconnect").bind("click", {
templateOBJ: template_reconnect
}, function (event) {
IsInterReConnect = 1;
$("#Btn_InterReconnect>button").css("background", "#D0D0D0");
$("#Btn_InterReconnect>button").text("connecting");
$("#Btn_InterReconnect>button").attr("disabled","disabled");
$("#InternetStatus", template_reconnect).attr("src", "img/ico_home_no.png");
$("#IPAddress", template_reconnect).text("0.0.0.0");
$("#DNS", template_reconnect).text("0.0.0.0");
ReConnectInternetHandle();
});
$("#Btn_Refresh").unbind("click");
$("#Btn_Refresh").bind("click", {
templateOBJ: template_reconnect
}, function (event) {
$("#Btn_Refresh>button").css("background", "#D0D0D0");
UpdateAttaDevHandle();
});
}
function showAttachedDevs() {
var temp = $("#AttachedDevsContent");
$("#template_AttachedDevs", temp).unbind("click");
$("#template_AttachedDevs").bind("click", function () {
var template = $(this);
showHomePopWin();
});
}
function initail_template_AssociateDevsCfg(Head) {
$("#instDelete_AttachedDevs", Head).unbind("click");
$("#instDelete_AttachedDevs", Head).bind("click", function (event) {
showWaitTip(false);
$("#AttachedDevsDiv_copy").remove();
$(document.body).css("overflow-y", "auto");
$(".online-device").css("overflow-y", "hidden");
});
window.onresize = function () {
if ($("#AttachedDevsDiv_copy").css("display") != "none") {
reposition_box("AttachedDevsDiv_copy");
}
}
}
function showHomePopWin(template) {
showWaitTip(true)
$(document.body).css("overflow-y", "hidden");
$(".online-device").css("overflow-y", "auto");
var source = $("#AttachedDevsDiv");
var clone = source.clone(true);
clone.attr("id", clone.attr("id") + "_copy");
clone.showIt(true);
clone.appendTo('body');
var Head = $("#AttachedDevsCfg", clone);
InitailAssociatedDevs(Head);
}
function InitailAssociatedDevs(Head) {
initail_template_AssociateDevsCfg(Head);
Head.succfunction = function (xml) {
if (Head.hasError(xml) == 0) {
$("#AttachedDevsDiv_copy").css("display", "block");
reposition_box("AttachedDevsDiv_copy");
renderSubrouterLists(xml)
renderDeviceLists(xml);
} else {
$("#instDelete_AttachedDevs", Head).click();
}
};
Head.failfunction = function (xml) {
$("#instDelete_AttachedDevs", Head).click();
};
if ($(".collapBarWithDataTrans", Head).length <= 0) {
Head.dataTransfer(ServerAddr,
"GET",
Head.succfunction,
Head.failfunction,
false,
true);
} else {
initial_collapBarWithDataTrans(Head);
}
}
function createEle(eleName, eleClassName, eleVal) {
if (!eleName) return null;
var eleDom = document.createElement(eleName);
if (!eleClassName) return eleDom;
eleDom.className = eleClassName;
if (!eleVal) return eleDom;
return eleDom
}
function renderSubrouterLists(xml) {
var $subrouter = $(".main-router-lists");
var frg = document.createDocumentFragment();
OBJ_Temp = $(xml).find('OBJ_INTERNET_STATUS_ID');
INSTs = $("Instance", OBJ_Temp);
$(".sub-count>span").text("1");
var INST = INSTs.eq(0);
var defWAN_info = ['IPAddress','TxRate', 'RxRate', 'MacAddr'];
var oLi = createEle('li', 'item:0');
var pictureWrap = createEle('div', 'device-picture hAuto');
var pictureImg = createEle('img');
pictureImg.src = "img/Group_34.png";
pictureWrap.appendChild(pictureImg);
var deviceInfo = createEle('div', 'device-info');
INST.find("ParaName").each(function () {
var oP = createEle('p', 'wifi-info');
ParaName = $(this).text();
ParaValue = $(this).next().text();
if (ParaName === "IPAddress") {
oP.textContent = ParaValue;
oP.className = "wifi-title";
defWAN_info[0] = oP;
}
if (ParaName === "MacAddr") {
oP.textContent = ParaValue;
defWAN_info[3] = oP;
}
});
OBJ_Temp = $(xml).find('OBJ_HOME_PONRATE_ID');
INSTs = $("Instance", OBJ_Temp);
INST = INSTs.eq(0);
INST.find("ParaName").each(function () {
var oSpan = createEle('span');
ParaName = $(this).text();
ParaValue = $(this).next().text();
if (ParaName === "TxRate") {
oSpan.textContent = ParaValue;
defWAN_info[1] = oSpan;
}
if (ParaName === "RxRate") {
oSpan.textContent = ParaValue;
defWAN_info[2] = oSpan;
}
});
var tempP = createEle('p', 'wifi-info');
if (defWAN_info[1] && defWAN_info[1] != "TxRate") {
var oI1 = createEle('i', 'arrow-icon up-icon');
tempP.appendChild(oI1);
tempP.appendChild(defWAN_info[1]);
}
if (defWAN_info[2] && defWAN_info[2] != "RxRate") {
var oI2 = createEle('i', 'arrow-icon down-icon');
tempP.appendChild(oI2);
tempP.appendChild(defWAN_info[2]);
}
defWAN_info.splice(1, 2, tempP);
$(defWAN_info).each(function (index, p) {
p.nodeName === "P" ? deviceInfo.appendChild(p) : null
})
oLi.appendChild(pictureWrap);
oLi.appendChild(deviceInfo);
frg.appendChild(oLi);
$subrouter.children("li").remove();
$subrouter.append(frg)
frg = null;
}
function renderDeviceLists(xml) {
var $deviceUl = $(".device-lists");
var frg = document.createDocumentFragment();
OBJ_Temp = $(xml).find('OBJ_ACCESSDEV_INFO_ID');
INSTs = $("Instance", OBJ_Temp);
$(".device-count>span").text(INSTs.length);
for (var i = 1; i <= INSTs.length; i++) {
var INST = INSTs.eq(i - 1);
var wifi_info = ['MACAddress', 'Interface', 'UpRate', 'DownRate', 'LinkSpeed', 'IPAddress'];
var picture_ary = ['img/Group_37.png', 'img/Group_36.png'];
var accessType = '';
var oLi = document.createElement("li");
oLi.className = 'item:' + i;
var devicePicture = document.createElement("div");
devicePicture.className = "device-picture";
var pictureImg = document.createElement("img");
var deviceInfo = document.createElement("div");
deviceInfo.className = "device-info";
INST.find("ParaName").each(function () {
var oP = document.createElement('p');
oP.className = "wifi-info";
var oSpan = document.createElement("span");
ParaName = $(this).text();
ParaValue = $(this).next().text();
if (ParaName === "MACAddress") {
oP.className = "wifi-title";
oP.textContent = ParaValue;
wifi_info[0] = oP;
}
if (ParaName === "Interface") {
if(ParaValue.indexOf("eth")>-1){
var lanNum = parseInt(ParaValue[ParaValue.length-1])+1;
ParaValue = "lan" + lanNum.toString();
}
oP.textContent = ParaValue;
wifi_info[1] = oP;
}
if (ParaName === "UpRate") {
oSpan.textContent = ParaValue;
oSpan.className = 'up-span';
wifi_info[2] = oSpan;
}
if (ParaName === "DownRate") {
oSpan.textContent = ParaValue;
oSpan.className = 'down-span';
wifi_info[3] = oSpan;
}
if (ParaName === "LinkSpeed") {
oP.textContent = ParaValue;
wifi_info[4] = oP;
}
if (ParaName === "IPAddress") {
oP.textContent = ParaValue;
wifi_info[5] = oP;
}
if (ParaName === "InterfaceType") {
if (ParaValue == "Ethernet") {
pictureImg.src = picture_ary[1];
accessType = 'eth';
} else if (ParaValue === "802.11") {
pictureImg.src = picture_ary[0];
accessType = 'wlan';
}
}
});
if (accessType == 'eth')
{
var SpeedOBJ = $(xml).find('OBJ_PON_PORT_BASIC_STATUS_ID');
var SpeedINSTs = $("Instance", SpeedOBJ);
for (var j = 0; j < SpeedINSTs.length; j++) {
var interfaceName;
var interfaceSpeed;
var INST = SpeedINSTs.eq(j);
INST.find("ParaName").each(function () {
var ParaName = $(this).text();
var ParaValue = $(this).next().text();
if ( ParaName == "IFName" )
{
interfaceName = ParaValue;
}
else if (ParaName == "Speed")
{
interfaceSpeed = ParaValue;
}
});
if(interfaceName == wifi_info[1].textContent)
{
var LanStatus;
switch(parseInt(interfaceSpeed))
{
case 0:
LanStatus = "AUTO";
break;
case 1:
LanStatus = "10Mbps";
break;
case 2:
LanStatus = "100Mbps";
break;
case 3:
LanStatus = "1000Mbps";
break;
case 4:
LanStatus = "2500Mbps";
break;
case 5:
LanStatus = "5000Mbps";
break;
case 6:
LanStatus = "10000Mbps";
break;
}
wifi_info[4].textContent = "Link Speed:" + LanStatus;
break;
}
}
}
if (accessType === 'wlan') {
if (wifi_info[2].textContent < 1000) {
wifi_info[2].textContent = Number(wifi_info[2].textContent).toFixed(0) + 'Kbps ';
} else if (wifi_info[2].textContent >= 1000 && wifi_info[2].textContent < 1000000) {
wifi_info[2].textContent = Number(wifi_info[2].textContent / 1000).toFixed(0) + 'Mbps ';
} else if (wifi_info[2].textContent >= 1000000) {
wifi_info[2].textContent = Number(wifi_info[2].textContent / 1000 / 1000).toFixed(0) + 'Gbps ';
}
if (wifi_info[3].textContent < 1000) {
wifi_info[3].textContent = Number(wifi_info[3].textContent).toFixed(0) + 'Kbps ';
} else if (wifi_info[3].textContent >= 1000 && wifi_info[3].textContent < 1000000) {
wifi_info[3].textContent = Number(wifi_info[3].textContent / 1000).toFixed(0) + 'Mbps ';
} else if (wifi_info[3].textContent >= 1000000) {
wifi_info[3].textContent = Number(wifi_info[3].textContent / 1000 / 1000).toFixed(0) + 'Gbps ';
}
if (wifi_info[4].textContent < 1000) {
wifi_info[4].textContent = "Link Speed:" + Number(wifi_info[4].textContent).toFixed(0) + 'Kbps ';
} else if (wifi_info[4].textContent >= 1000 && wifi_info[4].textContent < 1000000) {
wifi_info[4].textContent = "Link Speed:" + Number(wifi_info[4].textContent / 1000).toFixed(0) +
'Mbps ';
} else if (wifi_info[4].textContent >= 1000000) {
wifi_info[4].textContent = "Link Speed:" + Number(wifi_info[4].textContent / 1000 / 1000).toFixed(0) +
'Gbps ';
}
} else if (accessType === 'eth') {
if (wifi_info[2].textContent < 1000) {
wifi_info[2].textContent = wifi_info[2].textContent + 'bps ';
} else if (wifi_info[2].textContent >= 1000 && wifi_info[2].textContent < 1000000) {
wifi_info[2].textContent = Number(wifi_info[2].textContent / 1000).toFixed(0) + 'Kbps ';
} else if (wifi_info[2].textContent >= 1000000) {
wifi_info[2].textContent = Number(wifi_info[2].textContent / 1000 / 1000).toFixed(0) + 'Mbps ';
}
if (wifi_info[3].textContent < 1000) {
wifi_info[3].textContent = wifi_info[3].textContent + 'bps ';
} else if (wifi_info[3].textContent >= 1000 && wifi_info[3].textContent < 1000000) {
wifi_info[3].textContent = Number(wifi_info[3].textContent / 1000).toFixed(0) + 'Kbps ';
} else if (wifi_info[3].textContent >= 1000000) {
wifi_info[3].textContent = Number(wifi_info[3].textContent / 1000 / 1000).toFixed(0) + 'Mbps ';
}
}
devicePicture.appendChild(pictureImg);
var tempP = document.createElement("p");
tempP.className = "wifi-info";
if (wifi_info[2] && wifi_info[2] != "UpRate") {
var oI1 = document.createElement("i");
oI1.className = "arrow-icon up-icon";
tempP.appendChild(oI1);
tempP.appendChild(wifi_info[2]);
}
if (wifi_info[3] && wifi_info[3] != "DownRate") {
var oI2 = document.createElement("i");
oI2.className = "arrow-icon down-icon";
tempP.appendChild(oI2);
tempP.appendChild(wifi_info[3]);
}
wifi_info.splice(2, 2, tempP);
$(wifi_info).each(function (index, p) {
p.nodeName === "P" ? deviceInfo.appendChild(p) : null
})
oLi.appendChild(devicePicture);
oLi.appendChild(deviceInfo);
frg.appendChild(oLi);
}
$deviceUl.children("li").remove();
$deviceUl.append(frg);
frg = null;
}
function UpdateHomeStatus() {
var AISHomeHeadID = "homeWrapper";
var AISHomeHead = $("#" + AISHomeHeadID);
showAttachedDevs();
initial_Click();
ReconnectClick();
AISHomeHead.succfunction = function (xml) {
UpdateEasyDiagHandle();
var cmapiErrorContainer = $(".errorHint", AISHomeHead);
if (cmapiErrorContainer.hasError(xml) == 0) {
var OBJID = ["OBJ_DEVINFO_ID", "OBJ_ACCESSDEV_NUM_ID", "OBJ_INTERNET_STATUS_ID", "OBJ_TAGPARAM_ID",
"OBJ_EASY_DIAG_ID"
];
AISHomeHead.fillDataByOBJID(xml, OBJID, $("#homeWrapper"), 0);
var PONSN = getParaValueInXML(xml, "OBJ_SN_INFO_ID", 0, "Sn");
$("#Sn").text(PONSN.toUpperCase());
}
ReGetDevInfo(xml);
var wlanObj = $(xml).find("OBJ_WLANSETTING_ID");
INSTs = $("Instance", wlanObj);
for (var i = 0; i <= INSTs.length; i++) {
var INST = INSTs.eq(i - 1);
INST.find("ParaName").each(function () {
ParaName = $(this).text();
ParaValue = $(this).next().text();
BaseEnable = $(this).next().next().next().text();
if (ParaValue == "DEV.WIFI.RD1") {
if (BaseEnable == "1") {
$("[id='cmn-toggle-1']", AISHomeHead).prop("checked", true);
}
}
if (ParaValue == "DEV.WIFI.RD2") {
if (BaseEnable == "1") {
$("[id='cmn-toggle-2']", AISHomeHead).prop("checked", true);
}
}
});
}
SSIDOBJ = $(xml).find("OBJ_WLANAP_ID");
INSTs = $("Instance", SSIDOBJ);
for (var i = 0; i <= INSTs.length; i++) {
var INST = INSTs.eq(i - 1);
INST.find("ParaName").each(function () {
ParaName = $(this).text();
ParaValue = $(this).next().text();
SSIDName = $(this).next().next().next().next().next().text();
if (ParaValue == "DEV.WIFI.AP1") {
$("[id='ESSID24G']", AISHomeHead).text(SSIDName);
}
if (ParaValue == "DEV.WIFI.AP5") {
$("[id='ESSID5G']", AISHomeHead).text(SSIDName);
}
});
}
$("#WLAN24GUrl, #WLAN5GUrl").each(function () {
var linkOBJ = $(this);
var linkId = linkOBJ.attr("id");
var linkUrl = "wlanBasic";
if (linkUrl != "" && menuTreeObj.findMenu(linkUrl)) {
linkOBJ.addClass("link2More");
linkOBJ.unbind("click");
linkOBJ.bind("click", function (event) {
openLink(linkUrl);
});
} else {
linkOBJ.removeClass("emColor");
}
});
$("#RouterUrl").each(function () {
var linkOBJ = $(this);
var linkId = linkOBJ.attr("id");
var linkUrl = "mmTopology";
if (linkUrl != "" && menuTreeObj.findMenu(linkUrl)) {
linkOBJ.addClass("link2More");
linkOBJ.unbind("click");
linkOBJ.bind("click", function (event) {
$("#AttachedDevsDiv_copy").remove();
$(document.body).css("overflow-y", "auto");
openLink(linkUrl);
});
} else {
linkOBJ.removeClass("emColor");
}
});
ReGetInterStatus(xml)
ReGetAttaDev(xml);
ReGetDevInfo(xml);
$(".InstSwitch input", AISHomeHead).each(function () {
var InputOBJ = $(this);
if (InputOBJ.attr("type") == "checkbox") {
InputOBJ.unbind("change");
InputOBJ.change(function (event) {
var _InstIDName = "_InstID";
var temp_switch = $(this).parent().parent("[id^='Switch_']");
var _InstIDValue = temp_switch.find("[id^='InstID_']").val();
if (_InstIDValue == "DEV.WIFI.RD1") {
var checkvalue = $("[id='cmn-toggle-1']", AISHomeHead).is(":checked");
} else {
var checkvalue = $("[id='cmn-toggle-2']", AISHomeHead).is(":checked");
}
if (checkvalue == true) {
checkswitchvalue = "1";
} else {
checkswitchvalue = "0";
}
var instSwitchName = "RadioStatus";
var instSwitchValue = checkswitchvalue;
var PostData = "IF_ACTION=Apply" + "&" +
instSwitchName + "=" + instSwitchValue + "&" +
_InstIDName + "=" + _InstIDValue;
var actionType = "InstSwitch";
var PostSuccHandler = "fillDataByInstSwitchResult";
dataPost(actionType, PostSuccHandler, ServerAddr, AISHomeHead, PostData);
});
}
});
renderSubrouterLists(xml);
renderDeviceLists(xml);
AISHomeHead.unbind("fillDataByRestartResult");
AISHomeHead.bind("fillDataByRestartResult", function (event, xml, AISHomeHead) {
if (AISHomeHead.hasError(xml) == 0) {
setTimeout("IfServerLive()", 30000);
} else {
showWaitTip(false);
}
});
$("#Btn_restart").unbind("click");
$("#Btn_restart").bind("click", {
templateOBJ: AISHomeHead
}, function (event) {
var template = event.data.templateOBJ;
var msg = "&?DeviceManag_010;";
var confirmLayerOBJ = IniConfirm(msg);
$("#confirmOK", confirmLayerOBJ).unbind("click");
$("#confirmOK", confirmLayerOBJ).bind("click", {
FuncOBJ: template
}, function (event) {
showWaitTip(false);
showWaitTip(true, "&?DeviceManag_011;");
dataPost("Restart", "fillDataByRestartResult", ServerAddr, template, undefined,
false);
});
});
};
if ($(".collapBarWithDataTrans", AISHomeHead).length <= 0) {
var makeVisibility = $("#blackMask").css("display");
var IfShowWaitTip = (makeVisibility === "block" ? false : true);
AISHomeHead.dataTransfer(ServerAddr,
"GET",
AISHomeHead.succfunction, undefined, IfShowWaitTip);
} else {
initial_collapBarWithDataTrans(AISHomeHead);
}
}
function SpeedTestInits() {
$("#speedTestStatus").unbind("click");
$("#speedTestStatus").bind("click", function (event) {
$("#UpRate").prop("textContent", "0.00")
$("#DownRate").prop("textContent", "0.00")
$("#myProgressBar").css("width", "0")
$("#myProgressLabel").text("0% Complete");
$("#speedTestStatus").hide();
$("#SpeedtestUrl").hide();
$("#myProgress").show();
$("#SpeedtestBar").show();
var addr = ServerAddr + "&IF_ACTION=SpeedtestDIAG" + "&Url=" + $("#Url option:selected").attr(
"data-url");
SpeedTestHead.unbind("PostTestSuccHandler")
SpeedTestHead.bind("PostTestSuccHandler", function (event, xml, SpeedTestHead) {
var OBJ = $(xml).find("SESSION_IDKEY");
var sessionId = OBJ.next().text();
var count = 0;
SpeedTestDiagHandle = function () {
count++;
var testaddr = ServerAddr + "&IF_ACTION=SpeedtestGetDIAG" + "&sessionId=" +
sessionId;
SpeedTestHead.getsucc = function (xml) {
var OBJID = "OBJ_SPEEDTEST_DIAGNOSE_ID"
OBJ_Temp = $(xml).find(OBJID);
INSTs = $("Instance", OBJ_Temp);
for (var i = 1; i <= INSTs.length; i++) {
var INST = INSTs.eq(i - 1);
INST.find("ParaName").each(function () {
ParaName = $(this).text();
ParaValue = $(this).next().text();
if (ParaName == "UpRate") {
$("#UpRate").prop("textContent", ParaValue);
}
if (ParaName == "DownRate") {
$("#DownRate").prop("textContent",
ParaValue);
}
if (ParaName == "Percntage") {
var wid = ParaValue
$("#myProgressBar").css("width", wid + "%")
$("#myProgressLabel").text(wid + "% Complete");
}
if (ParaName == "State") {
if (ParaValue != 0 || count == SpeedTestDiagMaxTime) {
count = 0
$("#myProgress").hide()
$("#SpeedtestBar").hide()
$("#SpeedtestUrl").show()
$("#speedTestStatus").show()
clearInterval(SpeedTestDiagId)
SpeedTestDiagId = "";
}
}
})
}
}
SpeedTestHead.dataTransfer(testaddr, "GET", SpeedTestHead.getsucc, null, false);
}
SpeedTestDiag.start();
SpeedTestDiagId = SpeedTestDiag.getTimerID();
console.log("start " + SpeedTestDiagId);
})
var PostData = "IF_ACTION=SpeedtestDIAG" + "&Url=" + $("#Url option:selected").attr("data-url");
dataPost("SpeedtestDIAG", "PostTestSuccHandler", addr, SpeedTestHead, PostData, false);
});
}
function SetSpeedTestServer() {
$("#speedTestStatus").prop("disabled", "disabled");
$("#speedTestStatus").prop("textContent", "connecting... ...");
$("#speedTestStatus").removeClass("green");
$("#speedTestStatus").addClass("black");
var count = 0;
var state = "";
var SpeedTestHead = $("#speedTest");
var addr = ServerAddr + "&IF_ACTION=SetSpeedtestServer";
SpeedTestHead.PostSuccHandler = function (xml) {
SpeedTestServer.start();
SpeedTestServerid = SpeedTestServer.getTimerID();
var OBJ = $(xml).find("SESSION_IDKEY");
var sessioniden = OBJ.next().text();
if (SpeedTestHead.hasError(xml) == 0) {
SpeedTestServerHandle = function () {
count++;
var testaddr = ServerAddr + "&IF_ACTION=GetSpeedtestServer" + "&sessionId=" + sessioniden;
SpeedTestHead.Succ = function (xml) {
if (state == "1") {
$("#speedTestStatus").removeClass("black");
$("#speedTestStatus").addClass("gray");
$("#speedTestStatus").prop("textContent", "connected failed");
clearInterval(SpeedTestServerid);
SpeedTestServerid = "";
return;
}
if (state == "3") {
$("#speedTestStatus").removeClass("black");
$("#speedTestStatus").addClass("gray");
$("#speedTestStatus").prop("textContent", "No Route");
clearInterval(SpeedTestServerid);
SpeedTestServerid = "";
return;
}
if (state == "2") {
clearInterval(SpeedTestServerid);
SpeedTestServerid = "";
}
var urls = [];
var OBJID = "OBJ_SPEEDTEST_SERVERS_ID";
OBJ_Temp = $(xml).find(OBJID);
INSTs = $("Instance", OBJ_Temp);
for (var i = 1; i <= INSTs.length; i++) {
var INST = INSTs.eq(i - 1);
INST.find("ParaName").each(function () {
ParaName = $(this).text();
ParaValue = $(this).next().text();
if (ParaName == "State") {
state = ParaValue;
}
if (state == "2") {
url = [];
var reg = /^URL\d+$/;
if (reg.test(ParaName)) {
urls.push(ParaValue);
}
if (urls.length == 15) {
$("#speedTestStatus").addClass("green");
$("#speedTestStatus").removeAttr("disabled");
$("#speedTestStatus").prop("textContent", "speedTest");
$("#Url").empty();
for (var j = 0; j < 15; j++) {
if(urls[j] != "")
$("#Url").append("<option data-url='" + SelectUrl(urls[j], "url") + "'>" + SelectUrl(urls[j],"name") + "</option>");
}
SpeedTestInits();
}
}
})
}
}
SpeedTestHead.dataTransfer(testaddr, "GET", SpeedTestHead.Succ, null, false);
}
}
}
SpeedTestHead.dataTransfer(addr, "GET", SpeedTestHead.PostSuccHandler, null, false);
}
function SelectUrl(url, type) {
if (type == "name") {
return url.split("@")[0];
} else {
return url.split("@")[1];
}
}
function UpdateAttaDevHandle() {
var addr = ServerAddr + "&IF_ACTION=DevRefresh";
homeWrapperHead.RefershSuccHandler = function (xml) {
if (homeWrapperHead.hasError(xml) == 0) {
$("#Btn_Refresh>button").css("background", "#E8E8E8");
ReGetAttaDev(xml);
}
}
homeWrapperHead.dataTransfer(addr, "GET", homeWrapperHead.RefershSuccHandler, null, false);
}
UpdateInterStatusHandle = function () {
var addr = ServerAddr + "&IF_ACTION=InterReconnect";
homeWrapperHead.InterReconnectSuccHandler = function (xml) {
if (homeWrapperHead.hasError(xml) == 0) {
$("#Btn_InterReconnect>button").css("background", "#E8E8E8");
if(IsInterReConnect == 1)
{
$("#Btn_InterReconnect>button").text("Re-Connect");
$("#Btn_InterReconnect>button").removeAttr("disabled");
IsInterReConnect = 0;
}
ReGetInterStatus(xml);
}
}
homeWrapperHead.dataTransfer(addr, "GET", homeWrapperHead.InterReconnectSuccHandler, null, false);
}
UpdateDevInfoHandle = function () {
var addr = ServerAddr + "&IF_ACTION=DevInfoRefresh";
homeWrapperHead.DevInfoRefershSuccHandler = function (xml) {
if (homeWrapperHead.hasError(xml) == 0) {
ReGetDevInfo(xml);
}
}
homeWrapperHead.dataTransfer(addr, "GET", homeWrapperHead.DevInfoRefershSuccHandler, null, false);
}
UpdateEasyDiagHandle = function () {
var addr = ServerAddr + "&IF_ACTION=PingReconnect&DiagFinish="+DiagFinish;
var PostData = "&IF_ACTION=PingReconnect&DiagFinish="+DiagFinish;
homeWrapperHead.unbind("PingReconnectSuccHandler")
homeWrapperHead.bind("PingReconnectSuccHandler", function (event, xml, homeWrapperHead) {
if (homeWrapperHead.hasError(xml) == 0) {
$("#Btn_PingReconnect>button").css("background", "#E8E8E8");
ReGetPingDiagnosis(xml);
}
})
dataPost("PingReconnect","PingReconnectSuccHandler",addr,homeWrapperHead,PostData,false)
}
ReConnectInternetHandle = function () {
var addr = ServerAddr + "&IF_ACTION=InterReconnect";
var PostData = "&IF_ACTION=InterReconnect&InterReFlag=1";
homeWrapperHead.unbind("InterReconnSetSuccHandler");
homeWrapperHead.bind("InterReconnSetSuccHandler", function (event, xml, homeWrapperHead) {
if (homeWrapperHead.hasError(xml) == 0) {
setTimeout("UpdateInterStatusHandle()", 2000);
}
});
dataPost("InterReconnect","InterReconnSetSuccHandler",addr,homeWrapperHead,PostData,false);
}
function inittimer() {
var UpdateAttaDevTimeInterval = 60;
UpdateAttaDev = new ContextBindingTimer(function () {
"";
UpdateAttaDevHandle();
}, {
interval: UpdateAttaDevTimeInterval * 1000,
contextDom: homeWrapperHead.get(0)
})
var UpdateInterStatusTimeInterval = 120;
UpdateInterStatus = new ContextBindingTimer(function () {
"";
UpdateInterStatusHandle();
}, {
interval: UpdateInterStatusTimeInterval * 1000,
contextDom: homeWrapperHead.get(0)
})
var UpdateDevInfoTimeInterval = 30;
UpdateDevInfo = new ContextBindingTimer(function () {
"";
UpdateDevInfoHandle();
}, {
interval: UpdateDevInfoTimeInterval * 1000,
contextDom: homeWrapperHead.get(0)
})
var UpdateEasyDiagIDTimeInterval = 2;
UpdateEasyDiagID = new ContextBindingTimer(function () {
"";
UpdateEasyDiagHandle();
}, {
interval: UpdateEasyDiagIDTimeInterval * 1000,
contextDom: homeWrapperHead.get(0)
})
var UpdateReEasyDiagTimeInterval = 90;
UpdateReEasyDiag = new ContextBindingTimer(function () {
"";
UpdateReEasyDiagHandle();
}, {
interval: UpdateReEasyDiagTimeInterval * 1000,
contextDom: homeWrapperHead.get(0)
})
UpdateReEasyDiagHandle = function () {
UpdateEasyDiagHandle();
}
var SpeedTestServerTimeInterval = 5;
SpeedTestServer = new ContextBindingTimer(function () {
"";
SpeedTestServerHandle();
}, {
interval: SpeedTestServerTimeInterval * 1000,
contextDom: SpeedTestHead.get(0)
})
var SpeedTestDiagTimeInterval = 1;
SpeedTestDiag = new ContextBindingTimer(function () {
"";
SpeedTestDiagHandle();
}, {
interval: SpeedTestDiagTimeInterval * 1000,
contextDom: SpeedTestHead.get(0)
})
}
function startalltimer() {
UpdateAttaDev.start();
UpdateAttaDevId = UpdateAttaDev.getTimerID();
UpdateInterStatus.start();
UpdateInterStatusId = UpdateInterStatus.getTimerID();
UpdateDevInfo.start();
UpdateDevInfoId = UpdateDevInfo.getTimerID();
UpdateEasyDiagHandle();
}
$(document).ready(function () {
showWaitTip(false);
UpdateHomeStatus();
SetSpeedTestServer();
SpeedTestHead = $("#speedTest");
homeWrapperHead = $("#homeWrapper");
inittimer();
startalltimer();
});
</script>
