<script type="text/javascript">
<%
cgilua_lp.include("../../thinklua/template/template_help_js.lp",getfenv(1))
cgilua_lp.include("../../thinklua/template/commpage_status_comm.lp", getfenv(1))
cgilua_lp.include("../../thinklua/template/jquery_validate_extjs.lp", getfenv(1))
%>
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
var ServerAddr = "/?_type=hiddenData&_tag=mirrorcfg_data";
initial_template_Mirror(templateID);
Head.succfunction = function(xml){
Head.hasError(xml,"externErrorHint");
destSelectVal = getParaValueInXML(xml, "OBJ_MIRROR_ID", 0, "MirrorDest");
srcSelectVal = getParaValueInXML(xml, "OBJ_MIRROR_ID", 0, "MirrorSrc");
if (Head.hasError(xml) == 0)
{
var OBJID = ["OBJ_MIRROR_ID"];
Head.fillDataByOBJID(xml, OBJID, $("#"+templateID), 0);
}
};
Head.dataTransfer(ServerAddr,"GET",Head.succfunction);
});
})();
</script>
