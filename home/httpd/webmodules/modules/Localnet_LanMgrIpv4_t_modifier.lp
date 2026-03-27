<script>
<%
if env.getenv("CountryCode") == "63" then
%>
(function(){
$(document).ready(function(){
$("#DHCPBasicCfgBar").text("&?LanIpv4_010;");
});
})();
<%
end
%>
</script><script>
<%
if CountryCode == "163" then
%>
(function(){
$(document).ready(function(){
$("#DnsServerSource0").click(function(){
alert("&?BClaro_001;");
});
$("#DHCPStaticRule").hide();
});
})();
$.addModifier("DHCPBasicCfg/undisplayDNSConf",function(){
$("#div_DnsServerSource").hide();
$("#div_Ipv4DnsOrigin").hide();
});
<%
end
%>
</script>
<script type="text/javascript">
function ISPDNSModify(e,subTemplate,b,c)
{
<% if env.getenv("CountryCode") == "14" then %>
$("#ISPDNS",subTemplate).html("&?true_LanMgrIpv4_001;");
<%end%>
}
$.subscribe("/some/MinMaxIPCtrl", ISPDNSModify);
</script><script>
<%
if "156" == env.getenv("CountryCode") then
%>
$("#div_NetbiosName").show();
function winsaddr(e,subTemplate,b,c){
if($("#NetbiosName").val() == "")
{
$("#NetbiosNameEnable").val(0);
}
else
{
$("#NetbiosNameEnable").val(1);
}
$("#NetbiosNameEnable").removeClass("PostIgnore");
$("#NetbiosName").removeClass("PostIgnore");
}
$.subscribe("/some/changePostData", winsaddr);
(function(){
$(document).ready(function(){
$("[for^='LeaseTimeSelfDefine']").text("&?ctc_lease_001;");
$("#timeunit").hide();
$("[id^='DHCPHostInfo_title']").find("span").eq(3).removeClass("w100").addClass("w80");
$("[id^='PhyPortName:DHCPHostInfo']").removeClass("w100").addClass("w80");
});
})();
$.unsubscribe("/some/softVersionModify");
function ctcLANFilterModify(e,subTemplate,b,c)
{
var selfSpanHtml = $(subTemplate).text();
switch(selfSpanHtml)
{
case "SSID5": $(subTemplate).text("SSID4");break;
case "SSID6": $(subTemplate).text("SSID5");break;
case "SSID7": $(subTemplate).text("SSID6"); break;
}
}
$.subscribe("/some/softVersionModify", ctcLANFilterModify);
<%
end
%>
</script><script>
<%
local sess_id = cgilua.getCurrentSessID()
local uRight = session_get(sess_id, "Right")
if env.getenv("CountryCode") == "131" and uRight == "2" then
%>
(function(){
$(document).ready(function(){
var template = $("#DHCPBasicCfg");
template.find("*").attr("disabled",true);
var template1 = $("#DHCPStaticRule");
template1.find("*").attr("disabled",true);
return;
});
})();
<%
end
%>
</script>
<script>
<%
if env.getenv("CountryCode") == "98" then
%>
(function(){
$(document).ready(function(){
$("[id^='DnsServerSource']").parent().hide();
$("[id^='div_Ipv4DnsOrigin").remove();
$("[id^='div_DNSServer1").hide();
$("[id^='div_DNSServer2").hide();
});
})();
<%
end
%>
</script>
<script type="text/javascript">
<% if "139" == CountryCode then %>
(function(){
$(document).ready(function(){
$("#div_OptValue").show();
});
})()
<% end %>
</script>
