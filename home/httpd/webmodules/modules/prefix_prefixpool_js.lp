<script type="text/javascript">
(function () {
function initial_template_PrefixPool(templateID)
{
var template = $("#"+templateID);
template.bind("fillDataByCustom", function(event, suffix, ContainerOBJ){
var Head = ContainerOBJ.parents(".HeadDIV");
var ValidPreferTimeOBJ = $("[id^='ValidPreferTime']", ContainerOBJ);
var AID = $("[id^='PreferredLifetime']", ContainerOBJ).attr("id");
var PreferredLifetime = $("[id^='PreferredLifetime']", ContainerOBJ).val();
if ( PreferredLifetime == "4294967295")
{
PreferredLifetime = "&?LanMgrIpv6_033;";
}
var ValidLifetime = $("[id^='ValidLifetime']", ContainerOBJ).val();
if ( ValidLifetime == "4294967295")
{
ValidLifetime = "&?LanMgrIpv6_033;";
}
var ValidPreferTime = PreferredLifetime + "/" + ValidLifetime;
ValidPreferTimeOBJ.text(ValidPreferTime);
ValidPreferTimeOBJ.attr("title", ValidPreferTime);
var Prefix = $("[id^='Prefix:']", ContainerOBJ).val();
var PrefixLen = $("[id^='PrefixLen:']", ContainerOBJ).val();
var RealPrefix = Prefix + "/" + PrefixLen;
var RealPrefixOBJ = $("[id^='RealPrefix:']", ContainerOBJ);
RealPrefixOBJ.text(RealPrefix);
RealPrefixOBJ.attr("title", RealPrefix);
var InstValue = $("[id^='PrefixPoolInst']", ContainerOBJ).val();
var DeleRelationStr = $("#FullDelegationRelation", Head).val();
var DeleRelationArray = DeleRelationStr.split(',');
for( var i=0; i<DeleRelationArray.length; i++ )
{
if ( InstValue == DeleRelationArray[i] )
{
$("[id^='IsDelegation']", ContainerOBJ).prop("checked", true).attr("checked","checked");
}
}
});
}
$(document).ready(function(){
var HeadID = "PrefixPool";
var Head = $("#"+HeadID);
var templateID = "template_"+ HeadID;
initial_template_PrefixPool(templateID);
Head.succfunction = function(xml){
var OBJ = $(xml).find("OBJ_PREFIXPOOL_ID");
var RuleNum = $("Instance", OBJ).length;
if ( RuleNum > 0 )
{
$(".noDataRow",Head).showIt(false);
var OBJID = ["OBJ_PREFIXPOOL_ID"];
Head.createPageDataByClone(RuleNum, OBJID, xml);
colorTblRow(".colorTbl", "even", Head);
}
else
{
$(".noDataRow",Head).showIt(true);
}
};
Head.failfunction = function(xml){
$("#tr_NoData",Head).showIt(true);
};
var Btn_PrefixPool = $("#Btn_PrefixPool", Head);
Btn_PrefixPool.unbind("click");
Btn_PrefixPool.click(function(event, DelegationRelationStr){
$("#FullDelegationRelation", Head).val(DelegationRelationStr);
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
});
});
})();
</script>
