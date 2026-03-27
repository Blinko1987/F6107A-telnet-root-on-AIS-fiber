<script type="text/javascript">
(function(){
$(document).ready(function(){
showWaitTip(false);
var HeadID = "AISUserConfDownload";
var Head = $("#"+HeadID);
var template = $("#template_"+ HeadID);
template.bind("g_downLoadAllowHandle", function(event,xml, template)
{
if (Head.hasError(xml) == 0)
{
var fileURL = "/?_type=menuData&_tag=backupdownloadcfg_lua.lua";
document.getElementById("userConf_fDownload").action = fileURL;
var userConf_fDownload = $("#userConf_fDownload", Head).get(0);
userConf_fDownload.submit();
}
else
{
showWaitTip(false);
}
});
$("#Btn_AISDownload").bind("click", function(){
var loadAllowAddr = "/?_type=menuData&_tag=updownload_prevent_ctl.lua";
var postData = "&sessToken=" +document.getElementById("TOKEN_DOWNLOAD").value;
dataPost("updownload", "g_downLoadAllowHandle", loadAllowAddr, template, postData);
});
$(".collapsibleBar", $("#AISUserConfDownload")).click();
});
})();
</script>
