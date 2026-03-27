<script type="text/javascript">
(function(){
var g_TotalCheckTime_timer = null;
function initial_template_FtpTest(templateID)
{
var template = $("#"+templateID);
var instForm = template.find("form");
instForm.validate({
"rules": {
"IPAddress": {
"required": true
},
"Port": {
"required": true,
"integer": true,
"range":[1,65535]
},
"UserName": {
"required": true,
"rangelength":[1,64]
},
"Password": {
"required": true,
"rangelength":[1,64],
"PasswordASCII": true
},
"FilePath": {
"required": true,
"rangelength":[1,256]
},
},
"messages": {
}
});
template.bind("fillDataByApplyResult", function(event,xml, template){
var OBJID = ["OBJ_FTPTEST_ID"];
ActionByApplyResult(xml, template);
template.fillDataByOBJID(xml, OBJID, template, 0);
if (template.hasError(xml)==0)
{
showWaitTip(false);
showWaitTip(true,"&?ftp_test_004;",true);
setTimeout(function(){getWanStatus();}, 2000);
}
else
{
showWaitTip(false);
}
});
$("#Btn_go_testlink").bind("click",function(){
if ( false == $(".form_content", template).valid() )
{
return;
}
var ServerAddr = "/?_type=menuData&_tag=ftp_test_lua.lua";
dataPost("Apply", "fillDataByApplyResult", ServerAddr, template, undefined, false);
});
template.bind("fillDataByStopResult", function(event,xml, template){
if (template.hasError(xml) == 0)
{
showWaitTip(false);
$("#forftptestResults").hide();
}
});
}
function getWanStatus()
{
var HeadID = "FtpTest";
var Head = $("#"+HeadID);
var templateID = "template_"+ HeadID;
var ServerAddr = $("address span", Head).text();
var template = $("[id^='template_']",Head);
var confirmLayerOBJ = $("#confirmLayer");
$("#confirmStop",confirmLayerOBJ).unbind("click");
$("#confirmStop",confirmLayerOBJ).bind("click", function(event){
var msg = "&?ftp_test_005;";
IniConfirm(msg);
$("#confirmCancel",confirmLayerOBJ).unbind("click");
$("#confirmCancel",confirmLayerOBJ).bind("click", function(event){
showWaitTip(true,"&?ftp_test_004;",true);
});
$("#confirmOK",confirmLayerOBJ).unbind("click");
$("#confirmOK",confirmLayerOBJ).bind("click", {TEMPLATE: template, SERVERADDR:ServerAddr}, function(event){
clearTimeout(g_TotalCheckTime_timer);
showWaitTip(false);
var template = event.data.TEMPLATE;
var serverAddr = event.data.SERVERADDR;
dataPost("STOP", "fillDataByStopResult", serverAddr,
template, undefined, false);
});
});
Head.succfunction=function(xml)
{
RegetWanStatus(xml);
var OBJID = ["OBJ_FTPTEST_ID"];
Head.fillDataByOBJID(xml ,OBJID, template,0);
}
Head.dataTransfer(ServerAddr,"GET",Head.succfunction,undefined,false);
}
function RegetWanStatus(xml)
{
var HeadID = "FtpTest";
var Head = $("#"+HeadID);
var templateID = "template_"+ HeadID;
var ServerAddr = $("address span", Head).text();
var template = $("#template_FtpTest");
var CurrentFlag = "";
if (template.hasError(xml) == 0)
{
CurrentFlag = getParaValueInXML(xml, "OBJ_FTPTEST_ID", 0, "Flag");
}
else
{
}
if(CurrentFlag == "0")
{
clearTimeout(g_TotalCheckTime_timer);
showWaitTip(false);
$("#forftptestResults").show();
$("#ResultIfSucess").show();
}
else if(CurrentFlag == "1")
{
g_TotalCheckTime_timer = setTimeout(function(){getWanStatus()}, 2000);
$("#forftptestResults").show();
$("#ResultIfSucess").hide();
}
else
{
clearTimeout(g_TotalCheckTime_timer);
showWaitTip(false);
$("#forftptestResults").hide();
}
}
$(document).ready(function(){
var HeadID = "FtpTest";
var Head = $("#"+HeadID);
var templateID = "template_"+ HeadID;
var ServerAddr = $("address span", Head).text();
initial_template_FtpTest(templateID);
Head.succfunction = function(xml){
var template = $("[id^='template_']",Head);
Head.hasError(xml);
var OBJID = ["OBJ_FTPTEST_ID"];
Head.fillDataByOBJID(xml ,OBJID, template,0);
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
})();
</script>
