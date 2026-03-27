<script type="text/javascript">
<%
cgilua_lp.include("../../thinklua/template/template_help_js.lp",getfenv(1))
cgilua_lp.include("../../thinklua/template/commpage_status_comm.lp", getfenv(1))
%>
function initial_template(templateID)
{
var template = $("#"+templateID);
template.bind("fillDataByApplyResult", function(event, xml, template){
ActionByApplyResult(xml, template);
});
template.bind("fillDataByCancelResult", function(event,xml, template){
var OBJID = ["OBJ_CHANGEDOCSISSTATUS_ID"];
ActionByCancelResult(xml, template, OBJID);
});
}
$(document).ready(function(){
var HeadID = "DocsisCtr";
var Head = $("#"+HeadID);
var templateID = "template_"+HeadID;
var ServerAddr = $("address span", Head).text();
initial_template(templateID);
Head.succfunction = function(xml){
if (Head.hasError(xml) == 0)
{
var OBJID = ["OBJ_CHANGEDOCSISSTATUS_ID"];
Head.fillDataByOBJID(xml, OBJID, $("#"+templateID), 0);
}
};
if ( $(".collapBarWithDataTrans",Head).length <= 0 )
{
Head.dataTransfer(ServerAddr,"GET",Head.succfunction);
}
else
{
initial_collapBarWithDataTrans(Head);
}
});
</script>
