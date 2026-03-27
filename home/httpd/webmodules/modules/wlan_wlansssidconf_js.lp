<script type="text/javascript">
var cver = "<%=CountryCode%>";
var DisableSSID = ssidConf.disableSSID;
(function () {
<%
cgilua_lp.include("../../webmodules/modules/wlan_ssid_comm_js.lp", getfenv(1))
%>
jQuery.validator.addMethod(
"chkKeyPassphrase",
function(value, element)
{
if (value.match("[^0-9a-zA-Z]") != null || value.length < 10)
{
return false;
}
return true;
},
$.validator.format("&?public_error057;")
);
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
}
function EncryptionTypeAuxCtrlsDisp(tempObj)
{
var EncryptionType = $("[id^='EncryptionType']", tempObj).val();
$(".div_MasterAuthServerIP", tempObj).hide();
$(".div_MasterAuthServerPort", tempObj).hide();
$(".div_MasterAuthServerSecret", tempObj).hide();
if ( EncryptionType == "No Security"
|| EncryptionType == "WPA3-OWE")
{
$("[id^='div_KeyPassphrase']", tempObj).hide();
$("[id^='div_WPAGroupRekey']", tempObj).hide();
$("[id^='div_ShowKeyPassphrase']", tempObj).hide();
$("[id^='_PSKCONIG']", tempObj).val("N");
$("[id^='div_WEPKey0']", tempObj).hide();
$("[id^='div_WEPKeyIndex']", tempObj).hide();
$("[id^='div_ShowWEPKey']", tempObj).hide();
$("[id^='_WEPCONIG']", tempObj).val("N");
}
else if ( EncryptionType == "WPA-PSK-TKIP"
|| EncryptionType == "WPA2-PSK-AES"
|| EncryptionType == "WPA/WPA2-PSK-TKIP/AES"
|| EncryptionType == "WPA-PSK-AES"
|| EncryptionType == "WPA-PSK-TKIP/AES"
|| EncryptionType == "WPA2-PSK-TKIP"
|| EncryptionType == "WPA2-PSK-TKIP/AES"
|| EncryptionType == "WPA/WPA2-PSK-TKIP"
|| EncryptionType == "WPA/WPA2-PSK-AES"
|| EncryptionType == "WPA3-SAE"
|| EncryptionType == "WPA/WPA2/WPA3-PSK/SAE"
|| EncryptionType == "WPA2/WPA3-SAE"
|| EncryptionType == "WPA2-PSK-AES/WPA3-SAE-AES")
{
$("[id^='div_KeyPassphrase']", tempObj).show();
$("[id^='div_WPAGroupRekey']", tempObj).show();
$("[id^='div_ShowKeyPassphrase']", tempObj).show();
$("[id^='_PSKCONIG']", tempObj).val("Y")
$("[id^='div_WEPKey0']", tempObj).hide();
$("[id^='div_WEPKeyIndex']", tempObj).hide();
$("[id^='div_ShowWEPKey']", tempObj).hide();
$("[id^='_WEPCONIG']", tempObj).val("N");
}
else if ( EncryptionType == "WEP-OpenSystem"
|| EncryptionType == "WEP-ShareKey" )
{
$("[id^='div_KeyPassphrase']", tempObj).hide();
$("[id^='div_WPAGroupRekey']", tempObj).hide();
$("[id^='div_ShowKeyPassphrase']", tempObj).hide();
$("[id^='_PSKCONIG']", tempObj).val("N");
$("[id^='div_WEPKey0']", tempObj).show();
$("[id^='div_WEPKeyIndex']", tempObj).show();
$("[id^='div_ShowWEPKey']", tempObj).show();
$("[id^='_WEPCONIG']", tempObj).val("Y");
}
else if( EncryptionType == "WPA2-EAP-AES"
|| EncryptionType == "WPA/WPA2-EAP-TKIP/AES"
|| EncryptionType == "WPA-EAP-TKIP")
{
$("[id^='div_KeyPassphrase']", tempObj).hide();
$(".div_MasterAuthServerIP", tempObj).show();
$(".div_MasterAuthServerPort", tempObj).show();
$(".div_MasterAuthServerSecret", tempObj).show();
$("[id^='_PSKCONIG']", tempObj).val("N")
$("[id^='div_WEPKey0']", tempObj).hide();
$("[id^='div_WEPKeyIndex']", tempObj).hide();
$("[id^='div_ShowWEPKey']", tempObj).hide();
$("[id^='_WEPCONIG']", tempObj).val("N");
}
else
{
}
}
function g_fillDataByCustom(suffix, tempObj)
{
var BeaconType = $("[id^='BeaconType']", tempObj).val();
var WEPAuthMode = $("[id^='WEPAuthMode']", tempObj).val();
var WPAAuthMode = $("[id^='WPAAuthMode']", tempObj).val();
var WPA3AuthMode = $("[id^='WPA3AuthMode']", tempObj).val();
var WPA3EncryptType = $("[id^='WPA3EncryptType']", tempObj).val();
var _11iAuthMode = $("[id^='11iAuthMode']", tempObj).val();
var WPAEncryptType = $("[id^='WPAEncryptType']", tempObj).val();
var _11iEncryptType = $("[id^='11iEncryptType']", tempObj).val();
if( BeaconType == "None" )
{
$("[id^='EncryptionType']", tempObj).val("No Security");
}
else if ( BeaconType == "Basic" && WEPAuthMode == "None" )
{
$("[id^='EncryptionType']", tempObj).val("WEP-OpenSystem");
}
else if( BeaconType == "Basic" && WEPAuthMode == "SharedAuthentication" )
{
$("[id^='EncryptionType']", tempObj).val("WEP-ShareKey");
}
else if( BeaconType == "WPA" && WPAAuthMode == "PSKAuthentication" )
{
if ( WPAEncryptType == "TKIPEncryption" )
{
$("[id^='EncryptionType']", tempObj).val("WPA-PSK-TKIP");
}
else if(WPAEncryptType == "AESEncryption" )
{
$("[id^='EncryptionType']", tempObj).val("WPA-PSK-AES");
}
else if(WPAEncryptType == "TKIPandAESEncryption" )
{
$("[id^='EncryptionType']", tempObj).val("WPA-PSK-TKIP/AES");
}
}
else if( BeaconType == "11i" && _11iAuthMode == "PSKAuthentication" )
{
if ( _11iEncryptType == "AESEncryption" )
{
$("[id^='EncryptionType']", tempObj).val("WPA2-PSK-AES");
}
else if(_11iEncryptType == "TKIPEncryption")
{
$("[id^='EncryptionType']", tempObj).val("WPA2-PSK-TKIP");
}
else if(_11iEncryptType == "TKIPandAESEncryption")
{
$("[id^='EncryptionType']", tempObj).val("WPA2-PSK-TKIP/AES");
}
}
else if( (BeaconType == "WPAand11i") && (WPAAuthMode == "PSKAuthentication") && (_11iAuthMode == "PSKAuthentication") )
{
if ( WPAEncryptType == "TKIPEncryption" )
{
$("[id^='EncryptionType']", tempObj).val("WPA/WPA2-PSK-TKIP");
}
else if(WPAEncryptType == "AESEncryption")
{
$("[id^='EncryptionType']", tempObj).val("WPA/WPA2-PSK-AES");
}
else if(WPAEncryptType == "TKIPandAESEncryption")
{
$("[id^='EncryptionType']", tempObj).val("WPA/WPA2-PSK-TKIP/AES");
}
}
else if(BeaconType == "WPAand11i" &&
WPAAuthMode == "EAPAuthentication" &&
_11iAuthMode == "EAPAuthentication" &&
WPAEncryptType == "TKIPandAESEncryption" &&
_11iEncryptType == "TKIPandAESEncryption")
{
$("[id^='EncryptionType']", tempObj).val("WPA/WPA2-EAP-TKIP/AES");
}
else if(BeaconType == "11i" && _11iAuthMode == "EAPAuthentication" && _11iEncryptType == "AESEncryption")
{
$("[id^='EncryptionType']", tempObj).val("WPA2-EAP-AES");
}
else if(BeaconType == "WPA3" && WPA3AuthMode == "OWEAuthentication" && WPA3EncryptType == "AESEncryption")
{
$("[id^='EncryptionType']", tempObj).val("WPA3-OWE");
}
else if(BeaconType == "WPA3" && WPA3AuthMode == "SAEAuthentication" && WPA3EncryptType == "AESEncryption")
{
$("[id^='EncryptionType']", tempObj).val("WPA3-SAE");
}
else if(BeaconType == "WPAand11iandWPA3" && WPAAuthMode == "PSKAuthentication" &&
WPA3AuthMode == "SAEAuthentication" && _11iAuthMode == "PSKAuthentication" &&
WPAEncryptType == "TKIPandAESEncryption" && _11iEncryptType == "TKIPandAESEncryption" &&
WPA3EncryptType == "AESEncryption")
{
$("[id^='EncryptionType']", tempObj).val("WPA/WPA2/WPA3-PSK/SAE");
}
else if(BeaconType == "11iandWPA3" && WPA3AuthMode == "SAEAuthentication" &&
_11iAuthMode == "PSKAuthentication" && _11iEncryptType == "TKIPandAESEncryption" &&
WPA3EncryptType == "AESEncryption")
{
$("[id^='EncryptionType']", tempObj).val("WPA2/WPA3-SAE");
}
else if(BeaconType == "11iandWPA3" && _11iAuthMode == "PSKAuthentication" && WPA3AuthMode == "SAEAuthentication"
&& _11iEncryptType == "AESEncryption" && WPA3EncryptType == "AESEncryption")
{
$("[id^='EncryptionType']", tempObj).val("WPA2-PSK-AES/WPA3-SAE-AES");
}
else if(BeaconType == "WPA" && WPAAuthMode == "EAPAuthentication" && WPAEncryptType == "TKIPEncryption")
{
$("[id^='EncryptionType']", tempObj).val("WPA-EAP-TKIP");
}
else
{
}
EncryptionTypeAuxCtrlsDisp(tempObj);
}
function g_transValueVisableToHidden(template)
{
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
},
"WPA2-EAP-AES": {
"BeaconType": "11i",
"11iAuthMode": "EAPAuthentication",
"11iEncryptType": "AESEncryption"
},
"WPA/WPA2-EAP-TKIP/AES": {
"BeaconType": "WPAand11i",
"WPAAuthMode": "EAPAuthentication",
"11iAuthMode": "EAPAuthentication",
"WPAEncryptType": "TKIPandAESEncryption",
"11iEncryptType": "TKIPandAESEncryption"
},
"WPA3-OWE": {
"BeaconType":"WPA3",
"WPA3AuthMode":"OWEAuthentication",
"WPA3EncryptType":"AESEncryption"
},
"WPA3-SAE": {
"BeaconType":"WPA3",
"WPA3AuthMode":"SAEAuthentication",
"WPA3EncryptType":"AESEncryption"
},
"WPA/WPA2/WPA3-PSK/SAE": {
"BeaconType":"WPAand11iandWPA3",
"WPAAuthMode":"PSKAuthentication",
"11iAuthMode":"PSKAuthentication",
"WPA3AuthMode":"SAEAuthentication",
"WPAEncryptType":"TKIPandAESEncryption",
"11iEncryptType":"TKIPandAESEncryption",
"WPA3EncryptType":"AESEncryption"
},
"WPA2/WPA3-SAE": {
"BeaconType":"11iandWPA3",
"11iAuthMode":"PSKAuthentication",
"WPA3AuthMode":"SAEAuthentication",
"11iEncryptType":"TKIPandAESEncryption",
"WPA3EncryptType":"AESEncryption"
},
"WPA2-PSK-AES/WPA3-SAE-AES": {
"BeaconType":"11iandWPA3",
"11iAuthMode":"PSKAuthentication",
"WPA3AuthMode":"SAEAuthentication",
"11iEncryptType":"AESEncryption",
"WPA3EncryptType":"AESEncryption"
},
"WPA-EAP-TKIP": {
"BeaconType":"WPA",
"WPAAuthMode": "EAPAuthentication",
"WPAEncryptType":"TKIPEncryption"
},
};
var EncryptionType = $("[id^='EncryptionType']", template).val();
if ( EncryptionPara[EncryptionType] )
{
var EncryptionDataByType = EncryptionPara[EncryptionType];
for ( var Tmp in EncryptionDataByType )
{
$("[id^='"+Tmp+"']").val(EncryptionDataByType[Tmp]);
}
}
}
function WLANKeyRemoveAttrValue(template)
{
var keyOBJ = $("[id^='KeyPassphrase']", template);
var keyVal = keyOBJ.val();
keyOBJ.removeAttr("value");
keyOBJ.val(keyVal);
$("input[id^='WEPKey']",template).each(function(){
var WEPKeyVal = $(this).val();
$(this).removeAttr("value");
$(this).val(WEPKeyVal);
});
}
function initial_template_SSID(templateID)
{
var template = $("#"+templateID);
g_WlanEncryptionTypeOptionCtrl(template);
template.bind("hiddenValueChangeByCustom", function(event, template){
g_transValueVisableToHidden(template);
});
template.bind("fillDataByApplyResult", function(event,xml, template){
if (template.hasError(xml) == 0)
{
succHintShow(template);
}
});
template.bind("fillDataByCancelResult", function(event,xml, template){
var isError = template.hasError(xml);
if (isError == 0)
{
var WLANSSIDHeadID = "WLANSSIDConf";
var WLANSSIDHead = $("#"+WLANSSIDHeadID);
g_ChanegeDataByCustom(xml);
var ParaArrayByOBJID = {
"WLANCONFIG": {
"OBJID":["OBJ_WLANAP_ID"],
"InstID":"_InstID"
},
"WLANWEPKEY0": {
"OBJID":["OBJ_WLANWEPKEY_ID"],
"InstID":"_InstID_WEP0"
},
"WLANWEPKEY1": {
"OBJID":["OBJ_WLANWEPKEY_ID"],
"InstID":"_InstID_WEP1"
},
"WLANWEPKEY2": {
"OBJID":["OBJ_WLANWEPKEY_ID"],
"InstID":"_InstID_WEP2"
},
"WLANWEPKEY3": {
"OBJID":["OBJ_WLANWEPKEY_ID"],
"InstID":"_InstID_WEP3"
},
"WLANPSK": {
"OBJID":["OBJ_WLANPSK_ID"],
"InstID":"_InstID_PSK"
}
};
for ( var OBJTmp in ParaArrayByOBJID )
{
var ParaArray = ParaArrayByOBJID[OBJTmp];
var OBJID = ParaArray["OBJID"];
var Inst = $("[id^='"+ParaArray["InstID"]+"']", template).val();
var suffix = getInstIndexByPath(xml, OBJID[0], Inst);
WLANSSIDHead.fillDataByOBJID(xml, OBJID, template, suffix);
}
g_fillDataByCustom(0, template);
WLANKeyRemoveAttrValue(template);
}
});
template.bind("applyPromptCheckJSON", function(event, template){
var ipSegmentCheck = {
"required": true,
"integer": true,
"range": [0, 255]
};
var checkJSONTempObj = {
"groups": {
"MasterAuthServerIp": "sub_MasterAuthServerIp0 sub_MasterAuthServerIp1 sub_MasterAuthServerIp2 sub_MasterAuthServerIp3"
},
"rules": {
"ESSID": {
"required": true,
"ASCII": true,
"rangelength": [1, 32]
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
},
"WPAGroupRekey": {
"required": true,
"integer": true,
"range": [100, 1000]
},
"MaxUserNum": {
"required": true,
"integer": true,
<% if CountryCode=="36" or CountryCode=="85" then %>
"range": [1, 64]
<% elseif CountryCode=="2008" then %>
"range": [0, 32]
<% else %>
"range": [1, 32]
<% end %>
},
"sub_MasterAuthServerIp0": ipSegmentCheck,
"sub_MasterAuthServerIp1": ipSegmentCheck,
"sub_MasterAuthServerIp2": ipSegmentCheck,
"sub_MasterAuthServerIp3": ipSegmentCheck,
"MasterAuthServerPort": {
"required": true
},"MasterAuthServerSecret": {
"required": true
}
},
"messages": {
}
};
$.publish("/some/ctcWlanssidClientModify", [checkJSONTempObj]);
var data={};
data.checkJson = checkJSONTempObj;
data.template=template;
$.callModifier("wlanSSID/ChangePWDRules", data);
template.setPromptCheckJSON(checkJSONTempObj, template);
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
$("[id^='WEPKey0'][type='text']",ParentObj).attr("class","w280");
WEPKey00TextObj.val(WEPKey00PassObj.val());
WEPKey01TextObj.val(WEPKey01PassObj.val());
WEPKey02TextObj.val(WEPKey02PassObj.val());
WEPKey03TextObj.val(WEPKey03PassObj.val());
}
else
{
$("[id^='WEPKey0'][type='password']",ParentObj).attr("style","width: 280px");
$("[id^='WEPKey0'][type='password']",ParentObj).attr("class","inputNorm valid");
$("[id^='WEPKey0'][type='text']",ParentObj).attr("style","display:none");
$("[id^='WEPKey0'][type='text']",ParentObj).attr("class","PostIgnore");
WEPKey00PassObj.val(WEPKey00TextObj.val());
WEPKey01PassObj.val(WEPKey01TextObj.val());
WEPKey02PassObj.val(WEPKey02TextObj.val());
WEPKey03PassObj.val(WEPKey03TextObj.val());
}
});
$("#ShowKeyPassphrase", template).bind("click",function(){
showPass($(this), "KeyPassphrase");
});
$("#ShowMasterAuthServerSecret", template).bind("click",function(){
showPass($(this), "MasterAuthServerSecret");
});
function showPass(srcObj, tObjId){
var TypeOBJ = (srcObj);
var ParentObj = TypeOBJ.closest(".formTbl");
var KeyPassphrasePassObj = $("[id^="+tObjId+"][type='password']",ParentObj);
var KeyPassphraseTextObj = $("[id^="+tObjId+"][type='text']",ParentObj);
if(cver == "96")
{
if(TypeOBJ.attr("src") == "../img/sleeping.png")
{
TypeOBJ.attr("src", "../img/awaking.png");
$("[id^="+tObjId+"][type='password']",ParentObj).hide();
$("[id^="+tObjId+"][type='password']",ParentObj).attr("class","PostIgnore");
$("[id^="+tObjId+"][type='text']",ParentObj).attr("style","border:none;margin:0");
$("[id^="+tObjId+"][type='text']",ParentObj).attr("class","w280");
KeyPassphraseTextObj.val(KeyPassphrasePassObj.val());
}
else
{
TypeOBJ.attr("src", "../img/sleeping.png");
$("[id^="+tObjId+"][type='password']",ParentObj).attr("style","border:none;margin:0");
$("[id^="+tObjId+"][type='password']",ParentObj).attr("class","w280");
$("[id^="+tObjId+"][type='text']",ParentObj).hide();
$("[id^="+tObjId+"][type='text']",ParentObj).attr("class","PostIgnore");
KeyPassphrasePassObj.val(KeyPassphraseTextObj.val());
}
}
else
{
if(TypeOBJ.attr("src") == "../img/sleeping.png")
{
TypeOBJ.attr("src", "../img/awaking.png");
$("[id^="+tObjId+"][type='password']",ParentObj).hide();
$("[id^="+tObjId+"][type='password']",ParentObj).attr("class","PostIgnore");
$("[id^="+tObjId+"][type='text']",ParentObj).attr("class","w280");
$("[id^="+tObjId+"][type='text']",ParentObj).show();
KeyPassphraseTextObj.val(KeyPassphrasePassObj.val());
}
else
{
TypeOBJ.attr("src", "../img/sleeping.png");
$("[id^="+tObjId+"][type='password']",ParentObj).attr("style","width: 280px");
$("[id^="+tObjId+"][type='password']",ParentObj).attr("class","valid");
$("[id^="+tObjId+"][type='text']",ParentObj).hide();
$("[id^="+tObjId+"][type='text']",ParentObj).attr("class","PostIgnore");
KeyPassphrasePassObj.val(KeyPassphraseTextObj.val());
}
}
}
}
$(document).ready(function(){
var WLANSSIDHeadID = "WLANSSIDConf";
var WLANSSIDHead = $("#"+WLANSSIDHeadID);
var ServerAddr = $("address span", WLANSSIDHead).text();
initial_template_SSID("template_"+WLANSSIDHeadID);
WLANSSIDHead.fillDataByCustom = function(suffix, tempObj){
g_fillDataByCustom(suffix, tempObj);
};
WLANSSIDHead.succfunction = function(xml){
WLANSSIDHead.hasError(xml,"externErrorHint");
g_ChanegeDataByCustom(xml);
var SSIDOBJ = $(xml).find("OBJ_WLANAP_ID");
var RuleNum = $("Instance", SSIDOBJ).length;
var OBJID = ["OBJ_GUESTWIFI_ID","OBJ_WLANAP_ID"];
WLANSSIDHead.createPageDataByClone(RuleNum, OBJID, xml,
WLANSSIDHead.fillDataByCustom);
for (var i=0; i<RuleNum; i++)
{
var data={};
data.relatParam = "ESSID";
data.func="";
data.strTips="&?public_174;";
$.callModifier("wlanSSID/StrongChangeTips",data);
new CheckPwdStrengthClass("KeyPassphrase", data.relatParam, "template_WLANSSIDConf_"+i, data.func,data.strTips);
var tempObj = $("#template_WLANSSIDConf_"+i);
var suffix = i + 1;
var Alias = $("[id^='Alias']", tempObj).val();
var band = findBandOfSSID(tempObj, xml);
$("[id^='TitleName']", tempObj).val(Alias+band);
tempObj.collapsibleInstTitleChange("TitleName")
if(cver == "96" && band.indexOf("5G") != -1)
{
$("[id^='EncryptionType'] option[value='WEP-ShareKey']",tempObj).remove();
$("[id^='EncryptionType'] option[value='WEP-OpenSystem']",tempObj).remove();
}
var SSIDVn = $("[id^='_InstID:']", tempObj).val();
OBJID = ["OBJ_WLANWEPKEY_ID"];
var WEP = ["WEP1","WEP2","WEP3","WEP4"];
for ( var WEPTmp in WEP )
{
suffix = getInstIndexByPath(xml, OBJID[0],
SSIDVn+"."+WEP[WEPTmp]);
WLANSSIDHead.fillDataByOBJID(xml, OBJID, tempObj, suffix);
}
OBJID = ["OBJ_WLANPSK_ID"];
suffix = getInstIndexByPath(xml, OBJID[0], SSIDVn+".PSK1");
WLANSSIDHead.fillDataByOBJID(xml, OBJID, tempObj, suffix);
WLANSSIDHead.fillDataByCustom(0, tempObj);
WLANKeyRemoveAttrValue(tempObj);
$("[id^='EncryptionType']", tempObj).change(function(){
var template = $(this).parents("[id^='template']");
EncryptionTypeAuxCtrlsDisp(template);
var enctype = $(this).val()
tipsforNoSecurity = "";
if ( "WEP-OpenSystem"==enctype || "WEP-ShareKey"==enctype )
{
tipsforNoSecurity = "&?WlanBasicAd_080;"
$.publish("/some/iodataWlanssidModifyalert", [tipsforNoSecurity]);
alert(tipsforNoSecurity);
}
if( "No Security"==enctype )
{
tipsforNoSecurity = "&?WlanBasicAd_116;"
$.publish("/some/iodataWlanssidModifyalert", [tipsforNoSecurity]);
alert(tipsforNoSecurity);
}
if( "WPA3-OWE"==enctype)
{
alert("&?WlanBasicAd_117;");
}
});
$("[id^='clearPass']", tempObj).click(function(){
var template = $(this).parents("[id^='template']");
$("[id^='KeyPassphrase:']", template).val("");
});
$("[id^='clearPass00']", tempObj).click(function(){
var template = $(this).parents("[id^='template']");
$("[id^='WEPKey00:']", template).val("");
});
$("[id^='clearPass01']", tempObj).click(function(){
var template = $(this).parents("[id^='template']");
$("[id^='WEPKey01:']", template).val("");
});
$("[id^='clearPass02']", tempObj).click(function(){
var template = $(this).parents("[id^='template']");
$("[id^='WEPKey02:']", template).val("");
});
$("[id^='clearPass03']", tempObj).click(function(){
var template = $(this).parents("[id^='template']");
$("[id^='WEPKey03:']", template).val("");
});
if ( 0 == i )
{
$(".collapsibleInst", tempObj).click();
}
if( DisableSSID != undefined && DisableSSID.indexOf(SSIDVn) != -1)
{
tempObj.find("*").attr("disabled",true);
$("[class^='Button']", tempObj).addClass("disableBtn");
$("[id^='Btn_cancel_'],[id^='Btn_apply_']", tempObj).unbind();
}
}
g_GREHide_SSID(WLANSSIDHead, xml);
g_CtrlSSIDConf(WLANSSIDHead,xml)
if(cver == "96")
{
$("#template_WLANSSIDConf_2").hide();
$("#template_WLANSSIDConf_3").hide();
$("#template_WLANSSIDConf_6").hide();
$("#template_WLANSSIDConf_7").hide();
}
$.publish("/some/softVersionModify", [WLANSSIDHead]);
$.callModifier("wlanSSID/undisplaySSIDConf");
};
if ( $(".collapBarWithDataTrans",WLANSSIDHead).length <= 0 )
{
WLANSSIDHead.dataTransfer(ServerAddr,
"GET",
WLANSSIDHead.succfunction);
}
else
{
initial_collapBarWithDataTrans(WLANSSIDHead);
}
wlanDisableControl(WLANSSIDHeadID);
var Btn_WLANSSIDConf_Refresh= $("#WLANSSIDConf_Refresh_button", WLANSSIDHead);
Btn_WLANSSIDConf_Refresh.unbind("click");
Btn_WLANSSIDConf_Refresh.click(function(){
var WLANSSIDHeadID = WLANSSIDHead.attr("id");
if ( $("[id^='template_"+WLANSSIDHeadID+"_']",WLANSSIDHead).length > 0 )
{
WLANSSIDHead.find("[id^='template_"+WLANSSIDHeadID+"_']").each(function(){
$(this).remove();
});
var ServerAddr = $("address span", WLANSSIDHead).text();
WLANSSIDHead.dataTransfer(ServerAddr,
"GET",
WLANSSIDHead.succfunction,
WLANSSIDHead.failfunction,
false,
false);
}
});
});
})();
</script>
