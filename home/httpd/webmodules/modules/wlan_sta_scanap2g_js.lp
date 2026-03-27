<script type="text/javascript">
<%
local sess_id = cgilua.getCurrentSessID()
%>
(function(){
$(document).ready(function(){
var HeadID = "WLANScanAP";
var Head = $("#"+HeadID);
var templateID = "template_WLANScanAP";
var template = $("#"+templateID);
var ServerAddr = $("address span", Head).text();
ServerAddr = ServerAddr + "&APGetFrom=ScanAP" + "&_sessionTOKEN=" + "<%=_G.encodeJS(session_get(sess_id, 'sess_token'))%>";
Head.succfunction = function(xml){
Head.hasError(xml,"externErrorHint");
var GETAPOBJ = $(xml).find("OBJ_WLANGETNEBAP_ID");
var RuleNum = $("Instance", GETAPOBJ).length;
var OBJID = ["OBJ_WLANGETNEBAP_ID"];
Head.createPageDataByClone(RuleNum, OBJID, xml,Head.fillDataByCustom);
colorTblRow(".colorTbl", "even", Head);
$("#div_Scanning_tip").hide();
};
$("#Btn_scanap").click(function(){
$("#div_Scanning_tip").show();
$("[id^='template_WLANScanAP_']").remove();
Head.dataTransfer(ServerAddr, "GET", Head.succfunction);
});
if ( $(".collapBarWithDataTrans",Head).length <= 0 )
{
}
else
{
initial_collapBarWithDataTrans(Head);
}
});
})();
</script>
