<script>
<%
if CountryCode == "163" and "2" == Right then
%>
(function(){
$(document).ready(function(){
$("[id^='FilterMode']").find("option[value='WhiteList']").remove();
});
})();
<%
end
%>
</script><script>
<%
if "138" == CountryCode then
%>
$.addModifier("ParentCtrl/changeTime",function(data){
var template = data.template;
$("[id^='Week:']", template).val("127");
$("[id^='StartHour:']", template).val("0");
$("[id^='EndHour:']", template).val("23");
$("[id^='StartMin:']", template).val("0");
$("[id^='EndMin:']", template).val("59");
});
$(document).ready(function(){
$("[id^='TR_TimeCfg']").hide();
})
<%
end
%>
</script><script>
<%
if "124" == CountryCode then
%>
$.addModifier("ParentCtrl/changeTime",function(data){
var template = data.template;
$("[id^='Week:']", template).val("127");
$("[id^='StartHour:']", template).val("0");
$("[id^='EndHour:']", template).val("23");
$("[id^='StartMin:']", template).val("0");
$("[id^='EndMin:']", template).val("59");
});
$(document).ready(function(){
$("[id^='TR_TimeCfg']").hide();
})
<%
end
%>
</script>
