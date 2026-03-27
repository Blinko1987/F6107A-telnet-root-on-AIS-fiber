<script type="text/javascript">
<% if CountryCode == "156" then %>
(function(){
$.addModifier("/accessdev/TAHidden",function(data){
var dataxml = data.xml;
var OBJ = $(dataxml).find("OBJ_ACCESSDEV_ID");
$("Instance",OBJ).each(function(){
var inst = $(this);
var AliasName = "";
$("ParaName",inst).each(function(){
var curr = $(this);
if(curr.text() == "AliasName")
{
AliasName = curr.next().text();
return false;
}
});
if(AliasName.indexOf("SSID") != -1 )
{
inst.remove();
}
});
})
})()
<%end%>
</script>
