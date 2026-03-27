<script type="text/javascript">
(function(){
$(document).ready(function(){
var HeadID = "VOIPPhoneStatus";
var Head = $("#"+HeadID);
var ServerAddr = $("address span", Head).text();
RefreshClickHandle(Head);
Head.chanegeDataByCustom =function(xml){
var OBJTag = xml.getElementsByTagName("OBJ_VOIPVPPHYINTERFACE_ID")[0];
if ( !OBJTag )
{
return;
}
var ParametersTag = OBJTag.getElementsByTagName("Instance");
for (var i=0; i<ParametersTag.length; i++)
{
var phoneNumParaName =xml.createElement("ParaName");
var phoneNumParaNameTextNode = xml.createTextNode("phoneName");
phoneNumParaName.appendChild(phoneNumParaNameTextNode);
var phoneID = parseInt(i) + 1;
var phoneNumParaValue =xml.createElement("ParaValue");
var phoneNumParaValueTextNode = xml.createTextNode("&?VoipStatus_016;"+ phoneID);
phoneNumParaValue.appendChild(phoneNumParaValueTextNode);
ParametersTag[i].appendChild(phoneNumParaName);
ParametersTag[i].appendChild(phoneNumParaValue);
}
};
Head.fillDataByCustom = function(suffix,ContainerOBJ,xml){
var LanPortStatusOBJ = ContainerOBJ.find("[id^='LanPortStatus']");
var PortStatus = LanPortStatusOBJ.text();
switch(PortStatus)
{
case "0": PortStatus = "&?VoipStatus_021;";break;
case "1": PortStatus = "&?VoipStatus_022;";break;
case "2": PortStatus = "&?VoipStatus_023;";break;
case "3": PortStatus = "&?VoipStatus_037;";break;
case "4": PortStatus = "&?VoipStatus_028;";break;
case "5": PortStatus = "&?VoipStatus_023;";break;
case "6": PortStatus = "&?VoipStatus_024;";break;
case "7": PortStatus = "&?VoipStatus_025;";break;
default: break;
}
LanPortStatusOBJ.text(PortStatus);
LanPortStatusOBJ.attr("title", PortStatus);
};
Head.succfunction = function(xml){
if (Head.hasError(xml) == 0)
{
Head.chanegeDataByCustom(xml);
var OBJ = $(xml).find("OBJ_VOIPVPPHYINTERFACE_ID");
var RuleNum = $("Instance", OBJ).length;
var OBJID = ["OBJ_VOIPVPPHYINTERFACE_ID"];
Head.createPageDataByClone(RuleNum, OBJID, xml,
Head.fillDataByCustom);
colorTblRow(".colorTbl", "even", Head);
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
