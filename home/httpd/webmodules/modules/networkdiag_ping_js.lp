<script type="text/javascript">
var Ping_Time = 8;
function PingReGetResult()
{
var HeadID = "PingDiagnosis";
var Head = $("#"+HeadID);
var template = $("#template_PingDiagnosis");
var ServerAddr = $("address span", Head).text();
Head.succfunction = function(xml){
ReGetPingDiagnosis(xml);
};
Head.dataTransfer(ServerAddr, "GET", Head.succfunction,
Head.failfunction, false);
}
function ReGetPingDiagnosis(xml)
{
var template = $("#template_PingDiagnosis");
var PingResult = "";
var ErrorString = $("IF_ERRORSTR", $(xml)).text();
if (template.hasError(xml) == 0)
{
var ToOperParaArr = {
"PingAck" : {ValueOrigin: ""}
};
xmlParaInInstOperate(xml, "OBJ_DEVPING_ID", 0, ToOperParaArr);
PingResult = ToOperParaArr.PingAck.ValueOrigin;
}
if(ErrorString == "SUCC" && Ping_Time > 0 && PingResult == "NULL")
{
Ping_Time--;
setTimeout("PingReGetResult()", 3000);
}
else
{
Ping_Time = 8;
showWaitTip(false);
if (template.hasError(xml) == 0)
{
succHintShow(template);
var OBJID = ["OBJ_DEVPING_ID"];
if(PingResult!="NULL")
{
template.fillDataByOBJID(xml ,OBJID, template,0);
}
else
{
$("#PingAck").val("&?DiagnosisManag_039;");
}
return;
}
}
}
function initial_template_PingDiagnosis(templateID)
{
var template = $("#"+templateID);
var instForm = template.find("form");
instForm.validate({
"rules": {
"Host:PingDiagnosis": {
"required": true
}
},
"messages": {
}
});
template.bind("fillDataByPingDiagnosisResult", function(event,xml, template){
if ( template.hasError(xml) == 0 )
{
PingReGetResult();
}
else
{
showWaitTip(false);
}
});
}
$(document).ready(function(){
var PingHeadID = "PingDiagnosis";
var PingHead = $("#"+PingHeadID);
var PingtemplateID = "template_"+ PingHeadID;
var PingServerAddr = $("address span", PingHead).text();
initial_template_PingDiagnosis(PingtemplateID);
$(".Btn_PingDiagnosis").bind("click", {templateOBJ:PingtemplateID}, function(event){
if ( false == $(".form_content", $("#"+PingtemplateID)).valid() )
{
return;
}
var Pingtemplate = $(this).parents("[id^='template']");
PingHead.find("textarea").val("");
showWaitTip(false);
showWaitTip(true,"&?cmret_004;");
dataPost("PingDiagnosis", "fillDataByPingDiagnosisResult",
PingServerAddr, Pingtemplate, undefined, false);
});
PingHead.succfunction = function(xml){
PingHead.hasError(xml,"externErrorHint");
var ContainerOBJ = $("[id^='template_']",PingHead)
$.publish("/some/CTCWANOptionsChange", [PingHead]);
$.publish("/some/networkdiag_ping", [ContainerOBJ]);
};
PingHead.dataTransfer(PingServerAddr,
"GET",
PingHead.succfunction);
});
</script>
