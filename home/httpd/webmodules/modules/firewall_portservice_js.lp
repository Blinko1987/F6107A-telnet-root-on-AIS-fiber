<script type="text/javascript">
(function(){
function initial_template_IPv6DHCPPortCtl(templateID)
{
var template = $("#"+templateID);
var instForm = template.find("form");
instForm.validate({
"rules": {
},
"messages": {
}
});
template.bind("fillDataByApplyResult", function(event, xml, template){
ActionByApplyResult(xml, template);
});
template.bind("fillDataByCancelResult", function(event, xml, template){
var templateID = template.attr("id");
if ( template.hasError(xml) == 0 )
{
var RuleNum = $("#_InstNum", template).val();
for (var i=0; i<RuleNum; i++)
{
var _InstID = $("[id^='_InstID_']", template).eq(i).val();
var RuleObj = $("[id^='div_ServPortRule_']", template).eq(i);
var DataOBJID = ["OBJ_FW_SERVPORT_ID"];
var suffix = getInstIndexByPath(xml, DataOBJID[0], _InstID);
RuleObj.fillDataByOBJID(xml, DataOBJID, RuleObj, suffix, "_");
}
}
});
}
$(document).ready(function(){
var HeadID = "ServPortCfg";
var Head = $("#"+HeadID);
var ServerAddr = $("address span", Head).text();
initial_template_IPv6DHCPPortCtl("template_"+HeadID);
Head.succfunction = function(xml){
Head.hasError(xml,"externErrorHint");
var OBJ = $(xml).find("OBJ_FW_SERVPORT_ID");
var RuleNum = $("Instance", OBJ).length;
$("#_InstNum", Head).val(RuleNum);
for (var i=0; i<RuleNum; i++)
{
var ruleTemplate = $("#div_ServPortRule");
var clone = ruleTemplate.cloneWithSuffix(i, "_");
var DataOBJID = ["OBJ_FW_SERVPORT_ID"];
ruleTemplate.before(clone);
clone.fillDataByOBJID(xml, DataOBJID, clone, i, "_");
clone.showIt(true);
}
$.publish("/some/SerCtrModify", [Head]);
$.callModifier("/ServName/displaytelnet");
$("[id^='ServPort_']",Head).each(function(){
$(this).rules("add",{
"required": true,
"integer": true,
"range":[1, 65535]
});
});
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
