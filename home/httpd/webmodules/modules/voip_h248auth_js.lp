<script type="text/javascript">
(function(){
function initial_template(templateID)
{
var template = $("#"+templateID);
template.bind("applyPromptCheckJSON", function(event, template){
var checkJSONTempObj = {
"rules": {
"MD5AuthMGID": {
"rangelength":[0,63]
},
"InitPublicKey": {
"rangelength":[0,63]
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
var OBJID = ["OBJ_VOIPH248MAIN_ID"];
ActionByCancelResult(xml, template, OBJID);
template.trigger("fillDataByCustom",[0, template, xml]);
});
$("[id^='AuthenticationMethID']", template).change(function(){
var subTemplate = $(this).parents("[id^='template_H248Auth']");
var beCtlRows = $(".beCtrl", subTemplate);
if ($(this).val() == "100")
{
beCtlRows.show();
$("input,select", beCtlRows).removeClass("PostIgnore");
$("[id^='MD5AuthMGIDType']", subTemplate).change();
}
else
{
beCtlRows.hide();
$("input,select", beCtlRows).addClass("PostIgnore");
}
});
$("[id^='MD5AuthMGIDType']", template).change(function(){
var subTemplate = $(this).parents("[id^='template_H248Auth']");
var beCtlRow = $("[id^='Row_MD5AuthMGID']", subTemplate);
if ($(this).val() != "2")
{
beCtlRow.hide();
$("input", beCtlRow).addClass("PostIgnore");
}
else
{
beCtlRow.show();
$("input", beCtlRow).removeClass("PostIgnore");
}
});
template.bind("fillDataByCustom", function(event, suffix, template){
$("[id^='AuthenticationMethID']", $(this)).change();
});
}
$(document).ready(function(){
var HeadID = "H248Auth";
var Head = $("#"+HeadID);
var ServerAddr = $("address span", Head).text();
initial_template("template_"+HeadID);
Head.succfunction = function(xml){
Head.hasError(xml,"externErrorHint");
var OBJ = $(xml).find("OBJ_VOIPH248MAIN_ID");
var RuleNum = $("Instance", OBJ).length;
var OBJID = ["OBJ_VOIPH248MAIN_ID"];
Head.createPageDataByClone(RuleNum, OBJID, xml);
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
