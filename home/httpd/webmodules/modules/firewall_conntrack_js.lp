<script type="text/javascript">
(function(){
$(document).ready(function(){
var RegStatusHeadID = "ConntrackStatus";
var RegStatusHead = $("#"+RegStatusHeadID);
var ServerAddr = $("address span", RegStatusHead).text();
RefreshClickHandle(RegStatusHead);
RegStatusHead.chanegeDataByCustom =function(xml){
colorTblRow(".colorTbl", "even", RegStatusHead);
};
RegStatusHead.succfunction = function(xml){
var cmapiErrorContainer = $(".errorHint",RegStatusHead);
if (cmapiErrorContainer.hasError(xml) == 0);
{
var template = $("[id^='template_']",RegStatusHead);
RegStatusHead.hasError(xml,"externErrorHint");
var OBJID = ["OBJ_CONNTRACK_ID"];
RegStatusHead.fillDataByOBJID(xml ,OBJID, template,0);
RegStatusHead.chanegeDataByCustom(xml);
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
