<script type="text/javascript">
var cver = "<%=env.getenv("CountryCode")%>";
(function () {
function g_ChanegeDataByCustom(xml)
{
var OBJ = $(xml).find("OBJ_WLANWEPKEY_ID");
var instances = $("Instance ", OBJ);
instances.each(function(i){
var inst = $(this);
var step = 0;
inst.find("ParaName").each(function(){
var ParaName = $(this).text();
var ParaValue = $(this).next().text();
if ( ParaName == "_InstID" )
{
var suffix = ParaValue.match(/\d*$/);
var suffix = parseInt(suffix, 10);
suffix--;
step = suffix;
$(this).text("_InstID_WEP"+suffix);
}
if ( ParaName == "WEPKey" )
{
$(this).text("WEPKey0"+step);
}
});
});
var OBJ = $(xml).find("OBJ_WLANPSK_ID");
var instances = $("Instance ", OBJ);
instances.each(function(){
var inst = $(this);
inst.find("ParaName").each(function(){
var ParaName = $(this).text();
if ( ParaName == "_InstID" )
{
$(this).text("_InstID_PSK");
}
});
});
var OBJ = $(xml).find("OBJ_WLANSETTING_ID");
var instances = $("Instance ", OBJ);
instances.each(function(){
var inst = $(this);
inst.find("ParaName").each(function(){
var ParaName = $(this).text();
if ( ParaName == "_InstID" )
{
$(this).text("_InstID_WLANSETTING");
}
});
});
}
function EncryptionTypeAuxCtrlsDisp(ContainerOBJ)
{
var KeyPassphrase = $("[id^='div_KeyPassphrase'],[id^='div_ShowKeyPassphrase']", ContainerOBJ);
var PSKCONIG = $("[id^='_PSKCONIG']", ContainerOBJ);
var WEPKeyZone = $("[id^='div_WEPKey0'],[id^='div_WEPKeyIndex'],[id^='div_ShowWEPKey']", ContainerOBJ);
var WEPCONIG = $("[id^='_WEPCONIG']", ContainerOBJ);
var EncryptionType = $("[id^='EncryptionType']", ContainerOBJ).val();
if ( EncryptionType == "No Security" )
{
KeyPassphrase.hide();
PSKCONIG.val("N");
WEPKeyZone.hide();
WEPCONIG.val("N");
}
else if ( EncryptionType == "WPA-PSK-TKIP"
|| EncryptionType == "WPA2-PSK-AES"
|| EncryptionType == "WPA/WPA2-PSK-TKIP/AES"
|| EncryptionType == "WPA-PSK-AES"
|| EncryptionType == "WPA-PSK-TKIP/AES"
|| EncryptionType == "WPA2-PSK-TKIP"
|| EncryptionType == "WPA2-PSK-TKIP/AES"
|| EncryptionType == "WPA/WPA2-PSK-TKIP"
|| EncryptionType == "WPA/WPA2-PSK-AES" )
{
KeyPassphrase.show();
PSKCONIG.val("Y")
WEPKeyZone.hide();
WEPCONIG.val("N");
}
else if ( EncryptionType == "WEP-OpenSystem"
|| EncryptionType == "WEP-ShareKey" )
{
KeyPassphrase.hide();
PSKCONIG.val("N");
WEPKeyZone.show();
WEPCONIG.val("Y");
}
else
{
}
}
function g_fillDataByCustom_Special(ContainerOBJ)
{
ContainerOBJ.collapsibleInstTitleChange("Band");
var BeaconType = $("[id^='BeaconType']", ContainerOBJ).val();
var WEPAuthMode = $("[id^='WEPAuthMode']", ContainerOBJ).val();
var WPAAuthMode = $("[id^='WPAAuthMode']", ContainerOBJ).val();
var _11iAuthMode = $("[id^='11iAuthMode']", ContainerOBJ).val();
var WPAEncryptType = $("[id^='WPAEncryptType']", ContainerOBJ).val();
var _11iEncryptType = $("[id^='11iEncryptType']", ContainerOBJ).val();
var EncryptionType = $("[id^='EncryptionType']", ContainerOBJ);
if( BeaconType == "None" )
{
EncryptionType.val("No Security");
}
else if ( BeaconType == "Basic" && WEPAuthMode == "None" )
{
EncryptionType.val("WEP-OpenSystem");
}
else if( BeaconType == "Basic" && WEPAuthMode == "SharedAuthentication" )
{
EncryptionType.val("WEP-ShareKey");
}
else if( BeaconType == "WPA" && WPAAuthMode == "PSKAuthentication" )
{
if ( WPAEncryptType == "TKIPEncryption" )
{
EncryptionType.val("WPA-PSK-TKIP");
}
else if(WPAEncryptType == "AESEncryption" )
{
EncryptionType.val("WPA-PSK-AES");
}
else if(WPAEncryptType == "TKIPandAESEncryption" )
{
EncryptionType.val("WPA-PSK-TKIP/AES");
}
}
else if( BeaconType == "11i" && _11iAuthMode == "PSKAuthentication" )
{
if ( _11iEncryptType == "AESEncryption" )
{
EncryptionType.val("WPA2-PSK-AES");
}
else if(_11iEncryptType == "TKIPEncryption")
{
EncryptionType.val("WPA2-PSK-TKIP");
}
else if(_11iEncryptType == "TKIPandAESEncryption")
{
EncryptionType.val("WPA2-PSK-TKIP/AES");
}
}
else if( (BeaconType == "WPAand11i")
&& (WPAAuthMode == "PSKAuthentication")
&& (_11iAuthMode == "PSKAuthentication") )
{
if ( WPAEncryptType == "TKIPEncryption" )
{
EncryptionType.val("WPA/WPA2-PSK-TKIP");
}
else if(WPAEncryptType == "AESEncryption")
{
EncryptionType.val("WPA/WPA2-PSK-AES");
}
else if(WPAEncryptType == "TKIPandAESEncryption")
{
EncryptionType.val("WPA/WPA2-PSK-TKIP/AES");
}
}
else
{
}
EncryptionTypeAuxCtrlsDisp(ContainerOBJ);
}
function g_fillDataByOBJID_Special(xml, template)
{
var suffix = 0;
var SSIDVn = $("[id^='_InstID']", template).val();
OBJID = ["OBJ_WLANWEPKEY_ID"];
var WEP = ["WEP1","WEP2","WEP3","WEP4"];
for ( var WEPTmp in WEP )
{
suffix = getInstIndexByPath(xml, OBJID[0],
SSIDVn+"."+WEP[WEPTmp]);
template.fillDataByOBJID(xml, OBJID, template, suffix);
}
OBJID = ["OBJ_WLANPSK_ID"];
suffix = getInstIndexByPath(xml, OBJID[0], SSIDVn+".PSK1");
template.fillDataByOBJID(xml, OBJID, template, suffix);
OBJID = ["OBJ_WLANSETTING_ID"];
var cardID = $("[id^='WLANViewName']", template).val();
suffix = getInstIndexByPath(xml, OBJID[0], cardID);
template.fillDataByOBJID(xml, OBJID, template, suffix);
}
function initial_template_SSID(templateID)
{
var template = $("#"+templateID);
$("#EncryptionType", template).change(function(){
var template = $(this).parents("[id^='template_']");
EncryptionTypeAuxCtrlsDisp(template);
var enctype = $(this).val()
if ( "WEP-OpenSystem"==enctype || "WEP-ShareKey"==enctype )
{
alert("&?WlanBasicAd_080;");
}
});
template.bind("applyPromptCheckJSON", function(event, template){
var checkJSONTempObj = {
"rules": {
"ESSID": {
"required": true,
"ASCII": true,
"rangelength": [1,32]
},
"WEPKey00": {
"required": true,
"WEPAsciiOrHexLen": true
},
"WEPKey01": {
"required": true,
"WEPAsciiOrHexLen": true
},
"WEPKey02": {
"required": true,
"WEPAsciiOrHexLen": true
},
"WEPKey03": {
"required": true,
"WEPAsciiOrHexLen": true
},
"KeyPassphrase": {
"required": true,
"ASCII": true,
"rangelength": [8, 63]
}
},
"messages": {
}
};
template.setPromptCheckJSON(checkJSONTempObj, template);
});
template.bind("hiddenValueChangeByCustom", function(event, template){
var EncryptionPara = {
"No Security": {
"BeaconType": "none"
},
"WEP-OpenSystem": {
"BeaconType":"Basic",
"WEPAuthMode":"None"
},
"WEP-ShareKey": {
"BeaconType": "Basic",
"WEPAuthMode":"SharedAuthentication"
},
"WPA-PSK-TKIP": {
"BeaconType":"WPA",
"WPAAuthMode":"PSKAuthentication",
"WPAEncryptType":"TKIPEncryption"
},
"WPA-PSK-AES": {
"BeaconType":"WPA",
"WPAAuthMode":"PSKAuthentication",
"WPAEncryptType":"AESEncryption"
},
"WPA-PSK-TKIP/AES": {
"BeaconType":"WPA",
"WPAAuthMode":"PSKAuthentication",
"WPAEncryptType":"TKIPandAESEncryption"
},
"WPA2-PSK-AES": {
"BeaconType":"11i",
"11iAuthMode":"PSKAuthentication",
"11iEncryptType":"AESEncryption"
},
"WPA2-PSK-TKIP": {
"BeaconType":"11i",
"11iAuthMode":"PSKAuthentication",
"11iEncryptType":"TKIPEncryption"
},
"WPA2-PSK-TKIP/AES": {
"BeaconType":"11i",
"11iAuthMode":"PSKAuthentication",
"11iEncryptType":"TKIPandAESEncryption"
},
"WPA/WPA2-PSK-TKIP": {
"BeaconType":"WPAand11i",
"WPAAuthMode":"PSKAuthentication",
"11iAuthMode":"PSKAuthentication",
"WPAEncryptType":"TKIPEncryption",
"11iEncryptType":"TKIPEncryption"
},
"WPA/WPA2-PSK-AES": {
"BeaconType":"WPAand11i",
"WPAAuthMode":"PSKAuthentication",
"11iAuthMode":"PSKAuthentication",
"WPAEncryptType":"AESEncryption",
"11iEncryptType":"AESEncryption"
},
"WPA/WPA2-PSK-TKIP/AES": {
"BeaconType":"WPAand11i",
"WPAAuthMode":"PSKAuthentication",
"11iAuthMode":"PSKAuthentication",
"WPAEncryptType":"TKIPandAESEncryption",
"11iEncryptType":"TKIPandAESEncryption"
}
};
var EncryptionType = $("[id^='EncryptionType']", template).val();
if ( EncryptionPara[EncryptionType] )
{
var EncryptionDataByType = EncryptionPara[EncryptionType];
for ( var Tmp in EncryptionDataByType )
{
$("[id^='"+Tmp+"']", template).val(EncryptionDataByType[Tmp]);
}
}
});
template.bind("fillDataByApplyResult", function(event,xml, template){
ActionByApplyResult(xml, template);
});
template.bind("fillDataByCancelResult", function(event,xml, template){
g_ChanegeDataByCustom(xml);
var OBJID = ["OBJ_WLANAP_ID"];
ActionByCancelResult(xml, template, OBJID);
g_fillDataByOBJID_Special(xml, template);
g_fillDataByCustom_Special(template);
});
$("#ShowWEPKey",template).change(function(event){
var TypeOBJ = $(this);
var ParentObj = TypeOBJ.closest(".formTbl");
var WEPKey00PassObj = $("[id^='WEPKey00'][type='password']",ParentObj);
var WEPKey00TextObj = $("[id^='WEPKey00'][type='text']",ParentObj);
var WEPKey01PassObj = $("[id^='WEPKey01'][type='password']",ParentObj);
var WEPKey01TextObj = $("[id^='WEPKey01'][type='text']",ParentObj);
var WEPKey02PassObj = $("[id^='WEPKey02'][type='password']",ParentObj);
var WEPKey02TextObj = $("[id^='WEPKey02'][type='text']",ParentObj);
var WEPKey03PassObj = $("[id^='WEPKey03'][type='password']",ParentObj);
var WEPKey03TextObj = $("[id^='WEPKey03'][type='text']",ParentObj);
if(TypeOBJ.is(':checked'))
{
$("[id^='WEPKey0'][type='password']",ParentObj).attr("style","display:none");
$("[id^='WEPKey0'][type='password']",ParentObj).attr("class","PostIgnore");
$("[id^='WEPKey0'][type='text']",ParentObj).attr("style","");
$("[id^='WEPKey0'][type='text']",ParentObj).attr("class","inputLong");
WEPKey00TextObj.val(WEPKey00PassObj.val());
WEPKey01TextObj.val(WEPKey01PassObj.val());
WEPKey02TextObj.val(WEPKey02PassObj.val());
WEPKey03TextObj.val(WEPKey03PassObj.val());
}
else
{
$("[id^='WEPKey0'][type='password']",ParentObj).attr("style","width: 330px");
$("[id^='WEPKey0'][type='password']",ParentObj).attr("class","inputNorm valid");
$("[id^='WEPKey0'][type='text']",ParentObj).attr("style","display:none");
$("[id^='WEPKey0'][type='text']",ParentObj).attr("class","PostIgnore");
WEPKey00PassObj.val(WEPKey00TextObj.val());
WEPKey01PassObj.val(WEPKey01TextObj.val());
WEPKey02PassObj.val(WEPKey02TextObj.val());
WEPKey03PassObj.val(WEPKey03TextObj.val());
}
});
$("#ShowKeyPassphrase",template).change(function(event){
var TypeOBJ = $(this);
var ParentObj = TypeOBJ.closest(".formTbl");
var KeyPassphrasePassObj = $("[id^='KeyPassphrase'][type='password']",ParentObj);
var KeyPassphraseTextObj = $("[id^='KeyPassphrase'][type='text']",ParentObj);
if(TypeOBJ.is(':checked'))
{
$("[id^='KeyPassphrase'][type='password']",ParentObj).attr("style","display:none");
$("[id^='KeyPassphrase'][type='password']",ParentObj).attr("class","PostIgnore");
$("[id^='KeyPassphrase'][type='text']",ParentObj).attr("style","");
$("[id^='KeyPassphrase'][type='text']",ParentObj).attr("class","inputLong");
KeyPassphraseTextObj.val(KeyPassphrasePassObj.val());
}
else
{
$("[id^='KeyPassphrase'][type='password']",ParentObj).attr("style","width: 330px");
$("[id^='KeyPassphrase'][type='password']",ParentObj).attr("class","inputNorm valid");
$("[id^='KeyPassphrase'][type='text']",ParentObj).attr("style","display:none");
$("[id^='KeyPassphrase'][type='text']",ParentObj).attr("class","PostIgnore");
KeyPassphrasePassObj.val(KeyPassphraseTextObj.val());
}
});
}
$(document).ready(function(){
var HeadID = "WLANSSIDConf";
var Head = $("#"+HeadID);
var ServerAddr = $("address span", Head).text();
initial_template_SSID("template_"+HeadID);
Head.succfunction = function(xml){
Head.hasError(xml);
g_ChanegeDataByCustom(xml);
var SSIDOBJ = $(xml).find("OBJ_WLANAP_ID");
var RuleNum = $("Instance", SSIDOBJ).length;
var OBJID = ["OBJ_WLANAP_ID"];
Head.fillDataByCustom = undefined;
Head.createPageDataByClone(RuleNum, OBJID, xml,
Head.fillDataByCustom);
for (var i=0; i<RuleNum; i++)
{
var template = $("#template_WLANSSIDConf_"+i);
g_fillDataByOBJID_Special(xml, template);
g_fillDataByCustom_Special(template);
$("[id^='clearPass']", template).click(function(){
var tempobj = $(this).parents("[id^='template']");
$("[id^='KeyPassphrase:']", tempobj).val("");
});
$("[id^='clearPass00']", template).click(function(){
var tempobj = $(this).parents("[id^='template']");
$("[id^='WEPKey00:']", tempobj).val("");
});
$("[id^='clearPass01']", template).click(function(){
var tempobj = $(this).parents("[id^='template']");
$("[id^='WEPKey01:']", tempobj).val("");
});
$("[id^='clearPass02']", template).click(function(){
var tempobj = $(this).parents("[id^='template']");
$("[id^='WEPKey02:']", tempobj).val("");
});
$("[id^='clearPass03']", template).click(function(){
var tempobj = $(this).parents("[id^='template']");
$("[id^='WEPKey03:']", tempobj).val("");
});
var band = $("[id^='Band:']", template).val();
if ( 0 == i )
{
$(".collapsibleInst", template).click();
}
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
var Btn_WLANSSIDConf_Refresh= $("#WLANSSIDConf_Refresh_button", Head);
Btn_WLANSSIDConf_Refresh.unbind("click");
Btn_WLANSSIDConf_Refresh.click(function(){
var HeadID = Head.attr("id");
if ( $("[id^='template_"+HeadID+"_']",Head).length > 0 )
{
Head.find("[id^='template_"+HeadID+"_']").each(function(){
$(this).remove();
});
var ServerAddr = $("address span", Head).text();
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
