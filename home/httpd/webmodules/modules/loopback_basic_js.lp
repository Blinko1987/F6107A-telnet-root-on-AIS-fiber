<script type="text/javascript">
function initial_template_ldBasicHead(templateID)
{
var template = $("#"+templateID);
template.bind("applyPromptCheckJSON", function(event, template){
var checkJSONTempObj = {
"rules": {
"V_Ethertype": {
"required": true,
"HEX": true,
"hexRange":[[0, "80ff"],["8101","ffff"]]
},
"Sendinterval": {
"required": true,
"integer": true,
"range":[100, 1000]
},
"RenewTime": {
"required": true,
"integer": true,
"range":[60, 300]
},
"CheckInterval": {
"required": true,
"integer": true,
"range":[5, 300]
}
},
"messages": {
}
};
template.setPromptCheckJSON(checkJSONTempObj, template);
});
template.bind("fillDataByApplyResult", function(event,xml, template){
ActionByApplyResult(xml, template);
});
template.bind("fillDataByCancelResult", function(event,xml, template){
var OBJID = ["OBJ_LOOPBACK_BASIC_ID"];
ActionByCancelResult(xml, template, OBJID);
template.trigger("fillDataByCustom",[0, template, xml]);
});
template.bind("fillDataByCustom", function(event, suffix, template){
var ethTypeObj = $("[id^='V_Ethertype']", template);
var ethVal = $("[id^='Ethertype']", template).val();
ethTypeObj.val(parseInt(ethVal, 10).toString(16));
});
template.bind("hiddenValueChangeByCustom", function(event,template){
var ethHiddenObj = $("[id^='Ethertype']", template);
var ethVal = $("[id^='V_Ethertype']", template).val();
ethHiddenObj.val(parseInt(ethVal, 16));
});
}
$(document).ready(function(){
var ldBasicHeadID = "LoopbackDetectBasic";
var ldBasicHead = $("#"+ldBasicHeadID);
var ServerAddr = $("address span", ldBasicHead).text();
initial_template_ldBasicHead("template_"+ldBasicHeadID);
ldBasicHead.succfunction = function(xml){
ldBasicHead.hasError(xml,"externErrorHint");
var OBJ = $(xml).find("OBJ_LOOPBACK_BASIC_ID");
var RuleNum = $("Instance", OBJ).length;
var OBJID = ["OBJ_LOOPBACK_BASIC_ID"];
ldBasicHead.createPageDataByClone(RuleNum, OBJID, xml);
};
if ( $(".collapBarWithDataTrans",ldBasicHead).length <= 0 )
{
ldBasicHead.dataTransfer(ServerAddr,
"GET",
ldBasicHead.succfunction);
}
else
{
initial_collapBarWithDataTrans(ldBasicHead);
}
});
</script>
