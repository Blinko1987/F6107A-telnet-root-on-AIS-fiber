<script type="text/javascript">
(function(){
function initial_template_Firewall(templateID)
{
var template = $("#"+templateID);
template.bind("fillDataByApplyResult", function(event,xml, template){
ActionByApplyResult(xml, template);
});
template.bind("fillDataByCancelResult", function(event,xml, template){
var OBJID = ["OBJ_FWDOS_ID"];
ActionByCancelResult(xml, template, OBJID);
});
}
$(document).ready(function(){
var HeadID = "FirewallDos";
var Head = $("#"+HeadID);
var templateID = "template_"+ HeadID;
var ServerAddr = $("address span", Head).text();
initial_template_Firewall(templateID);
Head.succfunction = function(xml){
var template = $("[id^='template_']",Head);
Head.hasError(xml,"externErrorHint");
var FirewallDosOBJ = $(xml).find("OBJ_FWDOS_ID");
var num = $("Instance", FirewallDosOBJ).length;
var OBJID = ["OBJ_FWDOS_ID"];
Head.createPageDataByClone(num, OBJID, xml);
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
