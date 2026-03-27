<script type="text/javascript">
(function () {
function initial_template(templateID)
{
var template = $("#"+templateID);
var instForm = template.find("form");
instForm.validate({
"rules": {
"DomainName": {
"ASCII": true,
"rangelength":[0,255]
}
},
"messages": {
}
});
template.bind("fillDataByApplyResult", function(event,xml, template){
ActionByApplyResult(xml, template);
});
template.bind("fillDataByCancelResult", function(event,xml, template){
var OBJID = ["OBJ_DNS_ID"];
ActionByCancelResult(xml, template, OBJID);
});
}
$(document).ready(function(){
var HeadID = "LocalDns";
var Head = $("#"+HeadID);
var ServerAddr = $("address span", Head).text();
initial_template("template_"+HeadID);
Head.chanegeDataByCustom =function(xml){
};
Head.fillDataByCustom = function(suffix,ContainerOBJ){
};
Head.succfunction = function(xml){
var cmapiErrorContainer = $(".errorHint",Head);
if (cmapiErrorContainer.hasError(xml) == 0)
{
Head.chanegeDataByCustom(xml);
var OBJ = $(xml).find("OBJ_DNS_ID");
var RuleNum = $("Instance", OBJ).length;
var tempobj = $("#template_LocalDns");
var OBJID = ["OBJ_DNS_ID"];
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
