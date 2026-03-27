<script type="text/javascript">
(function () {
$(document).ready(function(){
var PONPortID = "PON_Port";
var PONPortHead = $("#"+PONPortID);
var ServerAddr = $("address span", PONPortHead).text();
var RegStatusHead = $("#template_PON_Port");
PONPortHead.chanegeDataByCustom =function(xml){
colorTblRow(".colorTbl", "even", PONPortHead);
};
PONPortHead.succfunction = function(xml){
PONPortHead.fillDataByOBJID(xml, ["OBJ_PON_Port_sta"], $("#PON_Port_container"), 0);
PONPortHead.chanegeDataByCustom(xml);
RefreshClickHandle(PONPortHead);
};
if ( $(".collapBarWithDataTrans",PONPortHead).length <= 0 )
{
PONPortHead.dataTransfer(ServerAddr,"GET",PONPortHead.succfunction);
}
else
{
initial_collapBarWithDataTrans(PONPortHead);
}
});
})();
</script>
