<script type="text/javascript">
(function(){
function Customize_Dslite(paramsOBJ)
{
var ContainerOBJ = paramsOBJ["ContainerOBJ"];
ContainerOBJ.collapsibleInstTitleChange("Tunnel46name");
var objremote = $("[id^='TUN46REMOTEIPAddr']", ContainerOBJ);
if ("::" == objremote.val())
{
objremote.val("");
}
var radioObj = $("[name^='IsHMREMOTEAddrSrc']", ContainerOBJ);
radioObj.each(function(){
$(this).change();
});
if ($("[id^='TUN46WANCViewName']",ContainerOBJ).val() == "")
{
$("[id^='AutoSense']",ContainerOBJ).prop("checked",true);
}
else
{
$("[id^='Manual']",ContainerOBJ).prop("checked",true);
}
$(":radio[name^='Method']",ContainerOBJ).change();
}
function initial_Dslite_Internet(templateID)
{
var template = $("#"+templateID);
template.bind("fillDataByCustom", function(event, suffix, template){
var CustomizeParams = {
"ContainerOBJ":template
};
Customize_Dslite(CustomizeParams);
});
template.bind("fillDataByCancelResult", function(event, xml, template){
var OBJID = ["OBJ_TUNNEL46_ID"];
ActionByCancelResult(xml, template, OBJID);
var CustomizeParams = {
"ContainerOBJ":template
};
Customize_Dslite(CustomizeParams);
});
template.bind("fillDataByApplyResult", function(event, xml, template){
ActionByApplyResult(xml, template, "Tunnel46name");
});
template.bind("hiddenValueChangeByCustom", function(event,template){
var wanObj = $("[id^='TUN46WANCViewName']",template);
if ($("[id^='AutoSense']",template).is(':checked'))
{
wanObj.val("");
}
});
var IPCheckRules = {
"required": true,
"integer": true,
"range":[2,6]
};
template.bind("applyPromptCheckJSON", function(event, template){
var checkJSONTempObj = {
"groups": {
TUN46Localv4Addr: "sub_TUN46Localv4Addr0 sub_TUN46Localv4Addr1 sub_TUN46Localv4Addr2 sub_TUN46Localv4Addr3"
},
"rules": {
"Tunnel46name": {
"utf8": true,
"required": true,
"utf8LengthRange":[1,32]
},
"TUN46REMOTEIPAddr": {
"ASCII": true,
"required": true,
"rangelength":[1,256]
},
"TUN46Localv4Addr": {
"ASCII": true,
"required": true,
"rangelength":[1,32]
},
"TUN46WANCViewName": {
"required": true
},
"sub_TUN46Localv4Addr3":IPCheckRules
},
"messages": {
}
};
var data = {};
data.checkJSONTemp = checkJSONTempObj;
$.callModifier("internetConfig/DSLite", data);
checkJSONTempObj = data.checkJSONTemp;
template.setPromptCheckJSON(checkJSONTempObj, template);
});
$("input[type='radio'][name='Method']", template).change(function(event){
var iTemplate = $(this).parents("[id^='template_']");
var wanRow = $("[id^='Div_TUN46WANCViewName']", iTemplate);
var autoObj = $("[id^='AutoSense']", iTemplate);
if (autoObj.is(':checked'))
{
wanRow.hide();
}
else
{
wanRow.show();
}
});
obj = $("[name^='IsHMREMOTEAddrSrc']", template);
obj.change(function(){
var TypeOBJ = $(this);
var temp = TypeOBJ.parents("[id^='template_']");
var ipojb = $("[id^='Prefix_sub_TUN46REMOTEIPAddr']", temp);
var ipojp = $("[id^='TUN46REMOTEIPAddr']", ipojb);
if ( TypeOBJ.is(':checked'))
{
var value = TypeOBJ.val();
if ("1" == value)
{
ipojb.show();
ipojp.removeClass("PostIgnore");
}
else
{
ipojp.addClass("PostIgnore");
ipojb.hide();
}
}
});
}
$(document).ready(function(){
var HeadID = "Dslite_4in6";
var Head = $("#"+HeadID);
var tempalteID = "template_"+ HeadID;
var ServerAddr = $("address span", Head).text();
initial_Dslite_Internet(tempalteID);
Head.succfunction = function(xml){
Head.hasError(xml,"externErrorHint");
var FWIPOBJ = $(xml).find("OBJ_TUNNEL46_ID");
var RuleNum = $("Instance", FWIPOBJ).length;
var OBJID = ["OBJ_TUNNEL46_ID"];
Head.createPageDataByClone(RuleNum,OBJID,xml);
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
