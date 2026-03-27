<script type="text/javascript">
$(document).ready(function(){
initial_sceneTip();
initial_CollapsibleBar();
initial_addInstLink();
initial_QueryAccessDeviceLink();
initial_TimeCtl();
$(".HeadDIV").each(function(){
var Head = $(this);
var HeadID = Head.attr("id");
var template = $("#template_"+HeadID,Head);
var formOBJ = $("form",Head);
if ( ! formOBJ.attr("onsubmit") )
{
formOBJ.attr("onsubmit", "return false;");
}
var stopFormAutoSubmitStr = "<input type='text' id='_stopFormAutoSubmit'"
+" value='' class='PostIgnore'"
+" style='display:none;'>";
formOBJ.prepend(stopFormAutoSubmitStr);
initial_button("Apply", Head);
initial_button("Cancel", Head);
initial_button("Delete", Head);
initialCtrlAllLink(Head);
initial_special_password(Head);
var collapsibleInstObj = $(".collapsibleInst",template);
collapsibleInstObj.unbind("click");
collapsibleInstObj.click(function(event){
var collapsibleInst = $(this);
var template = collapsibleInst.parents("[id^='template_']");
var ChangeArea = $(".ChangeArea",template);
if ( ChangeArea.is(":hidden") )
{
ChangeArea.showIt(true);
collapsibleInst.addClass("instNameExp");
}
else
{
ChangeArea.showIt(false);
collapsibleInst.removeClass("instNameExp");
$(".Btn_cancel",ChangeArea).click();
}
});
$(".utf8Compatible", template).each(function(){
var thisObj = $(this);
var dTip = thisObj.text();
var dTipArr = dTip.split("");
var firstNum = "";
var secNum = "";
var firstNumStart = "";
var firstNumEnd = "";
var secNumStart = "";
var secNumEnd = "";
var Nums = 0;
var newTip = "";
dTipArr = $.grep(dTipArr, function(n,i){
return n != " ";
});
dTip = dTipArr.join("");
for(var i=0; i<dTipArr.length; i++)
{
if (Nums > 2)
{
thisObj.remove();
break;
}
if (isNaN(dTipArr[i]) == false)
{
if (firstNumStart == "")
{
firstNumStart = i;
firstNumEnd = parseInt(i)+1;
Nums += 1;
}
else
{
if (secNumStart == "")
{
if (firstNumEnd == i)
{
firstNumEnd = parseInt(i)+1;
}
else
{
secNumStart = i;
secNumEnd = parseInt(i)+1;
Nums += 1;
}
}
else
{
if (secNumEnd == i)
{
secNumEnd = parseInt(i)+1;
}
else
{
Nums = 3;
}
}
}
}
}
if (firstNumStart != "" && secNumStart != "")
{
firstNum = dTip.slice(firstNumStart, firstNumEnd);
secNum = dTip.slice(secNumStart, secNumEnd);
newTip = dTip.slice(0, firstNumStart)+" ";
if (parseInt(secNum) < 3)
{
var prevObjId = thisObj.prev().attr("id");
alert("Element[id='"+prevObjId+"']'s length range ["+ firstNum+","+secNum+"] will be invalid after utf-8 transforming!");
}
else
{
firstNum = Math.ceil(parseInt(firstNum) / 3);
secNum = Math.floor(parseInt(secNum) / 3);
if (firstNum < secNum)
{
firstNum=reformString(firstNum.toString(), 3);
secNum=reformString(secNum.toString(), 3);
newTip += firstNum + " ~ " + secNum;;
}
else if (firstNum == secNum)
{
secNum=reformString(secNum.toString(), 3);
newTip += secNum;
}
else
{
var prevObjId = thisObj.prev().attr("id");
alert("Element[id='"+prevObjId+"']'s length range ["+firstNum+","+secNum+"] is invalid after utf-8 transforming!");
}
}
}
else
{
thisObj.remove();
}
if (newTip != "")
{
thisObj.text(newTip);
}
});
template.on("focus.dTip","input[type='text'],input[type='password']", function(){
var thisObj = $(this);
if (thisObj.attr("readonly")) {
return;
}
var msg = thisObj.next("span").not(".__CheckPwdStrength").text();
if (msg != "")
{
var pos = thisObj.offset();
var objWidth = thisObj.width();
var dhtml = "<div id='dynamicTip'><div id='dTip_l'></div>"
+ "<div id='dTip_m'>"
+ msg
+ "</div><div id='dTip_r'></div></div>";
var dtObj = $(dhtml).css({top:(pos.top-33)+'px',left:(pos.left+objWidth+8)+'px'});
dtObj.appendTo('body').fadeIn(400);
thisObj.bind("blur.dTip",function(){
dtObj.remove();
});
}
var fObj = $(":focus");
var tObj = $("#dynamicTip");
if ( (tObj.length > 0) && (fObj.attr("id") != thisObj.attr("id")) )
{
tObj.remove();
}
});
$("input.ip,input.mac", template).each(function(){
var InputOBJ = $(this);
InputOBJ.unbind("keydown");
InputOBJ.unbind("keyup");
InputOBJ.keydown(function(event){
autoJumpBack(this,this.value,event);
});
InputOBJ.keyup(function(event){
FocusAutoJump(this,this.value,event);
});
});
$(".instSwitch input",template).each(function(){
var InputOBJ = $(this);
if (InputOBJ.attr("type") == "radio")
{
InputOBJ.unbind("change");
InputOBJ.change(function(event){
var template = $(this).parents("[id^='template_']");
var ChangeArea = $(".ChangeArea",template);
var _InstIDName = "_InstID";
var _InstIDValue = template.find("[id^='_InstID']").val();
var luquidObjUl = $("._LuQUID_CONFIG_OBJID", Head);
var objId = $("li", luquidObjUl).eq(0).text();
if ( _InstIDValue == undefined )
{
var instId = objId + "\\._OBJ_InstID";
_InstIDValue = $("[id^='"+ instId +"']",template).val();
_InstIDName = objId + "._OBJ_InstID";
}
if ( ChangeArea.is(":hidden")
&& _InstIDValue != "-1" )
{
var ServerAddr = template.parents(".HeadDIV").find("address span").text();
var instSwitchName = colonStripping(InputOBJ.attr("name"));
var instSwitchValue = InputOBJ.val();
var PostData = "IF_ACTION=Apply"+"&"
+ instSwitchName+"="+instSwitchValue+"&"
+ _InstIDName+"=" + _InstIDValue;
var actionType = "InstSwitch";
var PostSuccHandler = "fillDataByInstSwitchResult";
dataPost(actionType, PostSuccHandler, ServerAddr, template, PostData);
}
});
}
});
template.unbind("fillDataByInstSwitchResult");
template.bind("fillDataByInstSwitchResult", function(event,xml, template){
if ( template.hasError(xml) == 0 )
{
return;
}
$(".ChangeArea",template).showIt(true);
$(".collapsibleInst",template).addClass("instNameExp");
});
template.unbind("fillDataByDeleteResult");
template.bind("fillDataByDeleteResult", function(event,xml, template){
if ( template.hasError(xml) == 0 )
{
template.remove();
}
else
{
$(".ChangeArea",template).showIt(true);
}
});
initialStatusArea(Head);
initialConfigArea(Head);
});
$("[id^='AreaHideAttr']").each(function(){
var HideAttr = $(this);
var HeadID = $(this).next().next().attr("id") || $(this).next().attr("id");
var template = $("#template_"+HeadID);
if (HideAttr.html() == <%=Right%>){
template.find("*").attr("disabled",true).attr("hideattr",true);
$("[class^='Button']", template).addClass("disableBtn");
$("[class^='longBtn']", template).addClass("disableBtn");
$("[class^='instDelete Btn_delete']").remove();
$("[class^='addInstBar AddContentContainer']").remove();
$("[id^='Btn_cancel_'],[id^='Btn_apply_']", template).unbind();
$("[class^='Button Btn_refresh']").removeClass("disableBtn").attr("disabled",false);
}
});
});
</script>
