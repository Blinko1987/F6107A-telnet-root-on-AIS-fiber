<script type="text/javascript">
(function () {
function initial_template_PrefixMgr(templateID)
{
var template = $("#"+templateID);
template.bind("applyPromptCheckJSON", function(event, template){
var checkJSONTempObj = {
"groups": {
Prefix: "Prefix:PrefixMgr PrefixLen:PrefixMgr"
},
"rules": {
"Alias:PrefixMgr": {
"required": true,
"utf8": true,
"utf8LengthRange":[1,32]
},
"Prefix:PrefixMgr": {
"required": true,
"IPv6Addr": true,
"banValue": ["::"]
},
"PrefixLen:PrefixMgr": {
"required": true,
"integer": true,
"range":[1, 64]
}
},
"messages": {
}
};
template.setPromptCheckJSON(checkJSONTempObj, template);
});
template.bind("fillDataByCustom", function(event, suffix, ContainerOBJ, xml){
ContainerOBJ.collapsibleInstTitleChange("Alias");
$("[id^='Btn_apply_PrefixMgr']", ContainerOBJ).addClass("disableBtn");
});
template.bind("fillDataByApplyResult", function(event,xml, template){
if (ActionByApplyResult(xml, template, "Alias") == 0 )
{
$("[id^='Btn_apply_PrefixMgr']", template).addClass("disableBtn");
$("#Btn_SelfUpd_IPv6DHCPServer", $("#IPv6DHCPServer")).click();
$("#Btn_SelfUpd_RAService", $("#RAService")).click();
}
});
template.bind("fillDataByCancelResult", function(event,xml, template){
var OBJID = ["OBJ_STATIC_PREFIX_ID"];
ActionByCancelResult(xml, template, OBJID, "Alias");
template.trigger("fillDataByCustom",[0, template, xml]);
});
template.unbind("fillDataByDeleteResult");
template.bind("fillDataByDeleteResult", function(event,xml, template){
if ( template.hasError(xml) == 0 )
{
template.remove();
$("#Btn_SelfUpd_IPv6DHCPServer", $("#IPv6DHCPServer")).click();
$("#Btn_SelfUpd_RAService", $("#RAService")).click();
}
else
{
$(".ChangeArea",template).showIt(true);
}
});
}
$(document).ready(function(){
var HeadID = "PrefixMgr";
var Head = $("#"+HeadID);
var templateID = "template_"+ HeadID;
var ServerAddr = $("address span", Head).text();
initial_template_PrefixMgr(templateID);
Head.succfunction = function(xml){
Head.hasError(xml,"externErrorHint");
var OBJ = $(xml).find("OBJ_STATIC_PREFIX_ID");
var RuleNum = $("Instance", OBJ).length;
var OBJID = ["OBJ_STATIC_PREFIX_ID"];
Head.createPageDataByClone(RuleNum, OBJID, xml);
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
