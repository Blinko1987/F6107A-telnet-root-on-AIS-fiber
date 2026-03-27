<script type="text/javascript">
(function(){
function initial_template_H248Basic(templateID)
{
var template = $("#"+templateID);
template.bind("applyPromptCheckJSON", function(event, template){
var checkJSONTempObj = {
"rules": {
"MGCAddr1": {
"rangelength": [0,63]
},
"MGCAddr2": {
"rangelength": [0,63]
},
"MGMID": {
"rangelength": [0,64]
},
"LocalPort": {
"integer": true,
"required":true,
"range": [1024,65535]
},
"MGCPort1": {
"integer": true,
"required":true,
"range": [1024,65535]
},
"MGCPort2": {
"integer": true,
"required":true,
"range": [1024,65535]
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
$("[id^='MGMIDType']", template).change(function(){
var subTemplate = $(this).parents("[id^='template_']");
var Row_MGMID = $("[id^='Row_MGMID']", subTemplate);
if ($(this).val() == "0")
{
Row_MGMID.hide();
$("input", Row_MGMID).addClass("PostIgnore");
}
else
{
Row_MGMID.show();
$("input", Row_MGMID).removeClass("PostIgnore");
}
});
template.bind("fillDataByCustom", function(event, suffix, template, xml){
$("[id^='MGMIDType']", template).change();
});
}
$(document).ready(function(){
var H248BasicHeadID = "H248Basic";
var H248BasicHead = $("#"+H248BasicHeadID);
var ServerAddr = $("address span", H248BasicHead).text();
initial_template_H248Basic("template_"+H248BasicHeadID);
H248BasicHead.succfunction = function(xml){
H248BasicHead.hasError(xml);
var H248BasicOBJ = $(xml).find("OBJ_VOIPH248MAIN_ID");
var RuleNum = $("Instance", H248BasicOBJ).length;
var OBJID = ["OBJ_VOIPH248MAIN_ID"];
H248BasicHead.createPageDataByClone(RuleNum, OBJID, xml);
};
if ( $(".collapBarWithDataTrans",H248BasicHead).length <= 0 )
{
H248BasicHead.dataTransfer(ServerAddr, "GET", H248BasicHead.succfunction);
}
else
{
initial_collapBarWithDataTrans(H248BasicHead);
}
});
})();
</script>
