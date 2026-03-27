<script type="text/javascript">
(function(){
function Customize_SipIf(paramsOBJ)
{
var ContainerOBJ = paramsOBJ["ContainerOBJ"];
var WCObj = $("[id^='WanConn']", ContainerOBJ);
WCObj.change();
var MWCObj = $("[id^='S_MediaWanConn']", ContainerOBJ);
var hiddenMWCVal = $("[id^='MediaWanConn']", ContainerOBJ).val();
if (hiddenMWCVal != "")
{
MWCObj.val(hiddenMWCVal);
}
}
function initial_template_SipIf(templateID)
{
var template = $("#"+templateID);
var WCName = "&?SipIf_003;";
template.find("label[for='WanConn']").text(WCName);
$("[id^='WanConn']", template).change(function(event,template){
var subTemplate = $(this).parents("[id^='template_SipIf']");
var WCObj = $(this);
var WCVal = WCObj.val();
var WCOptions = WCObj.find("option");
var WCIpmode = WCObj.find("option:selected").attr("IPMode");
var MWCObj = $("[id^='S_MediaWanConn']", subTemplate);
MWCObj.empty();
var anyOption = $("<option>").val("").text("&?public_039;");
MWCObj.append(anyOption);
WCOptions.each(function(){
var thisOption = $(this);
var ipmode = thisOption.attr("IPMode");
var val = thisOption.val();
var txt = thisOption.text();
if ( (WCIpmode == 0 && txt != "Any")
|| (WCIpmode != 0 && WCVal == val)
|| (ipmode == 1 && WCIpmode ==1)
|| (ipmode == 2 && WCIpmode ==2))
{
var mwcOption = $("<option>").val(val).text(txt);
MWCObj.append(mwcOption);
}
});
MWCObj.hide().show();
});
template.bind("fillDataByApplyResult", function(event, xml, template){
ActionByApplyResult(xml, template);
});
template.bind("fillDataByCancelResult", function(event, xml, template){
var OBJID = ["OBJ_VOIPBEARINFO_ID"];
ActionByCancelResult(xml, template, OBJID);
var CustomizeParams = {
"ContainerOBJ":template
};
Customize_SipIf(CustomizeParams);
});
template.bind("hiddenValueChangeByCustom", function(event,template){
var MWCVal = $("[id^='S_MediaWanConn']",template).val();
$("[id^='MediaWanConn']",template).val(MWCVal);
});
template.bind("fillDataByCustom", function(event, suffix, ContainerOBJ, xml){
var CustomizeParams = {
"ContainerOBJ":ContainerOBJ
};
Customize_SipIf(CustomizeParams);
});
}
$(document).ready(function(){
var HeadID = "SipIf";
var Head = $("#"+HeadID);
var TempalteID = "template_"+ HeadID;
var ServerAddr = $("address span", Head).text();
initial_template_SipIf(TempalteID);
Head.succfunction = function(xml){
Head.hasError(xml,"externErrorHint");
var OBJ = $(xml).find("OBJ_VOIPBEARINFO_ID");
var RuleNum = $("Instance", OBJ).length;
var OBJID = ["OBJ_VOIPBEARINFO_ID"];
Head.createPageDataByClone(RuleNum, OBJID, xml);
};
initial_collapBarWithDataTrans(Head);
});
})();
</script>
