<script type="text/javascript">
<% if env.getenv("CountryCode") == "156" then %>
function ctcIPv4PolicyRoutingModify(e,subTemplate,b,c)
{
$("[id^='DestInterface'] option",subTemplate).each(function(){
if( $(this).val() == "DEV.IP.IF3" || $(this).val() == "DEV.IP.IF5" || $(this).val() == "DEV.IP.IF6")
{
$(this).remove();
}
});
}
$.subscribe("/some/softVersionModify", ctcIPv4PolicyRoutingModify);
<% end %>
</script>
