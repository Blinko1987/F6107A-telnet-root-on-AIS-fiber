<script type="text/javascript">
var g_traceroute_timer = null;
var TraceRoute_Time = 500;
function TraceRouteReGetResult()
{
var HeadID = "TraceRouteDiagnosis";
var Head = $("#"+HeadID);
var template = $("#template_TraceRouteDiagnosis");
var ServerAddr = $("address span", Head).text();
var confirmLayerOBJ = $("#confirmLayer");
template.bind("fillDataByTRStopResult", function(event,xml, template){
if (template.hasError(xml) == 0)
{
showWaitTip(false);
}
});
$("#confirmStop",confirmLayerOBJ).bind("click", function(event){
var msg = "&?DiagnosisManag_038;";
IniConfirm(msg);
$("#confirmCancel",confirmLayerOBJ).unbind("click");
$("#confirmCancel",confirmLayerOBJ).bind("click", function(event){
showWaitTip(true,"&?cmret_004;",true);
});
$("#confirmOK",confirmLayerOBJ).unbind("click");
$("#confirmOK",confirmLayerOBJ).bind("click", {TEMPLATE: template, SERVERADDR:ServerAddr}, function(event){
clearTimeout(g_traceroute_timer);
showWaitTip(false);
var template = event.data.TEMPLATE;
var serverAddr = event.data.SERVERADDR;
dataPost("TRStop", "fillDataByTRStopResult", serverAddr,
template, undefined, false);
});
});
Head.succfunction = function(xml){
ReGetTraceRouteDiagnosis(xml);
};
Head.dataTransfer(ServerAddr, "GET", Head.succfunction,
Head.failfunction, false, true);
}
function ReGetTraceRouteDiagnosis(xml)
{
var template = $("#template_TraceRouteDiagnosis");
var TRResult = "";
var TRFlag = "";
var ErrorString = $("IF_ERRORSTR", $(xml)).text();
if (template.hasError(xml) == 0)
{
var ToOperParaArray = {
"Result" : {
ValueOrigin: ""
},
"Flag" : {
ValueOrigin: ""
}
};
xmlParaInInstOperate(xml, "OBJ_TRACERT_ID", 0, ToOperParaArray);
TRResult = ToOperParaArray.Result.ValueOrigin;
TRFlag = ToOperParaArray.Flag.ValueOrigin;
}
if(ErrorString == "SUCC" && TraceRoute_Time > 0 && TRFlag == "1")
{
TraceRoute_Time--;
g_traceroute_timer = setTimeout("TraceRouteReGetResult()", 3000);
}
else
{
TraceRoute_Time = 500;
showWaitTip(false);
if (template.hasError(xml) == 0)
{
succHintShow(template);
var OBJID = ["OBJ_TRACERT_ID"];
if(TRResult!="NULL")
{
$("#Result").val(TRResult);
}
else
{
$("#Result").val("FAIL");
}
return;
}
}
}
function initial_template_TRDiagnosis(templateID)
{
var template = $("#"+templateID);
template.bind("fillDataByTRDiagnosisResult", function(event,xml, template){
if ( template.hasError(xml) == 0 )
{
TraceRouteReGetResult();
}
else
{
showWaitTip(false);
}
});
template.bind("PostDataChangeByCustom", function(event, NameValueJson){
var ElemsID = NameValueJson.ElemsMainID;
if(ElemsID == "Control" )
{
NameValueJson.ElemsValue = "0";
}
});
var instForm = template.find("form");
instForm.validate({
"rules": {
"Host:TraceRouteDiagnosis": {
"required": true
},
"MaxHopCount": {
"integer": true,
"range":[1,64]
},
"Timeout:TraceRouteDiagnosis": {
"integer": true,
"range":[2000,10000]
}
},
"messages": {
}
});
}
$(document).ready(function(){
var TRHeadID = "TraceRouteDiagnosis";
var TRHead = $("#"+TRHeadID);
var TRtemplateID = "template_"+ TRHeadID;
var TRServerAddr = $("address span", TRHead).text();
initial_template_TRDiagnosis(TRtemplateID);
$(".Btn_TraceRouteDiagnosis").bind("click", {templateOBJ:TRtemplateID}, function(event){
if ( false == $(".form_content", $("#"+TRtemplateID)).valid() )
{
return;
}
showWaitTip(false);
showWaitTip(true,"&?cmret_004;",true);
var TRtemplate = $(this).parents("[id^='template']");
TRHead.find("textarea").val("");
dataPost("TraceRouteDiagnosis", "fillDataByTRDiagnosisResult",
TRServerAddr, TRtemplate, undefined, false);
});
TRHead.succfunction = function(xml){
TRHead.hasError(xml,"externErrorHint");
var template = $("#"+TRtemplateID);
var OBJID = "OBJ_TRACERT_ID";
var tMaxHopCount = getParaValueInXML(xml, OBJID, 0, "MaxHopCount");
var tTimeout = getParaValueInXML(xml, OBJID, 0, "Timeout");
$("#MaxHopCount", template).val(tMaxHopCount);
$("#Timeout\\:TraceRouteDiagnosis", template).val(tTimeout);
$.publish("/some/CTCWANOptionsChange", [TRHead]);
$.publish("/some/networkdiag_traceroute", [template]);
};
TRHead.dataTransfer(TRServerAddr,
"GET",
TRHead.succfunction,
TRHead.failfunction,
true,
true);
});
</script>
