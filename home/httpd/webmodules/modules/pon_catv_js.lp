<script type="text/javascript">
(function(){
function checkRange(value,min,max)
{
if(value > max || value < min)
{
return false;
}
return true;
}
function g_ChanegeDataByCustom(template)
{
var AOSObj = $("[id^='AOS']", template);
var ParaValue = $("[id^='AgcOffset']", template).val();
if (checkRange(ParaValue,0,127))
AOSObj.val((ParaValue/10.0).toFixed(1));
else if (checkRange(ParaValue,128,255))
AOSObj.val(((ParaValue-256)/10.0).toFixed(1));
}
function initial_template_CATV(templateID)
{
var template = $("#"+templateID);
var instForm = template.find("form");
instForm.validate({
"rules": {
"AOS": {
"required": true,
"number": true,
"range":[-12.8, 12.7]
}
},
"messages": {
}
});
template.bind("fillDataByApplyResult", function(event, xml, template){
ActionByApplyResult(xml, template);
});
template.bind("fillDataByCancelResult", function(event, xml, template){
var OBJID = ["OBJ_PON_CATV_ID"];
ActionByCancelResult(xml, template, OBJID);
g_ChanegeDataByCustom(template);
});
template.bind("hiddenValueChangeByCustom", function(event,template){
var AgcOffsetHiddenObj = $("[id^='AgcOffset']", template);
var AOSVal = $("[id^='AOS']", template).val();
if (checkRange(AOSVal,-0.05,12.7))
AgcOffsetHiddenObj.val(Math.round(AOSVal*10));
else
AgcOffsetHiddenObj.val(Math.round(256 + AOSVal*10));
});
}
$(document).ready(function(){
var HeadID = "CATV";
var Head = $("#"+HeadID);
var ServerAddr = $("address span", Head).text();
var templateID = "template_"+ HeadID;
initial_template_CATV(templateID);
Head.succfunction = function(xml){
var template = $("[id^='template_']",Head);
Head.hasError(xml,"externErrorHint");
var OBJID = ["OBJ_PON_CATV_ID"];
Head.fillDataByOBJID(xml ,OBJID, template,0);
g_ChanegeDataByCustom(template);
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
