<script type="text/javascript">
(function(){
function initial_template_TRUNK(templateID)
{
var template = $("#"+templateID);
template.bind("fillDataByApplyResult", function(event,xml, template){
ActionByApplyResult(xml, template);
});
template.bind("fillDataByCancelResult", function(event,xml, template){
var OBJID = ["OBJ_TRUNK_ID"];
ActionByCancelResult(xml, template, OBJID);
});
}
$(document).ready(function(){
var HeadID = "TrunkMode";
var Head = $("#"+HeadID);
var ServerAddr = $("address span", Head).text();
initial_template_TRUNK("template_"+HeadID);
Head.succfunction = function(xml){
var cmapiErrorContainer = $(".errorHint",Head);
if (cmapiErrorContainer.hasError(xml) == 0)
{
var tempobj = $("#template_TrunkMode");
var OBJID = ["OBJ_TRUNK_ID"];
Head.fillDataByOBJID(xml, OBJID, tempobj, 0);
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
})();
</script>
