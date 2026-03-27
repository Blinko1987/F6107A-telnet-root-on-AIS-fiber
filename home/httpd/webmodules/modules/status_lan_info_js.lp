<script type="text/javascript">
(function(){
var getXml = "";
$(document).ready(function(){
var HeadID = "lan_info";
var Head = $("#"+HeadID);
var ServerAddr = $("address span", Head).text();
var template = $("#template_"+ HeadID);
template.bind("fillDataByClearResult",function(event, xml, template){
$("#Btn_refresh_lan_info").click();
});
$("#LANStatus_Btn_clear", Head).bind("click",{templateOBJ:template}, function(event){
var buttonOBJ = $(this);
var template = event.data.templateOBJ;
var action = "LAN_CLEAR";
dataPost(action, "fillDataByClearResult", ServerAddr, template);
});
RefreshClickHandle(Head);
Head.chanegeDataByCustom =function(xml){
colorTblRow(".colorTbl", "even", Head);
};
Head.fillDataByCustom = function(suffix,ContainerOBJ){
var AliasNameOBJ = ContainerOBJ.find("[id^='AliasName']");
var StatusOBJ = ContainerOBJ.find("[id^='Status']");
var InBytesOBJ = ContainerOBJ.find("[id^='InBytes']");
var InPktsOBJ = ContainerOBJ.find("[id^='InPkts']");
var InUnicastOBJ = ContainerOBJ.find("[id^='InUnicast']");
var InMulticastOBJ = ContainerOBJ.find("[id^='InMulticast']");
var InErrorOBJ = ContainerOBJ.find("[id^='InError']");
var InDiscardOBJ = ContainerOBJ.find("[id^='InDiscard']");
var index = parseInt(suffix) + 1;
var AliasName = "LAN" + index;
var Status = getParaValueInXML(getXml, "OBJ_PON_PORT_BASIC_STATUS_ID", suffix, "Status");
var Speed = parseInt(getParaValueInXML(getXml, "OBJ_PON_PORT_BASIC_STATUS_ID", suffix, "Speed"));
var Duplex = parseInt(getParaValueInXML(getXml, "OBJ_PON_PORT_BASIC_STATUS_ID", suffix, "Duplex"));
var InBytes =getParaValueInXML(getXml, "OBJ_PON_PORT_BASIC_STATUS_ID", suffix, "InBytes");
var InPkts = getParaValueInXML(getXml, "OBJ_PON_PORT_BASIC_STATUS_ID", suffix, "InPkts");
var InUnicast = getParaValueInXML(getXml, "OBJ_PON_PORT_BASIC_STATUS_ID", suffix, "InUnicast");
var InMulticast = getParaValueInXML(getXml, "OBJ_PON_PORT_BASIC_STATUS_ID", suffix, "InMulticast");
var InError = getParaValueInXML(getXml, "OBJ_PON_PORT_BASIC_STATUS_ID", suffix, "InError");
var InDiscard = getParaValueInXML(getXml, "OBJ_PON_PORT_BASIC_STATUS_ID", suffix, "InDiscard");
var OutBytes = getParaValueInXML(getXml, "OBJ_PON_PORT_BASIC_STATUS_ID", suffix, "OutBytes");
var OutPkts = getParaValueInXML(getXml, "OBJ_PON_PORT_BASIC_STATUS_ID", suffix, "OutPkts");
var OutUnicast = getParaValueInXML(getXml, "OBJ_PON_PORT_BASIC_STATUS_ID", suffix, "OutUnicast");
var OutMulticast = getParaValueInXML(getXml, "OBJ_PON_PORT_BASIC_STATUS_ID", suffix, "OutMulticast");
var OutError = getParaValueInXML(getXml, "OBJ_PON_PORT_BASIC_STATUS_ID", suffix, "OutError");
var OutDiscard = getParaValueInXML(getXml, "OBJ_PON_PORT_BASIC_STATUS_ID", suffix, "OutDiscard");
var LanStatus;
var InOutBytes;
var InOutPkts;
var InOutUnicast;
var InOutMulticast;
var InOutError;
var InOutDiscard;
if(Status == 0)
{
LanStatus = "&?pdt_lan002;/";
switch(Speed)
{
case 0:
LanStatus += "AUTO/";
break;
case 1:
LanStatus += "10Mbps/";
break;
case 2:
LanStatus += "100Mbps/";
break;
case 3:
LanStatus += "1000Mbps/";
break;
case 4:
LanStatus += "2500Mbps/";
break;
case 5:
LanStatus += "5000Mbps/";
break;
case 6:
LanStatus += "10000Mbps/";
break;
}
switch(Duplex)
{
case 0:
LanStatus += "&?pdt_lan005;";
break;
case 1:
LanStatus += "&?pdt_lan003;";
break;
case 2:
LanStatus += "&?pdt_lan004;";
break;
}
}
else if (Status == 1)
{
LanStatus = "&?pdt_lan006;";
}
else if (Status == 2)
{
LanStatus = "&?pdt_lan007;";
}
else if (Status == 3)
{
LanStatus = "&?pdt_lan008;";
}
InOutBytes = InBytes + "/" + OutBytes;
InOutPkts = InPkts + "/" + OutPkts;
InOutUnicast = InUnicast + "/" + OutUnicast;
InOutMulticast = InMulticast + "/" + OutMulticast;
InOutError = InError + "/" + OutError;
InOutDiscard = InDiscard + "/" + OutDiscard;
AliasNameOBJ.text(AliasName);
AliasNameOBJ.attr("title", AliasName);
StatusOBJ.text(LanStatus);
StatusOBJ.attr("title", LanStatus);
InBytesOBJ.text(InOutBytes);
InBytesOBJ.attr("title", InOutBytes);
InPktsOBJ.text(InOutPkts);
InPktsOBJ.attr("title", InOutPkts);
InUnicastOBJ.text(InOutUnicast);
InUnicastOBJ.attr("title", InOutUnicast);
InMulticastOBJ.text(InOutMulticast);
InMulticastOBJ.attr("title", InOutMulticast);
InErrorOBJ.text(InOutError);
InErrorOBJ.attr("title", InOutError);
InDiscardOBJ.text(InOutDiscard);
InDiscardOBJ.attr("title", InOutDiscard);
};
Head.succfunction = function(xml){
getXml = xml;
var cmapiErrorContainer = $(".errorHint",Head);
if (cmapiErrorContainer.hasError(xml) == 0);
{
Head.chanegeDataByCustom(xml);
var OBJ = $(xml).find("OBJ_PON_PORT_BASIC_STATUS_ID");
var RuleNum = $("Instance", OBJ).length;
var OBJID = ["OBJ_PON_PORT_BASIC_STATUS_ID"];
Head.createPageDataByClone(RuleNum, OBJID, xml,
Head.fillDataByCustom);
}
};
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
