<script type="text/javascript">
(function(){
var VOIP_ID = "OBJ_VOIPH248MAIN_ID";
<%
local voipProtocol = "H248";
voipProtocol = env.getenv("VoIPProtocal")
if voipProtocol == "SIP" then
%>
VOIP_ID = "OBJ_VOIPSIP_ID";
<%
end
%>
function initial_template_Signal(templateID)
{
var template = $("#"+templateID);
template.bind("fillDataByApplyResult", function(event,xml, template){
ActionByApplyResult(xml, template);
});
template.bind("fillDataByCancelResult", function(event,xml, template){
var OBJID = [VOIP_ID];
ActionByCancelResult(xml, template, OBJID);
});
template.bind("fillDataByCustom", function(event, suffix, ContainerOBJ, xml){
var lineIndex = parseInt(suffix, 10)+1;
var isTR104v2 = "<%=env.getenv("VoIPTR104V2") %>";
var languageTag = (isTR104v2 == 1)? "&?mmMenu_001;" : "&?SipAdvanced_020;";
$("[id^='instName_VoIPQoSConf:']", ContainerOBJ).text(languageTag+lineIndex);
});
template.bind("applyPromptCheckJSON", function(event, template){
var checkJSONTempObj = {
"rules": {
"DSCPMarkSignalling": {
"required":true,
"integer": true,
"range":[0,63]
},
"EthernetPriorityMark": {
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
var HeadID = "VoIPQoSConf";
var Head = $("#"+HeadID);
initial_template_Signal("template_"+HeadID);
Head.chanegeDataByCustom =function(xml){
};
Head.succfunction = function(xml){
Head.hasError(xml,"externErrorHint");
var OBJ = $(xml).find(VOIP_ID);
var RuleNum = $("Instance", OBJ).length;
var OBJID = [VOIP_ID];
Head.createPageDataByClone(RuleNum, OBJID, xml);
};
initial_collapBarWithDataTrans(Head);
});
})();
</script>
