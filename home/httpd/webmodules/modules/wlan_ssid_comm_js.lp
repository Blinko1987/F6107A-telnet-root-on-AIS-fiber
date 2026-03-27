<%
local cjson = require"common_lib.json"
%>
var ssidEncryJson = {};
ssidEncryJson = JSON.parse('<%=cjson.encode(_G.ssidConf["EncryptionType"])%>');
function findBandOfSSID(template, xml)
{
var CardInstID = $("[id^='WLANViewName:']", template).val();
var OBJ = "OBJ_WLANSETTING_ID";
var WLANSettingXML = $(xml).find(OBJ);
var cardInsts = WLANSettingXML.find("Instance");
var cardNum = cardInsts.length;
var band = "";
for ( var i=0; i<cardNum; i++ )
{
var ToOperParaArray = {
"_InstID" : {
ValueOrigin: ""
},
"Band" : {
ValueOrigin: ""
}
};
xmlParaInInstOperate(xml, OBJ, i, ToOperParaArray);
var instid = ToOperParaArray["_InstID"].ValueOrigin;
if ( instid == CardInstID )
{
band = ToOperParaArray["Band"].ValueOrigin;
break;
}
}
if ( band != "" )
{
band = " ("+band+")";
}
return band;
}
function disableSSID(SSIDAlias)
{
var WLANSSIDHeadID = "WLANSSIDConf";
var WLANSSIDHead = $("#"+WLANSSIDHeadID);
WLANSSIDHead.find("[id^='template_"+WLANSSIDHeadID+"_']").each(function(){
var obj = $(this);
if($("[id^='Alias:']",obj).val() == SSIDAlias)
{
obj.find("*").attr("disabled",true);
$("[id^='Btn_apply_WLANSSIDConf:']",obj).addClass("disableBtn");
$("[id^='Btn_cancel_WLANSSIDConf:']",obj).addClass("disableBtn");
return false;
}
});
}
function g_SmartWifi_SSID(xml)
{
}
function g_GREHide_SSID(HeadObj,xml)
{
<%
if _G.ssidConf["GRE"].ssidHide == "true" then
local GREEnable = ""
local APIndex = ""
local greData = cmapi.getinst("OBJ_GRE_ID","IGD")
if greData.IF_ERRORID == 0 then
GREEnable = greData["GREEnable"]
local greIndex = string.gsub(greData.SSIDIfName, "DEV.BRIDGING.BR1.BRPORT", "")
for v in string.gmatch(greIndex, "%d") do
local greIndexNum = _G.tonumber(v) - _G.tonumber(env.getenv("lanSupport")) - 1
APIndex = APIndex .. "DEV.WIFI.AP" .. greIndexNum .. ","
end
end
if GREEnable == "1" then
%>
var indexArr = "<%=APIndex%>".split(",");
$("[id^='template_WLANSSIDConf_']",HeadObj).each(function(){
var instID = $("[id^='_InstID:']", this).val();
if($.inArray(instID, indexArr) != -1)
{
$(this).find("*").remove();
}
});
<%
end
end
%>
}
function getBSCtrl(xml)
{
var BSDisableSSID = "";
var BSEnable = getParaValueInXML(xml, "OBJ_MAP_MASTER_ID", 0, "EnBandSteer");
if(BSEnable == "1")
{
BSDisableSSID = "<%=_G.ssidConf["BSDisableSSID"]%>";
}
return BSDisableSSID;
}
function g_CtrlSSIDConf(HeadObj,xml)
{
var ctrlStr = "";
var ctrFlag = "";
if(ssidConf.disableSSID != undefined)
{
ctrlStr = ssidConf.disableSSID;
}
else
{
ctrlStr = getBSCtrl(xml);
}
if(ctrlStr == "")
{
return;
}
if(ctrlStr.indexOf(":") != -1)
{
var ruleList = ctrlStr.split(":");
ctrlStr = ruleList[0];
ctrFlag = ruleList[1];
}
var DisableSSIDArr = ctrlStr.split(",");
$("[id^='template_WLANSSIDConf_']", HeadObj).each(function(){
if(ctrlStr == "all" || DisableSSIDArr.includes($("[id^='_InstID:']", this).val()))
{
$(this).find("*").attr("disabled",true);
$("[class^='Button']", this).addClass("disableBtn");
$("[id^='Btn_cancel_'],[id^='Btn_apply_']", this).unbind();
if(ctrFlag == "hideBtn")
{
$("[id^='Btn_cancel_'],[id^='Btn_apply_']", this).showIt(false);
}
}
});
}
function g_WlanEncryptionTypeOptionCtrl(template)
{
var EncryptionTypeOBJ = $("#EncryptionType", template);
if ((ssidEncryJson=="") || (typeof ssidEncryJson!='object')) {
return;
}
EncryptionTypeOBJ.empty();
var value2Name = {
"No Security" : "&?public_059;",
"WPA2-PSK-AES" : "&?WlanBasicAd_062;",
"WPA/WPA2-PSK-TKIP/AES" : "&?WlanBasicAd_063;",
"WPA-PSK-TKIP" : "&?WlanBasicAd_061;",
"WPA-PSK-AES" : "&?WlanBasicAd_082;",
"WPA-PSK-TKIP/AES" : "&?WlanBasicAd_083;",
"WPA2-PSK-TKIP" : "&?WlanBasicAd_084;",
"WPA2-PSK-TKIP/AES" : "&?WlanBasicAd_081;",
"WPA/WPA2-PSK-AES" : "&?WlanBasicAd_086;",
"WPA/WPA2-PSK-TKIP" : "&?WlanBasicAd_085;",
"WEP-OpenSystem" : "&?WlanBasicAd_064;",
"WEP-ShareKey" : "&?WlanBasicAd_065;",
"WPA-EAP-TKIP" : "&?WlanBasicAdProduct_013;",
"WPA2-EAP-AES" : "&?WlanBasicAd_102;",
"WPA/WPA2-EAP-TKIP/AES" : "&?WlanBasicAd_103;",
"WPA2-PSK-AES/WPA3-SAE-AES" : "&?WlanBasicAd_148;",
"WPA2/WPA3-SAE" : "&?WlanBasicAd_126;",
"WPA3-SAE" : "&?WlanBasicAd_124;",
"WPA3-OWE" : "&?WlanBasicAd_123;",
"WPA/WPA2/WPA3-PSK/SAE" : "&?WlanBasicAd_125;"
}
for(var i=0; i<ssidEncryJson.length; i++){
EncryStr = ssidEncryJson[i];
var EncryList = EncryStr.split(":");
if(EncryList[1] == undefined) {
EncryList[1] = "";
}
if(checkRight(EncryList[1]) == false){
continue;
}
var langStr = value2Name[EncryList[0]];
var optionStr = "<option value ='"+EncryList[0]+"' title='"+langStr+"'>"+langStr+"</option>";
EncryptionTypeOBJ.append(optionStr);
}
}
