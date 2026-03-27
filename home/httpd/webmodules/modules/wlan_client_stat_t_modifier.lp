<script type="text/javascript">
<% if env.getenv("CountryCode") == "156" then %>
function ctcWlanssidClientStaModify(e,subTemplate,b,c){
var OBJ = $(subTemplate).find("OBJ_WLAN_AD_ID");
var instances = $("Instance", OBJ);
instances.each(function(i){
var inst = $(this);
inst.find("ParaName").each(function(){
var ParaName = $(this).text();
var ParaValue = $(this).next().text();
if ( ParaName == "RxRate" )
{
ParaValue = ParaValue/1000;
$("[id^='RxRate:"+ i +"']").text(ParaValue+" Mbps");
}
if(ParaName == "TxRate")
{
ParaValue = ParaValue/1000;
$("[id^='TxRate:"+ i +"']").text(ParaValue+" Mbps");
}
});
});
$("[id^='IPV6Address']").hide();
$("[title^='IPv6 Address']").hide();
}
$.subscribe("/some/ctcWlanssidClientStaModify", ctcWlanssidClientStaModify);
function ctcWlanssidClientStaSSID(e,subTemplate,b,c){
var strView = $("[id^='AliasName']",subTemplate).text();
var strIndex = strView.charAt(strView.length - 1);
if (strIndex >= 5)
{
strIndex=strIndex-1;
}
var AliasNameStr = "&?public_117;"+strIndex;
var anObj = $("[id^='AliasName']", subTemplate);
anObj.text(AliasNameStr);
anObj.attr("title", AliasNameStr);
}
$.subscribe("/some/ctcWlanssidClientStaSSID", ctcWlanssidClientStaSSID);
<% end %>
</script><script type="text/javascript">
(function(){
$(document).ready(function(){
<% if env.getenv("CountryCode") == "170" then %>
$("#NoiseSNR").showIt(true);
<%end%>
});
})();
</script><script type="text/javascript">
<% if "139" == CountryCode then %>
$("#ConnectionTime").css("display","");
<% end %>
</script>
