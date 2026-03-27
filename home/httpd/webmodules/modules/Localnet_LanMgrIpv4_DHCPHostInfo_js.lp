<script type="text/javascript">
$(document).ready(function(){
var HeadID = "DHCPHostInfo";
var Head = $("#"+HeadID);
var ServerAddr = $("address span", Head).text();
RefreshClickHandle(Head);
Head.succfunction = function(xml){
var hasExpiredInst = 0;
var OBJ = $(xml).find("OBJ_DHCPHOSTINFO_ID");
var instances = $("Instance ", OBJ);
instances.each(function(i){
var inst = $(this);
inst.find("ParaName").each(function(){
var ParaName = $(this).text();
var ParaValue = $(this).next().text();
if ( ParaName == "IPAddr"
&& ParaValue == "" )
{
hasExpiredInst = 1;
return false;
}
});
if ( 1 == hasExpiredInst )
{
$("IF_ERRORSTR", $(xml)).text("SUCC");
return false;
}
});
if (Head.hasError(xml) == 0)
{
var TemplateOBJ = $("#template_"+HeadID,Head);
var XMLOBJ = $(xml).find("OBJ_DHCPHOSTINFO_ID");
var RuleNum = $("Instance", XMLOBJ).length;
var OBJID = ["OBJ_DHCPHOSTINFO_ID"];
if (RuleNum == 0)
{
$(".noDataHint",Head).showIt(true);
TemplateOBJ.parent().showIt(false);
}
else
{
$(".noDataHint",Head).showIt(false);
TemplateOBJ.parent().showIt(true);
Head.createPageDataByClone(RuleNum, OBJID, xml);
$("[id^='ExpiredTime\\:']", Head).each(function()
{
var selfSpanHtml = $(this).text();
if (selfSpanHtml != "-1")
{
selfSpanHtml = sec2HrMinSec(selfSpanHtml);
}
else
{
selfSpanHtml = selfSpanHtml.replace("-1", "&?LanMgrIpv4_003;");
}
$(this).text(selfSpanHtml);
$(this).attr("title", selfSpanHtml);
});
$("[id^='IPAddr\\:']", Head).each(function()
{
var elID = $(this).attr("id");
if ( elID == "IPAddr:DHCPHostInfo" )
{
return false;
}
var selfSpanHtml = $(this).text();
if ( "" == selfSpanHtml )
{
$(this).parent().remove();
}
});
colorTblRow(".colorTbl", "even", Head);
var tempObjs = $("[id^='template_"+HeadID+"_']", Head);
if ( tempObjs.length == 0 )
{
var dataTitle = $("#"+HeadID+"_title", Head);
$(".noDataHint",Head).showIt(true);
dataTitle.parent().showIt(false);
}
}
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
</script>
