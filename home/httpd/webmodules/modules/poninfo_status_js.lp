<script type="text/javascript">
(function(){
var LosInfo = "";
var TimerID;
$(document).ready(function(){
var RegStatusHeadID = "PonInfoOptical";
var RegStatusHead = $("#"+RegStatusHeadID);
var ServerAddr = $("address span", RegStatusHead).text();
RefreshClickHandle(RegStatusHead);
RegStatusHead.chanegeDataByCustom =function(xml){
colorTblRow(".colorTbl", "even", RegStatusHead);
};
<% if CountryCode == "95" then %>
$(".w250").attr("class","w180");
<%end%>
RegStatusHead.succfunction = function(xml){
var cmapiErrorContainer = $(".errorHint",RegStatusHead);
if (cmapiErrorContainer.hasError(xml) == 0);
{
RegStatusHead.chanegeDataByCustom(xml);
LosInfo = getParaValueInXML(xml, "OBJ_LOS_INFO_ID", 0, "LosInfo");
var RegStatus = getParaValueInXML(xml, "OBJ_GPONREGSTATUS_ID", 0, "RegStatus");
var CatvEnable = getParaValueInXML(xml, "OBJ_PON_CATV_ID", 0, "CatvEnable");
var GponRegStatus = "";
switch(RegStatus)
{
case "0": GponRegStatus = "&?ponreg002;";break;
case "1": GponRegStatus = "&?ponreg003;";break;
case "2": GponRegStatus = "&?ponreg004;";break;
case "3": GponRegStatus = "&?ponreg005;";break;
case "4": GponRegStatus = "&?ponreg006;";break;
case "5": GponRegStatus = "&?ponreg007;";break;
case "6": GponRegStatus = "&?ponreg008;";break;
case "7": GponRegStatus = "&?ponreg009;";break;
default: GponRegStatus = "&?ponreg002;";break;
}
var InternetSipLineOBJ = $(xml).find("OBJ_PON_OPTICALPARA_ID");
var RegStatusRuleNum = $("Instance", InternetSipLineOBJ).length;
var OBJID = ["OBJ_PON_OPTICALPARA_ID"];
RegStatusHead.fillDataByOBJID(xml, OBJID, $("#PonInfoOptical_container"), 0);
if(LosInfo == "1")
{
$("#RxPower").html("--");
$("#TxPower").html("--");
<%if env.getenv("catvSupport") ~= "0" then%>
$("#RFTxPower").html("--");
$("#VideoRxPower").html("--");
<%end%>
}
<%if env.getenv("catvSupport") ~= "0" then%>
else if(CatvEnable != "1")
{
$("#RFTxPower").html("N/A");
$("#VideoRxPower").html("N/A");
}
<%end%>
$("#RegStatus").html(GponRegStatus);
var PONOnTime = parseInt(getParaValueInXML(xml, "OBJ_PON_POWERONTIME_ID", 0, "PONOnTime"));
var tmphour = 0;
var tmpmon = 0;
var tmpsec = 0;
if(!isNaN(PONOnTime))
{
tmphour = parseInt(PONOnTime/3600);
tmpmon = parseInt((PONOnTime%3600)/60);
tmpsec = (PONOnTime%3600)%60;
}
$("#PONOnTime").html(tmphour+"&?public_011;"+tmpmon+"&?public_012;"+tmpsec+"&?public_013;");
<% if CountryCode == "14" then %>
$("#div_Time").showIt(true);
clearTimeout(TimerID);
TimerID = setTimeout(function() {
$("#Btn_refresh_PonInfoOptical", RegStatusHead).click();
}, 10000);
<%end%>
<% if CountryCode == "131" then %>
$("#Volt_font").html("&?PonInfoOptical_015;");
<%end%>
}
};
if ( $(".collapBarWithDataTrans",RegStatusHead).length <= 0 )
{
RegStatusHead.dataTransfer(ServerAddr,
"GET",
RegStatusHead.succfunction);
}
else
{
initial_collapBarWithDataTrans(RegStatusHead);
}
});
})();
</script>
