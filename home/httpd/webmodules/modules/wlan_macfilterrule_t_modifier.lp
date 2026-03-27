<script>
<%
local sess_id = cgilua.getCurrentSessID()
local uRight = session_get(sess_id, "Right")
if env.getenv("CountryCode") == "131" and uRight == "2" then
%>
(function(){
$(document).ready(function(){
var template = $("#MACFilterRule");
template.find("*").attr("disabled",true);
return;
});
})();
<%
end
%>
</script>
