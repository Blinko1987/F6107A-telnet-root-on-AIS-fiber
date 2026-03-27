<script type="text/javascript">
(function () {
$(document).ready(function(){
var HeadID = "IPv6DHCPHostInfo";
var Head = $("#"+HeadID);
var ServerAddr = $("address span", Head).text();
RefreshClickHandle(Head);
Head.fillDataByCustom = function(suffix,ContainerOBJ){
var ExpiredTimeOBJ = ContainerOBJ.find("[id^='ExpiredTime']");
var ExpiredTime = ExpiredTimeOBJ.text();
if ( ExpiredTime == "4294967295")
{
ExpiredTime = "&?LanMgrIpv6_033;";
}
else
{
ExpiredTime = sec2HrMinSec(ExpiredTime);
}
ExpiredTimeOBJ.text(ExpiredTime);
ExpiredTimeOBJ.attr("title", ExpiredTime);
};
Head.succfunction = function(xml){
if (Head.hasError(xml) == 0)
{
var TemplateOBJ = $("#template_"+HeadID , Head);
var OBJ = $(xml).find("OBJ_DHCP6C_ID");
var RuleNum = $("Instance", OBJ).length;
var OBJID = ["OBJ_DHCP6C_ID"];
if (RuleNum == 0)
{
$(".noDataHint",Head).showIt(true);
TemplateOBJ.parent().showIt(false);
}
else
{
$(".noDataHint",Head).showIt(false);
TemplateOBJ.parent().showIt(true);
Head.createPageDataByClone(RuleNum,
OBJID,
xml,
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
