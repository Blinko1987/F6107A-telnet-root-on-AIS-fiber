$(document).ready(function(){
$("#Btn_apply").bind("click", function(){
var seclectuser = "";
var formInputContent = $("#Level").find("input");
formInputContent.each(function(key){
var Elems = $(this);
if (Elems.is(':checked'))
{
seclectuser = Elems.val();
return;
}
});
if(seclectuser == "")
{
var msg = "&?LogManag_023;";
var confirmLayerOBJ = IniConfirm(msg);
$("#confirmCancel",confirmLayerOBJ).css( "display","none" );
$("#confirmOK",confirmLayerOBJ).unbind("click").focus();
$("#confirmOK",confirmLayerOBJ).bind("click", function(event){
showWaitTip(false);
});
}
else
{
var postData = {};
postData["preempt_sessid"] = seclectuser;
postData["action"] = "preempt";
$.post( "/?_type=loginData&_tag=login_preempt", postData, undefined, "json" )
.done(function( data ) {
if ( data.login_need_refresh )
{
top.location.href = top.location.href;
}
});
postData = undefined;
}
});
$("#Btn_cancel").bind("click", function(){
var postData = {};
postData["action"] = "preempt_cancel";
$.post( "/?_type=loginData&_tag=login_preempt", postData, undefined, "json" )
.done(function( data ) {
if ( data.login_need_refresh )
{
top.location.href = top.location.href;
}
});
postData = undefined;
});
showWaitTip(false);
});
