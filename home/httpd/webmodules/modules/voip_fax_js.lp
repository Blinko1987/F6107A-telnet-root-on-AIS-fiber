<script type="text/javascript">
(function(){
var isTR104v2 = "<%=env.getenv("VoIPTR104V2") %>";
var OBJIDSTR = (isTR104v2 == "1") ? "OBJ_VOIPSIPLINE_ID" : "OBJ_VOIPFAXT38_ID";
function g_ChanegeDataByCustom(xml)
{
}
function changeSetInstID(xml){
var OBJ = $(xml).find("OBJ_VOIPFAXMODE_ID");
var instances = $("Instance ", OBJ);
instances.each(function(i){
var inst = $(this);
inst.find("ParaName").each(function(){
var ParaName = $(this).text();
if ( ParaName == "_InstID" )
{
$(this).text("_InstID_mode");
}
});
});
}
function initial_template_Fax(templateID)
{
var template = $("#"+templateID);
template.bind("fillDataByApplyResult", function(event, xml, template){
ActionByApplyResult(xml, template);
});
template.bind("fillDataByCancelResult", function(event, xml, template){
var OBJID = [OBJIDSTR,"OBJ_VOIPFAXMODE_ID"];
g_ChanegeDataByCustom(xml);
changeSetInstID(xml);
ActionByCancelResult(xml, template, OBJID);
});
template.bind("fillDataByCustom", function(event, suffix, ContainerOBJ, xml){
var lineIndex = parseInt(suffix, 10)+1;
var languageTag = (isTR104v2 == 1) ? "&?Tr104v2_001;" : "&?SipAdvanced_020;";
$("[id^='instName_Fax:']", ContainerOBJ).text(languageTag+lineIndex);
});
}
$(document).ready(function(){
var HeadID = "Fax";
var Head = $("#"+HeadID);
var TempalteID = "template_"+ HeadID;
var ServerAddr = $("address span", Head).text();
initial_template_Fax(TempalteID);
Head.succfunction = function(xml){
Head.hasError(xml,"externErrorHint");
g_ChanegeDataByCustom(xml);
changeSetInstID(xml);
var OBJ = $(xml).find(OBJIDSTR);
var RuleNum = $("Instance", OBJ).length;
var OBJID = [OBJIDSTR,"OBJ_VOIPFAXMODE_ID"];
Head.createPageDataByClone(RuleNum, OBJID, xml);
};
if ( $(".collapBarWithDataTrans",Head).length <= 0 )
{
Head.dataTransfer(ServerAddr, "GET", Head.succfunction);
}
else
{
initial_collapBarWithDataTrans(Head);
}
});
})();
</script>
