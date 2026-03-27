<script type="text/javascript">
(function(){
$(document).ready(function(){
var HeadID = "VOIPCallLog";
var Head = $("#"+HeadID);
var ServerAddr = $("address span", Head).text();
RefreshClickHandle(Head);
Head.fillDataByCustom = function(suffix,ContainerOBJ) {
var ResultOBJ = ContainerOBJ.find("[id^='Result']");
var Result = ResultOBJ.text();
switch (Result)
{
case "0":
{
Result = "&?VoipStatus_009;";
break;
}
case "1":
{
Result = "&?VoipStatus_010;";
break;
}
case "2":
{
Result = "&?VoipStatus_011;";
break;
}
case "3":
{
Result = "&?VoipStatus_012;";
break;
}
case "4":
{
Result = "&?VoipStatus_013;";
break;
}
default:
{
Result = "&?VoipStatus_009;";
break;
}
}
ResultOBJ.text(Result);
ResultOBJ.attr("title", Result);
};
Head.succfunction = function(xml) {
if (Head.hasError(xml) == 0)
{
var TemplateOBJ = $("#template_"+HeadID,Head);
var OBJ = $(xml).find("OBJ_VOIP_CALL_LOG");
var RuleNum = $("Instance", OBJ).length;
var OBJID = ["OBJ_VOIP_CALL_LOG"];
if (RuleNum == 0)
{
$(".noDataHint",Head).showIt(true);
TemplateOBJ.parent().showIt(false);
}
else
{
$(".noDataHint",Head).showIt(false);
TemplateOBJ.parent().showIt(true);
Head.createPageDataByClone(RuleNum, OBJID, xml,
Head.fillDataByCustom);
colorTblRow(".colorTbl", "even", Head);
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
});
})();
</script>
