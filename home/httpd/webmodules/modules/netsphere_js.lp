<script type="text/javascript">
(function(){
function initial_template_NETSPHERE(templateID)
{
var template = $("#"+templateID);
var instForm = template.find("form");
instForm.validate({
"rules": {
"RoamRssiLmt24G": {
"integer": true,
"required": true,
"range":[-110,-40]
},
"RoamRssiLmt5G": {
"integer": true,
"required": true,
"range":[-110,-40]
}
},
"messages": {
}
});
template.bind("fillDataByApplyResult", function(event,xml, template){
ActionByApplyResult(xml, template);
});
template.bind("fillDataByCancelResult", function(event,xml, template){
var OBJID = ["OBJ_MULTIAP_ROAM_ID","OBJ_WLAN_BANDSTEERING_ID"];
ActionByCancelResult(xml, template, OBJID);
});
}
$(document).ready(function(){
var HeadID = "Netsphere";
var Head = $("#"+HeadID);
var ServerAddr = $("address span", Head).text();
initial_template_NETSPHERE("template_"+HeadID);
Head.succfunction = function(xml){
var cmapiErrorContainer = $(".errorHint",Head);
if (cmapiErrorContainer.hasError(xml) == 0)
{
var tempobj = $("#template_Netsphere");
var OBJID = ["OBJ_MULTIAP_ROAM_ID","OBJ_WLAN_BANDSTEERING_ID","OBJ_NETSPHERE_MAP_ID"];
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
