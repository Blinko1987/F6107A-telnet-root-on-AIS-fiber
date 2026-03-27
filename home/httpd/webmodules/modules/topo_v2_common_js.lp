<script type="text/javascript">
var g_UpdateTopoTimer = null;
var g_topoServerAddr = "/?_type=menuData&_tag=topo_lua.lua";
if (!g_isThinklua)
{
g_topoServerAddr = "getpage.lua?pid=1005&nextpage=topo_lua.lua";
}
var CONTROLLER_CONTAINER_WIDTH = 180;
var CONTROLLER_CONTAINER_HEIGHT = 170;
var AGENT_CONTAINER_WIDTH = 118;
var AGENT_CONTAINER_HEIGHT = 150;
var LAYER1_AGENT_AXIS_Y = 240;
var LAYER2_AGENT_AXIS_Y = 450;
var MAX_AGENT_NUM = 8;
function initial_template_svg(template, TOPO_CONTAINER_WIDTH, CONTROLLER_CONTAINER_WIDTH,
CONTROLLER_CONTAINER_HEIGHT, AGENT_CONTAINER_WIDTH, AGENT_CONTAINER_HEIGHT,
LAYER1_AGENT_AXIS_Y, LAYER2_AGENT_AXIS_Y, layer, svgHeight, draw, topodata) {
function setJsonDataToPop(jqSelector, jsonData) {
for (var item in jsonData) {
var jsonvalue = "";
if (item != "" && $("[id^='" + item + "']", jqSelector).length > 0) {
jsonvalue = jsonData[item];
var linktype = {
"Connecting" : "/",
"2.4G" : "2.4GHz",
"5G" : "5GHz",
"ETH" : "ETH"
}
if (item == "AccessType") {
if (linktype[jsonvalue] != undefined
&& linktype[jsonvalue] != null) {
jsonvalue = linktype[jsonvalue];
}
}
if (item == "LinkSpeed") {
if (jsonvalue == "0") {
jsonvalue = "/";
} else {
jsonvalue = jsonvalue + "Mbps";
}
}
$("#" + item, jqSelector).text(jsonvalue).attr("title", jsonvalue);
}
}
}
function multiInstfillData(Head, data, datatype) {
var HeadID = Head.attr("id");
var ruleTemplate = $("#data_" + HeadID, Head);
var TemplateOBJ = $("#template_"+HeadID,Head);
$("[id^='data_" + HeadID + "_']", TemplateOBJ).remove();
$(".notopoDataHint", TemplateOBJ).css("display", "none");
if (data == null)
{
return;
}
var RuleNum = data["MGET_INST_NUM"];
$("#_InstNum", Head).val(RuleNum);
if (RuleNum == 0)
{
$(".notopoDataHint", TemplateOBJ).css("display", "");
return;
}
for (var i=0; i<RuleNum; i++)
{
var j = i+1;
var hostname = data[j].HostName;
var mac = data[j].MacAddr;
var ip = data[j].IpAddr;
var onlineduration = sec2HrMinSec(data[j].AssocTime);
var realtimeupstream = bps_speed_change_auto(data[j].TxRateBps);
var realtimedownstream = bps_speed_change_auto(data[j].RxRateBps);
var rssi = data[j].Rssi + "&?public_110;";
var btm = data[j].Btm;
var rrm = data[j].Rrm;
var wlm = data[j].WirelessMode;
var clone = ruleTemplate.cloneWithSuffix(i, "_");
ruleTemplate.before(clone);
$("[id^='HostName_"+i+"']", clone).text(hostname).attr("title", hostname);
$("[id^='MacAddr_"+i+"']", clone).text(mac).attr("title", mac);
$("[id^='IpAddr_"+i+"']", clone).text(ip).attr("title", ip);
$("[id^='AssocTime_"+i+"']", clone).text(onlineduration).attr("title", onlineduration);
$("[id^='RxRateMbps_"+i+"']", clone).text(realtimeupstream).attr("title", realtimeupstream);
$("[id^='TxRateMbps_"+i+"']", clone).text(realtimedownstream).attr("title", realtimedownstream);
$("[id^='Rssi_"+i+"']", clone).text(rssi).attr("title", rssi);
$("[id^='Btm_"+i+"']", clone).text(btm).attr("title", btm);
$("[id^='Rrm_"+i+"']", clone).text(rrm).attr("title", rrm);
$("[id^='WirelessMode_"+i+"']", clone).text(wlm).attr("title", wlm);
clone.showIt(true);
}
}
function dealdetaildata(Head, data) {
var master_div = $("#routeinfo", Head);
var master_info = data.master;
setJsonDataToPop(master_div, master_info);
var laninfo_div = $("#laninfo", Head);
multiInstfillData(laninfo_div, data.lan, "eth");
var wlan2Ginfo_div = $("#wlan2Ginfo", Head);
multiInstfillData(wlan2Ginfo_div, data.wlan2G, "wlan");
var wlan5Ginfo_div = $("#wlan5Ginfo", Head);
multiInstfillData(wlan5Ginfo_div, data.wlan5G, "wlan");
}
function getPopData(parentID, Head) {
var serverAddr = g_topoServerAddr + "&ParentID=" + parentID + "&Action=GetPopData";
$.ajax({
url:serverAddr,
type: "GET",
dataType: "json",
timeout: 30000,
async: true,
cache:false,
error: function(){
},
success: function(data){
dealdetaildata(Head, data);
}
});
}
function TopoShowPopData(macvalue, devinfotop) {
var source = $("#PopDevDataDiv");
var clone = source.clone(true);
clone.attr("id", clone.attr("id")+"_copy");
clone.showIt(true);
clone.appendTo('#svg-area');
var PopDataHead = $("#PopDevDataDisplay", clone);
getPopData(macvalue, PopDataHead);
$("#PopDevDataDiv_copy").css("width", $("#svg-area").width())
.css("top", devinfotop);
$("#PopDevDataDiv_copy").css("display", "block");
$("#"+"instDelete_PopDevData", PopDataHead).bind("click", function(event){
showWaitTip(false);
$("#PopDevDataDiv_copy").remove();
RestoreCircleColor();
if (document.getElementById("polygon") != null) {
document.getElementById("polygon").remove();
}
g_UpdateTopoTimer.start();
});
}
function RestoreCircleColor() {
var circleobj = document.getElementsByTagName("circle");
var routernum = circleobj.length;
for (var i=0; i<routernum; i++) {
var singleroute = circleobj[i];
if (singleroute.getAttribute("name") == "selectedroute") {
singleroute.setAttribute("stroke","#e2e2e8");
singleroute.setAttribute("stroke-width","1");
singleroute.removeAttribute("name");
}
}
}
function drawDevice(x, y, w, h, devHeight, data, type) {
var backgdimg = "url(#backgroundimg)";
if(type == "agent") {
backgdimg = "url(#agentbackgroundimg)";
}
var container = draw.rect(w, h).attr({
fill: '#fff'
, 'fill-opacity': 0.5
, stroke: '#000'
, 'stroke-width': 0.0
}).move(x, y);
var devX = x + (w - devHeight) / 2;
var devCircle = draw.circle(devHeight).attr({id: data.MACAddr, InstID_Dev: data.instID, "stroke":"#e2e2e8", "stroke-width":"1"}).move(devX, y).addClass('router');
devCircle.fill(backgdimg);
devCircle.on("click", function (e) {
g_UpdateTopoTimer.stop();
var circleobj = document.getElementById(this);
var nameattr = circleobj.getAttribute("name");
if (nameattr == "selectedroute") {
$("#instDelete_PopDevData", $("#PopDevDataDiv_copy")).click();
return;
}
RestoreCircleColor();
circleobj.setAttribute("name", "selectedroute");
$("#PopDevDataDiv_copy").remove();
var devinfotop = devHeight + y + 3;
if (document.getElementById("polygon") != null) {
document.getElementById("polygon").remove();
}
var circleX = circleobj.cx.baseVal.value;
var circleY = circleobj.cy.baseVal.value;
var circleR = circleobj.r.baseVal.value;
var pXTop = circleX;
var pYTop = circleY + circleR - 20;
var pXLeft = circleX - 12;
var pXRight = circleX + 12;
var pYBottom = pYTop + 20;
var polygonPoint = [[pXTop, pYTop],[pXRight, pYBottom],[pXLeft, pYBottom]];
var devPolygon = draw.polygon(polygonPoint).attr({fill:'#fff',stroke:'#fff','stroke-width':1, id:"polygon"});
TopoShowPopData(this, devinfotop);
});
if (data.accdevCount > 0) {
var accdevCircle = draw.circle(20).attr({ fill: '#00b7ef' }).move(devX + devHeight * 3 / 4, y + devHeight * 3 / 4);
var accdevCountText = draw.text(data.accdevCount.toString()).fill('#fff').move(devX + devHeight * 3 / 4 + 10, y + devHeight * 3 / 4 + 12);
accdevCountText.font({
family: 'Helvetica'
, size: 11
, anchor: 'middle'
, leading: '1em'
});
if (data.accdevCount > 9) {
accdevCountText.dx(-1);
}
}
var hostNameText = draw.text(data.HostName).fill('#262727').move(x + w / 2, y + devHeight + 5).addClass("hostText");
hostNameText.font({
family: 'Helvetica'
, size: 14
, anchor: 'middle'
, weight: 'bold'
});
hostNameText.on("click", function (e) {
var ipaddr = data.IPAddr;
var abs = window.top.location.href;
var patt2 = /\w+:/;
var protocolStr = abs.match(patt2);
var urlStr = protocolStr + "//" + ipaddr;
window.open(urlStr);
});
var macText = draw.text("MAC:" + data.MACAddr).fill('#a4a6a6').move(x + w / 2, y + devHeight + 25);
macText.font({
family: 'Helvetica'
, size: 11
, anchor: 'middle'
});
var ipText = draw.text("IP: " + data.IPAddr).fill('#a4a6a6').move(x + w / 2, y + devHeight + 40);
ipText.font({
family: 'Helvetica'
, size: 11
, anchor: 'middle'
});
}
function drawController(x, y, data) {
drawDevice(x, y, CONTROLLER_CONTAINER_WIDTH, CONTROLLER_CONTAINER_HEIGHT, 110, data, "control");
}
function drawAgent(x, y, data) {
drawDevice(x, y, AGENT_CONTAINER_WIDTH, AGENT_CONTAINER_HEIGHT, 90, data, "agent");
}
var patterncontrol = draw.pattern().attr({"id":"backgroundimg","patternUnits":"objectBoundingBox","width":"1","height":"1"});
patterncontrol.image('img/topov2_router.svg').attr({"preserveAspectRatio":"none meet", "x":"0", "y":"0", "width":"115", "height":"115"});
var patternagent = draw.pattern().attr({"id":"agentbackgroundimg","patternUnits":"objectBoundingBox","width":"1","height":"1"});
patternagent.image('img/topov2_router.svg').attr({"preserveAspectRatio":"none meet", "x":"0", "y":"0", "width":"90", "height":"90"});
var patterneth = draw.pattern().attr({"id":"ethimg","patternUnits":"objectBoundingBox","width":"1","height":"1"});
patterneth.image('img/topov2_ethconn.png').attr({"preserveAspectRatio":"none meet", "x":"0", "y":"0", "width":"20", "height":"20"});
var patternwlan = draw.pattern().attr({"id":"wlanimg","patternUnits":"objectBoundingBox","width":"1","height":"1"});
patternwlan.image('img/topov2_wlanconn.png').attr({"preserveAspectRatio":"none meet", "x":"0", "y":"0", "width":"20", "height":"20"});
var controllerData = {
"accdevCount": topodata.controllerData.accdevCount,
"MACAddr": topodata.controllerData.MacAddr,
"HostName": topodata.controllerData.DeviceName,
"IPAddr": topodata.controllerData.IpAddr,
"instID": topodata.controllerData.instID
}
drawController((TOPO_CONTAINER_WIDTH / 2 - CONTROLLER_CONTAINER_WIDTH / 2), 0, controllerData);
function calcLayer1AgentsAxis_X(agentCount, start, end) {
var output = [];
var iterator = function (agentCount, start, end) {
var width = end - start;
if (agentCount == 1) {
output.push(start + width / 2)
return;
}
if (agentCount % 2 == 1) {
output.push(start + width / 2)
agentCount--;
} else {
}
iterator(agentCount / 2, start, start + width / 2);
iterator(agentCount / 2, end - width / 2, end);
return;
};
iterator(agentCount, start, end);
return output;
}
function getLayer1AgentsAxis_X(agentCount, width, startX) {
var output = [];
var oneAgentWidth = width / agentCount;
for (var i = 0; i < agentCount; i++) {
output.push(startX + oneAgentWidth / 2);
startX = startX + oneAgentWidth;
}
return output;
}
function getConnBackgroundImg(accessType) {
var img = "#ccc";
if (accessType == "ETH") {
img = "url(#ethimg)";
} else if(accessType == "2.4G" || accessType == "5G") {
img = "url(#wlanimg)";
}
return img;
}
function drawConnectedLine(pointArray,accessType) {
var connimg = getConnBackgroundImg(accessType);
draw.polyline(pointArray).fill('none').stroke({ width: 0.5, color: '#999' });
var d = pointArray.pop();
var devCircle = draw.circle(20).move(d[0] - 10, d[1]).attr({ fill: connimg });
}
function drawLayer1Agents(topoData) {
var startX = 0;
var L1Agents = topoData.agentlay1.MGET_INST_NUM;
if (L1Agents == 2)
{
var agent10_id = topoData.agentlay1[0].instID;
var agent10_slavenum = 0;
var agent11_slavenum = 0;
for(var i=0; i<topoData.agentlay2.MGET_INST_NUM; i++) {
if (agent10_id == topoData.agentlay2[i].instID_Parent) {
agent10_slavenum = agent10_slavenum + 1;
}
else {
agent11_slavenum = agent11_slavenum + 1;
}
}
if (agent10_slavenum == 6 || agent10_slavenum == 5) {
startX = TOPO_CONTAINER_WIDTH/6;
}
}
var agentsAxis_x_array = getLayer1AgentsAxis_X(L1Agents, TOPO_CONTAINER_WIDTH, startX);
var agentLay1TotalNum = 0;
agentsAxis_x_array.forEach(function (x, i) {
var perlay1data = topoData.agentlay1[i];
drawAgent((x - AGENT_CONTAINER_WIDTH / 2), LAYER1_AGENT_AXIS_Y, { accdevCount: perlay1data.accdevCount, HostName: perlay1data.DeviceName, "MACAddr": perlay1data.MacAddr, "IPAddr": perlay1data.IpAddr, "instID": perlay1data.instID});
drawConnectedLine([[TOPO_CONTAINER_WIDTH / 2, CONTROLLER_CONTAINER_HEIGHT],
[TOPO_CONTAINER_WIDTH / 2, CONTROLLER_CONTAINER_HEIGHT + 25],
[x, CONTROLLER_CONTAINER_HEIGHT + 25],
[x, CONTROLLER_CONTAINER_HEIGHT + 45]],
perlay1data.AccessType);
agentLay1TotalNum = agentLay1TotalNum + 1;
if (agentLay1TotalNum == MAX_AGENT_NUM) {
return false;
}
});
}
if (topodata.agentlay1.MGET_INST_NUM > 0){
drawLayer1Agents(topodata);
}
if (topodata.agentlay2.MGET_INST_NUM > 0 ) {
var leftnum = MAX_AGENT_NUM - topodata.agentlay1.MGET_INST_NUM;
var lay2allowNum = leftnum;
if (topodata.agentlay2.MGET_INST_NUM < leftnum) {
lay2allowNum = topodata.agentlay2.MGET_INST_NUM;
}
var AgentLay1Obj = document.getElementsByTagName("circle");
for (var i=0; i< AgentLay1Obj.length; i++) {
if (AgentLay1Obj[i].getAttribute("InstID_Dev") == null
|| AgentLay1Obj[i].getAttribute("InstID_Dev") == "") {
continue;
}
if (lay2allowNum <= 0) {
break;
}
var lay2agentArray = [];
var lay2agentnum = 0;
var parentid = AgentLay1Obj[i].getAttribute("InstID_Dev");
for (var j=0; j< topodata.agentlay2.MGET_INST_NUM; j++) {
var perlay2data = topodata.agentlay2[j];
if (perlay2data.instID_Parent == parentid) {
var agentdata = {
"accdevCount": perlay2data.accdevCount,
"MACAddr": perlay2data.MacAddr,
"HostName": perlay2data.DeviceName,
"IPAddr": perlay2data.IpAddr,
"instID": perlay2data.instID,
"AccessType":perlay2data.AccessType,
}
lay2agentnum = lay2agentnum + 1;
lay2agentArray.push(agentdata);
if (lay2agentnum >= lay2allowNum) {
break;
}
}
}
lay2allowNum = lay2allowNum - lay2agentnum;
if (lay2agentArray.length > 0) {
var x = AgentLay1Obj[i].cx.baseVal.value;
lay2agentArray["children"] = lay2agentArray.length;
drawLayer2Agents(lay2agentArray, x);
}
}
}
function drawLayer2Agents(agentData, parentX) {
var childCount = 3;
childCount = agentData.children;
var agent2Axis_x_array = getLayer2AgentsAxis_X(childCount, parentX);
agent2Axis_x_array.forEach(function (x, i) {
var perdata = agentData[i];
drawAgent(x - AGENT_CONTAINER_WIDTH / 2, LAYER2_AGENT_AXIS_Y, perdata);
drawConnectedLine([[parentX, 390],
[parentX, 390 + 20],
[x, 390 + 20],
[x, 390 + 30]],
perdata.AccessType);
});
}
function getLayer2AgentsAxis_X(agentCount, parentX) {
var output = [];
var oneAgentWidth = AGENT_CONTAINER_WIDTH + 2;
var startX = parentX - (AGENT_CONTAINER_WIDTH + 2) * agentCount / 2;
for (var i = 0; i < agentCount; i++) {
output.push(startX + oneAgentWidth / 2);
startX = startX + oneAgentWidth;
}
return output;
}
}
function modifyAccDev(btn, id) {
var template = $(btn).closest("div.formBorder");
$(btn).hide();
$("button.editing", template).show();
var hostNameObj = $("[id^=" + id + "]", template);
var oldName = hostNameObj.text();
hostNameObj.html("<input type='text' value='" + HTMLEnCode(oldName) + "' class='w80'>" +
"<input type='hidden' value='" + HTMLEnCode(oldName) + "'>");
}
function fillDataByApply(template, hostNameObj, inputVal) {
UpdateTopo();
hostNameObj.text(inputVal).attr("title", inputVal);
$("button.notEditing", template).show();
$("button.editing", template).hide();
}
function doModify(btn, id) {
var template = $(btn).closest("div.formBorder");
var hostNameObj = $("[id^=" + id + "]", template);
var inputVal = $("input[type=text]", hostNameObj).val();
var macaddr = $("[id^=MacAddr]", template).val();
var PostDataTmp = "InstIdentity=" + encodeURIComponent(macaddr)
+ "&Alias=" + encodeURIComponent(inputVal);
var selfHeader = {};
var procData = true;
if (PostDataTmp.indexOf("%20") >= 0)
{
procData = false;
}
if (commConf.IntegCheck)
{
var degistStr = sha256(PostDataTmp);
selfHeader["Check"] = asyEncode(degistStr);
}
$.ajax({
url:g_topoServerAddr+"&Action=SET_ALIAS",
type: 'POST',
data: PostDataTmp,
dataType: 'json',
timeout: 30000,
headers: selfHeader,
processData: procData,
async: false,
cache:false,
error: function(){
fillDataByApply(template, hostNameObj, inputVal);
},
success: function(xml){
fillDataByApply(template, hostNameObj, inputVal);
}
});
}
function cancelModify(btn, id) {
var template = $(btn).closest("div.formBorder");
$("button.notEditing", template).show();
$("button.editing", template).hide();
var hostNameObj = $("[id^=" + id + "]", template);
var inputVal = $("input[type=hidden]", hostNameObj).val();
hostNameObj.text(inputVal);
}
function cloneFormContent(formContent,i) {
var clone = formContent.clone(true);
clone.attr("id", clone.attr("id")+"_"+i);
var idElems = clone.find("*[id!='']");
idElems.each(function(){
var idElem = $(this);
var oldID = idElem.attr("id");
if (oldID != undefined) {
{
var newID = oldID + "_" + i;
idElem.attr("id", newID);
}
}
});
return clone;
}
function topoFormUpdate() {
var template_title = $("[id^='topoFormTitle']");
$("[id^='title_APIP']", template_title).removeClass("w150").addClass("w120");
$("[id^='title_returnHz']", template_title).removeClass("w150").addClass("w120");
$("[id^='title_role']", template_title).removeClass("w150").addClass("w120");
var template_content = $("[id^='topoFormContent']");
$("[id^='APIP']", template_content).removeClass("w150").addClass("w120");
$("[id^='returnHz']", template_content).removeClass("w150").addClass("w120");
$("[id^='role']", template_content).removeClass("w150").addClass("w120");
$("#topoFormBar").click(function(){
if($("#topoFormBar").hasClass("formH1Show")){
$("#topoFormBar").removeClass("formH1Show");
$("#topoFormContainer").hide();
}else {
$("#topoFormBar").addClass("formH1Show");
$.ajax({
url: g_topoServerAddr + "&Action=GetALLAP",
type: "GET",
dataType: "json",
timeout: 30000,
async: true,
cache:false,
error: function(){
showWaitTip(false);
},
success: function(data){
$("#_InstNum", $("#topoForm")).val(data.apData.MGET_INST_NUM);
var TemplateOBJ = $("#topoFormContainer");
$("[id^='topoFormContent_']", TemplateOBJ).remove();
$(".notopoDataHint", TemplateOBJ).css("display", "none");
var RuleNum = data.apData.MGET_INST_NUM;
if (RuleNum == 0)
{
$(".notopoDataHint", TemplateOBJ).css("display", "block");
return;
}
for (var i=1; i<=RuleNum; i++)
{
var j = i - 1;
var devideName = data.apData[i].DeviceName;
var APIP = data.apData[i].IpAddr;
var APMAC = data.apData[i].MacAddr;
var role = data.apData[i].role;
var returnHz = data.apData[i].AccessType + "/" +data.apData[i].BhStaRssi + "&?public_110;";
if (role == "controller") {
returnHz = "/";
}
else if (data.apData[i].AccessType == "ETH") {
returnHz = "ETH";
}
var topoTemplate = $("#topoFormContent");
var clone = cloneFormContent(topoTemplate,j);
topoTemplate.before(clone);
$("[id^='devideName_"+j+"']", clone).text(devideName).attr("title", devideName);
$("[id^='APIP_"+j+"']", clone).text(APIP).attr("title", APIP);
$("[id^='APMAC_"+j+"']", clone).text(APMAC).attr("title", APMAC);
$("[id^='role_"+j+"']", clone).text(role).attr("title", role);
$("[id^='returnHz_"+j+"']", clone).text(returnHz).attr("title", returnHz);
$("[id^='MacAddr_"+j+"']", clone).val(APMAC);
clone.showIt(true);
}
}
});
$("#topoFormContainer").show();
}
})
}
function clientFormUpdate() {
var template_title = $("[id^='clientFormTitle']");
$("[id^='title_relateRole']", template_title).removeClass("w165").addClass("w120");
$("[id^='title_relateHz']", template_title).removeClass("w165").addClass("w120");
$("[id^='title_RSSI']", template_title).removeClass("w165").addClass("w120");
var template_content = $("[id^='clientFormContent']");
$("[id^='relateRole']", template_content).removeClass("w165").addClass("w120");
$("[id^='relateHz']", template_content).removeClass("w165").addClass("w120");
$("[id^='RSSI']", template_content).removeClass("w165").addClass("w120");
$("#clientFormBar").click(function(){
if($("#clientFormBar").hasClass("formH1Show")){
$("#clientFormBar").removeClass("formH1Show");
$("#clientFormContainer").hide();
}else {
$("#clientFormBar").addClass("formH1Show");
$.ajax({
url: g_topoServerAddr + "&Action=GetALLClients",
type: "GET",
dataType: "json",
timeout: 30000,
async: true,
cache:false,
error: function(){
showWaitTip(false);
},
success: function(data){
$("#_InstNum", $("#clientForm")).val(data.clientsData.MGET_INST_NUM);
var TemplateOBJ = $("#clientFormContainer");
$("[id^='clientFormContent_']", TemplateOBJ).remove();
var RuleNum = data.clientsData.MGET_INST_NUM;
$(".notopoDataHint", TemplateOBJ).css("display", "none");
if (RuleNum == 0)
{
$(".notopoDataHint", TemplateOBJ).css("display", "block");
return;
}
var relateArray = {
"0": "ETH",
"1": "2.4GHz",
"2": "5GHz"
}
for (var i=1; i<=RuleNum; i++)
{
var j = i - 1;
var clientHostName = data.clientsData[i].HostName;
var relateRole = data.clientsData[i].parentType;
var relateHz = relateArray[data.clientsData[i].AccessType];
var RSSI = data.clientsData[i].Rssi + "&?public_110;";
if (relateHz == "ETH") {
RSSI = "/";
}
var clientTemplate = $("#clientFormContent");
var clone = cloneFormContent(clientTemplate,j);
clientTemplate.before(clone);
$("[id^='clientHostName_"+j+"']", clone).text(clientHostName).attr("title", clientHostName);
$("[id^='relateRole_"+j+"']", clone).text(relateRole).attr("title", relateRole);
$("[id^='relateHz_"+j+"']", clone).text(relateHz).attr("title", relateHz);
$("[id^='RSSI_"+j+"']", clone).text(RSSI).attr("title", RSSI);
$("[id^='MacAddr_"+j+"']", clone).val(data.clientsData[i].MacAddr);
clone.showIt(true);
}
}
});
$("#clientFormContainer").show();
}
})
}
function UpdateTopo()
{
$.ajax({
url: g_topoServerAddr,
type: "GET",
dataType: "json",
timeout: 30000,
async: true,
cache:false,
error: function(){
showWaitTip(false);
},
success: function(data){
if (!Array.from) {
Array.from = function(el) {
return Array.apply(this, el)
}
}
var svgobj = Array.from(document.getElementsByTagName("svg"));
if (svgobj.length > 0) {
svgobj.forEach(function (item) {
if (item != null) {
var userAgent = navigator.userAgent;
if ((userAgent.indexOf("compatible") > -1 && userAgent.indexOf("MSIE") > -1) || ((/Trident\/7./).test(navigator.userAgent))) {
item.parentNode.removeChild(item);
} else {
item.remove();
}
}
});
}
consoleLog(data);
var head = $("#svg-area");
var CONTAINER_ID = "svg-area";
var CONTAINER = $("#" + CONTAINER_ID);
var TOPO_CONTAINER_WIDTH = CONTAINER.width();
var layer = 1;
var svgHeight = 200;
if (data.agentlay1.MGET_INST_NUM > 0) {
if (data.agentlay1.MGET_INST_NUM >= MAX_AGENT_NUM
|| data.agentlay2.MGET_INST_NUM == 0) {
layer = 2;
svgHeight = 400;
if (data.agentlay1.MGET_INST_NUM >= MAX_AGENT_NUM) {
data.agentlay1.MGET_INST_NUM = MAX_AGENT_NUM;
}
} else {
layer = 3;
svgHeight = 600;
var leftagent = MAX_AGENT_NUM - data.agentlay1.MGET_INST_NUM;
if (data.agentlay2.MGET_INST_NUM > leftagent) {
var agentlay2 = {};
for(var i=0; i< leftagent; i++)
{
agentlay2[i] = data.agentlay2[i];
}
data.agentlay2 = agentlay2;
data.agentlay2.MGET_INST_NUM = leftagent;
}
for(var i=0; i<data.agentlay1.MGET_INST_NUM; i++) {
var agentnum = 0
for(var j=0; j<data.agentlay2.MGET_INST_NUM;j++) {
if (data.agentlay2[j].instID_Parent == data.agentlay1[i].instID) {
agentnum = agentnum + 1;
}
}
data.agentlay1[i].slave2Count = agentnum;
}
var agent1temp = data.agentlay1;
var maxCountagent_num = 0;
var maxCountagent = agent1temp[0];
for(var i=1; i<agent1temp.MGET_INST_NUM; i++) {
var acount = agent1temp[i].slave2Count;
if (acount > maxCountagent.slave2Count) {
maxCountagent_num = i;
maxCountagent = agent1temp[i];
}
}
var middle_num = Math.ceil(agent1temp.MGET_INST_NUM/2)-1;
if(agent1temp.MGET_INST_NUM > 1) {
var tmpagent = data.agentlay1[middle_num]
data.agentlay1[middle_num] = maxCountagent;
data.agentlay1[maxCountagent_num] = tmpagent;
}
}
}
consoleLog(data);
var draw = SVG("svg-area").attr("id", "svg_topo").size(TOPO_CONTAINER_WIDTH, svgHeight);
initial_template_svg(head, TOPO_CONTAINER_WIDTH, CONTROLLER_CONTAINER_WIDTH,
CONTROLLER_CONTAINER_HEIGHT, AGENT_CONTAINER_WIDTH, AGENT_CONTAINER_HEIGHT,
LAYER1_AGENT_AXIS_Y, LAYER2_AGENT_AXIS_Y, layer, svgHeight, draw, data);
}
});
}
$(document).ready(function(){
topoFormUpdate();
clientFormUpdate();
showWaitTip(false);
var timeIntervalTOPO = 30;
var TopoOBJ = $("#svg-area");
g_UpdateTopoTimer = new ContextBindingTimer(function () {
UpdateTopo();
}, {interval: timeIntervalTOPO*1000, contextDom: TopoOBJ.get(0)});
UpdateTopo();
g_UpdateTopoTimer.start();
});
</script>
