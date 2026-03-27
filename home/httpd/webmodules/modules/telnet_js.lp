<script type="text/javascript">
(function(){
function setRadio(ElemsObj, dataValue)
{
var radioObj = $("input[type=radio]", ElemsObj);
radioObj.each(function(){
var thisObj = $(this);
if (thisObj.val() == dataValue)
{
thisObj.prop("checked", true);
}
else
{
thisObj.prop("checked", false);
}
});
}
function initial_template_TELNET(templateID)
{
var template = $("#"+templateID);
template.bind("fillDataByApplyResult", function(event,xml, template){
ActionByApplyResult(xml, template);
});
template.bind("fillDataByCancelResult", function(event,xml, template){
var OBJID = ["OBJ_TELNET_ID"];
ActionByCancelResult(xml, template, OBJID);
template.trigger("fillDataByCustom",[0, template]);
});
template.bind("fillDataByCustom", function(event, suffix, ContainerOBJ){
var wanEnable = $("#Wan_Enable",ContainerOBJ).val();
var lanEnable = $("#Lan_Enable",ContainerOBJ).val();
var fakeEnableObj = $("#F_TS_Enable",ContainerOBJ);
var tsEnable = $("#TS_Enable",ContainerOBJ).val();
setRadio(fakeEnableObj, tsEnable);
});
template.bind("hiddenValueChangeByCustom", function(event,template){
var wanEnableObj = $("#Wan_Enable",template);
var lanEnableObj = $("#Lan_Enable",template);
var fakeEnable = $('input:radio[name="F_TS_Enable"]:checked').val();
$("#TS_Enable",template).val(fakeEnable);
wanEnableObj.val(fakeEnable);
lanEnableObj.val(fakeEnable);
});
}
$(document).ready(function(){
var HeadID = "LocalTELNET";
var Head = $("#"+HeadID);
var ServerAddr = $("address span", Head).text();
initial_template_TELNET("template_"+HeadID);
Head.succfunction = function(xml){
var cmapiErrorContainer = $(".errorHint",Head);
if (cmapiErrorContainer.hasError(xml) == 0)
{
var tempobj = $("#template_LocalTELNET");
var OBJID = ["OBJ_TELNET_ID"];
Head.fillDataByOBJID(xml, OBJID, tempobj, 0);
tempobj.trigger("fillDataByCustom",[0, tempobj]);
}
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
