<script type="text/javascript">
(function(){
function initial_template(templateID)
{
var template = $("#"+templateID);
var instForm = template.find("form");
instForm.validate({
"rules": {
},
"messages": {
}
});
template.bind("fillDataByApplyResult", function(event, xml, template){
ActionByApplyResult(xml, template);
});
template.bind("fillDataByCancelResult", function(event,xml, template){
if ( template.hasError(xml) == 0 )
{
var RuleNum = $("#_InstNum", template).val();
for (var i=0; i<RuleNum; i++)
{
var _InstID = $("[id^='_InstID_']", template).eq(i).val();
var RuleObj = $("[id^='div_MulticastAddressRule_']", template).eq(i);
var DataOBJID = ["OBJ_IGMPADDLIMITUNTAG_ID"];
var suffix = getInstIndexByPath(xml, DataOBJID[0], _InstID);
RuleObj.fillDataByOBJID(xml, DataOBJID, RuleObj, suffix, "_");
RuleObj.trigger("fillDataByCustom",[0, RuleObj]);
}
}
});
}
$(document).ready(function(){
var HeadID = "MulticastAddress";
var Head = $("#"+HeadID);
var templateID = "template_"+HeadID;
var ServerAddr = $("address span", Head).text();
initial_template(templateID);
Head.succfunction = function(xml){
Head.hasError(xml,"externErrorHint");
var OBJ = $(xml).find("OBJ_IGMPADDLIMITUNTAG_ID");
var RuleNum = $("Instance", OBJ).length;
$("#_InstNum", Head).val(RuleNum);
for (var i=0; i<RuleNum; i++)
{
var ruleTemplate = $("#div_MulticastAddressRule");
var clone = ruleTemplate.cloneWithSuffix(i, "_");
ruleTemplate.before(clone);
var DataOBJID = ["OBJ_IGMPADDLIMITUNTAG_ID"];
clone.fillDataByOBJID(xml, DataOBJID, clone, i, "_");
clone.trigger("fillDataByCustom",[i, clone]);
clone.showIt(true);
}
if(RuleNum != 0)
{
$("[id^='MaxNodeNum_']",Head).each(function(){
$(this).rules("add",{
"required":true,
"integer": true,
"range": [1,1024]
});
});
}
$.publish("/some/softVersionModify", [Head]);
$.publish("/some/sncTAHidden", [Head]);
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
