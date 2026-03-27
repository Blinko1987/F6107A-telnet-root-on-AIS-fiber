<script>
<%
if "77" == CountryCode then
%>
$(document).ready(function(){
$("#TR069BasicConf_container *").disableIt(true);
})
<%
end
%>
</script>
<script>
<%
if "98" == env.getenv("CountryCode") then
%>
$(document).ready(function(){
$("input").attr("disabled",true);
$("select").attr("disabled",true);
$(".Button").addClass("disableBtn");
});
<%
end
%>
</script><script>
<%
local sess_id = cgilua.getCurrentSessID()
local loginName = session_get(sess_id, "login_name")
if "124" == CountryCode then
%>
$(document).ready(function(){
<% if loginName == "support" then %>
$("[id='TR069BasicConf_container'] *").attr("disabled",true);
$("#Btn_apply_TR069BasicConf,#Btn_cancel_TR069BasicConf").remove();
<% end %>
})
<%
end
%>
</script>
