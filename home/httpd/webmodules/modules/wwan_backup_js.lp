<script type="text/javascript">
function initial_template_DongleSet(templateID)
{
var template = $("#"+templateID);
$("input:radio[name='Enable']",template).change(function(){
if ($("#Enable1",template).is(':checked'))
{
$("#DelayUpTime_div", template).show();
$("#DelayDownTime_div", template).show();
$("#DelayUpTime", template).removeClass("PostIgnore");
$("#DelayDownTime", template).removeClass("PostIgnore");
}
else
{
$("#DelayUpTime_div", template).hide();
$("#DelayDownTime_div", template).hide();
$("#DelayUpTime", template).addClass("PostIgnore");
$("#DelayDownTime", template).addClass("PostIgnore");
}
});
var instForm = template.find("form");
instForm.validate({
"rules": {
"DelayUpTime": {
"required":true,
"integer": true,
"range": [0,2147483647]
},
"DelayDownTime": {
"required":true,
"integer": true,
"range": [0,2147483647]
}
},
"messages": {
}
});
template.bind("fillDataByApplyResult", function(event,xml, template){
ActionByApplyResult(xml, template);
});
template.bind("fillDataByCancelResult", function(event,xml, template){
var OBJID = ["OBJ_DongleSet_ID"];
ActionByCancelResult(xml, template, OBJID);
template.trigger("fillDataByCustom",[0, template, xml]);
});
template.bind("fillDataByCustom", function(event, suffix, ContainerOBJ, xml){
$("input:radio[name='Enable']",ContainerOBJ).trigger("change");
});
}
$(document).ready(function(){
var HeadID = "DongleSet";
var Head = $("#"+HeadID);
var ServerAddr = $("address span", Head).text();
$("#DongleSetBar").text("&?DongleSet_001_LTE;");
$("[for='Enable']").text("&?DongleSet_002_LTE;");
initial_template_DongleSet("template_"+HeadID);
Head.succfunction = function(xml){
var cmapiErrorContainer = $(".errorHint",Head);
if (cmapiErrorContainer.hasError(xml) == 0)
{
var OBJ = $(xml).find("OBJ_DongleSet_ID");
var RuleNum = $("Instance", OBJ).length;
var tempobj = $("#template_DongleSet");
var OBJID = ["OBJ_DongleSet_ID"];
Head.fillDataByOBJID(xml, OBJID, tempobj, 0);
tempobj.trigger("fillDataByCustom",[0, tempobj, xml]);
}
};
if ( $(".collapBarWithDataTrans",Head).length <= 0 )
{
Head.dataTransfer(ServerAddr, "GET", Head.succfunction);
}
else
{
initial_collapBarWithDataTrans(Head);
}
});
</script>
