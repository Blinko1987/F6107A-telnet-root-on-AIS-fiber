<script>
<%
if env.getenv("CountryCode") == "63" then
%>
(function(){
$(document).ready(function(){
$('label[for="Ipv6DnsOrigin"]').text("&?LanMgrIpv4_016;");
});
})();
<%
end
%>
</script><script>
<% if env.getenv("CountryCode") == "14" then %>
function showIpv6Dnseta(e,subTemplate,b,c)
{
var DnsOriginStr = '<label for="Ipv6DnsOrigin" class="cfgLabel w200">&?true_LanMgrIpv4_001;</label>'
+ '<div id="Ipv6DnsOrigin" class="right">'
+ '<input type="radio" id="Ipv6DnsOrigin1" name="Ipv6DnsOrigin" value="1"/>'
+ '<label for="Ipv6DnsOrigin1">&?public_033;</label>'
+ '&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;'
+ '<input type="radio" id="Ipv6DnsOrigin0" name="Ipv6DnsOrigin" value="0"/>'
+ '<label for="Ipv6DnsOrigin0">&?public_034;</label>'
+ '</div></div>';
$("#div_Ipv6DnsOrigin",subTemplate).html(DnsOriginStr);
$("#div_Ipv6DnsOrigin",subTemplate).show();
<% if "2" == session_get(sess_id, "Right") then %>
$("#div_PrefixMode",subTemplate).hide();
<%end%>
}
$.subscribe("/some/Ipv6DnsControlA", showIpv6Dnseta);
<% if "2" == session_get(sess_id, "Right") then %>
function showIpv6PrefixZone(e,subTemplate,b,c)
{
$("#DHCPPrefixZone",subTemplate).hide();
}
$.subscribe("/some/Ipv6Prefix", showIpv6PrefixZone);
<%end%>
<%end%>
</script>
