<script type="text/javascript">
(function(){
var destSelectVal = "", srcSelectVal = "";
function initial_template_Mirror(templateID)
{
var template = $("#"+templateID);
$("[id^='MirrorSrc']", template).bind("change", function(){
if($(this).val() == srcSelectVal){
$("[id^='MirrorDest']").val(destSelectVal);
}else{
$("[id^='MirrorDest'] option:eq(0)").attr("selected", 'selected');
}
});
template.bind("applyPromptCheckJSON", function(event, template){
var NewID = "[id^='"+ $("[id^='NewPassword']",template).attr("id")+"']";
var checkJSONTempObj = {
"rules": {
"MirrorSrc": {
"required": true
},
"MirrorDest": {
"required": true
}
},
"messages": {
}
};
template.setPromptCheckJSON(checkJSONTempObj, template);
});
template.bind("fillDataByApplyResult", function(event,xml, template){
ActionByApplyResult(xml, template);
});
template.bind("fillDataByCancelResult", function(event,xml, template){
var OBJID = ["OBJ_MIRROR_ID"];
ActionByCancelResult(xml, template, OBJID);
});
}
$(document).ready(function(){
var HeadID = "MirroManag";
var Head = $("#"+HeadID);
var templateID = "template_"+ HeadID;
var ServerAddr = $("address span", Head).text();
initial_template_Mirror(templateID);
Head.succfunction = function(xml){
Head.hasError(xml,"externErrorHint");
destSelectVal = getParaValueInXML(xml, "OBJ_MIRROR_ID", 0, "MirrorDest");
srcSelectVal = getParaValueInXML(xml, "OBJ_MIRROR_ID", 0, "MirrorSrc");
var OBJ = $(xml).find("OBJ_MIRROR_ID");
var RuleNum = $("Instance", OBJ).length;
var OBJID = ["OBJ_MIRROR_ID"];
Head.createPageDataByClone(RuleNum,OBJID,xml);
};
initial_collapBarWithDataTrans(Head);
});
})();
</script>
