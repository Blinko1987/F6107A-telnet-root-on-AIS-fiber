<script type="text/javascript">
$(document).ready(function(){
var HeadID = "WPSBtn";
var Head = $("#"+HeadID);
var template = $("#template_"+ HeadID);
template.bind("fillDataByApplyResult", function(event,xml, template){
if ( template.hasError(xml) == 0 )
{
succHintShow(template);
}
});
$("#Btn_WPSBtn").bind("click", function(event){
showWaitTip(false);
var ServerAddr = $("address span", Head).text();
dataPost("WPSBTN", "fillDataByApplyResult", ServerAddr, template, undefined, false);
});
initial_collapBarWithDataTrans(Head);
});
</script>
