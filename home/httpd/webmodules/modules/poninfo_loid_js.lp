<script type="text/javascript">
(function(){
jQuery.validator.addMethod("spaceForbid", function(value, element) {
return ( this.optional(element) || value.match("[ ]") == null );
}, $.validator.format("&?PON_007;"));
function initial_template_PonLoidHead(templateID)
{
var template = $("#"+templateID);
var instForm = template.find("form");
instForm.validate({
"rules": {
"PonLoid": {
"ASCII": true,
"required": true,
"rangelength":[1,24],
"spaceForbid":true
},
"LoidPasswd": {
<% if "1" == CountryCode then %>
"ASCII": true,
<% else %>
"PasswordASCII": true,
<% end %>
"rangelength":[0,12]
}
},
"messages": {
}
});
template.bind("fillDataByApplyResult", function(event,xml, template){
ActionByApplyResult(xml, template);
});
template.bind("fillDataByCancelResult", function(event,xml, template){
var OBJID = ["OBJ_PON_LOID_ID"];
ActionByCancelResult(xml, template, OBJID);
});
if(commConf.passCanSee.indexOf("Loid") != -1){
g_ChangePass2See(template,"LoidPasswd");
}
}
$(document).ready(function(){
var HeadID = "PonLoidHead";
var Head = $("#"+HeadID);
var template = $("#template_"+ HeadID);
var ServerAddr = $("address span", Head).text();
initial_template_PonLoidHead("template_"+HeadID);
<% if CountryCode == "14" then %>
$(".Btn_apply").unbind("click");
$(".Btn_apply").bind("click", {templateOBJ:template}, function(event){
var template = event.data.templateOBJ;
var msg = "&?PON_011;";
var confirmLayerOBJ = IniConfirm(msg);
$("#confirmOK",confirmLayerOBJ).bind("click", {FuncOBJ: template}, function(event){
showWaitTip(false);
var template = event.data.FuncOBJ;
var Head = template.parents(".HeadDIV");
var ServerAddr = $("address span", Head).text();
dataPost("Apply", "fillDataByApplyResult", ServerAddr, template, undefined, true);
});
});
<% end %>
Head.succfunction = function(xml){
var cmapiErrorContainer = $(".errorHint",Head);
if (cmapiErrorContainer.hasError(xml) == 0)
{
var OBJ = $(xml).find("OBJ_PON_LOID_ID");
var RuleNum = $("Instance", OBJ).length;
var tempobj = $("#template_PonLoidHead");
var OBJID = ["OBJ_PON_LOID_ID"];
Head.fillDataByOBJID(xml, OBJID, tempobj, 0);
<% if Right == "2" and env.getenv("RestoreFlag") == "1" then %>
$("[id^='PonLoid']",template).attr("disabled", "disabled");
$("[id^='LoidPasswd']",template).attr("disabled", "disabled");
$("[id^='Btn_cancel']",template).attr("disabled", "disabled");
$("[id^='Btn_apply']",template).attr("disabled", "disabled");
<% end %>
}
};
if ( $(".collapBarWithDataTrans",Head).length <= 0 )
{
Head.dataTransfer(ServerAddr,
"GET",
Head.succfunction);
}
else
{
initial_collapBarWithDataTrans(Head);
}
});
})();
</script>
