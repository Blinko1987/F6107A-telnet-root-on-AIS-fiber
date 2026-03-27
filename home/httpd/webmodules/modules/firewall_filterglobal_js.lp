<script type="text/javascript">
var cver = <% =env.getenv("CountryCode")%>;
var uRight = <% =session_get(sess_id, "Right")%>;
(function(){
function initial_template_SecurityGlobalCtl(templateID)
{
var template = $("#"+templateID);
template.bind("fillDataByApplyResult", function(event,xml, template){
ActionByApplyResult(xml, template);
});
template.bind("fillDataByCancelResult", function(event,xml, template){
var OBJID = [
"OBJ_FWLEVEL_ID",
"OBJ_FWBASE_ID"
];
ActionByCancelResult(xml, template, OBJID);
});
}
$(document).ready(function(){
var HeadID = "SecurityGlobalCtl";
var Head = $("#"+HeadID);
var templateID = "template_"+ HeadID;
var ServerAddr = $("address span", Head).text();
initial_template_SecurityGlobalCtl(templateID);
if(cver == "41" && uRight != "1"){
$("#macfilter_div").hide();
}
Head.succfunction = function(xml){
var template = $("[id^='template_']",Head);
Head.hasError(xml,"externErrorHint");
var OBJID = [
"OBJ_FWLEVEL_ID",
"OBJ_FWBASE_ID"
];
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
