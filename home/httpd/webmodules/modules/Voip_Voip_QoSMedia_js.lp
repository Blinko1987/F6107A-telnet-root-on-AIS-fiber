<script type="text/javascript">
(function(){
var RTP_ID = "OBJ_VOIPRTP_ID";
function initial_template_Media(templateID)
{
var template = $("#"+templateID);
template.bind("fillDataByApplyResult", function(event,xml, template){
ActionByApplyResult(xml, template);
});
template.bind("fillDataByCancelResult", function(event,xml, template){
var OBJID = [RTP_ID];
ActionByCancelResult(xml, template, OBJID);
});
template.bind("fillDataByCustom", function(event, suffix, ContainerOBJ, xml){
var lineIndex = parseInt(suffix, 10)+1;
$("[id^='instName_VoIPQoSConf_Media:']", ContainerOBJ).text("&?SipAdvanced_020;"+lineIndex);
});
template.bind("applyPromptCheckJSON", function(event, template){
var checkJSONTempObj = {
"rules": {
"DSCPMarkMedia": {
"required":true,
"integer": true,
"range":[0,63]
},
"RTPEthernetPriorityMark": {
"required":true,
"integer": true,
"range":[-1,7]
},
},
"messages": {
}
};
template.setPromptCheckJSON(checkJSONTempObj, template);
});
}
$(document).ready(function(){
var HeadID_Media = "VoIPQoSConf_Media";
var Head_Media = $("#"+HeadID_Media);
initial_template_Media("template_"+HeadID_Media);
Head_Media.chanegeDataByCustom =function(xml){
};
Head_Media.succfunction = function(xml){
Head_Media.hasError(xml,"externErrorHint");
var OBJ = $(xml).find(RTP_ID);
var RuleNum = $("Instance", OBJ).length;
var OBJID = [RTP_ID];
Head_Media.createPageDataByClone(RuleNum, OBJID, xml);
};
initial_collapBarWithDataTrans(Head_Media);
});
})();
</script>
