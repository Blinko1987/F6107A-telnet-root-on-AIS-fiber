<script type="text/javascript">
(function(){
jQuery.validator.addMethod(
"PLFormat",
function(value, element, params)
{
if ( this.optional(element) )
{
return "dependency-mismatch";
}
if (null != value.match(/[^01\/.: ]/))
{
return false;
}
return true;
},
jQuery.validator.format("&?PortLocate_009;")
);
function initial_template(templateID)
{
var template = $("#"+templateID);
<%
if env.getenv("CountryCode") ~= "4" then
%>
template.bind("applyPromptCheckJSON", function(event, template){
var checkJSONTempObj = {
"rules": {
"PortLocateFormat": {
"required": true,
"rangelength":[1, 60],
"PLFormat": true
}
},
"messages": {
}
};
var data={};
data.checkJson = checkJSONTempObj;
data.template=template;
$.callModifier("PortLocate/ChangePLFRules", data);
template.setPromptCheckJSON(checkJSONTempObj, template);
});
<%
end
%>
template.bind("fillDataByApplyResult", function(event,xml, template){
ActionByApplyResult(xml, template);
});
template.bind("fillDataByCancelResult", function(event,xml, template){
var OBJID = ["OBJ_PORTLOCATE_ID"];
ActionByCancelResult(xml, template, OBJID);
template.trigger("fillDataByCustom",[0, template, xml]);
});
<%
if env.getenv("CountryCode") ~= "4" then
%>
$("[id^='PortLocateFormatSelect']", template).change(function(){
var subTemplate = $(this).parents("[id^='template_PortLocate']");
var beCtlRows = $(".beCtrl", subTemplate);
if ($(this).val() == "")
{
beCtlRows.show();
}
else
{
beCtlRows.hide();
}
});
template.bind("fillDataByCustom", function(event, suffix, template){
var formatVal = $("[id^='PortLocateFormat\\:']", template).val();
var selectObj = $("[id^='PortLocateFormatSelect']", template);
var findOption = 0;
$("option", selectObj).each(function(){
var OptionObj = $(this);
OptionObj.removeAttr("selected");
if (OptionObj.val() == formatVal)
{
findOption = 1;
selectObj.val(formatVal);
return false;
}
});
selectObj.change();
selectObj.attr("disabled", "disabled");
});
template.bind("hiddenValueChangeByCustom", function(event,template){
var selVal = $("[id^='PortLocateFormatSelect']", template).val();
var plFormatObj = $("[id^='PortLocateFormat\\:']", template);
if (selVal != "")
{
plFormatObj.val(selVal);
}
});
<%
end
%>
}
$(document).ready(function(){
var HeadID = "PortLocate";
var Head = $("#"+HeadID);
var ServerAddr = $("address span", Head).text();
initial_template("template_"+HeadID);
Head.succfunction = function(xml){
Head.hasError(xml,"externErrorHint");
var OBJ = $(xml).find("OBJ_PORTLOCATE_ID");
var RuleNum = $("Instance", OBJ).length;
var OBJID = ["OBJ_PORTLOCATE_ID"];
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
