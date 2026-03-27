<script type="text/javascript">
(function(){
function initial_template_SLCTIME(templateID)
{
var template = $("#"+templateID);
template.bind("fillDataByApplyResult", function(event,xml, template){
ActionByApplyResult(xml, template);
});
template.bind("fillDataByCancelResult", function(event,xml, template){
var OBJID = ["OBJ_VOIPSLCTIME_ID"];
ActionByCancelResult(xml, template, OBJID);
});
template.bind("fillDataByCustom", function(event, suffix, ContainerOBJ, xml){
var lineIndex = parseInt(suffix, 10)+1;
$("[id^='instName_SLCTIME:']", ContainerOBJ).text("&?SipAdvanced_028;"+lineIndex);
});
template.bind("applyPromptCheckJSON", function(event, template){
var checkJSONTempObj = {
"rules": {
"HookLow": {
"integer": true,
"required":true,
"range": [30,150]
},
"FlashLowMin": {
"integer": true,
"required":true,
"range": [5,10]
}
},
"messages": {
}
};
$.publish("/some/rdsVoipSLCTimeModify", [checkJSONTempObj]);
template.setPromptCheckJSON(checkJSONTempObj, template);
});
}
$(document).ready(function(){
var SLCTIMEHeadID = "SLCTIME";
var SLCTIMEHead = $("#"+SLCTIMEHeadID);
var ServerAddr = $("address span", SLCTIMEHead).text();
initial_template_SLCTIME("template_"+SLCTIMEHeadID);
SLCTIMEHead.succfunction = function(xml){
SLCTIMEHead.hasError(xml);
var SLCTIMEOBJ = $(xml).find("OBJ_VOIPSLCTIME_ID");
var RuleNum = $("Instance", SLCTIMEOBJ).length;
var OBJID = ["OBJ_VOIPSLCTIME_ID"];
SLCTIMEHead.createPageDataByClone(RuleNum, OBJID, xml);
};
if ( $(".collapBarWithDataTrans",SLCTIMEHead).length <= 0 )
{
SLCTIMEHead.dataTransfer(ServerAddr, "GET", SLCTIMEHead.succfunction);
}
else
{
initial_collapBarWithDataTrans(SLCTIMEHead);
}
});
})();
</script>
