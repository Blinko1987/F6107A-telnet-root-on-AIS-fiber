<script type="text/javascript">
(function(){
function initial_template_NETSPHERE(templateID)
{
var template = $("#"+templateID);
var instForm = template.find("form");
instForm.validate({
"rules": {
"TimeInverval": {
"integer": true,
"required": true,
"range":[1,2147483647]
},
"ReqTimeout": {
"integer": true,
"required": true,
"range":[0,2147483647]
},
"RoamRssiLmt24G": {
"integer": true,
"required": true,
"range":[-110,-40]
},
"RoamRssiLmt5G": {
"integer": true,
"required": true,
"range":[-110,-40]
},
"RssiDelta": {
"integer": true,
"required": true,
"range":[-2147483648,19]
},
"RoamBounceDetectTimeLmt": {
"integer": true,
"required": true,
"range":[1,2147483647]
},
"RoamBounceCountsLmt": {
"integer": true,
"required": true,
"range":[1,2147483647]
},
"RoamBounceDwellTimeLmt": {
"integer": true,
"required": true,
"range":[1,2147483647]
}
},
"messages": {
}
});
template.bind("fillDataByApplyResult", function(event,xml, template){
ActionByApplyResult(xml, template);
});
template.bind("fillDataByCancelResult", function(event,xml, template){
var OBJID = ["OBJ_MGTS_ROAM_ID"];
ActionByCancelResult(xml, template, OBJID);
});
}
$(document).ready(function(){
var HeadID = "ROAM";
var Head = $("#"+HeadID);
var ServerAddr = $("address span", Head).text();
initial_template_NETSPHERE("template_"+HeadID);
Head.succfunction = function(xml){
var cmapiErrorContainer = $(".errorHint",Head);
if (cmapiErrorContainer.hasError(xml) == 0)
{
var tempobj = $("#template_ROAM");
var OBJID = ["OBJ_MGTS_ROAM_ID"];
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
