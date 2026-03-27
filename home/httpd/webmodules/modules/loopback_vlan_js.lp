<script type="text/javascript">
(function(){
function createInstName(template)
{
var nameObj = $(".collapsibleInst", template);
var lanObj = $("[id^='PortID']", template);
var lan = $("option[value='" + lanObj.val() + "']", lanObj).text();
var vlan = $("[id^='VidStr']", template).val();
var nameTxt = lan + "-" + vlan;
nameObj.text(nameTxt);
nameObj.attr("title", nameTxt);
}
function initial_template_ldVLANHead(templateID)
{
var template = $("#"+templateID);
template.bind("applyPromptCheckJSON", function(event, template){
var checkJSONTempObj = {
"rules": {
"VidStr": {
"required": true,
"integer": true,
"range":[1, 4094]
}
},
"messages": {
}
};
template.setPromptCheckJSON(checkJSONTempObj, template);
});
template.bind("fillDataByApplyResult", function(event,xml, template){
if (ActionByApplyResult(xml, template) == 0)
{
template.trigger("fillDataByCustom", [0, template, xml]);
}
});
template.bind("fillDataByCancelResult", function(event,xml, template){
var OBJID = ["OBJ_LOOPBACK_VLAN_ID"];
ActionByCancelResult(xml, template, OBJID);
template.trigger("fillDataByCustom", [0, template, xml]);
});
template.bind("fillDataByCustom", function(event, suffix, template){
createInstName(template);
$("[id^='PortID']", template).attr("disabled", "disabled");
});
}
$(document).ready(function(){
var ldVLANHeadID = "LoopbackDetectVlan";
var ldVLANHead = $("#"+ldVLANHeadID);
var ServerAddr = $("address span", ldVLANHead).text();
initial_template_ldVLANHead("template_"+ldVLANHeadID);
ldVLANHead.succfunction = function(xml){
ldVLANHead.hasError(xml,"externErrorHint");
var OBJ = $(xml).find("OBJ_LOOPBACK_VLAN_ID");
var RuleNum = $("Instance", OBJ).length;
var OBJID = ["OBJ_LOOPBACK_VLAN_ID"];
ldVLANHead.createPageDataByClone(RuleNum, OBJID, xml);
};
if ( $(".collapBarWithDataTrans",ldVLANHead).length <= 0 )
{
ldVLANHead.dataTransfer(ServerAddr,
"GET",
ldVLANHead.succfunction);
}
else
{
initial_collapBarWithDataTrans(ldVLANHead);
}
});
})();
</script>
