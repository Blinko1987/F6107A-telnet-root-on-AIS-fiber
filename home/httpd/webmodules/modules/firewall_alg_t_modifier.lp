<script type="text/javascript">
<%
if env.getenv("CountryCode") == "1" then
%>
(function(){
$(document).ready(function(){
$("#IPSECAlg").show();
$("#L2TPAlg").show();
});
})();
<%
end
%>
</script>
<script type="text/javascript">
<%
if "79" == CountryCode then
%>
(function(){
$(document).ready(function(){
$("#IPSECAlg").show();
$("#L2TPAlg").show();
return;
});
})();
<%
end
%>
</script>
