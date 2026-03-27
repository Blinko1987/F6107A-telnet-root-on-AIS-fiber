<script type="text/javascript">
<% if "39" == CountryCode then %>
(function(){
$(document).ready(function(){
var template = $("#VOIPSipService");
template.find("*").attr("disabled",true);
});
})();
<% end %>
</script><script>
<%
if "128" == CountryCode or "185" == CountryCode then
%>
(function(){
$(document).ready(function(){
$("[for^='CallForwardUnconditionalEnable']").parent().hide();
$("[for^='CallForwardOnBusyEnable']").parent().hide();
$("[for^='CallForwardOnNoAnswerEnable']").parent().hide();
$("[for^='CallTransfer']").parent().hide();
$("[for^='CallHoldFlag']").parent().hide();
});
})();
<%
end
%>
</script><script>
<% if "136" == CountryCode then %>
$("[id^='CallForwardUnconditionalEnable'],[id^='CallForwardOnBusyEnable'],[id^='CallForwardOnNoAnswerEnable'] input").attr("disabled","disabled").addClass("PostIgnore");
<% end %>
</script>
