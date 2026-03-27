<script type="text/javascript">
(function(){
$(document).ready(function(){
showWaitTip(false);
var HeadID = "DefaultConfDownload";
var Head = $("#"+HeadID);
var template = $("#template_"+ HeadID);
template.bind("g_downLoadAllowHandle", function(event,xml, template)
{
if (Head.hasError(xml) == 0)
{
var fileURL = "/?_type=menuData&_tag=do_download_defcfg.lua";
document.getElementById("fDownload").action = fileURL;
document.fDownload.submit();
}
else
{
showWaitTip(false);
}
});
$("#Btn_Download").bind("click", function(){
var loadAllowAddr = "/?_type=menuData&_tag=updownload_prevent_ctl.lua";
var postData = "&sessToken=" +document.getElementById("TOKEN_DOWNLOAD").value;
dataPost("updownload", "g_downLoadAllowHandle", loadAllowAddr, template, postData);
});
$(".collapsibleBar", $("#DefaultConfDownload")).click();
});
})();
</script>
