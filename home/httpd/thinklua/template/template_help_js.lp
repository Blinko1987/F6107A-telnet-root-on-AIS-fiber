function showWaitTip(show, TipMsg, StopTag)
{
var TipMsgTmp = TipMsg;
if( show )
{
$("#blackMask,#tipLayer,#confirmBtnArea").css("display", "block");
if (TipMsgTmp == undefined || TipMsgTmp == "")
{
$("#waitingImgArea").css("display", "none");
if(true==StopTag)
{
$("#confirmStop").css("display", "block");
$("#confirmCancel,#confirmOK").css("display", "none");
}
else
{
$("#confirmStop").css("display", "none");
$("#confirmCancel,#confirmOK").css("display", "block");
}
}
else
{
$("#confirmLayer, #waitingImgArea").css("display", "block");
$("#confirmMsg p").text(TipMsgTmp);
if(true==StopTag)
{
$("#confirmStop").css("display", "block");
$("#confirmCancel,#confirmOK").css("display", "none");
}
else
{
$("#confirmCancel,#confirmOK,#confirmStop").css("display", "none");
}
}
reposition_box("tipLayer");
}
else
{
$("#blackMask, #tipLayer, #confirmLayer").css("display", "none");
}
}
function IniConfirm(msg)
{
showWaitTip(true);
var confirmLayerOBJ = $("#confirmLayer");
confirmLayerOBJ.css("display", "block");
$("#confirmMsg p",confirmLayerOBJ).text(msg);
$("#confirmCancel",confirmLayerOBJ).unbind( "click" );
$("#confirmOK",confirmLayerOBJ).unbind( "click" );
$("#confirmStop",confirmLayerOBJ).unbind( "click" );
$("#confirmCancel",confirmLayerOBJ).bind("click", function(event){
showWaitTip(false);
});
$("#confirmCancel",confirmLayerOBJ).focus();
return confirmLayerOBJ;
}
function IniTip(msg, infoType)
{
showWaitTip(true);
var confirmLayerOBJ = $("#confirmLayer");
$("#confirmCancel",confirmLayerOBJ).css("display", "none");
confirmLayerOBJ.css("display", "block");
if (infoType == "err")
{
$("#confirmMsg",confirmLayerOBJ).css("background", 'url("../img/err_m.png") no-repeat 20px 50%');
}
else if (infoType == "succ")
{
$("#confirmMsg",confirmLayerOBJ).css("background", 'url("../img/succ_m.png") no-repeat 20px 50%');
}
else
{
$("#confirmMsg",confirmLayerOBJ).css("background", 'url("../img/info_m.png") no-repeat 20px 50%');
}
$("#confirmMsg p",confirmLayerOBJ).text(msg);
$("#confirmCancel",confirmLayerOBJ).unbind( "click" );
$("#confirmOK",confirmLayerOBJ).unbind( "click" );
$("#confirmStop",confirmLayerOBJ).unbind( "click" );
$("#confirmOK",confirmLayerOBJ).bind("click", function(event){
showWaitTip(false);
$("#confirmMsg",confirmLayerOBJ).css("background", 'url("../img/info_m.png") no-repeat 20px 50%');
});
$("#confirmOK",confirmLayerOBJ).focus();
return confirmLayerOBJ;
}
function getStyle(obj,attr)
{
if (obj.currentStyle)
{
return obj.currentStyle[attr];
}
else
{
return document.defaultView.getComputedStyle(obj,null)[attr];
}
}
function reposition_box(divId)
{
var box=document.getElementById(divId);
if (null!=box)
{
var boxObj = $("#"+divId);
var winH = $(window).height();
var winW = $(window).width();
var divH = boxObj.height();
var divW = boxObj.width();
var h = (winH-divH)/2;
h = (h > 0) ? h : 5;
var w = (winW-divW)/2;
w = (w > 0) ? w : 5;
boxObj.css({top:h, left:w});
if ( divH > winH || divW > winW)
{
boxObj.css("position", "absolute");
}
else
{
boxObj.css("position", "fixed");
}
}
}
