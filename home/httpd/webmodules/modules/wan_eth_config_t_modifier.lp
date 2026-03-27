<script>
<%
if "154" == CountryCode then
%>
$.addModifier("Internet/DSCP/DisplayCtr",function(data){
data.dscpv6 = true;
});
<%
if "3" == env.getenv("Right") then
%>
(function(){
$(document).ready(function(){
$("input,select").attr("disabled",true);
$(".Button,.addInstBar").remove();
$("[id^='instDelete_Internet']").remove();
});
})();
<%
end
end
%>
</script><script>
<%
local sess_id = cgilua.getCurrentSessID()
local uRight = session_get(sess_id, "Right")
local cver = env.getenv("CountryCode")
if cver == "163" then
if uRight == "1" then
env.setenv("deleteWan","1")
else
env.setenv("deleteWan","0")
end
end
if cver == "156" or cver == "61" or cver == "140" then
env.setenv("ShowWanPassword","1")
else
env.setenv("ShowWanPassword","0")
end
if cver == "36" and uRight == "2" then
env.setenv("ShowWanUsername","0")
else
env.setenv("ShowWanUsername","1")
end
local HardwareVer = ""
local t = cmapi.getinst("OBJ_DEVINFO_ID", "")
if t.IF_ERRORID == 0 then
HardwareVer = t["HardwareVer"]
end
if cver == "68" then
%>
function unnumberedChange (e,subTemplate,b,c)
{
$("[id^='Unnumbered']", subTemplate).hide();
$("[id^='Unnumbered']", subTemplate).addClass("PostIgnore");
}
$.subscribe("/some/unnumberedModify", unnumberedChange);
<%
end
%>
$(document).ready(function(){
});
</script><script>
<%
if CountryCode == "163" and "2" == Right then
%>
(function(){
$(document).ready(function(){
$(".addInstBar").remove();
$("#instDelete_Internet").remove();
});
})();
function judgeWan(e,subTemplate,b,c)
{
var xml=arguments[1];
if( getParaValueInXML(xml, "ID_WAN_COMFIG", wanIndex, "StrServList") != "INTERNET" ||
getParaValueInXML(xml, "ID_WAN_COMFIG", wanIndex, "linkMode") != "IP" ||
getParaValueInXML(xml, "ID_WAN_COMFIG", wanIndex, "WANCName") == "COMMUNITY WIFI")
{
isDisplay = true;
}
}
$.unsubscribe("/some/isDisplayWan");
$.subscribe("/some/isDisplayWan", judgeWan);
function disabledWanId(e,subTemplate,b,c)
{
$("[id^='div_WANCName:'],[id^='Prefix_mode:'],[id^='Prefix_MTU:'],[id^='Prefix_linkMode:'],[id^='Prefix_IpMode:']",subTemplate).hide();
$("[id^='Prefix_ServList:'],[id^='foripvS:'],[id^='forVlan:'],[id^='IsNAT:']",subTemplate).hide();
}
$.unsubscribe("/some/displayWanElem");
$.subscribe("/some/displayWanElem", disabledWanId);
$.addModifier("Internet/undisplayVlan",function(data){
$("[id^='forVlan:']",data.template).hide();
});
<%
end
%>
</script><script>
<%
if "140" == CountryCode then
%>
$(document).ready(function(){
$("[id^='Password']").val("").removeClass("SpecialPassword");
})
<%
end
%>
</script><script>
<% if "36"==CountryCode and "2"==Right then %>
$.addModifier("WANConf/enCodePPPOEUsername", function(data){
var nameObj = $("#UserName", data.template);
nameObj.replaceWith("<input class='w150 SpecialPassword' type='password' id='UserName' name='UserName' value='						' autocomplete='new-password'/>");
$("[id^='UserName']", data.template).each(function(){
$(this).mouseup( function(){
if(this.focused){
this.focused=false;
return false;
}
});
});
$("[id^='UserName']", data.template).each(function(){
$(this).focus( function(){
this.select();
this.focused=true;
});
});
});
$.addModifier("WANConf/checkPPPOEUsername", function(data){
data.template.rules.UserName["PasswordASCII"] = true;
delete data.template.rules.UserName["ASCII"];
});
<% end %>
</script><script>
</script><script>
<%
if "68" == env.getenv("CountryCode") then
%>
$.addModifier("Internet/DSCP/DisplayCtr",function(data){
data.dscpv6 = true;
});
<%
end
%>
</script>
<script type="text/javascript">
<%
if CountryCode == '125' and Right == "2" then
%>
$.addModifier("/WANClone/specialCustom",function(data){
var OBJ = data.template;
var modevalue= $("[id^='mode']",OBJ).val();
if (modevalue=="bridge")
{
$("[id^='Btn_cancel_internet']", OBJ).attr("disabled", "disabled").addClass("disableBtn");
$("[id^='Btn_apply_internet']", OBJ).attr("disabled", "disabled").addClass("disableBtn");
$("[id^='Enable1']", OBJ).attr("disabled", "disabled");
$("[id^='Enable0']", OBJ).attr("disabled", "disabled");
$("[id^='VLANID']", OBJ).attr("disabled", "disabled");
}
});
<%
end
%>
</script><script>
<% if "120" == CountryCode then %>
$.addModifier("Internet/UpdateServelistName",function(data){
$("#ServList option[value='3']").text("TR069_INTERNET");
$("#ServList option[value='4']").text("VOIP");
$("#ServList option[value='8']").text("IPTV");
var str2 = new RegExp("&?InternetDE_088;","g");
data.template[2] = data.template[2].replace(str2,"TR069_INTERNET");
var str3 = new RegExp("&?InternetDE_089;","g");
data.template[3] = data.template[3].replace(str3,"VOIP");
var str7 = new RegExp("&?InternetDE_093;","g");
data.template[7] = data.template[7].replace(str7,"IPTV");
})
<%
end
%>
</script><script>
<% if CountryCode == "139" then %>
$.addModifier("/Internet/customActionBeforeAddInst", function(data){
var ipmodeObj = $("[id^='IpMode']", data.tmp);
ipmodeObj.val("Both");
ipmodeObj.change();
})
<% end %>
</script><script type="text/javascript">
<% if CountryCode == "2009" then %>
$.addModifier("Internet/MTU/changeRange",function(data){
data.template.PPP = {
"IPv4" : {
"PPPoE" : [128, 1500],
"PPPoA" : [128, 1540]
},
"IPv6" : {
"PPPoE" : [1280, 1500],
"PPPoA" : [1280, 1540]
},
"Both" : {
"PPPoE" : [1280, 1500],
"PPPoA" : [1280, 1540]
}
}
});
<%end%>
</script><script>
<%
if "187" == CountryCode then
%>
$.addModifier("/Internet/customActionBeforeAddInst", function(data){
var ipmodeObj = $("[id^='IpMode']", data.tmp);
ipmodeObj.val("Both");
ipmodeObj.change();
})
<%
end
%>
</script>
