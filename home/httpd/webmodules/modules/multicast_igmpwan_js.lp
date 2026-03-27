<script type="text/javascript">
(function(){
function initial_template_IGMPWan(templateID)
{
var template = $("#"+templateID);
var instForm = template.find("form");
instForm.validate({
"rules": {
"WanCID": {
"required": true,
"ASCII": true
}
},
"messages": {
}
});
template.bind("fillDataByApplyResult", function(event, xml, template){
ActionByApplyResult(xml, template);
});
template.bind("fillDataByCancelResult", function(event,xml, template){
var OBJID = ["OBJ_IGMPPROXYEX_ID"];
ActionByCancelResult(xml, template, OBJID);
});
$("[id^='WanCID']",template).change(function(){
var WANSelect = $(this).find("option:selected");
var template = WANSelect.parents("[id^='template_']");
var WANType = WANSelect.attr("IPMode");
var DivMcPrefix = $("[id^='div_McPrefix']",template);
var McPrefix = $("[id^='McPrefix']",template);
var McPrefixLen = $("[id^='McPrefixLen']",template);
if ( WANType == 2 )
{
DivMcPrefix.showIt(true);
McPrefix.removeClass("PostIgnore");
McPrefixLen.removeClass("PostIgnore");
}
else
{
DivMcPrefix.showIt(false);
McPrefix.addClass("PostIgnore");
McPrefixLen.addClass("PostIgnore");
}
});
template.bind("fillDataByCustom", function(event, suffix, ContainerOBJ, xml){
$("[id^='WanCID']",ContainerOBJ).change();
});
}
$(document).ready(function(){
var HeadID = "IGMPWan";
var Head = $("#"+HeadID);
var templateID = "template_"+HeadID;
var ServerAddr = $("address span", Head).text();
initial_template_IGMPWan(templateID);
Head.succfunction = function(xml){
var template = $("[id^='template_']",Head);
Head.hasError(xml,"externErrorHint");
var OBJID = ["OBJ_IGMPPROXYEX_ID"];
Head.fillDataByOBJID(xml ,OBJID, template,0);
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
