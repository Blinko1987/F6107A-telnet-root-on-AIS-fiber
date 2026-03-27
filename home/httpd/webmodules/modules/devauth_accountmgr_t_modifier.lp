<script type="text/javascript">
$.unsubscribe("/some/AccountPwdChk");
function checkPass(e,subTemplate,b,c)
{
jQuery.validator.addMethod(
"chkPass",
function(value, element)
{
if ( !(/[0-9]+/).test(value) ||
!(/[a-zA-Z]+/).test(value) ||
!(/[!"#$%&'()*+,-./:;<=>?@\[\\\]^_`{|}~]+/).test(value) ||
value.length < 6)
{
return false;
}
return true;
},
$.validator.format("&?ais_passcheck;")
);
var NewID = "[id^='"+ $("[id^='NewPassword']",subTemplate).attr("id")+"']";
var checkJSONTempObj = {
"rules": {
"Username": {
"required": true,
"ASCII": true,
"rangelength":[1,256]
},
"NewConfirmPassword": {
"ASCII": true,
"equalTo": NewID
},
"NewPassword": {
"ASCII": true,
"chkPass": true
}
},
"messages": {
}
};
subTemplate.setPromptCheckJSON(checkJSONTempObj, subTemplate);
}
$.subscribe("/some/AccountPwdChk", checkPass);
$.addModifier("devAccount/StrongChangeTips",function(data){
data.minLongth = 6;
})
</script>
<script>
<% if "156" == env.getenv("CountryCode") then%>
function CtcWANhideLAN(e,subTemplate,b,c){
var userObj = $("[id='template_AccountManag_1']",subTemplate);
if(userObj.length > 0)
{
userObj.remove();
}
}
$.subscribe("/some/ctcHideUser", CtcWANhideLAN);
<% end %>
</script><script>
<% if "98" == env.getenv("CountryCode") and "1" == env.getenv("Right") then%>
$.unsubscribe("/some/ctcHideUser");
function IndiaHathwayHideAdmin(e,subTemplate,b,c){
var adminObj = $("[id='template_AccountManag_0']",subTemplate);
if(adminObj.length > 0)
{
adminObj.remove();
$("[id='AccountManagBar:1]",subTemplate).attr("class","collapsibleBar collapsibleBarExp");
$("[id='AccountManag_container:1']",subTemplate).show();
}
}
$.subscribe("/some/ctcHideUser", IndiaHathwayHideAdmin);
<% end %>
</script>
