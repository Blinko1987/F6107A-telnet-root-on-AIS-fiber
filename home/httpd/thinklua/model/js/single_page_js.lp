<script type="text/javascript">
(function(){
var pageConf = JSON.parse("<%=page.jsInfo%>");
var pageObj = pageConf.objList;
var pageId = pageConf.id;
var controlList = pageConf.pageCtrl.split("+");
var rules = pageConf.rules;
function initial_template(templateID)
{
var template = $("#" + templateID);
var RulesAll = {};
for(let item in rules)
{
let ruleStr = rules[item];
RulesAll[item] = $.parseJSON(ruleStr);
}
var instForm = template.find("form");
instForm.validate({
"rules": RulesAll,
"messages": {
}
});
template.bind("fillDataByApplyResult", function(event, xml, template){
ActionByApplyResult(xml, template);
if(controlList.indexOf("refresh") != -1)
{
top.location.href = top.location.href;
}
});
template.bind("fillDataByCancelResult", function(event, xml, template){
ActionByCancelResult(xml, template, pageObj);
});
$.publish("/some/softVersionModify", [template]);
}
$(document).ready(function(){
var commSingleHeadID = pageId;
var commSingleHead = $("#" + commSingleHeadID);
var commSingleContainer = $("#" + commSingleHeadID + "_container");
var commSingleTemplateID = "template_" + commSingleHeadID;
var ServerAddr = $("address span", commSingleHead).text();
initial_template(commSingleTemplateID);
commSingleHead.succfunction = function(xml){
var cmapiErrorContainer = $(".errorHint", commSingleHead);
if (cmapiErrorContainer.hasError(xml) == 0)
{
commSingleHead.fillDataByOBJID(xml, pageObj, commSingleContainer, 0);
}
};
if(controlList.indexOf("disabled") != -1)
{
disable_all_templte(commSingleTemplateID);
}
if ($(".collapBarWithDataTrans", commSingleHead).length <= 0)
{
commSingleHead.dataTransfer(ServerAddr, "GET", commSingleHead.succfunction);
}
else
{
initial_collapBarWithDataTrans(commSingleHead);
}
});
})();
</script>
