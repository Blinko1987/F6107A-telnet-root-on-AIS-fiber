<script type="text/javascript">
<%
if "77" == env.getenv("CountryCode") then
%>
(function(){
$(document).ready(function(){
$("#div_CpuUse").showIt(true);
});
})();
<%
end
%>
</script><script type="text/javascript">
<%
if env.getenv("CountryCode") == "1" then
%>
function SNToUpper(e,subTemplate,b,c)
{
var SNText = $("#SerialNumber",subTemplate).text();
var SNSplit = SNText.split('-');
SNText = SNSplit[1].toUpperCase();
$("#SerialNumber",subTemplate).html(SNText);
}
$.unsubscribe("/some/SNShow");
$.subscribe("/some/SNShow", SNToUpper);
<%
end
%>
</script>
<script type="text/javascript">
(function(){
$(document).ready(function(){
$("#div_VerDate").showIt(true);
<% if env.getenv("OperationMode")=="0" then %>
$("#div_SubVersion").showIt(true);
<%end%>
});
})();
</script><script type="text/javascript">
<% if "39" == CountryCode then %>
$.addModifier("ManagStatus/paramsCtr",function(data){
var TCpuUsage = "";
for (var i = 1;i <= data.CpuNum;i++)
{
if(i != 1)
TCpuUsage = TCpuUsage + ";";
var tmp = getParaValueInXML(data.xml, "OBJ_CPUMEMUSAGE_ID", 0, "CpuUsage"+i);
if(tmp == "0")
TCpuUsage = TCpuUsage + tmp;
else
TCpuUsage = TCpuUsage + tmp + "%";
}
$("#CpuUsage").html(TCpuUsage);
});
(function(){
$(document).ready(function(){
$("#div_CpuUse,#div_MemUse").showIt(true);
});
})();
<% end %>
</script><script>
<%
local sess_id = cgilua.getCurrentSessID()
local uRight = session_get(sess_id, "Right")
if "68" == env.getenv("CountryCode") and uRight == "2" then
%>
(function(){
$(document).ready(function(){
$("#div_HardwareVer").hide();
$("#div_SoftwareVer").hide();
$("#div_BootVer").hide();
return;
});
})();
<%
end
%>
</script>
<script type="text/javascript">
<% if env.getenv("CountryCode") == "131" then %>
$(document).ready(function(){
<%
local retTable = nil
local Sn
retTable = cmapi.getinst("OBJ_SN_INFO_ID", "")
if type(retTable) ~= "table" then
g_logger:warn("retTable is not a table!")
end
if retTable.IF_ERRORID == 0 then
Sn = retTable["Sn"]
end
%>
$("#div_BootVer").after("<div id='div_Ponsn' class='colorTblRow' ><span class='w250 emFont' title='&?StatusManag_ponsn;'>&?StatusManag_ponsn;</span><span class='w250' id='ponsn' title='<%=Sn%>'><%=Sn%></span></div>")
$("#SerialNumber").parent().hide();
return;
});
<% end %>
</script><script type="text/javascript">
<% if CountryCode == "120" then %>
$(document).ready(function(){
<%
local retTable = nil
local Sn
retTable = cmapi.getinst("OBJ_SN_INFO_ID", "")
if type(retTable) ~= "table" then
g_logger:warn("retTable is not a table!")
end
if retTable.IF_ERRORID == 0 then
Sn = string.upper(retTable["Sn"])
end
%>
$.addModifier("ManagStatus/paramsCtr",function(data){
$("#SerialNumber").html("<%=Sn%>")
})
return;
});
<% end %>
</script><script type="text/javascript">
<% if "139" == CountryCode then %>
$.addModifier("ManagStatus/paramsCtr",function(data){
var PowerOnTime = parseInt(getParaValueInXML(data.xml, "OBJ_POWERONTIME_ID", 0, "PowerOnTime"));
var tmpday = 0;
var tmphour = 0;
var tmpmin = 0;
var tmpsec = 0;
if(!isNaN(PowerOnTime))
{
tmpmin = parseInt((PowerOnTime%3600)/60);
tmpsec = PowerOnTime%60;
tmpday = parseInt(PowerOnTime/(3600*24));
tmphour = parseInt((PowerOnTime%(3600*24))/3600)
}
$("#PoweronTime").html(tmpday + "&?statusuptime_001;" + tmphour+"&?statusuptime_002;"+tmpmin+"&?statusuptime_003;"+tmpsec+"&?statusuptime_004;");
});
(function(){
$(document).ready(function(){
$("#div_Time").showIt(true);
});
})();
<% end %>
</script>
