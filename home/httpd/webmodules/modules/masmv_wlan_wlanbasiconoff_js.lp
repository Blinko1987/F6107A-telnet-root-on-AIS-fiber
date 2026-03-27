<script type="text/javascript">
(function() {
var g_xml;
function InitTimeOption(num,id)
{
for(var i=0;i<num;i++)
{
if (i < 10)
{
$("#"+id).append("<option value='"+i+"'>"+'0'+i+"</option>");
}
else
{
$("#"+id).append("<option value='"+i+"'>"+i+"</option>");
}
}
}
function fillData_WlanBasicAdOnOff(template,xml)
{
var OBJID = ["OBJ_WLANTIMECFG_ID","OBJ_WLANTIME_ID"];
template.fillDataByOBJID(xml, OBJID, template, 0);
$("[id^='div_WLANRadioStatus_']", template).each(function(){
$(this).remove();
})
var ruleTemplate = $("#div_WLANRadioStatus",template);
var OBJ = $(xml).find("OBJ_WLANSETTING_ID");
var RuleNum = $("Instance", OBJ).length;
for (var i=0; i<RuleNum; i++)
{
var clone = ruleTemplate.cloneWithSuffix(i, "_");
ruleTemplate.before(clone);
var DataOBJID = ["OBJ_WLANSETTING_ID"];
clone.fillDataByOBJID(xml, DataOBJID, clone, i, "_");
var radioNewName = "&?WlanBasicAd_077; (" + $("[id^='Band']",clone).val()+")";
$("label[for^='RadioStatus_"+i+"']").text(radioNewName);
clone.showIt(true);
}
$("[id^='TimerEnable'][type='radio']:checked",template).click();
}
function initial_template_WlanBasicAdOnOff(templateID)
{
var template = $("#"+templateID);
InitTimeOption(24,"TimeStartHour");
InitTimeOption(60,"TimeStartMin");
InitTimeOption(24,"TimeEndHour");
InitTimeOption(60,"TimeEndMin");
template.bind("fillDataByApplyResult", function(event,xml, template){
ActionByApplyResult(xml, template);
});
template.bind("fillDataByCancelResult", function(event,xml, template){
if (template.hasError(xml) == 0)
{
fillData_WlanBasicAdOnOff(template,xml);
}
});
$("[id^='TimerEnable'][type='radio']",template).each(function(){
var TimerEnableRadio = $(this);
TimerEnableRadio.click(function(){
var WLANRadioStatus = $("#TRCtl_WLANRadioStatus");
var OnTime = $("#TR_OnTime");
if ( $(this).val() == "1" )
{
OnTime.showIt(true);
WLANRadioStatus.showIt(false);
}
else
{
OnTime.showIt(false);
WLANRadioStatus.showIt(true);
}
});
});
$("#Btn_apply_WlanBasicAdConf_Confirm", template).click(function(){
var SmartWifiEnable = getParaValueInXML(g_xml, "OBJ_SMART_WIFI_ID", 0, "SmartWifiEnable");
if(SmartWifiEnable == "1"){
if ($("#RadioStatus1_0",template).is(':checked') || $("#RadioStatus1_1",template).is(':checked'))
{
var msg = "&?wlanbasiconoff_001;";
var confirmLayerOBJ = IniConfirm(msg);
$("#confirmOK",confirmLayerOBJ).unbind("click")
$("#confirmOK",confirmLayerOBJ).bind("click", template, function(event){
$("#Btn_apply_WlanBasicAdConf", template).click();
});
}
}
else
{
$("#Btn_apply_WlanBasicAdConf", template).click();
}
});
}
$(document).ready(function(){
var HeadID = "WlanBasicAdOnOff";
var Head = $("#"+HeadID);
var ServerAddr = $("address span", Head).text();
initial_template_WlanBasicAdOnOff("template_"+HeadID);
Head.succfunction = function(xml){
if (Head.hasError(xml) == 0)
{
g_xml = xml;
var template = $("#template_WlanBasicAdOnOff");
$.publish("/some/softVersionModify", [template]);
fillData_WlanBasicAdOnOff(template,xml);
$.publish("/some/disWlanOption", [template]);
}
};
wlanDisableControl(HeadID);
if ( $(".collapBarWithDataTrans",Head).length <= 0 )
{
Head.dataTransfer(ServerAddr, "GET", Head.succfunction);
}
else
{
initial_collapBarWithDataTrans(Head);
}
});
})();
</script>
