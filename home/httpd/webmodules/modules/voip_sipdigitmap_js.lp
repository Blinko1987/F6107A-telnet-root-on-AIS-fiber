<script type="text/javascript">
(function(){
function changeSetInstID(xml,template){
var OBJ = $(xml).find("OBJ_VOIPDMTIMER_ID");
var instances = $("Instance ", OBJ);
instances.each(function(i){
var inst = $(this);
inst.find("ParaName").each(function(){
var ParaName = $(this).text();
if ( ParaName == "_InstID" )
{
$(this).text("_InstID_timer");
}
});
});
}
function initial_template_VoipSipDigitMap(templateID)
{
var template = $("#"+templateID);
template.bind("fillDataByApplyResult", function(event,xml, template){
ActionByApplyResult(xml, template);
});
template.bind("fillDataByCancelResult", function(event,xml, template){
var OBJID = ["OBJ_VOIPVOICEPROFILE_ID","OBJ_VOIPDMTIMER_ID"];
changeSetInstID(xml);
ActionByCancelResult(xml, template, OBJID);
});
template.bind("fillDataByCustom", function(event, suffix, ContainerOBJ, xml){
var lineIndex = parseInt(suffix, 10)+1;
$("[id^='instName_VoipSipDigitMap:']", ContainerOBJ).text("&?SipAdvanced_020;"+lineIndex);
});
template.bind("applyPromptCheckJSON", function(event, template){
var checkJSONTempObj = {
"rules": {
"DigitMap": {
"required": true,
"rangelength":[1,4096]
},
"ShortTimer": {
"integer": true,
"required":true,
"range": [0,1000]
},
"LongTimer": {
"integer": true,
"required":true,
"range": [400,2000]
}
},
"messages": {
}
};
template.setPromptCheckJSON(checkJSONTempObj, template);
});
}
$(document).ready(function(){
var HeadID = "VoipSipDigitMap";
var Head = $("#"+HeadID);
var ServerAddr = $("address span", Head).text();
initial_template_VoipSipDigitMap("template_"+HeadID);
Head.succfunction = function(xml){
changeSetInstID(xml);
var cmapiErrorContainer = $(".errorHint",Head);
if (cmapiErrorContainer.hasError(xml) == 0)
{
var OBJ = $(xml).find("OBJ_VOIPVOICEPROFILE_ID");
var RuleNum = $("Instance", OBJ).length;
var tempobj = $("#template_VoipSipDigitMap");
var OBJID = ["OBJ_VOIPVOICEPROFILE_ID","OBJ_VOIPDMTIMER_ID"];
Head.createPageDataByClone(RuleNum, OBJID, xml);
}
};
initial_collapBarWithDataTrans(Head);
});
})();
</script>
