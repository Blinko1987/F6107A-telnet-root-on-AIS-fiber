<script type="text/javascript">
(function () {
var AParrayObj = new Array();
$(document).ready(function(){
var SSIDDevHeadID = "Wlan_ClientStat";
var SSIDDevHead = $("#"+SSIDDevHeadID);
var SSIDDevServerAddr = $("address span", SSIDDevHead).text();
SSIDDevHead.fillDataByCustom = function(suffix,ContainerOBJ){
var clientIndex = parseInt(suffix, 10) + 1;
var clientName = "&?LocalnetStatus_018;-"+clientIndex;
var cnObj = $("[id^='WClientNum']", ContainerOBJ);
cnObj.text(clientName);
cnObj.attr("title", clientName);
var strView = $("[id^='AliasName']",ContainerOBJ).text();
var strIndex = strView.split("AP");
var AliasNameStr = "";
var indexNum = "";
if(strIndex.length == 2){
indexNum = strIndex[1];
AliasNameStr = "&?public_117;"+indexNum;
}
var anObj = $("[id^='AliasName']", ContainerOBJ);
anObj.text(AliasNameStr);
anObj.attr("title", AliasNameStr);
$.publish("/some/ctcWlanssidClientStaSSID", [ContainerOBJ]);
var ESSIDObj = $("[id^='ESSID']", ContainerOBJ);
var ESSIDstr = AParrayObj[parseInt(indexNum)-1];
ESSIDObj.text(ESSIDstr);
ESSIDObj.attr("title", ESSIDstr);
var ConTime = $("[id^='LinkTime']", ContainerOBJ);
<%
local ConT="0"
if _G.ssidConf["WlanClientConTime"] ~= nil then
ConT=_G.ssidConf["WlanClientConTime"]
end
%>
var ConT="<%=ConT%>"
if(ConT=="1")
ConTime.text(sec2HrMinSec(ConTime.text()));
else
ConTime.text(ConTime.text()+" s");
};
SSIDDevHead.succfunction = function(xml){
if (SSIDDevHead.hasError(xml) == 0)
{
var wlanAPOBJ = $(xml).find("OBJ_WLANAP_ID");
var wlanAPNum = $("Instance", wlanAPOBJ).length;
for(var i=0; i<wlanAPNum; i++)
{
var APIndex = getParaValueInXML(xml, "OBJ_WLANAP_ID", i, "ESSID");
AParrayObj.push(APIndex);
}
var SSIDDevTemplateOBJ = $("#template_"+SSIDDevHeadID, SSIDDevHead);
var wlanADOBJ = $(xml).find("OBJ_WLAN_AD_ID");
var wlanADNum = $("Instance", wlanADOBJ).length;
var OBJID = ["OBJ_WLAN_AD_ID"];
if (wlanADNum == 0)
{
$(".noDataHint", SSIDDevHead).showIt(true);
SSIDDevTemplateOBJ.parent().showIt(false);
}
else
{
$(".noDataHint", SSIDDevHead).showIt(false);
SSIDDevTemplateOBJ.parent().showIt(true);
SSIDDevHead.createPageDataByClone(wlanADNum,OBJID,xml,
SSIDDevHead.fillDataByCustom);
colorTblRow(".colorTbl", "even", SSIDDevHead);
}
$.publish("/some/hidePostBackSSID", [SSIDDevHead]);
$.publish("/some/ctcWlanssidClientStaModify", [xml]);
}
};
if ( $(".collapBarWithDataTrans",SSIDDevHead).length <= 0 )
{
SSIDDevHead.dataTransfer(SSIDDevServerAddr, "GET", SSIDDevHead.succfunction);
}
else
{
initial_collapBarWithDataTrans(SSIDDevHead);
}
RefreshClickHandle(SSIDDevHead);
});
})();
</script>
