<script type="text/javascript">
function initial_template_DHCPPortService(templateID)
{
var template = $("#"+templateID);
template.bind("fillDataByApplyResult", function(event, xml, template){
ActionByApplyResult(xml, template);
});
<%
if "0" == env.getenv("DHCPConfigurable") then
%>
chanegeButtonByCustom("Btn_apply_DHCPPortService", template)
<%
end
%>
template.bind("fillDataByCancelResult", function(event, xml, template){
var templateID = template.attr("id");
if ( template.hasError(xml) == 0 )
{
var RuleNum = $("#_InstNum", template).val();
for (var i=0; i<RuleNum; i++)
{
var _InstID = $("[id^='_InstID_']", template).eq(i).val();
var RuleObj = $("[id^='div_PortCtlRule_']", template).eq(i);
var DataOBJID = ["OBJ_DHCPBINDONPORT_ID"];
var suffix = getInstIndexByPath(xml, DataOBJID[0], _InstID);
RuleObj.fillDataByOBJID(xml, DataOBJID, RuleObj, suffix, "_");
}
}
});
}
$(document).ready(function(){
var HeadID = "DHCPPortService";
var Head = $("#"+HeadID);
var ServerAddr = $("address span", Head).text();
initial_template_DHCPPortService("template_"+HeadID);
Head.succfunction = function(xml){
Head.hasError(xml,"externErrorHint");
var OBJ = $(xml).find("OBJ_DHCPBINDONPORT_ID");
var RuleNum = $("Instance", OBJ).length;
var TemplateOBJ = $("#template_"+HeadID,Head);
if (RuleNum == 0)
{
$(".noDataHint",Head).showIt(true);
TemplateOBJ.showIt(false);
}
else
{
$(".noDataHint",Head).showIt(false);
TemplateOBJ.showIt(true);
$("#_InstNum", Head).val(RuleNum);
for (var i=0; i<RuleNum; i++)
{
var ruleTemplate = $("#div_PortCtlRule");
var clone = ruleTemplate.cloneWithSuffix(i, "_");
ruleTemplate.before(clone);
var DataOBJID = ["OBJ_DHCPBINDONPORT_ID"];
clone.fillDataByOBJID(xml, DataOBJID, clone, i, "_");
clone.showIt(true);
}
}
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
</script>
