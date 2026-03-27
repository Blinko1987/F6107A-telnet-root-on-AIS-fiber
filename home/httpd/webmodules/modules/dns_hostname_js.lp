<script type="text/javascript">
(function () {
function Customize_HostName(paramsOBJ)
{
var ContainerOBJ = paramsOBJ["ContainerOBJ"];
ContainerOBJ.collapsibleInstTitleChange("HostName");
var isDHCPDNS = $("[id^='LeaseTime']", ContainerOBJ).val();
if (isDHCPDNS != "isDNSHOSTInst")
{
$("[id^='OBJID']", ContainerOBJ).val("DHCP");
$("[id^='Btn_apply_HostName']", ContainerOBJ).addClass("disableBtn");
$(".Btn_delete", ContainerOBJ).remove();
}
else
{
$("[id^='OBJID']", ContainerOBJ).val("DNS");
}
}
function initial_template_HostName(templateID)
{
var template = $("#"+templateID);
template.bind("applyPromptCheckJSON", function(event, template){
var checkJSONTempObj = {
"rules": {
"HostName": {
"ASCII": true,
"required": true,
"rangelength":[1,255]
}
},
"messages": {
}
};
template.setPromptCheckJSON(checkJSONTempObj, template);
});
template.bind("fillDataByApplyResult", function(event,xml, template){
ActionByApplyResult(xml, template, "HostName");
});
template.bind("fillDataByCancelResult", function(event,xml, template){
var OBJID = ["OBJ_DNSHOST_ID" ,"OBJ_DNSDHCPHOST_ID"];
ActionByCancelResult(xml, template, OBJID);
template.collapsibleInstTitleChange("HostName");
});
}
$(document).ready(function(){
var HeadID = "HostName";
var Head = $("#"+HeadID);
var ServerAddr = $("address span", Head).text();
initial_template_HostName("template_"+HeadID);
Head.chanegeDataByCustom =function(xml){
};
Head.fillDataByCustom = function(suffix,ContainerOBJ){
var CustomizeParams = {
"ContainerOBJ":ContainerOBJ
};
Customize_HostName(CustomizeParams);
};
Head.succfunction = function(xml){
Head.hasError(xml,"externErrorHint");
var OBJ = $(xml).find("ALLDNSHOST");
var RuleNum = $("Instance", OBJ).length;
var OBJID = ["ALLDNSHOST"];
Head.createPageDataByClone(RuleNum, OBJID, xml, Head.fillDataByCustom);
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
