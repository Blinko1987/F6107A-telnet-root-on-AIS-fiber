<script type="text/javascript">
<% if env.getenv("CountryCode") == "1" then %>
$(document).ready(function(){
$("[servicename^='TELNET']",$("#IPv6serviceCtl_container")).remove();
$("[for^='Servise_TELNET']",$("#IPv6serviceCtl_container")).remove();
});
<%end%>
</script>
