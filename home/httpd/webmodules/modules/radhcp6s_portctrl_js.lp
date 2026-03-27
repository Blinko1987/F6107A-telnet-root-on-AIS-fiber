<script type="text/javascript">
(function () {
function initial_template_IPv6DHCPPortCtl(templateID)
{
var template = $("#"+templateID);
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
var RuleObj = $("[id^='div_PortCtlRule_']", template).eq(i);
var DataOBJID = ["OBJ_IPV6BANPORT_ID"];
var suffix = getInstIndexByPath(xml, DataOBJID[0], _InstID);
RuleObj.fillDataByOBJID(xml, DataOBJID, RuleObj, suffix, "_");
RuleObj.trigger("fillDataByCustom",[0, RuleObj]);
}
}
});
}
$(document).ready(function(){
var HeadID = "IPv6DHCPPortCtl";
var Head = $("#"+HeadID);
var ServerAddr = $("address span", Head).text();
initial_template_IPv6DHCPPortCtl("template_"+HeadID);
Head.succfunction = function(xml){
Head.hasError(xml,"externErrorHint");
var OBJ = $(xml).find("OBJ_IPV6BANPORT_ID");
var RuleNum = $("Instance", OBJ).length;
$("#_InstNum", Head).val(RuleNum);
for (var i=0; i<RuleNum; i++)
{
var ruleTemplate = $("#div_PortCtlRule");
var clone = ruleTemplate.cloneWithSuffix(i, "_");
ruleTemplate.before(clone);
var DataOBJID = ["OBJ_IPV6BANPORT_ID"];
clone.fillDataByOBJID(xml, DataOBJID, clone, i, "_");
clone.trigger("fillDataByCustom",[i, clone]);
clone.showIt(true);
}
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
