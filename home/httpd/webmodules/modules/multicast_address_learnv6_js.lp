<script type="text/javascript">
(function(){
function RefreshClickHandle(Head)
{
$(".Btn_refresh", Head).each(function(){
$(this).unbind("click");
$(this).bind("click", function(){
showWaitTip(true);
var HeadID = Head.attr("id");
Head.find("[id^='template_"+HeadID+"_']").each(function(){
$(this).remove();
});
var ServerAddr = $("address span", Head).text();
Head.dataTransfer(ServerAddr,
"GET",
Head.succfunction,
Head.failfunction,
false,
true);
});
})
}
$(document).ready(function(){
var HeadID = "AdressLearnv6";
var Head = $("#"+HeadID);
var templateID = "template_"+HeadID;
var ServerAddr = $("address span", Head).text();
var ObjId = "OBJ_ADDRLEARNV6_ID";
RefreshClickHandle(Head, false);
Head.succfunction = function(xml){
Head.hasError(xml,"externErrorHint");
var OBJ = $(xml).find(ObjId);
var RuleNum = $("Instance", OBJ).length;
var OBJID = [ObjId];
Head.createPageDataByClone(RuleNum, OBJID, xml,
Head.fillDataByCustom);
colorTblRow(".colorTbl", "even", Head);
showWaitTip(false);
};
Head.dataTransfer(ServerAddr,
"GET",
Head.succfunction);
});
})();
</script>
