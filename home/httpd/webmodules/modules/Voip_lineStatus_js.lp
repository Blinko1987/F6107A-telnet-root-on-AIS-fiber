<script type="text/javascript">
(function(){
$(document).ready(function(){
var HeadID = "VOIPRegStatus";
var Head = $("#"+HeadID);
var ServerAddr = $("address span", Head).text();
var cver = "<%=CountryCode%>";
RefreshClickHandle(Head);
Head.chanegeDataByCustom =function(xml){
var OBJTag = xml.getElementsByTagName("OBJ_VOIPVPLINE_ID")[0];
if ( !OBJTag )
{
return;
}
var ParametersTag = OBJTag.getElementsByTagName("Instance");
for (var i=0; i<ParametersTag.length; i++)
{
var lineNumParaName =xml.createElement("ParaName");
var lineNumParaNameTextNode = xml.createTextNode("lineName");
lineNumParaName.appendChild(lineNumParaNameTextNode);
var lineID = parseInt(i) + 1;
var lineNumParaValue =xml.createElement("ParaValue");
var lineNumParaValueTextNode = xml.createTextNode("&?VoipStatus_035;"+ lineID);
lineNumParaValue.appendChild(lineNumParaValueTextNode);
ParametersTag[i].appendChild(lineNumParaName);
ParametersTag[i].appendChild(lineNumParaValue);
}
};
Head.fillDataByCustom = function(suffix,ContainerOBJ,xml){
var VoIPRegStatusOBJ = ContainerOBJ.find("[id^='VoIPRegStatus']");
var VoIPRegStatusValue = VoIPRegStatusOBJ.text();
switch(VoIPRegStatusValue)
{
case "0":
{
if (cver == "140")
{
VoIPRegStatusValue = "&?VoipStatusojo_030;";
}
else
{
VoIPRegStatusValue = "&?VoipStatus_030;";
}
break;
};
case "1": VoIPRegStatusValue = "&?VoipStatus_020;";break;
case "2": VoIPRegStatusValue = "&?VoipStatus_029;";break;
case "3": VoIPRegStatusValue = "&?VoipStatus_017;";break;
default: break;
}
VoIPRegStatusOBJ.text(VoIPRegStatusValue);
VoIPRegStatusOBJ.attr("title", VoIPRegStatusValue);
};
Head.succfunction = function(xml){
if (Head.hasError(xml) == 0)
{
Head.chanegeDataByCustom(xml);
var OBJ = $(xml).find("OBJ_VOIPVPLINE_ID");
var RuleNum = $("Instance", OBJ).length;
var OBJID = ["OBJ_VOIPSIPLINE_ID", "OBJ_VOIPVPLINE_ID"];
Head.createPageDataByClone(RuleNum, OBJID, xml,
Head.fillDataByCustom);
colorTblRow(".colorTbl", "even", Head);
}
$.publish("/some/voipVersionModify", [Head]);
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
