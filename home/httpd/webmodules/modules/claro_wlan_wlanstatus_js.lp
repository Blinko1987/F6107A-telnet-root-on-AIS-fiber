<script type="text/javascript">
(function () {
$(document).ready(function(){
var WLANStatusHeadID = "WLANStatus";
var WLANStatusHead = $("#"+WLANStatusHeadID);
var WLANStatusServerAddr = $("address span", WLANStatusHead).text();
var template = $("#template_"+ WLANStatusHeadID);
template.bind("fillDataByClearResult",function(event, xml, template){
$("#WLANStatus_Btn_refresh").click();
});
$("#WLANStatus_Btn_clear", WLANStatusHead).bind("click",{templateOBJ:template}, function(event){
var buttonOBJ = $(this);
var template = event.data.templateOBJ;
var action = "WLAN_CLEAR";
dataPost(action, "fillDataByClearResult", WLANStatusServerAddr, template);
});
WLANStatusHead.succfunction = function(xml){
WLANStatusHead.findBandOfSSID = function(template, xml)
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
WLANStatusHead.fillDataByCustom = function(suffix,ContainerOBJ){
var ssidOBJ = ContainerOBJ.find("[id^='_InstID']");
var Alias = $("[id^='Alias']", ContainerOBJ).val();
var band = WLANStatusHead.findBandOfSSID(ContainerOBJ, xml);
ssidOBJ.text(Alias+band);
ssidOBJ.attr("title", ssidOBJ.text());
var enabelOBJ = ContainerOBJ.find("[id^='Enable']");
var enaValue = enabelOBJ.text();
if (enaValue == 1)
{
enabelOBJ.text("&?public_033;");
enabelOBJ.attr("title", "&?public_033;");
}
else
{
enabelOBJ.text("&?public_034;");
enabelOBJ.attr("title", "&?public_034;");
}
var beaconTypeOBJ = $("[id^='BeaconType']", ContainerOBJ);
var WPAAuthMode = $("[id^='WPAAuthMode']",ContainerOBJ);
var _11iAuthMode = $("[id^='11iAuthMode']",ContainerOBJ);
var WPAEncryptType = $("[id^='WPAEncryptType']",ContainerOBJ);
var _11iEncryptType = $("[id^='11iEncryptType']",ContainerOBJ);
var WPA3AuthMode = $("[id^='WPA3AuthMode']",ContainerOBJ);
var WPA3AuthModeVal = WPA3AuthMode.val();
var beaconTypeVal = beaconTypeOBJ.text();
var WPAAuthModeVal = WPAAuthMode.val();
var _11iAuthModeVal = _11iAuthMode.val();
var WPAEncryptTypeVal = WPAEncryptType.val();
var _11iEncryptTypeVal = _11iEncryptType.val();
var WEPAuthMode = $("[id^='WEPAuthMode']",ContainerOBJ).val();
switch (beaconTypeVal)
{
case "Basic":
{
if(WEPAuthMode == "None")
{
beaconTypeVal = "&?WlanBasicAd_064;";
}
else if(WEPAuthMode == "SharedAuthentication")
{
beaconTypeVal = "&?WlanBasicAd_065;";
}
break;
}
case "WPA":
{
if(WPAEncryptTypeVal == "TKIPEncryption")
{
beaconTypeVal = "&?WlanBasicAd_061;";
}
else if(WPAEncryptTypeVal == "AESEncryption")
{
beaconTypeVal = "&?WlanBasicAd_082;";
}
else if(WPAEncryptTypeVal == "TKIPandAESEncryption")
{
beaconTypeVal = "&?WlanBasicAd_083;";
}
break;
}
case "11i":
{
if(_11iAuthModeVal == "EAPAuthentication" && _11iEncryptTypeVal == "AESEncryption")
{
beaconTypeVal = "&?WlanBasicAd_102;";
}
else if(_11iAuthModeVal == "PSKAuthentication" && _11iEncryptTypeVal == "AESEncryption")
{
beaconTypeVal = "&?WlanBasicAd_062;";
}
else if(_11iAuthModeVal == "PSKAuthentication" && _11iEncryptTypeVal == "TKIPEncryption")
{
beaconTypeVal = "&?WlanBasicAd_084;";
}
else if(_11iAuthModeVal == "PSKAuthentication" && _11iEncryptTypeVal == "TKIPandAESEncryption")
{
beaconTypeVal = "&?WlanBasicAd_081;";
}
break;
}
case "WPAand11i":
{
if(WPAAuthModeVal == "EAPAuthentication" &&
_11iAuthModeVal == "EAPAuthentication" &&
WPAEncryptTypeVal == "TKIPandAESEncryption" &&
_11iEncryptTypeVal == "TKIPandAESEncryption")
{
beaconTypeVal = "&?WlanBasicAd_103;";
}
else if (WPAAuthModeVal == "PSKAuthentication" && _11iAuthModeVal == "PSKAuthentication")
{
if(WPAEncryptTypeVal == "TKIPandAESEncryption" && _11iEncryptTypeVal == "TKIPandAESEncryption")
{
beaconTypeVal = "&?WlanBasicAd_063;";
}
else if(WPAEncryptTypeVal == "TKIPEncryption" && _11iEncryptTypeVal == "TKIPEncryption")
{
beaconTypeVal = "&?WlanBasicAd_085;";
}
else if(WPAEncryptTypeVal == "AESEncryption" && _11iEncryptTypeVal == "AESEncryption")
{
beaconTypeVal = "&?WlanBasicAd_086;";
}
}
break;
}
case "WPA3":
{
if(WPA3AuthModeVal == "OWEAuthentication")
{
beaconTypeVal = "WPA3-OWE";
}
else if(WPA3AuthModeVal == "SAEAuthentication")
{
beaconTypeVal = "WPA3-SAE";
}
break;
}
case "WPAand11iandWPA3":
{
if(WPA3AuthModeVal == "SAEAuthentication")
{
beaconTypeVal = "WPA/WPA2/WPA3-PSK/SAE";
}
break;
}
case "11iandWPA3":
{
if(WPA3AuthModeVal == "SAEAuthentication")
{
beaconTypeVal = "WPA2/WPA3-SAE";
}
break;
}
case "None":
default:
{
beaconTypeVal = "&?public_059;";
break;
}
}
beaconTypeOBJ.text(beaconTypeVal);
beaconTypeOBJ.attr("title", beaconTypeVal);
var TotalPacketsReceived = $("[id^='TotalPacketsReceived']", ContainerOBJ).val();
var TotalPacketsSent = $("[id^='TotalPacketsSent']", ContainerOBJ).val();
var TotalPacketsCount = TotalPacketsReceived+"/"+TotalPacketsSent;
var tpcObj = $("[id^='TotalPacketsCount']", ContainerOBJ);
tpcObj.text(TotalPacketsCount);
tpcObj.attr("title", TotalPacketsCount);
var TotalBytesReceived = $("[id^='TotalBytesReceived']", ContainerOBJ).val();
var TotalBytesSent = $("[id^='TotalBytesSent']", ContainerOBJ).val();
var TotalBytesCount = TotalBytesReceived+"/"+TotalBytesSent;
var tbcObj = $("[id^='TotalBytesCount']", ContainerOBJ);
tbcObj.text(TotalBytesCount);
tbcObj.attr("title", TotalBytesCount);
};
WLANStatusHead.hasError(xml,"externErrorHint");
var SSIDOBJ = $(xml).find("OBJ_WLANAP_ID");
var RuleNum = $("Instance", SSIDOBJ).length;
var OBJID = ["OBJ_WLANAP_ID", "OBJ_WLANCONFIGDRV_ID"];
WLANStatusHead.createPageDataByClone(RuleNum,OBJID,xml,WLANStatusHead.fillDataByCustom);
WLANStatusHead.fillDataOfCard = function(clone, xml) {
var location = $("[id^='"+ name + "']", clone);
var CardInstID = $("[id^='_InstID_']", clone).val();
var OBJ = "OBJ_WLANCONFIGDRV_ID";
var driverInsts = $(xml).find("OBJ_WLANCONFIGDRV_ID").find("Instance");
var driverInstNum = driverInsts.length;
var ChannelInUsed;
var RealRF;
for ( var i=0; i<driverInstNum; i++ )
{
var ToOperParaArray = {
"WLANViewName" : { ValueOrigin: "" },
"RealRF" : { ValueOrigin: "" },
"ChannelInUsed" : { ValueOrigin: "" }
};
xmlParaInInstOperate(xml, OBJ, i, ToOperParaArray);
var instid = ToOperParaArray["WLANViewName"].ValueOrigin;
if ( instid == CardInstID )
{
ChannelInUsed = ToOperParaArray["ChannelInUsed"].ValueOrigin;
RealRF = ToOperParaArray["RealRF"].ValueOrigin;
break;
}
}
if (ChannelInUsed == "0")
{
ChannelInUsed = "&?public_142;";
}
var ciuObj = $("[id^='ChannelInUsed_']", clone);
ciuObj.text(ChannelInUsed);
ciuObj.attr("title", ChannelInUsed);
if ( RealRF == "1" )
{
RealRF = "&?public_033;";
}
else
{
RealRF = "&?public_034;";
}
var rfObj = $("[id^='RealRF_']", clone);
rfObj.text(RealRF);
rfObj.attr("title", RealRF);
};
if (WLANStatusHead.hasError(xml) == 0)
{
$("[id^='div_WLANRadioSta_']", WLANStatusHead).each(function(){
$(this).remove();
})
var ruleTemplate = $("#div_WLANRadioSta",WLANStatusHead);
var OBJ = $(xml).find("OBJ_WLANSETTING_ID");
var RuleNum = $("Instance", OBJ).length;
for (var i=0; i<RuleNum; i++)
{
var clone = ruleTemplate.cloneWithSuffix(i, "_");
ruleTemplate.before(clone);
var DataOBJID = ["OBJ_WLANSETTING_ID"];
clone.fillDataByOBJID(xml, DataOBJID, clone, i, "_");
var Band = $("[id^='Band']",clone).val();
var radioNewName = "&?WlanBasicAd_077; (" + Band +")";
var titleRealRF = $("[id^='titleRealRF_"+i+"']");
titleRealRF.text(radioNewName);
titleRealRF.attr("title", radioNewName);
var radioNewName = "&?LocalnetStatus_004; (" + Band +")";
var titleChannelInUsed = $("[id^='titleChannelInUsed_"+i+"']");
titleChannelInUsed.text(radioNewName);
titleChannelInUsed.attr("title", radioNewName);
if (i/2 != 0)
{
clone.addClass("colorRow");
}
WLANStatusHead.fillDataOfCard(clone, xml);
clone.showIt(true);
}
}
$.publish("/some/softVersionModify", [WLANStatusHead]);
var BsStatus = getParaValueInXML(xml, "OBJ_WLAN_DUALBAND_ID", 0, "DualBandSyncStat");
if(BsStatus==1){
$("#BsSteerStatus").html("&?BsStatus_01;");
}else if(BsStatus==0){
$("#BsSteerStatus").html("&?BsStatus_02;");
}
};
if ( $(".collapBarWithDataTrans",WLANStatusHead).length <= 0 )
{
WLANStatusHead.dataTransfer(WLANStatusServerAddr, "GET", WLANStatusHead.succfunction);
}
else
{
initial_collapBarWithDataTrans(WLANStatusHead);
}
RefreshClickHandle(WLANStatusHead);
});
})();
</script>
