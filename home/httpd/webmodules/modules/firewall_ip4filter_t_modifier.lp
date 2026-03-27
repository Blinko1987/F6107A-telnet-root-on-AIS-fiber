<script type="text/javascript">
<% if env.getenv("CountryCode") == "156" then %>
function ctcIPv4FilterModify(e,subTemplate,b,c)
{
$("[id^='INCViewName'] option",subTemplate).each(function(){
if( $(this).val() == "DEV.IP.IF3" || $(this).val() == "DEV.IP.IF5" || $(this).val() == "DEV.IP.IF6")
{
$(this).remove();
}
});
$("[id^='OUTCViewName'] option",subTemplate).each(function(){
if( $(this).val() == "DEV.IP.IF3" || $(this).val() == "DEV.IP.IF5" || $(this).val() == "DEV.IP.IF6")
{
$(this).remove();
}
});
}
$.subscribe("/some/softVersionModify", ctcIPv4FilterModify);
<% end %>
</script>
