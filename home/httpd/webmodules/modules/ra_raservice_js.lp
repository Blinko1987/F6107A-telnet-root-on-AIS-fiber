<script type="text/javascript">
(function () {
function initial_template_RAService(templateID)
{
var template = $("#"+templateID);
var instForm = template.find("form");
instForm.validate({
"rules": {
"MinRtrAdvInterval": {
"required": true,
"integer": true,
"range":[3, 1350],
"extremumRange":["lessThan","MaxRtrAdvInterval"]
},
"MaxRtrAdvInterval": {
"required": true,
"integer": true,
"range":[4, 1800],
"extremumRange":["greatThan","MinRtrAdvInterval"]
},
"S_AdvLinkMTU": {
"required": true,
"integer": true,
"range":[1280, 1500]
}
},
"messages": {
}
});
$("[id^='AdvLinkMTUEnable'][type='radio']",template).each(function(){
$(this).click(function(){
var radioChangeOBJ = $(this);
var ContainerOBJ = radioChangeOBJ.parents("[id^='template_']");
var divLinkMTU = $("[id^='div_S_AdvLinkMTU']", ContainerOBJ);
var PeriodicInformIntervalOBJ = $("#PeriodicInformInterval", ContainerOBJ);
if ( radioChangeOBJ.val() == "1" )
{
divLinkMTU.showIt(true);
}
else
{
divLinkMTU.showIt(false);
}
})
});
var Btn_PrefixUpd = $("#Btn_PrefixUpd_RAService", template);
Btn_PrefixUpd.unbind("click");
Btn_PrefixUpd.click(function(){
var PrefixPoolHead = $("#PrefixPool");
var SelfHead = $(this).parents(".HeadDIV");
var ManualPrefixes = $("#ManualPrefixes", SelfHead).val();
$("#Btn_PrefixPool", PrefixPoolHead).trigger("click",[ManualPrefixes]);
var PrefixContent = $("#PrefixPool_container",PrefixPoolHead).html();
$("#RAPrefixZone",SelfHead).html(PrefixContent);
var container = $("#RAPrefixZone",SelfHead);
var instances = $("[id^='template_PrefixPool_']", container);
instances.each(function(){
var templateObj = $(this);
var isStaticPrefix = $("[id^='isStaticPrefix:']", templateObj).val();
var PrefixLen = $("[id^='PrefixLen:']", templateObj).val();
if ( isStaticPrefix == "1" && PrefixLen != "64" )
{
templateObj.remove();
}
})
colorTblRow(".colorTbl", "even", container);
});
$("[id^='PrefixMode:']",template).change(function(){
var template = $("#template_RAService");
var PrefixModeVal = $(this).val();
var PrefixModeTrans = {
"Auto" : false,
"Manual" : true
};
if( PrefixModeTrans[PrefixModeVal] == undefined )
{
PrefixModeVal = "Auto";
}
$("#RAPrefixZone",template).showIt(PrefixModeTrans[PrefixModeVal]);
});
template.bind("hiddenValueChangeByCustom", function(event,template){
var PrefixMode = $("[id^='PrefixMode:']",template).val();
var IsPrefixAutoModeOBJ = $("[id^='IsPrefixAutoMode']",template);
var ManualPrefixesOBJ = $("[id^='ManualPrefixes']",template);
var PrefixModeTrans = {
"Auto" : {"IsPrefixAutoMode" : 1, "ManualPrefixesOBJ": false},
"Manual" : {"IsPrefixAutoMode" : 0, "ManualPrefixesOBJ": true}
};
IsPrefixAutoModeOBJ.val(PrefixModeTrans[PrefixMode]["IsPrefixAutoMode"]);
if (PrefixModeTrans[PrefixMode]["ManualPrefixesOBJ"])
{
ManualPrefixesOBJ.removeClass("PostIgnore");
var RAPrefixZone = $("#RAPrefixZone",template);
var PrefixChosedArr = [];
var PrefixChosedNum = 0;
$("[id^='template_PrefixPool_']",RAPrefixZone).each(function(){
var PrefixPool = $(this);
var IsDelegation = $("[id^='IsDelegation']",PrefixPool);
var InstViewName = $("[id^='PrefixPoolInst']",PrefixPool).val();
if (IsDelegation.is(':checked'))
{
PrefixChosedArr[PrefixChosedNum] = InstViewName;
PrefixChosedNum = PrefixChosedNum + 1;
}
});
var PrefixChosedStr = PrefixChosedArr.join(",");
ManualPrefixesOBJ.val(PrefixChosedStr);
}
else
{
ManualPrefixesOBJ.addClass("PostIgnore");
}
});
template.bind("fillDataByCustom", function(event, suffix, ContainerOBJ, xml){
var IANAEnable = $("[id^='IANAEnable']",ContainerOBJ).val();
var IANAManualPrefixes = $("[id^='ManualPrefixes']",ContainerOBJ).val();
var PrefixModeOBJ = $("[id^='PrefixMode:']",ContainerOBJ);
var PrefixModeTrans = {
"Auto" : {"ManualPreResult" : (IANAManualPrefixes == "")},
"Manual" : {"ManualPreResult" : (IANAManualPrefixes != "")}
};
for (var PrefixMode in PrefixModeTrans)
{
if (PrefixModeTrans[PrefixMode]["ManualPreResult"])
{
PrefixModeOBJ.val(PrefixMode);
break;
}
}
$("[id^='PrefixMode:']",ContainerOBJ).change();
$("#Btn_PrefixUpd_RAService", ContainerOBJ).click();
$("[name='AdvLinkMTUEnable']:checked", ContainerOBJ).click();
});
template.bind("fillDataByApplyResult", function(event,xml, template){
if (ActionByApplyResult(xml, template) == 0)
{
var OBJID = ["OBJ_RAIS_ID"];
ActionByCancelResult(xml, template, OBJID);
template.trigger("fillDataByCustom",[0,template]);
}
});
template.bind("fillDataByCancelResult", function(event,xml, template){
var OBJID = ["OBJ_RAIS_ID"];
ActionByCancelResult(xml, template, OBJID);
template.trigger("fillDataByCustom",[0,template]);
});
}
$(document).ready(function(){
var HeadID = "RAService";
var Head = $("#"+HeadID);
var templateID = "template_"+ HeadID;
var ServerAddr = $("address span", Head).text();
initial_template_RAService(templateID);
Head.succfunction = function(xml){
var HeadID = Head.attr("id");
var template = $("[id^='template_"+HeadID+"']",Head);
Head.hasError(xml,"externErrorHint");
var OBJID = ["OBJ_RAIS_ID"];
Head.fillDataByOBJID(xml ,OBJID, template,0);
template.trigger("fillDataByCustom",[0,template]);
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
var Btn_SelfUpd = $("#Btn_SelfUpd_RAService", Head);
Btn_SelfUpd.unbind("click");
Btn_SelfUpd.click(function(){
var ServerAddr = $("address span", Head).text();
if ( $(".collapBarWithDataTrans",Head).length > 0
&& $("#DataHasBeenGot",Head).val() == 0)
{
}
else
{
Head.dataTransfer(ServerAddr,
"GET",
Head.succfunction,
Head.failfunction,
false,
false);
}
});
});
})();
</script>
