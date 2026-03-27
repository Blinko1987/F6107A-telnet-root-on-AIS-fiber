<script type="text/javascript">
(function(){
function initial_template_VOICEPROC(templateID)
{
var template = $("#"+templateID);
template.bind("fillDataByApplyResult", function(event,xml, template){
ActionByApplyResult(xml, template);
});
template.bind("fillDataByCancelResult", function(event,xml, template){
var OBJID = ["OBJ_VOIPSLCINF_ID"];
ActionByCancelResult(xml, template, OBJID);
});
template.bind("fillDataByCustom", function(event, suffix, ContainerOBJ, xml){
var lineIndex = parseInt(suffix, 10)+1;
$("[id^='instName_VOICESIPSLC:']", ContainerOBJ).text("&?SipAdvanced_019;"+lineIndex);
});
}
$(document).ready(function(){
var VOICESIPSLCHeadID = "VOICESIPSLC";
var VOICESIPSLCHead = $("#"+VOICESIPSLCHeadID);
var ServerAddr = $("address span", VOICESIPSLCHead).text();
initial_template_VOICEPROC("template_"+VOICESIPSLCHeadID);
VOICESIPSLCHead.succfunction = function(xml){
VOICESIPSLCHead.hasError(xml);
var VOICEPROCOBJ = $(xml).find("OBJ_VOIPSLCINF_ID");
var RuleNum = $("Instance", VOICEPROCOBJ).length;
var OBJID = ["OBJ_VOIPSLCINF_ID"];
VOICESIPSLCHead.createPageDataByClone(RuleNum, OBJID, xml);
};
if ( $(".collapBarWithDataTrans",VOICESIPSLCHead).length <= 0 )
{
VOICESIPSLCHead.dataTransfer(ServerAddr, "GET", VOICESIPSLCHead.succfunction);
}
else
{
initial_collapBarWithDataTrans(VOICESIPSLCHead);
}
});
})();
</script>
