<script type="text/javascript">
(function(){
var pageConf = JSON.parse("<%=page.jsInfo%>");
var pageObj = pageConf.objList;
var pageId = pageConf.id;
var pageAreaId = pageConf.areaId;
var pageTime = pageConf.time;
var pageMsg = pageConf.Msg;
function DiagnosisReGetResult()
{
var HeadID = pageId;
var Head = $("#" + HeadID);
var template = $("#template_" + HeadID);
var ServerAddr = $("address span", Head).text();
Head.succfunction = function(xml){
ReGetDiagnosis(xml);
};
Head.dataTransfer(ServerAddr, "GET", Head.succfunction, Head.failfunction, false);
}
function ReGetDiagnosis(xml)
{
var template = $("#template_" + pageId);
var Result = "";
var ErrorString = xml.IF_ERRORSTR;
if (template.hasError(xml) == 0)
{
var ToOperParaArr = new Object();
ToOperParaArr[pageAreaId] = {ValueOrigin: ""};
xmlParaInInstOperate(xml, pageObj, 0, ToOperParaArr);
Result = ToOperParaArr[pageAreaId].ValueOrigin;
}
if (ErrorString == "SUCC" && pageTime > 0 && Result == "")
{
pageTime--;
setTimeout(function(){DiagnosisReGetResult();}, 3000);
}
else
{
pageTime = pageConf.time;
showWaitTip(false);
if (template.hasError(xml) == 0)
{
succHintShow(template);
var OBJID = pageObj;
if (Result != "")
{
template.fillDataByOBJID(xml, OBJID, template, 0);
}
else
{
$("#" + pageAreaId).val(pageMsg);
}
return;
}
}
}
function initial_template_Diagnosis(templateID)
{
var template = $("#" + templateID);
template.bind("fillDataByDiagnosisResult", function(event, xml, template){
if (template.hasError(xml) == 0)
{
DiagnosisReGetResult();
}
else
{
showWaitTip(false);
}
});
}
$(document).ready(function(){
var diagnosisHeadID = pageId;
var diagnosisHead = $("#" + diagnosisHeadID);
var diagnosisTemplateID = "template_" + diagnosisHeadID;
var ServerAddr = $("address span", diagnosisHead).text();
initial_template_Diagnosis(diagnosisTemplateID);
$(".Btn_" + diagnosisHeadID).bind("click", {diagnosisTemplateOBJ:diagnosisTemplateID}, function(event){
if (false == $(".form_content", $("#" + diagnosisTemplateID)).valid())
{
return;
}
var diagnosisTemplate = $(this).parents("[id^='template']");
diagnosisHead.find("textarea").val("");
showWaitTip(false);
showWaitTip(true, "&?cmret_004;");
dataPost(diagnosisHeadID, "fillDataByDiagnosisResult", ServerAddr, diagnosisTemplate, undefined, false);
});
diagnosisHead.succfunction = function(xml){
diagnosisHead.hasError(xml, "externErrorHint");
$.publish("/some/WANOptionsChange", [$("[id^='Interface:']", $("#" + diagnosisTemplateID))]);
$.publish("/some/CTCWANOptionsChange", [diagnosisHead]);
};
diagnosisHead.dataTransfer(ServerAddr, "GET", diagnosisHead.succfunction);
initial_collapBarWithDataTrans(diagnosisHead);
});
})();
</script>
