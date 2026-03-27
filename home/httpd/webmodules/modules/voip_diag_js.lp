<script type="text/javascript">
(function(){
function initial_template_VoIPDiagnosis(templateID)
{
var template = $("#"+templateID);
template.bind("fillDataByCancelResult", function(event,xml, template){
var OBJID = ["OBJ_VoiceDiagnosisE_ID"];
ActionByCancelResult(xml, template, OBJID);
var status = $("[id^='RegStatus']", template);
if ("Pass" == status.val())
{
status.attr("style","color: green");
}
else
{
status.attr("style","color: red");
}
});
template.bind("fillDataByCustom", function(event, suffix, ContainerOBJ, xml){
var index = parseInt(suffix, 10)+1;
$("[id^='instName_VoipDiag:']", ContainerOBJ).text("&?public_017;"+index);
$("[id^='RegStatus']", ContainerOBJ).val("");
});
}
$(document).ready(function(){
var VoipDiagHeadID = "VoipDiag";
var VoipDiagHead = $("#"+VoipDiagHeadID);
var ServerAddr = $("address span", VoipDiagHead).text();
initial_template_VoIPDiagnosis("template_"+VoipDiagHeadID);
VoipDiagHead.succfunction = function(xml){
VoipDiagHead.hasError(xml);
var VoipDiagOBJ = $(xml).find("OBJ_VoiceDiagnosisE_ID");
var RuleNum = $("Instance", VoipDiagOBJ).length;
var OBJID = ["OBJ_VoiceDiagnosisE_ID"];
VoipDiagHead.createPageDataByClone(RuleNum, OBJID, xml);
};
if ( $(".collapBarWithDataTrans",VoipDiagHead).length <= 0 )
{
VoipDiagHead.dataTransfer(ServerAddr, "GET", VoipDiagHead.succfunction);
}
else
{
initial_collapBarWithDataTrans(VoipDiagHead);
}
});
})();
</script>
