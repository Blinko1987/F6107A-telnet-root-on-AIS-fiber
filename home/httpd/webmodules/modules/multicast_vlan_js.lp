<script type="text/javascript">
(function(){
function createInstName(template)
{
var nameObj = $(".collapsibleInst", template);
var lanObj = $("[id^='PortViewName']", template);
var lan = $("option[value='" + lanObj.val() + "']", lanObj).text();
var vlan = $("[id^='MultSrcVid']", template).val();
var nameTxt = lan + "-" + vlan;
nameObj.text(nameTxt);
nameObj.attr("title", nameTxt);
}
function initial_template_MulticastVlan(templateID)
{
var template = $("#"+templateID);
template.bind("applyPromptCheckJSON", function(event, template){
var checkJSONTempObj = {
"rules": {
"MultSrcVid": {
"required":true,
"integer": true,
"range": [1,4094]
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
var OBJID = ["OBJ_IGMPVLAN_ID"];
ActionByCancelResult(xml, template, OBJID);
template.trigger("fillDataByCustom", [0, template, xml]);
});
template.bind("fillDataByCustom", function(event, suffix, template){
createInstName(template);
$("[id^='PortViewName']", template).attr("disabled", "disabled");
});
}
$(document).ready(function(){
var HeadID = "MulticastVlanConf";
var Head = $("#"+HeadID);
var templateID = "template_"+ HeadID;
var ServerAddr = $("address span", Head).text();
initial_template_MulticastVlan(templateID);
Head.succfunction = function(xml){
Head.hasError(xml,"externErrorHint");
var MACFILTEROBJ = $(xml).find("OBJ_IGMPVLAN_ID");
var RuleNum = $("Instance", MACFILTEROBJ).length;
var OBJID = ["OBJ_IGMPVLAN_ID"];
Head.createPageDataByClone(RuleNum,OBJID,xml);
$.publish("/some/softVersionModify", [Head]);
};
if ( $(".collapBarWithDataTrans",Head).length <= 0 )
{
Head.dataTransfer(ServerAddr,
"GET",
Head.succfunction);
}
else
{
initial_collapBarWithDataTrans(Head);
}
});
})();
</script>
