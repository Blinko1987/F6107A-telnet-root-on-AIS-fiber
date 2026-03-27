<script>
<% if "154" == CountryCode then %>
$.addModifier("home/FWUrl/jump",function(data){
data.template.FWUrl["4"] = "firewall";
});
<%end%>
</script><script>
<% if "79" == CountryCode and "4" == Right then %>
$(document).ready(function(){
$("#home_category_usb").parent().remove();
});
<%end%>
</script><script>
(function(){
<%
if "106" == env.getenv("CountryCode") then
%>
$(".home_category_item").css("position", "relative");
$("a", "#home_category_area").css({position: "absolute", left: "70px"})
<%
end
%>
})()
</script><script>
<% if env.getenv("CountryCode") == "138" then %>
(function(){
$(document).ready(function(){
$("#home_category_wlan, #home_category_lan,#home_category_usb,#home_category_phone").addClass("color_OMA");
$("#home_category_setting").find("a").attr("class","color_OMA");
});
})();
<%
end
%>
</script>
<script>
</script>
<script>
<%
if "156" == env.getenv("CountryCode") then
%>
function addLinkToFireWall(e,subTemplate,b,c){
subTemplate.FWUrl["1"] = "filterCriteria";
subTemplate.FWUrl["2"] = "filterCriteria";
}
$.subscribe("/some/addLinkToFireWall", addLinkToFireWall);
function addLinkToWan(e,subTemplate,b,c){
wanUrl = "ethWanConfig";
}
$.subscribe("/some/addLinkToWan", addLinkToWan);
<%
end
%>
</script><script>
<% if CountryCode == "128" or CountryCode == "185" or CountryCode == "204" then %>
(function(){
$(document).ready(function(){
$("#home_category_wlan, #home_category_lan,#home_category_usb,#home_category_phone").addClass("color_OMA");
$("#home_category_setting").find("a").attr("class","color_OMA");
});
})();
<%
end
%>
</script>
<script>
<% if "146" == CountryCode and "2" == Right then %>
$(document).ready(function(){
$("#home_phone").remove();
$("#home_category_usb").parent().remove();
$("#home_devlist_area").css("height","240px");
});
<%end%>
</script>
