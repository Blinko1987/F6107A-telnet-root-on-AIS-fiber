<script>
(function(){
$(document).ready(function(){
var CountryCode = "<%=env.getenv("CountryCode")%>";
if (CountryCode == "156")
{
$("[id^='ServiceEnable']").hide();
$("[for^='ServiceEnable']").hide();
$("[id^='LogLevel']").hide();
$("[for^='LogLevel']").hide();
$("#LogManagerConfBar").text("&?ctc_log_001;")
$("[id^='ServiceIp']").remove();
}
});
})();
</script><script>
(function(){
$(document).ready(function(){
var CountryCode = "<%=env.getenv("CountryCode")%>";
if (CountryCode == "98")
{
$("[id^='LogEnable']").hide();
$("[for^='LogEnable']").hide();
$("[id^='div_LogLevel']").remove();
}
});
})();
</script>
