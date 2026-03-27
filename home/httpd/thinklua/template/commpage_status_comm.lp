var ssidConf = {};
var commConf = {};
var wanConf = {};
var voipConf = {};
var lanConf = {};
var curRight = "<%=Right%>";
<%
local cjson = require"common_lib.json"
if _G.ssidConf[Right] ~= nil then
%>
ssidConf = JSON.parse('<%=cjson.encode(_G.ssidConf[Right])%>');
<%
end
%>
commConf = JSON.parse('<%=cjson.encode(_G.commConf)%>');
if (!commConf.dataSave)
{
commConf.dataSave = 2000;
}
wanConf = JSON.parse('<%=cjson.encode(_G.wanConf)%>');
voipConf = JSON.parse('<%=cjson.encode(_G.voipConf)%>');
lanConf = JSON.parse('<%=cjson.encode(_G.lanConf)%>');
String.prototype.format = function(args) {
var result = this;
if (arguments.length > 0)
{
for (var i = 0; i < arguments.length; i++)
{
if (arguments[i] != undefined) {
var reg = new RegExp("({[" + i + "]})", "g");
result = result.replace(reg, arguments[i]);
}
}
}
return result;
};
function showOrHideRowDiv()
{
if (arguments.length < 2)
{
return;
}
var action = arguments[0];
for(var i = 1; i < arguments.length; i++)
{
var subWidget = arguments[i].find("*[id!='']")
if ( action == "show" )
{
arguments[i].showIt(true);
subWidget.removeClass("PostIgnore");
}
else
{
arguments[i].showIt(false);
subWidget.addClass("PostIgnore");
}
}
}
function colonStripping(str)
{
var colonLocation = str.indexOf(":");
if ( colonLocation != -1 )
{
return str.substring(0, colonLocation);
}
return str;
}
function colonStrippingLast(str)
{
var colonLocation = str.lastIndexOf(":");
if ( colonLocation != -1 )
{
return str.substring(0, colonLocation);
}
return str;
}
function randomNum(n){
var t='';
for(var i=0;i<n;i++)
{
t+=Math.floor(Math.random()*10);
}
return t;
}
function checkPassStrong(sz)
{
if(/[a-z]/.test(sz) && /[A-Z]/.test(sz) && /[0-9]/.test(sz) && (sz.length >= 8))
{
return true;
}
return false;
}
function asyEncode(srcStr)
{
var pubKey = "-----BEGIN PUBLIC KEY-----\nMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAodPTerkUVCYmv28SOfRV\n7UKHVujx/HjCUTAWy9l0L5H0JV0LfDudTdMNPEKloZsNam3YrtEnq6jqMLJV4ASb\n1d6axmIgJ636wyTUS99gj4BKs6bQSTUSE8h/QkUYv4gEIt3saMS0pZpd90y6+B/9\nhZxZE/RKU8e+zgRqp1/762TB7vcjtjOwXRDEL0w71Jk9i8VUQ59MR1Uj5E8X3WIc\nfYSK5RWBkMhfaTRM6ozS9Bqhi40xlSOb3GBxCmliCifOJNLoO9kFoWgAIw5hkSIb\nGH+4Csop9Uy8VvmmB+B3ubFLN35qIa5OG5+SDXn4L7FeAA5lRiGxRi8tsWrtew8w\nnwIDAQAB\n-----END PUBLIC KEY-----";
var encrypt = new JSEncrypt();
encrypt.setPublicKey(pubKey);
var encrypted = encrypt.encrypt(srcStr);
var dstStr = encrypted.toString();
if(dstStr.length == 0 || dstStr == "false")
{
console.log("encrypt key fail!");
dstStr = "";
}
return dstStr;
}
function encodeKey(key,iv)
{
var kv = key + "+" + iv;
return asyEncode(kv);
}
function encodeParaValue(src,key,iv)
{
if(src.length > 0)
{
var bKey = CryptoJS.SHA256(key);
var bIv = CryptoJS.SHA256(iv);
var encrypted =CryptoJS.AES.encrypt(src,bKey,
{
iv:bIv,
mode:CryptoJS.mode.CBC,
padding:CryptoJS.pad.ZeroPadding
});
var dst = encrypted.toString();
if(dst != "" && dst != "failed")
{
return dst;
}
}
return src;
}
function decodeParaValue(src,key,iv)
{
if(src.length > 0)
{
var bKey = CryptoJS.SHA256(key);
var bIv = CryptoJS.SHA256(iv);
var decrypted =CryptoJS.AES.decrypt(src,bKey,
{
iv:bIv,
mode:CryptoJS.mode.CBC,
padding:CryptoJS.pad.ZeroPadding
});
var dst = decrypted.toString(CryptoJS.enc.Utf8);
if(dst != "" && dst != "failed")
{
return dst;
}
}
return src;
}
function getDecodeValue(data)
{
var key = _sessionTmpToken;
var iv = key.split("").reverse().join("");
return decodeParaValue(data,key,iv);
}
jQuery.fn.showIt = function(show) {
if (show)
{
$(this).css("display", "");
}
else
{
$(this).css("display", "none");
}
};
jQuery.fn.disableIt = function(disable) {
if (disable)
{
$(this).attr("disabled", "disabled");
$(this).addClass("PostIgnore");
}
else if( undefined == $(this).attr("hideattr") )
{
$(this).prop("disabled", "");
$(this).removeClass("PostIgnore");
}
};
jQuery.fn.disableButton = function(disable) {
if (disable)
{
$(this).addClass("disableBtn");
}
else if( undefined == $(this).attr("hideattr"))
{
$(this).removeClass("disableBtn");
}
};
function GetSuffixedIDorName(oldValue, suffix, splitter, forParaName)
{
var newValue = "";
if ( forParaName == true )
{
oldValue = oldValue.split(":");
oldValue[0] += splitter + suffix;
newValue = oldValue.join(":");
}
else
{
newValue = oldValue + splitter + suffix;
}
return newValue;
}
jQuery.fn.cloneWithSuffix = function(suffix, splitter, forParaName) {
var source = $(this);
var clone = source.clone(true);
clone.attr("id", clone.attr("id")+"_"+suffix);
if ( undefined == splitter )
{
splitter = ":";
}
if ( undefined == forParaName )
{
forParaName = false;
}
var idElems = clone.find("*[id!='']");
idElems.each(function(){
var idEle = $(this);
var oldID = idEle.attr("id");
if (oldID != undefined)
{
var newID = GetSuffixedIDorName(oldID, suffix, splitter, forParaName);
idEle.attr("id", newID);
}
var oldName = idEle.attr("name");
if (oldName != undefined)
{
var newName = GetSuffixedIDorName(oldName, suffix, splitter, forParaName);
idEle.attr("name", newName);
}
});
labelForElems = clone.find("label");
labelForElems.each(function(){
var labelForEle = $(this);
var oldFor = labelForEle.attr("for");
if (oldFor != undefined)
{
var newFor = GetSuffixedIDorName(oldFor, suffix, splitter, forParaName);
labelForEle.attr("for", newFor);
}
});
clone.trigger("applyPromptCheckJSON", [clone]);
return clone;
};
function initial_sceneTip()
{
$(".sceneTip_container").each(function(){
$(this).hide();
});
$(".sceneTipLink").each(function(){
var sceneTipLinkContent = $(this).children();
sceneTipLinkContent.unbind( "click" );
sceneTipLinkContent.click(function(event){
event.preventDefault();
$(this).parent().next().slideToggle("normal");
});
});
$(".sceneTip_close").each(function(){
var sceneTip_closeLink = $(this).children();
sceneTip_closeLink.unbind( "click" );
sceneTip_closeLink.click(function(){
$(this).parent().parent().slideUp("normal");
});
});
}
function succHintShow(template)
{
var PostFeedbackOBJ = $(".succHint",template);
PostFeedbackOBJ.fadeIn(1000);
window.setTimeout(
function() {
PostFeedbackOBJ.fadeOut(1000);
PostFeedbackOBJ.hide();
},
commConf.dataSave
);
}
jQuery.fn.dataTransfer = function(URL, transferType, success_func, error_func, IfShowWaitTip, async, dataType){
if ( !URL || URL == "" )
{
consoleLog("[dataTransfer]URL is illegal!");
return;
}
var IfShowWaitTipTmp = IfShowWaitTip;
if ( IfShowWaitTipTmp == undefined )
{
IfShowWaitTipTmp = true;
}
var asyncTemp = async;
if ( asyncTemp == undefined )
{
asyncTemp = true;
}
if ( IfShowWaitTipTmp == true )
{
showWaitTip(true);
}
var Head = $(this);
$.ajax({
url:URL,
type: transferType,
timeout: 30000,
async: asyncTemp,
cache:false,
error: function(){
if ($.isFunction(error_func))
{
error_func();
}
else
{
if (Head != undefined)
{
var ajaxTransferFailHint = "&?public_076;";
var externErrorHint = $(".externErrorHint",Head);
if ( externErrorHint != undefined )
{
$("span",externErrorHint).text(ajaxTransferFailHint);
externErrorHint.showIt(true);
}
}
showWaitTip(false);
}
},
success: function(data){
success_func(data);
if ( IfShowWaitTipTmp == true )
{
showWaitTip(false);
}
}
});
};
function HTMLEnCode(str)
{
var s = "";
if (typeof(str) != "string")
{
return str;
}
if(str.length == 0)
{
return "";
}
s = str.replace(/&/g, "&#38;");
s = s.replace(/</g, "&#60;");
s = s.replace(/>/g, "&#62;");
s = s.replace(/ /g, "&#32;");
s = s.replace(/\'/g, "&#39;");
s = s.replace(/\"/g, "&#34;");
return s;
}
function addSlash(srcStr)
{
var str = "";
var ch = "";
if (typeof(srcStr) != "string")
{
return srcStr;
}
for(var i = 0; i < srcStr.length; i++)
{
ch = srcStr.substr(i, 1);
if( "\\" == ch )
{
ch = "\\\\";
}
else if( "\'" == ch )
{
ch = "\\\'";
}
else if( "\"" == ch )
{
ch = "\\\"";
}
str = str + ch;
}
return str;
}
function SetSelectValue(SelectElem, data)
{
$("option[class='_optExpHandle']", SelectElem).remove();
var findOption = 0;
$("option", SelectElem).removeAttr("selected");
$("option", SelectElem).each(function(){
var OptionObj = $(this);
if ( OptionObj.val() == data )
{
findOption = 1
return false;
}
});
if ( findOption == 0 )
{
SelectElem.append("<option value='"+ HTMLEnCode(data)
+ "' title='&?public_141;' class='_optExpHandle'>"
+ "&?public_141;" + "</option>");
}
SelectElem.val(data);
}
jQuery.fn.fillDataByType = function(data){
var Elems = $(this);
if (Elems.is("input"))
{
switch (Elems.attr("type"))
{
case "hidden":
{
Elems.val(data);
if (Elems.attr("_LuQUID_splitMACID") != undefined)
{
var splitMACID = Elems.attr("_LuQUID_splitMACID");
Elems.FillIPorMacDataBySplit(splitMACID, ":", 6);
}
else if (Elems.attr("_LuQUID_splitIPID") != undefined)
{
var splitIPID = Elems.attr("_LuQUID_splitIPID");
Elems.FillIPorMacDataBySplit(splitIPID, ".", 4);
}
break;
}
case "text":
case "password":
{
if( commConf.getEncode && Elems.attr("encode") == "1")
{
data = getDecodeValue(data);
}
Elems.val(data);
if (typeof(Elems.attr("title")) != "undefined")
{
Elems.attr("title", data);
}
break;
}
case "checkbox":
{
if( 1 == data )
{
Elems.prop("checked", true);
}
else
{
Elems.prop("checked", false);
}
Elems.val(data);
break;
}
default:
{
break;
}
}
}
else if (Elems.is("span"))
{
Elems.text(data);
if (typeof(Elems.attr("title")) != "undefined")
{
Elems.attr("title", data);
}
}
else if (Elems.is("a"))
{
Elems.text(data);
Elems.attr("href",data);
}
else if (Elems.is("select"))
{
SetSelectValue(Elems, data);
}
else if (Elems.is("textarea"))
{
Elems.val(data);
}
else if (Elems.is("label"))
{
Elems.text(data);
}
else if (Elems.is("div"))
{
var radioObj = $("input[type=radio]", Elems);
radioObj.each(function(){
var thisObj = $(this);
if (thisObj.val() == data)
{
thisObj.prop("checked", true);
}
else
{
thisObj.prop("checked", false);
}
});
}
else if (Elems.is("td"))
{
Elems.text(data);
if (typeof(Elems.attr("title")) != "undefined")
{
Elems.attr("title", data);
}
}
else
{
}
};
function fillEncodeAttr(data, OBJIDs, Clone)
{
if ($.isPlainObject(data))
{
$.each(OBJIDs,function(i,obj){
if(data[obj] != undefined && data[obj]["encode"] != undefined)
{
var encodePara= data[obj]["encode"].split(",");
for(var i in encodePara)
{
$("input[id^="+encodePara[i]+"]", Clone).attr("encode","1");
}
}
});
}
else
{
$(data).find("encode").each(function(){
var encodePara= $(this).text().split(",");
for(var i in encodePara)
{
$("input[id^="+encodePara[i]+"]", Clone).attr("encode","1");
}
});
}
}
function fillDataWithXML(data, OBJIDs, Clone, suffix, splitter)
{
for (var i=0; i<OBJIDs.length; i++)
{
var OBJID = OBJIDs[i];
var OBJIDSplit = OBJID.split(":");
var OBJIDIndex = 0;
var isSplitterExist = 0;
if ( OBJIDSplit.length == 2 )
{
OBJID = OBJIDSplit[0];
OBJIDIndex = parseInt(OBJIDSplit[1]);
isSplitterExist = 1;
}
var OBJs = $(data).find(OBJID);
if ( OBJs.length == 0 )
{
continue;
}
var OBJ;
if ( OBJIDIndex < OBJs.length )
{
OBJ = OBJs.get(OBJIDIndex);
}
else
{
continue;
}
var instances;
if ( 1 == isSplitterExist )
{
instances = $("Instance", OBJ);
}
else
{
instances = $("Instance", OBJs);
}
if ( instances.length <= suffix
|| suffix < 0 )
{
consoleLog("suffix off normal upper!!");
continue;
}
var InstOBJ = instances.eq(suffix);
InstOBJ.find("ParaName").each(function(){
var ParaName = $(this).text();
var ParaValue = $(this).next().text();
var Elems = $("[id^='"+ParaName+splitter+"']", Clone);
if ( Elems.length == 0 )
{
Elems = $("[id='"+ParaName+"']", Clone);
}
if ( Elems.length > 0 )
{
if ( Elems.length > 1 )
{
consoleLog("this ele id is duplicate[" +Elems.attr("id")+ "]");
}
Elems.fillDataByType(ParaValue);
}
else
{
if ( "_InstID" != ParaName )
{
consoleLog("XML ParaName("+ParaName+") cannot map to HTML "
+ "by fillDataByType, so it may be useless, "
+ "web security require deleting it!");
}
}
});
}
}
function fillDataWithJSON(data, OBJIDs, Clone, suffix, splitter)
{
for (var i=0; i<OBJIDs.length; i++)
{
var OBJID = OBJIDs[i];
var OBJIDSplit = OBJID.split(":");
var OBJIDIndex = 0;
var isSplitterExist = 0;
if ( OBJIDSplit.length == 2 )
{
OBJID = OBJIDSplit[0];
isSplitterExist = 1;
}
var OBJs = $(data).find(OBJID);
if ( data[OBJID] == undefined )
{
continue;
}
var instances = data[OBJID]["Instance"];
if ( instances.length <= suffix
|| suffix < 0 )
{
consoleLog("suffix off normal upper!!");
continue;
}
var InstOBJ = instances[suffix];
for (var key in InstOBJ)
{
var ParaName = key;
var ParaValue = InstOBJ[key];
var Elems = $("[id^='"+ParaName+splitter+"']", Clone);
if ( Elems.length == 0 )
{
Elems = $("[id='"+ParaName+"']", Clone);
}
if ( Elems.length > 0 )
{
if ( Elems.length > 1 )
{
consoleLog("this ele id is duplicate[" +Elems.attr("id")+ "]");
}
Elems.fillDataByType(ParaValue);
}
else
{
if ( "_InstID" != ParaName )
{
consoleLog("json ParaName("+ParaName+") cannot map to HTML "
+ "by fillDataByType, so it may be useless, "
+ "web security require deleting it!");
}
}
}
}
}
function fillData(data, OBJIDs, Clone, suffix, splitter)
{
if ($.isPlainObject(data))
{
fillDataWithJSON(data, OBJIDs, Clone, suffix, splitter);
}
else
{
fillDataWithXML(data, OBJIDs, Clone, suffix, splitter);
}
}
jQuery.fn.fillDataByOBJID = function(data, OBJIDs, Clone, suffix, splitter){
if ( undefined == splitter )
{
splitter = ":";
}
fillEncodeAttr(data, OBJIDs, Clone);
fillData(data, OBJIDs, Clone, suffix, splitter);
$(".SpecialPassword", Clone).each(function(i){
$(this).val("						");
});
};
jQuery.fn.InstantializeForTemplateBox = function(data, OBJIDs, container){
for (var i=0; i<OBJIDs.length; i++)
{
var OBJID = OBJIDs[i];
var OBJs = $(data).find(OBJID);
if ( OBJs.length == 0 )
{
continue;
}
var ruleTemplate = $("[id='"+OBJID+"']._LuQuid_TempalteBox", container);
if( ruleTemplate.length == 0 )
{
continue;
}
$("[id^='"+OBJID+"_']._LuQuid_TempalteBox", container).remove();
var subWidget = ruleTemplate.find("*[id!='']");
subWidget.removeClass("PostIgnore");
var instances = $("Instance", OBJs);
var ruleNum = instances.length;
for (var i=0; i<ruleNum; i++)
{
var clone = ruleTemplate.cloneWithSuffix(i, "_", true);
ruleTemplate.before(clone);
var DataOBJID = [OBJID];
clone.fillDataByOBJID(data, DataOBJID, clone, i, "_");
clone.showIt(true);
}
$("[id='"+OBJID+"._OBJ_InstNUM']", container).val(ruleNum);
var templateInstID = $("[id='"+OBJID+"._OBJ_InstID']", container);
templateInstID.addClass("PostIgnore");
subWidget.addClass("PostIgnore");
}
};
jQuery.fn.FillDataOnlyForTemplateBox = function(data, OBJIDs, container){
for (var i=0; i<OBJIDs.length; i++)
{
var OBJID = OBJIDs[i];
var OBJs = $(data).find(OBJID);
if ( OBJs.length == 0 )
{
continue;
}
var ruleTemplate = $("[id='"+OBJID+"']._LuQuid_TempalteBox", container);
if( ruleTemplate.length == 0 )
{
continue;
}
$("[id^='"+OBJID+"_']._LuQuid_TempalteBox", container).each(function(){
var instObj = $(this);
var instId = instObj.find("[id^='"+OBJID+"._OBJ_InstID']").val();
var index = -1;
var instances = $("Instance", OBJs);
var ruleNum = instances.length;
for (var i=0; i<ruleNum; i++)
{
var instIdName = OBJID+"._OBJ_InstID";
var ToOperParaArray = {};
ToOperParaArray[instIdName] = {
ValueOrigin: ""
};
xmlParaInInstOperate(data, OBJID, i, ToOperParaArray);
var ruleInstId = ToOperParaArray[instIdName].ValueOrigin;
if ( instId == ruleInstId )
{
index = i;
break;
}
}
if ( index > -1 )
{
var DataOBJID = [OBJID];
instObj.fillDataByOBJID(data, DataOBJID, instObj, index, "_");
}
else
{
consoleLog("instId("+instId+") cannot match xml instance");
}
});
}
};
jQuery.fn.createPageDataByClone = function(RuleNum,DataOBJID,data,fillDataByCustom){
var Head = $(this);
var HeadID = Head.attr("id");
var TemplateOBJ = $("#template_"+HeadID , Head);
$("#_InstNum", Head).val(RuleNum);
for (var i=0; i<RuleNum; i++)
{
var clone = TemplateOBJ.cloneWithSuffix(i);
TemplateOBJ.before(clone);
clone.fillDataByOBJID(data ,DataOBJID, clone, i);
if ( $.isFunction(fillDataByCustom) )
{
fillDataByCustom(i,clone);
}
else
{
clone.trigger("fillDataByCustom",[i,clone]);
}
clone.showIt(true);
}
};
jQuery.fn.hasError = function(data, location){
var ContentContainer = $(this);
var cmapiErrorContainer;
var ErrorString = "";
var ErrorParam = "";
if ($.isPlainObject(data))
{
if (data.IF_ERRORSTR == undefined || data.IF_ERRORPARAM == undefined)
{
consoleLog("[hasError:]json cannot find IF_ERRORSTR or IF_ERRORPARAM");
return 1;
}
ErrorString = data.IF_ERRORSTR;
ErrorParam = data.IF_ERRORPARAM;
}
else
{
if ($("IF_ERRORSTR", $(data)).length <= 0 || $("IF_ERRORPARAM", $(data)).length <= 0)
{
consoleLog("[hasError:]xml cannot find IF_ERRORSTR or IF_ERRORPARAM");
return 1;
}
ErrorString = $("IF_ERRORSTR", $(data)).text();
ErrorParam = $("IF_ERRORPARAM", $(data)).text();
}
if (!location)
{
location = "errorHint";
}
if (location == "externErrorHint")
{
cmapiErrorContainer = $(".externErrorHint",ContentContainer);
}
else
{
cmapiErrorContainer = $("."+location,ContentContainer);
}
if ( ErrorString == "SUCC" )
{
cmapiErrorContainer.showIt(false);
return 0;
}
else if ( ErrorString == "SessionTimeout" )
{
top.location.href = top.location.href;
return 1;
}
else
{
var cmapiErrorContainerHtml = "";
var paraString = "";
if ( ErrorParam != "SUCC")
{
var LabelFindResult = 0;
ErrorString = "&?cmret_101;"
var paraLabel = ContentContainer.find("label[for^='"+ErrorParam+"\\:']");
if ( paraLabel.length <= 0 )
{
paraLabel = ContentContainer.find("label[for='"+ErrorParam+"']");
}
if ( paraLabel.length > 0 )
{
paraLabel.each(function(){
var labelTmp = $(this);
if ( !labelTmp.hasClass("error"))
{
paraString = labelTmp.text();
LabelFindResult = 1;
return false;
}
});
}
if ( LabelFindResult == 0 )
{
ErrorString = "&?cmret_001;";
}
cmapiErrorContainerHtml = ErrorString.format(paraString);
}
else
{
if ( "FAIL" == ErrorString
|| "&?cmret_101;" == ErrorString )
{
ErrorString = "&?cmret_001;";
}
cmapiErrorContainerHtml = ErrorString;
}
$("span",cmapiErrorContainer).text(cmapiErrorContainerHtml);
cmapiErrorContainer.showIt(true);
return 1;
}
};
jQuery.fn.ShouldPostIgnore = function(){
if($(this).hasClass("PostIgnore"))
{
return true;
}
return false;
};
jQuery.fn.InitialPostData = function(actionType){
var AND = "&";
var template = $(this);
var PostData = "IF_ACTION=" + actionType;
var cryptoKey = randomNum(16);
var cryptoIv = randomNum(16);
var needEncode = false;
var formInputContent = template.find("input,select,textarea");
formInputContent.each(function(key){
var Elems = $(this);
if ( Elems.ShouldPostIgnore() )
{
if ( Elems.attr("encode") == "1" )
{
needEncode = true;
}
return true;
}
var ElemsID = Elems.attr("id");
if (typeof(ElemsID) != "string") {
return true;
}
if ( Elems.attr("type") == "radio" )
{
if ( Elems.is(':checked') )
{
ElemsID = Elems.attr("name");
}
else
{
return true;
}
}
var ElemsMainID = colonStripping(ElemsID);
var ElemsValue = "";
if ( Elems.is("input") )
{
switch (Elems.attr("type"))
{
case "hidden":
{
if (Elems.attr("_LuQUID_splitMACID") != undefined)
{
var splitMACID = Elems.attr("_LuQUID_splitMACID");
Elems.FillIPorMacDataCombination(splitMACID, ":", 6);
}
else if (Elems.attr("_LuQUID_splitIPID") != undefined)
{
var splitIPID = Elems.attr("_LuQUID_splitIPID");
Elems.FillIPorMacDataCombination(splitIPID, ".", 4);
}
ElemsValue = Elems.val();
if(commConf.setEncode && Elems.attr("encode") == "1")
{
ElemsValue = encodeParaValue(ElemsValue,cryptoKey,cryptoIv);
needEncode = true;
}
break;
}
case "text":
case "password":
case "radio":
{
ElemsValue = Elems.val();
if(commConf.setEncode && Elems.attr("encode") == "1")
{
ElemsValue = encodeParaValue(ElemsValue,cryptoKey,cryptoIv);
needEncode = true;
}
break;
}
case "checkbox":
{
if( Elems.is(':checked'))
{
ElemsValue = 1;
}
else
{
ElemsValue = 0;
}
break;
}
default:
{
break;
}
}
}
else if ( Elems.is("select") )
{
ElemsValue = Elems.val();
}
else if( Elems.is("textarea") && Elems.attr("needPost") == "needPost" )
{
ElemsValue = Elems.val();
}
else
{
consoleLog("when create post data, find not support elements type!!");
}
var NameValueJson = {
"ElemsMainID": ElemsMainID,
"ElemsValue": ElemsValue
};
template.trigger("PostDataChangeByCustom",[NameValueJson,template]);
var RealElemsValue = encodeURIComponent(NameValueJson.ElemsValue);
PostData += AND + ElemsMainID + "=" + RealElemsValue;
});
if(needEncode)
{
PostData += AND + "encode=" + encodeURIComponent(encodeKey(cryptoKey,cryptoIv));
}
return PostData;
};
function RefreshClickHandle(Head)
{
$(".Btn_refresh", Head).each(function(){
$(this).unbind("click");
$(this).bind("click", function(){
var buttonOBJ = $(this);
if (buttonOBJ.hasClass("disableBtn")
||buttonOBJ.hasClass("disableLongBtn"))
{
return;
}
var HeadID = Head.attr("id");
Head.find("[id^='template_"+HeadID+"_']").each(function(){
$(this).remove();
});
var ServerAddr = $("address span", Head).text();
Head.dataTransfer(ServerAddr,
"GET",
Head.succfunction,
Head.failfunction,
undefined,
true);
});
})
}
function initialStatusArea(Head)
{
if ( 0 == $("._LuQUID_STATUS_OBJID", Head).length )
{
return;
}
var OBJID = [];
var OBJDOMs = $("._LuQUID_STATUS_OBJID>li", Head);
OBJDOMs.each(function(){
var identity = $(this).text();
OBJID.push(identity);
})
var isMultiInst = $(".maxInstNum", Head).val();
var ServerAddr = $("address span", Head).text();
Head.succfunction = function(data){
if (Head.hasError(data,"externErrorHint") == 0)
{
Head.trigger("changeXMLDataBeforeFillData", [data]);
var XMLOBJ = $(data).find(OBJID[0]);
var RuleNum = $("Instance", XMLOBJ).length;
if (RuleNum == 0)
{
$(".noDataHint",Head).showIt(true);
$(".form_content",Head).showIt(false);
}
else
{
$(".noDataHint",Head).showIt(false);
$(".form_content",Head).showIt(true);
if (isMultiInst == 0)
{
Head.fillDataByOBJID(data ,OBJID, Head, 0);
Head.trigger("fillDataByCustom",[0, Head]);
var template = $("[id^='template_']", Head);
template.trigger("fillDataByCustom",[0, template]);
template.showIt(true);
}
else
{
Head.fillDataByCustom = undefined;
Head.createPageDataByClone(RuleNum, OBJID, data,
Head.fillDataByCustom);
}
colorTblRow(".colorTbl", "even", Head);
}
}
};
RefreshClickHandle(Head);
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
}
function initial_special_password(Head)
{
$(".SpecialPassword", Head).each(function(){
$(this).mouseup( function(){
if(this.focused){
this.focused=false;
return false;
}
});
});
$(".SpecialPassword", Head).each(function(){
$(this).focus( function(){
this.select();
this.focused=true;
});
});
}
function initial_button(buttonType, Head, IfShowWaitTip)
{
if ( !Head )
{
consoleLog("incoming para:Head is not defined!");
return;
}
var buttonClass = "";
var eventHandler = "";
if ( buttonType == "Apply" )
{
buttonClass = "Btn_apply";
eventHandler = "fillDataByApplyResult";
}
else if ( buttonType == "Cancel" )
{
buttonClass = "Btn_cancel";
eventHandler = "fillDataByCancelResult";
}
else if ( buttonType == "Delete" )
{
buttonClass = "Btn_delete";
eventHandler = "fillDataByDeleteResult";
}
else
{
}
$("."+buttonClass, Head).each(function(){
$(this).unbind("click");
$(this).bind("click",function(event){
var buttonOBJ = $(this);
if (buttonOBJ.hasClass("disableBtn")
||buttonOBJ.hasClass("disableLongBtn"))
{
return;
}
var Head = buttonOBJ.parents(".HeadDIV");
var template = buttonOBJ.parents("[id^='template']");
var ActionBeforePostResult = {result: "Process"};
if ( buttonType == "Apply" )
{
var formOBJ = $(".form_content", template);
if ( formOBJ.length > 0 && false == formOBJ.valid() )
{
return;
}
else
{
var formObj = $(".form_content", template);
var txtInputObjs = $("input[type='text']", formObj);
txtInputObjs.each(function(){
var obj = $(this);
var rules = obj.rules();
if (rules.integer)
{
var intStr = obj.val();
var sign, digits;
if ( intStr.charAt(0) == '-' )
{
sign = "-";
digits = intStr.substring(1);
}
else
{
sign = "";
digits = intStr;
}
while(digits.charAt(0) == '0' && digits.length > 1)
{
digits = digits.substring(1);
}
intStr = sign + digits;
obj.val(intStr);
}
});
}
var IPMACCheckResult = {result: "checkOK"};
template.trigger("wholeIPorMACCheck",[template,IPMACCheckResult]);
if (IPMACCheckResult.result != "checkOK")
{
return;
}
}
template.trigger("ActionBeforePostByCustom",[template,ActionBeforePostResult]);
if (ActionBeforePostResult.result != "Process")
{
return;
}
var ThisInstID = $("[id^='_InstID']",template).val();
if ( ThisInstID == undefined )
{
var luquidObjUl = $("._LuQUID_CONFIG_OBJID", Head);
var objId = $("li", luquidObjUl).eq(0).text();
var instId = objId + "\\._OBJ_InstID";
ThisInstID = $("[id^='"+ instId +"']",template).val();
}
if ( ThisInstID == -1
&& (buttonType == "Cancel" || buttonType == "Delete") )
{
template.remove();
return;
}
var ServerAddr = $("address span", Head).text();
var IfShowWaitTipTmp = IfShowWaitTip;
if ( IfShowWaitTipTmp == undefined )
{
IfShowWaitTipTmp = true;
}
dataPost(buttonType, eventHandler, ServerAddr, template, undefined, IfShowWaitTipTmp);
});
});
}
function dataPost(actionType, PostSuccHandler, ServerAddr, template, PostData, IfShowWaitTip, asyncFlag)
{
var IfShowWaitTipTmp = IfShowWaitTip;
if ( IfShowWaitTipTmp == undefined )
{
IfShowWaitTipTmp = true;
}
if (asyncFlag == undefined)
{
asyncFlag = true;
}
var PostDataTmp = "";
if (PostData == undefined)
{
template.trigger("hiddenValueChangeByCustom",[template, actionType]);
PostDataTmp = template.InitialPostData(actionType);
}
else
{
PostDataTmp = PostData;
}
PostDataTmp += "&_sessionTOKEN="+_sessionTmpToken;
var procData = true;
if (PostDataTmp.indexOf("%20") >= 0)
{
procData = false;
}
var selfHeader = {};
if (commConf.IntegCheck)
{
var degistStr = sha256(PostDataTmp);
selfHeader["Check"] = asyEncode(degistStr);
}
if ( IfShowWaitTipTmp == true )
{
showWaitTip(true);
}
$.ajax({
url:ServerAddr,
type: 'POST',
data: PostDataTmp,
headers: selfHeader,
processData: procData,
async: asyncFlag,
timeout: 30000,
cache:false,
error: function(){
var ajaxPostFailHint = "&?public_076;";
var errorContainer = $(".errorHint",template);
var changeArea = $(".ChangeArea",template);
var collapsibleInst = $(".collapsibleInst",template);
if ( errorContainer != undefined )
{
$("span", errorContainer).text(ajaxPostFailHint);
errorContainer.showIt(true);
if ( changeArea != undefined )
{
changeArea.showIt(true);
}
if ( collapsibleInst != undefined )
{
collapsibleInst.addClass("instNameExp");
}
template.showIt(true);
}
showWaitTip(false);
},
success: function(data){
_LuQUID_setTemplateDefEvents(template, PostSuccHandler);
template.trigger(PostSuccHandler,[data,template]);
if (template.hasError(data,"_noExist") == 0)
{
$(".SpecialPassword", template).each(function(i){
$(this).val("						");
});
}
var formObj = $(".form_content", template);
var errObjs = $(".errorLabelWraper > .error", formObj);
errObjs.attr("style", "display:none");
if ( IfShowWaitTipTmp == true )
{
showWaitTip(false);
}
}
});
}
function homedeletedataPost(actionType, PostSuccHandler, ServerAddr, template, PostData, IfShowWaitTip, asyncFlag)
{
var IfShowWaitTipTmp = IfShowWaitTip;
if ( IfShowWaitTipTmp == undefined )
{
IfShowWaitTipTmp = true;
}
if (asyncFlag == undefined)
{
asyncFlag = true;
}
var deleteid = $("[id^='Delete']",template).attr('id');
var idArr = deleteid.split(":");
var tmpinsid = idArr[idArr.length - 1];
var insid = parseInt(tmpinsid, 10) + 1;
var PostDataTmp = "IF_ACTION=" + actionType + "&" +"_InstID=" + parseInt(insid, 10);
if (typeof(_sessionTmpToken) != "undefined")
{
PostDataTmp += "&_sessionTOKEN="+_sessionTmpToken;
}
if ( IfShowWaitTipTmp == true )
{
showWaitTip(true);
}
$.ajax({
url:ServerAddr,
type: 'POST',
data: PostDataTmp,
async: asyncFlag,
timeout: 30000,
cache:false,
error: function(){
var ajaxPostFailHint = "&?public_076;";
var homeWrapperObj = template.parent("[id^='homeWrapper']");
var errorContainertmp = $(".lanErr",homeWrapperObj);
var errorContainer = $(".errorHint",errorContainertmp);
if ( errorContainer != undefined )
{
$("span", errorContainer).text(ajaxPostFailHint);
errorContainer.showIt(true);
template.showIt(true);
}
showWaitTip(false);
},
success: function(data){
template.trigger(PostSuccHandler);
if ( IfShowWaitTipTmp == true )
{
showWaitTip(false);
}
}
});
}
function focusAndSelectInput(jqObj)
{
var disValue = jqObj.attr("disabled");
if (disValue != "disabled" && disValue != true)
{
jqObj.focus();
jqObj.select();
}
}
function FocusAutoJump(obj,value,e)
{
var objJQ = $(obj);
var prevOBJ = objJQ.prev("input");
var nextOBJ = objJQ.next("input");
var valLen = value.length;
var keynum;
if (window.event)
{
keynum = e.keyCode;
}
else if (e.which)
{
keynum = e.which;
}
var temp = value.substring(valLen-1, valLen);
if ("." == temp && objJQ.hasClass("ip") && 0 != valLen)
{
objJQ.val(value.substring(0, valLen-1))
if ("." != value)
{
focusAndSelectInput(nextOBJ);
}
}
if (valLen == obj.maxLength)
{
if (nextOBJ.length <= 0)
{
return;
}
if (9 != keynum && 16 != keynum && 35 != keynum && 36 != keynum &&
37 != keynum && 38 != keynum && 39 != keynum && 40 != keynum &&
46 != keynum && 8 != keynum && objJQ.valid() == 1)
{
focusAndSelectInput(nextOBJ);
}
}
else if (valLen == 0 && 37 == keynum)
{
if (prevOBJ.length <= 0)
{
return;
}
focusAndSelectInput(prevOBJ);
}
else
{
return;
}
}
function autoJumpBack(obj,value,e)
{
var objJQ = $(obj);
var prevOBJ = objJQ.prev("input");
var nextOBJ = objJQ.next("input");
var valLen = value.length;
var keynum;
if (window.event)
{
keynum = e.keyCode;
}
else if (e.which)
{
keynum = e.which;
}
if (8 == keynum && valLen == 0)
{
if (prevOBJ.length <= 0)
{
return;
}
focusAndSelectInput(prevOBJ);
}
}
jQuery.fn.FillIPorMacDataBySplit = function(subid,Delimiter,length) {
var IPOBJ = $(this);
if ( IPOBJ.length == 0 )
{
return;
}
var containerOBJ = IPOBJ.parents("[id^='template_']");
var value = IPOBJ.val();
if ( !value )
{
return;
}
var temp= value.split(Delimiter);
if (length != temp.length)
{
return;
}
for(var i=0; i<length; i++)
{
var fillOBJ = $("[id^='"+subid+i+"']",containerOBJ);
fillOBJ.val(temp[i]);
}
};
jQuery.fn.FillIPorMacDataCombination = function(subid,Delimiter,length) {
var IPOBJ = $(this);
if ( IPOBJ.length == 0 )
{
return;
}
var containerOBJ = IPOBJ.parents("[id^='template_']");
var temp = "";
for(var i=0; i<length; i++)
{
var tempObj = $("[id^='"+subid+i+"']",containerOBJ);
if(0!=i)
{
temp += Delimiter;
}
var tempValue = tempObj.val();
if ( !tempValue )
{
tempValue = "";
}
temp += tempValue;
tempObj.addClass("PostIgnore");
}
IPOBJ.val(temp);
return temp;
};
jQuery.fn.checkIPorMACbyApply = function(checkIPorMACObj, template, IPMACCheckResult){
var breakFlag = 0;
$.each(checkIPorMACObj, function(key, value){
if (breakFlag != 0)
{
return false;
}
if ($("[id^='sub_"+key+"']",template).is(":visible") != true)
{
return true;
}
var labelId = value.labelId;
var paraName = "";
var paraNameObj = template.find("label[for^='"+labelId+"\\:']");
if ( paraNameObj.length <= 0 )
{
paraNameObj = template.find("label[for='"+labelId+"']");
}
if ( paraNameObj.length > 0 )
{
paraNameObj.each(function(){
var labelTmp = $(this);
if (labelTmp.hasClass("error"))
{
return true;
}
paraName = labelTmp.text();
return false;
});
}
var elementType = value.eleType;
if (elementType == "IP")
{
var IPObj = $("[id^='"+key+"']",template);
IPObj.FillIPorMacDataCombination("sub_"+key, ".", 4);
var ipValue = IPObj.val();
if (value.rules != undefined)
{
$.each(value.rules, function(k, v){
var ipRet = checkWholeIPv4(k, v, ipValue, template);
if (ipRet[0] == false)
{
var errMsg = getMsgofWholeMACIPCheck(ipRet, value, ipValue, paraName);
$(".errorHint",template).show();
$(".errorHint span",template).text(errMsg);
IPMACCheckResult.result = "checkFail";
breakFlag = 1;
return false;
}
else
{
$(".errorHint",template).hide();
}
});
}
}
else if (elementType == "MAC")
{
var MACObj = $("[id^='"+key+"']",template);
MACObj.FillIPorMacDataCombination("sub_"+key, ":", 6);
var macValue = MACObj.val();
if (value.rules != undefined)
{
$.each(value.rules, function(k, v){
var macRet = checkWholeMac(k, v, macValue);
if (macRet[0] == false)
{
var errMsg = getMsgofWholeMACIPCheck(macRet, value, macValue, paraName);
$(".errorHint",template).show();
$(".errorHint span",template).text(errMsg);
IPMACCheckResult.result = "checkFail";
breakFlag = 1;
return false;
}
else
{
$(".errorHint",template).hide();
}
});
}
}
else
{
consoleLog("ElementType +'"+elementType+"' is not supported now!")
}
});
};
jQuery.fn.setPromptCheckJSON = function(checkJSONTempObj, template){
var templateID = template.attr("id");
var instIndex = templateID.match(/\d+$/);
var suffix = "";
if ( instIndex )
{
suffix = ":"+instIndex;
}
var checkJSONInstObj = {"groups":{}, "rules":{}, "messages":{}};
if ( checkJSONTempObj.groups != undefined )
{
$.each(checkJSONTempObj.groups, function(key, value) {
var valJSONStr = value;
var idArr = value.split(" ");
for ( var i=0; i<idArr.length; i++ )
{
idArr[i] += suffix;
}
valJSONStr = idArr.join(" ");
var parameterJSON = eval("({'"+key+suffix+"':'" + valJSONStr + "'})");
$.extend(checkJSONInstObj.groups, parameterJSON);
});
}
if ( checkJSONTempObj.rules != undefined )
{
$.each(checkJSONTempObj.rules, function(key, value) {
var parameterJSON = {};
parameterJSON[key + suffix] = value;
$.extend(checkJSONInstObj.rules, parameterJSON);
});
}
if ( checkJSONTempObj.messages != undefined )
{
$.each(checkJSONTempObj.messages, function(key, value) {
var parameterJSON = {};
parameterJSON[key + suffix] = value;
$.extend(checkJSONInstObj.messages, parameterJSON);
});
}
var instForm = template.find("form");
instForm.validate(checkJSONInstObj);
};
function consoleLog(para)
{
if (typeof window.console == "undefined") {
window.console = {log: function() {}};
}
window.console.log( para );
}
function getInstIndexByPath(data, OBJID, path)
{
var instIndex = -1;
if ($.isPlainObject(data))
{
var instances = data[OBJID]["Instance"];
$.each(instances,function(i,v){
var inst = v;
if(inst["_InstID"] != undefined && inst["_InstID"] == path)
{
instIndex = i;
}
});
}
else
{
var OBJ = $(data).find(OBJID);
var instances = $("Instance", OBJ);
instances.each(function(i){
var inst = $(this);
inst.find("ParaName").each(function(){
var ParaName = $(this).text();
var ParaValue = $(this).next().text();
if ( ParaName.match(/^_InstID/) != null
&& ParaValue == path )
{
instIndex = i;
}
});
});
}
return instIndex;
}
function xmlParaInInstOperate(data, OBJVal, InstIndex, ToOperParaArray)
{
if ($.isPlainObject(data))
{
var instances = data[OBJVal]["Instance"];
var inst = instances[InstIndex];
for (var tmp in ToOperParaArray)
{
if(inst[tmp] != undefined)
{
ToOperParaArray[tmp].ValueOrigin = inst[tmp];
if (ToOperParaArray[tmp].setAction)
{
ToOperParaArray[tmp].setAction(inst, null, inst[tmp]);
}
}
}
}
else
{
var OBJ = $(OBJVal, $(data));
var inst = $("Instance", OBJ).eq(InstIndex);
inst.find("ParaName").each(function(){
var ParaSelf = $(this);
var ParaValSelf = $(this).next();
var ParaName = ParaSelf.text();
var ParaValue = ParaValSelf.text();
for (var tmp in ToOperParaArray)
{
if( tmp == ParaName )
{
ToOperParaArray[tmp].ValueOrigin = ParaValue;
if (ToOperParaArray[tmp].setAction)
{
ToOperParaArray[tmp].setAction(ParaSelf, ParaValSelf, ParaValue);
}
}
}
});
}
}
function getParaValueInXML(data, OBJID, InstIndex, paraNameIn)
{
var paraValueOut = "N/A";
if ($.isPlainObject(data))
{
var instances = data[OBJID]["Instance"];
var inst = instances[InstIndex];
if(inst[paraNameIn] != undefined)
{
paraValueOut = inst[paraNameIn];
if(commConf.getEncode && data[obj]["encode"] != undefined && data[obj]["encode"].indexOf(paraNameIn) != -1)
{
paraValueOut = getDecodeValue(paraValueOut);
}
}
}
else
{
var OBJ = $(data).find(OBJID);
var instances = $("Instance", OBJ);
var inst = instances.eq(InstIndex);
inst.find("ParaName").each(function(){
var ParaName = $(this).text();
var ParaValue = $(this).next().text();
if ( ParaName == paraNameIn )
{
paraValueOut = ParaValue;
$(data).find("encode").each(function(){
if(commConf.getEncode && $(this).text().indexOf(paraNameIn) != -1)
{
paraValueOut = getDecodeValue(paraValueOut);
return false;
}
});
return false;
}
});
}
return paraValueOut;
}
function setParaValueInXML(data, OBJID, InstIndex, paraNameIn, setValue)
{
if ($.isPlainObject(data))
{
var instances = data[OBJID]["Instance"];
var inst = instances[InstIndex];
if(inst[paraNameIn] != undefined)
{
inst[paraNameIn] = setValue;
}
}
else
{
var OBJ = $(data).find(OBJID);
var instances = $("Instance", OBJ);
var inst = instances.eq(InstIndex);
inst.find("ParaName").each(function(){
var ParaName = $(this).text();
if ( ParaName == paraNameIn )
{
$(this).next().text(setValue);
return false;
}
});
}
}
function colorTblRow(tblClass, rowAttr, Head)
{
$(tblClass+" .colorTblRow", Head).each(function(){
var thisRow = $(this);
thisRow.removeClass("colorRow");
});
var shouldPainted = true;
if ( rowAttr == "even" )
{
shouldPainted = true;
}
else
{
shouldPainted = false;
}
var allRows = $(tblClass+" .colorTblRow", Head);
allRows.each(function(){
var thisRow = $(this);
if ( thisRow.css("display") != "none" )
{
if ( true == shouldPainted )
{
thisRow.addClass("colorRow");
shouldPainted = false;
}
else
{
shouldPainted = true;
}
}
});
}
function reformString(inStr, splitNum)
{
var strLen = inStr.length;
var outStr = "";
var arr = [];
var start = 0;
var end = 0;
if (strLen > 4)
{
var flag = strLen % splitNum;
if (flag != 0)
{
end = flag;
}
else
{
end = start + splitNum;
}
for (var i=0; end <= strLen; i++)
{
arr[i] = inStr.slice(start, end);
start = end;
end = start + splitNum;
}
for (var j = 0; j < arr.length; j++)
{
outStr = outStr + arr[j] + " ";
}
outStr = outStr.slice(0, (outStr.length-1));
}
if (outStr == "")
{
outStr = inStr;
}
return outStr;
}
function sec2HrMinSec(sec)
{
if (sec == "")
{
consoleLog("[sec2HrMinSec]sec is empty, please check if it's ok?! ");
}
var s, m, h;
s = parseInt(sec % 60);
m = parseInt(sec / 60, 10) % 60;
h = parseInt(sec / 3600, 10);
return (h + " &?public_011; " + m + " &?public_012; " + s + " &?public_013;");
}
jQuery.fn.collapsibleInstTitleChange = function(referenceID) {
var ContainerOBJ = $(this);
var NameValue = "";
var nameSrcObj = $("[id^='"+referenceID+":']",ContainerOBJ);
var eleType = nameSrcObj[0].type;
if (eleType == "select-one") {
NameValue = $("option:selected", nameSrcObj).text();
}else {
NameValue = nameSrcObj.val();
}
var instNameObj = $(".collapsibleInst",ContainerOBJ);
instNameObj.text(NameValue);
instNameObj.attr("title", NameValue);
};
function initialCtrlAllLink(containerOBJ)
{
var AllObj = $(".AllOn, .AllOff",containerOBJ);
AllObj.unbind("click");
AllObj.click(function(event){
var AllCtlItme = $(this);
var Head = AllCtlItme.parents(".HeadDIV");
var Template = AllCtlItme.parents("[id^='template_']");
var needCheck = 1;
var EleSelectValue;
if ( AllCtlItme.hasClass("AllOn") )
{
needCheck = 1;
EleSelectValue = 1;
}
else if ( AllCtlItme.hasClass("AllOff") )
{
needCheck = 0;
EleSelectValue = 0;
}
else
{
}
if ( AllCtlItme.attr("EleSelectValue") )
{
EleSelectValue = AllCtlItme.attr("EleSelectValue");
}
$(":radio",Template).each(function(){
var RadioOBJ = $(this);
if ( RadioOBJ.val() == EleSelectValue )
{
RadioOBJ.prop("checked", true);
}
else
{
RadioOBJ.prop("checked", false);
}
});
$(":checkbox",Template).each(function(){
var CheckboxOBJ = $(this);
if ( needCheck == 1)
{
CheckboxOBJ.prop("checked", true);
}
else
{
CheckboxOBJ.prop("checked", false);
}
});
});
}
function ActionByApplyResult(data, template, TitleValueReferID)
{
var isError = template.hasError(data);
if (isError == 0)
{
$("span.__CheckPwdStrength",template).remove();
succHintShow(template);
if ($.isPlainObject(data))
{
if(data["_InstID"] != undefined)
{
$("[id^='_InstID']",template).val(data["_InstID"]);
}
}
else
{
var _InstIDOBJ = $(data).find("_InstID");
if (_InstIDOBJ.length > 0)
{
$("[id^='_InstID']",template).val(_InstIDOBJ.text());
}
}
var headObj = template.parents(".HeadDIV");
var luquidObjUl = $("._LuQUID_CONFIG_OBJID", headObj);
$("li", luquidObjUl).each(function(){
var objId = $(this).text();
var ruleTemplate = $("[id='"+objId+"']._LuQuid_TempalteBox", template);
if( ruleTemplate.length > 0 )
{
return true;
}
var instIdSelector = objId + "\\._OBJ_InstID";
var instIDTag = $(data).find(instIdSelector);
if (instIDTag.length == 0)
{
return true;
}
$("[id^='"+ instIdSelector +"']",template).val(instIDTag.text());
});
if ( TitleValueReferID != undefined )
{
template.collapsibleInstTitleChange(TitleValueReferID);
}
$("textarea[_readonlycanberm]",template).attr("readonly","readonly");
$("input[type!=button][_readonlycanberm],select[_readonlycanberm]",template).attr("disabled","disabled")
.addClass("readonlyInputBg");
$(".Button[_readonlycanberm]",template).attr("disabled","disabled").addClass("disableBtn");
$(".longBtn[_readonlycanberm]",template).attr("disabled","disabled").addClass("disableLongBtn");
}
return isError;
}
function ActionByCancelResult(data, template, OBJIDForFillData, TitleValueReferID)
{
var isError = template.hasError(data);
if ( isError == 0 )
{
$("span.__CheckPwdStrength",template).remove();
template.fillDataByOBJID(data, OBJIDForFillData, template, 0);
template.FillDataOnlyForTemplateBox(data, OBJIDForFillData, template);
if ( TitleValueReferID != undefined )
{
template.collapsibleInstTitleChange(TitleValueReferID);
}
}
else
{
$(".ChangeArea",template).showIt(true);
$(".collapsibleInst",template).addClass("instNameExp");
}
return isError;
}
function addInst(Head, InstNumOBJ)
{
var HeadID = Head.attr("id");
var templateOBJ = $("#template_"+HeadID);
var suffix = InstNumOBJ.val();
var clone = templateOBJ.cloneWithSuffix(suffix);
if(!$("[_readonlycanberm]",clone).attr("hideattr"))
$("[_readonlycanberm]",clone).removeAttr("disabled readonly")
.removeClass("readonlyInputBg disableBtn disableLongBtn");
templateOBJ.before(clone);
InstNumOBJ.val(parseInt(suffix)+1);
templateOBJ.trigger("ActionBeforeAddInst",[clone]);
clone.showIt(true);
$(".collapsibleInst",clone).addClass("instNameExp");
$(".ChangeArea",clone).showIt(true);
}
function IfCreateInstChk(Head, InstNumOBJ, AddInstLink)
{
var ExistInst = 0;
$("[id^='template_']",Head).each(function(){
if ($(this).css("display") == "block")
{
ExistInst = 1;
return false;
}
});
if ( ExistInst == 0
&& AddInstLink.length > 0 )
{
return true;
}
return false;
}
function collapBarAction(collapBar)
{
var Head = collapBar.parents(".HeadDIV");
var HeadID = Head.attr("id");
var containerMainID = HeadID + "_container";
var UnderControlContainer = $("#"+containerMainID, Head);
var template = collapBar.parents("[id^='template_']");
var selector = "[id^='"+ containerMainID +"']";
var containerInTemp = $(selector, template);
var containerLen = containerInTemp.length;
if ( containerLen > 0 )
{
UnderControlContainer = containerInTemp;
}
if ( UnderControlContainer.is(":visible") )
{
UnderControlContainer.showIt(false);
collapBar.removeClass("collapsibleBarExp");
}
else
{
UnderControlContainer.showIt(true);
collapBar.addClass("collapsibleBarExp");
}
var InstNumOBJ = $("#_InstNum",Head);
var AddInstLink = Head.find(".addInst");
if ( IfCreateInstChk(Head, InstNumOBJ, AddInstLink) )
{
addInst(Head, InstNumOBJ);
}
}
function initial_collapBarWithDataTrans(Head)
{
var UnderControlContainer = $("#"+ Head.attr("id") +"_container");
UnderControlContainer.hide();
$(".collapBarWithDataTrans",Head).click(function(event){
event.preventDefault();
var collapBar = $(this);
if ( $("#DataHasBeenGot",Head).val() == 0 )
{
showWaitTip(true);
setTimeout(function(){
var ServerAddr = $("address span", Head).text();
Head.dataTransfer(ServerAddr,
"GET",
Head.succfunction,
undefined,
undefined,
false
);
$("#DataHasBeenGot",Head).val(1);
collapBarAction(collapBar);
}, 2);
}
else
{
collapBarAction(collapBar);
}
});
}
function initial_CollapsibleBar()
{
$(".collapsibleBar").each(function(){
var HeadID = $(this).parents(".HeadDIV").attr("id");
var UnderControlContainer = $("#"+ HeadID +"_container");
UnderControlContainer.hide();
});
$(".collapsibleBar").each(function(){
var collapsibleBar = $(this);
collapsibleBar.click(function(event){
event.preventDefault();
var collapBar = $(this);
collapBarAction(collapBar);
});
});
}
function initial_addInstLink()
{
$(".addInst").each(function(event){
var addInstOBJ = $(this);
addInstOBJ.unbind("click");
addInstOBJ.click(function(event){
var Head = $(this).parents(".HeadDIV");
var InstNumOBJ = $("#_InstNum",Head);
addInst(Head, InstNumOBJ);
});
});
}
function _LuQUID_template_ApplyDefEventFunc(event, data, template)
{
return ActionByApplyResult(data, template);
}
function _LuQUID_template_CancelDefEventFunc(event, data, template)
{
var OBJID = [];
var Head = template.parents(".HeadDIV");
var OBJDOMs = $("._LuQUID_CONFIG_OBJID>li", Head);
OBJDOMs.each(function(){
var identity = $(this).text();
OBJID.push(identity);
})
ActionByCancelResult(data, template, OBJID);
template.trigger("fillDataByCustom",[0, template, data]);
}
function _LuQUID_template_DeleteDefEventFunc(event, data, template)
{
if ( template.hasError(data) == 0 )
{
template.remove();
}
else
{
$(".ChangeArea",template).showIt(true);
}
}
function _LuQUID_template_InstSwitchDefEventFunc(event, data, template)
{
if ( template.hasError(data) == 0 )
{
return;
}
$(".ChangeArea",template).showIt(true);
$(".collapsibleInst",template).addClass("instNameExp");
}
var _LuQUID_template_DefEventFuncMap = {
"fillDataByApplyResult" : _LuQUID_template_ApplyDefEventFunc,
"fillDataByCancelResult" : _LuQUID_template_CancelDefEventFunc,
"fillDataByDeleteResult" : _LuQUID_template_DeleteDefEventFunc,
"fillDataByInstSwitchResult" : _LuQUID_template_InstSwitchDefEventFunc
};
function _LuQUID_setTemplateDefEvents(template, PostSuccHandler)
{
var LuquidObj = $(template).parent().find("address").find("[class^='_LuQUID_']");
if( LuquidObj.length == 0 )
{
return;
}
var events = template.data("events");
if( events && events[PostSuccHandler] )
{
return ;
}
var eventFunc = _LuQUID_template_DefEventFuncMap[PostSuccHandler];
if ( eventFunc )
{
template.bind(PostSuccHandler, eventFunc);
}
}
function initialConfigArea(Head)
{
if ( 0 == $("._LuQUID_CONFIG_OBJID", Head).length )
{
return;
}
var OBJID = [];
var OBJDOMs = $("._LuQUID_CONFIG_OBJID>li", Head);
OBJDOMs.each(function(){
var identity = $(this).text();
OBJID.push(identity);
});
var isMultiInst = $(".maxInstNum", Head).val();
consoleLog("isMultiInst="+isMultiInst);
Head.succfunction = function(data){
Head.hasError(data, "externErrorHint");
{
Head.trigger("changeXMLDataBeforeFillData", [data]);
var XMLOBJ = $(data).find(OBJID[0]);
var RuleNum = $("Instance", XMLOBJ).length;
if (isMultiInst == 0)
{
Head.fillDataByOBJID(data, OBJID, Head, 0);
Head.InstantializeForTemplateBox(data, OBJID, Head);
var template = $("[id^='template_']", Head);
template.trigger("fillDataByCustom",[0, template]);
template.showIt(true);
}
else
{
Head.fillDataByCustom = undefined;
Head.createPageDataByClone(RuleNum, OBJID, data,
Head.fillDataByCustom);
}
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
}
function initial_QueryAccessDeviceLink()
{
var linkSelector = "._LuQUID_SelAccessDevice";
var selDevLinks = $(linkSelector);
if ( selDevLinks.length == 0 )
{
return;
}
selDevLinks.each(function(){
var selDevLink = $(this);
selDevLink.css("display", "block");
var rowObj = selDevLink.parents(".row").eq(0);
rowObj.append("<div class='clear'></div>");
var macID = rowObj.find(".mac").eq(0).attr("id");
var macIDStriped = macID;
var paraID = macIDStriped.match(/^sub_(.+)\d$/)[1];
var headID = selDevLink.parents(".HeadDIV").attr("id");
var suffix = ":"+paraID+":"+headID;
var devListHTML = ''
+ '<div class="_LuQUID_AccessDeviceList" name="_LuQUID_AccessDeviceInfo'+suffix+'" style="display:none;">'
+ '<input type="hidden" class="PostIgnore" id="_LuQUID_InstNum'+suffix+'" value="0">'
+ '<p id="_LuQUID_NoAccessDev'+suffix+'">&?public_145;</p>'
+ '<p id="_LuQUID_template_AccessDeviceInfo'+suffix+'" style="display:none">'
+ '<label class="cfgLabel">&nbsp;</label>'
+ '<input type="hidden" class="PostIgnore" id="_LuQUID_HostName'+suffix+'" value="">'
+ '<input type="hidden" class="PostIgnore" id="_LuQUID_IPAddress'+suffix+'" value="">'
+ '<input type="hidden" class="PostIgnore" id="_LuQUID_MACAddress'+suffix+'" value="">'
+ '<input type="radio" class="PostIgnore" id="_LuQUID_AccessDeviceRadio'+suffix+'" name="_LuQUID_AccessDeviceRadio'+suffix+'" value=""/>'
+ '<label for="_LuQUID_AccessDeviceRadio'+suffix+'">'
+ '&?public_146;: [<span id="_LuQUID_StrHostName'+suffix+'">&?public_006;</span>]'
+ '-&?public_010;: [<span id="_LuQUID_StrMACAddress'+suffix+'"></span>]'
+ '</label>'
+ '</p>'
+ '<a class="_LuQUID_HideAccessDevice">&?public_144;</a>'
+ '</div>';
var macObj = rowObj.find(".right");
var devListObj = $(devListHTML).insertAfter(macObj);
var labelObj = selDevLink.parent().prev();
var labelWidth = labelObj.css("width");
devListObj.css("margin-left", labelWidth);
});
var devRadios = $("input[name^='_LuQUID_AccessDeviceRadio']");
devRadios.click(function(event){
var devRadio = $(this);
var templateSelector = "[id^='_LuQUID_template_AccessDeviceInfo']";
var templateDev = devRadio.parents(templateSelector);
var devListObj = devRadio.parents("[name^='_LuQUID_AccessDeviceInfo']");
var rowObj = devRadio.parents(".row").eq(0);
var deviceRadioSelector = "input[name^='_LuQUID_AccessDeviceRadio']";
$(deviceRadioSelector, devListObj).prop("checked", false);
devRadio.prop("checked", true);
var devMACObj = $("[id^='_LuQUID_MACAddress']", templateDev);
var macID = rowObj.find(".mac").eq(0).attr("id");
var macIDStriped = colonStrippingLast(macID);
var subID = macIDStriped.match(/^(sub_.+)\d$/)[1];
devMACObj.FillIPorMacDataBySplit(subID, ":", 6);
var lastSubMAC = rowObj.find(".mac").last();
lastSubMAC.focus().blur();
});
var hideDevLinks = $("._LuQUID_HideAccessDevice");
hideDevLinks.unbind("click");
hideDevLinks.click(function(event){
event.preventDefault();
var devListObj = $(this).parents("[name^='_LuQUID_AccessDeviceInfo']");
devListObj.hide();
});
selDevLinks.unbind("click");
selDevLinks.click(function(event){
event.preventDefault();
var selDevLink = $(this);
var rowObj = selDevLink.parents(".row");
var devListObj = rowObj.find("[name^='_LuQUID_AccessDeviceInfo']");
if (devListObj.is(":visible"))
{
devListObj.hide();
return;
}
var InstNumBefore = $("[id^='_LuQUID_InstNum']", devListObj).val();
for ( var i=0; i<InstNumBefore; i++ )
{
var selector = "[id$='_"+i+"']"
+"[id^='_LuQUID_template_AccessDeviceInfo']";
$(selector, devListObj).remove();
}
devListObj.AccessDeviceXMLDealWith = function(data){
devListObj.hasError(data,"externErrorHint");
var ACCESSDEVRuleOBJ = $(data).find("OBJ_ACCESSDEV_ID");
var RuleNum = $("Instance", ACCESSDEVRuleOBJ).length;
var OBJID = ["OBJ_ACCESSDEV_ID"];
var templateSelector = "[id^='_LuQUID_template_AccessDeviceInfo']";
var TemplateOBJ = $(templateSelector, devListObj);
$("[id^='_LuQUID_InstNum']", devListObj).val(RuleNum);
var NoAccessDevObj = $("[id^='_LuQUID_NoAccessDev']", devListObj);
if (RuleNum == 0 )
{
NoAccessDevObj.show();
}
else
{
NoAccessDevObj.hide();
}
for (var i=0; i<RuleNum; i++)
{
var clone = TemplateOBJ.cloneWithSuffix(i);
TemplateOBJ.before(clone);
clone.fillDataByOBJID(data, OBJID, clone, i);
var HostNameStr = $("[id^='_LuQUID_HostName']", clone).val();
var IPAddress = $("[id^='_LuQUID_IPAddress']", clone).val();
var MACAddress = $("[id^='_LuQUID_MACAddress']", clone).val();
if (HostNameStr == "")
{
if (IPAddress != "")
{
HostNameStr = "PC" + IPAddress;
}
else if (MACAddress != "")
{
HostNameStr = "PC" + MACAddress
}
else
{
HostNameStr = "&?public_006;";
}
}
$("[id^='_LuQUID_StrHostName']", clone).text(HostNameStr);
var MACAddress = $("[id^='_LuQUID_MACAddress']", clone).val();
$("[id^='_LuQUID_StrMACAddress']", clone).text(MACAddress);
clone.show();
}
devListObj.show();
};
var accessMode = selDevLink.attr("_LuQUID_Access_Mode")
var AccessModeSet =
[
"ETH",
"WLAN",
"ALL"
];
if ( -1 == $.inArray(accessMode, AccessModeSet) )
{
var devTypeList = AccessModeSet.join("/")
consoleLog("_LuQUID_Access_Mode must be set as one of "+devTypeList);
return ;
}
var ServerAddr = "/?_type=hiddenData&_tag=accessdev_data&";
ServerAddr += "DeveiceType="+accessMode;
showWaitTip(true);
devListObj.dataTransfer(ServerAddr,
"GET",
devListObj.AccessDeviceXMLDealWith,
undefined,
undefined,
false);
});
}
function InitTimeOption(start,end,ele,step, ctrlClass)
{
var realNum = (end - start)/step;
for(var i=0; i<realNum; i++)
{
var tmp = i*step+start;
var tmpText = tmp;
if ( tmp < 10 )
{
tmpText = '0'+tmpText;
}
if (i == realNum-1
&&( ctrlClass == "group_HourEnd" || ctrlClass == "group_MinuteEnd" ) )
{
ele.append("<option value='"+tmp+"' selected='selected'>"+ tmpText +"</option>");
}
else
{
ele.append("<option value='"+tmp+"'>"+ tmpText +"</option>");
}
}
}
function initial_TimeCtl()
{
var TimeCtl = $("._LuQUID_TimeCtl");
if ( TimeCtl.length <= 0 )
{
return;
}
var timeArr = {
"group_HourStart" : [0, 24],
"group_MinuteStart" : [0, 60],
"group_HourEnd" : [0, 24],
"group_MinuteEnd" : [0, 60]
};
for (var tmp in timeArr)
{
var timeEle = $("."+ tmp, TimeCtl);
var start = timeArr[tmp][0];
var end = timeArr[tmp][1];
InitTimeOption(start, end, timeEle, 1, tmp);
}
}
function Second2DHMS(num)
{
var s = num % 60;
num = parseInt(num/60);
var m = num % 60;
num = parseInt(num/60);
var h = num % 24;
num = parseInt(num/24);
var d = num;
return {
day: d,
hour: h,
minute: m,
second: s
}
}
function InitSelectByIntRange(selectObj, min, max)
{
selectObj.empty();
var domCache = [];
for (var i = min; i <= max; i++)
{
domCache.push("<option title='" +i+ "' value='" +i+ "'>"+i+"</option>");
}
selectObj.append(domCache.join());
}
function SetCookie(name,value)
{
var Days = 30;
var exp = new Date();
exp.setTime(exp.getTime() + Days*24*60*60*1000);
document.cookie = name + "="+ escape (value)
+ ";expires=" + exp.toGMTString();
}
function getCookie(name)
{
var arr = document.cookie.match(new RegExp("(^| )"+name+"=([^;]*)(;|$)"));
if(arr != null)
{
return unescape(arr[2]);
}
return null;
}
function delCookie(name)
{
var exp = new Date();
exp.setTime(exp.getTime() - 1);
var cval = getCookie(name);
if( cval!=null )
{
document.cookie= name + "="+cval+";expires="+exp.toGMTString();
}
}
function IsBrowserSupportCookie()
{
var support = false;
SetCookie('cookie_test','1');
var cookie_test = getCookie('cookie_test');
if( '1' == cookie_test)
{
support = true;
}
delCookie('cookie_test');
return support;
}
(function () {
var setTimeout_context_binding = function (vCallback, nDelay ) {
var oThis = this, aArgs = Array.prototype.slice.call(arguments, 2);
return window.setTimeout(vCallback instanceof Function ? function () {
vCallback.apply(oThis, aArgs);
} : vCallback, nDelay);
};
var setInterval_context_binding = function(vCallback, nDelay ) {
var oThis = this, aArgs = Array.prototype.slice.call(arguments, 2);
return window.setInterval(vCallback instanceof Function ? function() {
vCallback.apply(oThis, aArgs);
} : vCallback, nDelay);
};
var timer = function(fnAlarm, options)
{
this.fnAlarm_inner = undefined;
this.timeout = undefined;
this.interval = undefined;
this.contextDom = undefined;
this.timerHandle;
if ( fnAlarm )
{
this.fnAlarm_inner = fnAlarm;
}
else
{
return;
}
if ( options )
{
if ( options.timeout )
{
this.timeout = options.timeout;
}
if ( options.interval )
{
this.interval = options.interval;
}
if ( options.contextDom )
{
this.contextDom = options.contextDom;
}
}
if ( !(this.timeout || options.interval) )
{
return;
}
};
timer.prototype.start = function(){
var context_binding_timer = undefined;
var time_value = undefined;
if ( this.timeout )
{
context_binding_timer = setTimeout_context_binding;
time_value = this.timeout;
}
else if ( this.interval )
{
context_binding_timer = setInterval_context_binding;
time_value = this.interval;
}
else
{
return;
}
this.timerHandle = context_binding_timer.call(this, function(){
if ( this.contextDom && !document.body.contains(this.contextDom) )
{
this.stop();
return;
}
this.fnAlarm_inner.call(this);
}, time_value);
};
timer.prototype.stop = function(){
if ( this.timeout ) {
clearTimeout(this.timerHandle)
} else {
clearInterval(this.timerHandle)
}
delete this.timerHandle;
};
timer.prototype.getTimerID = function(){
return this.timerHandle;
};
window.ContextBindingTimer = timer;
})();
(function ($) {
var o = $({});
var modifier = $({});
$.subscribe = function () {
o.on.apply(o, arguments);
};
$.unsubscribe = function () {
o.off.apply(o, arguments);
};
$.publish = function () {
o.trigger.apply(o, arguments);
};
$.addModifier = function(modifierName,callFunc){
modifier[modifierName] = callFunc;
};
$.callModifier = function(modifierName,data){
if(modifier[modifierName] == undefined){
return;
}
var callFunc = modifier[modifierName];
callFunc(data);
};
} (jQuery));
function getCaptcha(captchaImgJqObj)
{
$.get("/?_type=hiddenData&_tag=captcha_data")
.done(function(){
var imgSrc = "/webimg/captcha.jpg?" + Math.random();
captchaImgJqObj.attr("src", imgSrc);
})
.fail(function(){
consoleLog( "Fail to get captcha code. ");
});
}
function timeTranslate(timeString)
{
var timetempstr = timeString;
if( timeString != "" )
{
var dayTranslat = {
"Sun" : "&?SNTP_099;",
"Mon" : "&?SNTP_100;",
"Tue" : "&?SNTP_101;",
"Wed" : "&?SNTP_102;",
"Thu" : "&?SNTP_103;",
"Fri" : "&?SNTP_104;",
"Sat" : "&?SNTP_105;"
};
var MonTranslat = {
"Jan" : "&?SNTP_106;",
"Feb" : "&?SNTP_107;",
"Mar" : "&?SNTP_108;",
"Apr" : "&?SNTP_109;",
"May" : "&?SNTP_110;",
"Jun" : "&?SNTP_111;",
"Jul" : "&?SNTP_112;",
"Aug" : "&?SNTP_113;",
"Sep" : "&?SNTP_114;",
"Oct" : "&?SNTP_115;",
"Nov" : "&?SNTP_116;",
"Dec" : "&?SNTP_117;"
};
var timeArry = timeString.split(",");
if(timeArry.length > 1)
{
var datstr = timeArry[0];
var monstr = timeArry[1];
timeArry[0] = dayTranslat[datstr];
timeArry[1] = MonTranslat[monstr];
}
timetempstr = timeArry.join(",");
}
return timetempstr;
}
function getPwdLevel(val, relVal, Longth)
{
if (val.length < Longth)
{
return false;
}
if ( !(/[0-9]+/).test(val) ||
!(/[a-zA-Z]+/).test(val) ||
!(/[!"#$%&'()*+,-./:;<=>?@\[\\\]^_`{|}~]+/).test(val) )
{
return false;
}
if (val == relVal || val == relVal.split("").reverse().join(""))
{
return false;
}
return true;
}
function CheckPwdStrengthClass(pwdId, relativeId, templateId, customRuleFunc, customTip, minLongth){
this.pwdObj = $("[id^="+pwdId+"]", $("#"+templateId));
this.checkStrength = function(o, v){
var r = {
txt: "&?public_172;",
aClass: "redFont"
};
if (typeof(customRuleFunc) == "function"){
return customRuleFunc(o, v);
}
var myTplt = o.closest("[id^=template_]");
var relVal = $("[id^="+relativeId+"]", myTplt).val();
var Longth = 8;
if (typeof(minLongth) == "number") {
Longth = minLongth;
}
var strongPwd = getPwdLevel(v, relVal, Longth);
if (strongPwd) {
r.txt = "";
}
return r;
};
this.showResult = function(o, r){
var inputParent = o.parent();
inputParent.find(".__CheckPwdStrength").remove();
if (r.txt != "") {
inputParent.append("<span class='__CheckPwdStrength "+r.aClass+"'>"+r.txt+"</span>");
}
};
this.showTip = function(o){
var tipF = "&?public_174;";
if (typeof(customTip) == "string") {
tipF = customTip;
}
var tip = "";
if(typeof(minLongth) == "number") {
tip = tipF.format(minLongth);
}
else {
tip = tipF.format(8);
}
if (tip.length > 0){
var area = o.closest(".formTbl");
if (area.find(".__CheckPwdStrengthTip").length < 1) {
area.prepend("<div class='staticInfoHint __CheckPwdStrengthTip'><p>"+tip+"</p></div>");
}
}
$("#dynamicTip").remove();
o.trigger("focus.dTip");
};
var theCPSObj = this;
this.pwdObj.bind("keyup.pwdStrength", function(){
var v = $(this).val();
var r = theCPSObj.checkStrength($(this), v);
theCPSObj.showResult($(this), r);
}).bind("focus.pwdStrength", function(){
theCPSObj.showTip($(this));
});
}
function wlanDisableControl(funcID){
if(ssidConf.disable != undefined){
if(ssidConf.disable == "all" || ssidConf.disable.indexOf(funcID) != -1){
var Head = $("#"+funcID);
Head.find("input[id!=''],select[id!='']").attr("disabled","disabled");
Head.find(".Button").addClass("disableBtn");
Head.find(".instDelete,.instNew").off("click");
}
}
}
function speed_change_auto(accessType, speeddata) {
var speeddata = parseInt(speeddata);
if (accessType === 'wlan') {
if (speeddata < 1000) {
speeddata = Number(speeddata).toFixed(0) + 'bps ';
} else if (speeddata >= 1000 && speeddata < 1000000) {
speeddata = Number(speeddata / 1000).toFixed(0) + 'Kbps ';
} else if (speeddata >= 1000000 && speeddata < 1000000000) {
speeddata = Number(speeddata / 1000 / 1000).toFixed(0) + 'Mbps ';
} else if (speeddata >= 1000000000) {
speeddata = Number(speeddata / 1000 / 1000 / 1000).toFixed(0) + 'Gbps ';
}
} else if (accessType === 'eth') {
var tmp = speeddata/1000;
if (tmp < 1000) {
tmp = tmp + 'bps ';
} else if (tmp >= 1000 && tmp < 1000000) {
tmp = Number(tmp / 1000).toFixed(0) + 'Kbps ';
} else if (tmp >= 1000000) {
tmp = Number(tmp / 1000 / 1000).toFixed(0) + 'Mbps ';
}
speeddata = tmp;
}
return speeddata;
}
function bps_speed_change_auto(speeddata) {
var speeddata = parseInt(speeddata);
if (speeddata < 1000) {
speeddata = Number(speeddata).toFixed(0) + 'bps ';
} else if (speeddata >= 1000 && speeddata < 1000000) {
speeddata = Number(speeddata / 1000).toFixed(0) + 'Kbps ';
} else if (speeddata >= 1000000) {
speeddata = Number(speeddata / 1000 / 1000).toFixed(0) + 'Mbps ';
}
return speeddata;
}
function disable_all_templte(template) {
if(typeof(template) == "string"){
template = $("#"+template);
}
$("div.row",template).find("input,select").disableIt(true);
$("div.buttongroup",template).find(":button").disableButton(true);
}
function g_WlanCountryCodeOptionAdd(template)
{
var countryCodeOBJ = $("#CountryCode", template);
<%
local countryC = ""
local countryT = ""
local mode
if _G.ssidConf["wlanCountryConf"] ~= nil then
countryC = _G.ssidConf["wlanCountryConf"][1]
countryT = _G.ssidConf["wlanCountryConf"][2]
countryT = lang[countryT]
mode = _G.ssidConf["wlanCountryConf"][3] or "add"
end
%>
var countryCodeEx = "<%=countryC%>";
var countryCodeTitle = "<%=countryT%>";
var modiferMode = "<%=mode%>";
if(countryCodeEx == "")
{
return;
}
if(modiferMode == "add")
{
var optionStr = "<option value ='"+countryCodeEx+"' title='"+countryCodeTitle+"'>"+countryCodeTitle+"</option>";
countryCodeOBJ.append(optionStr);
}
else if (modiferMode == "replace")
{
$("option",countryCodeOBJ).each(function(index,item){
if(this.value == countryCodeEx )
{
this.title = countryCodeTitle;
this.text = countryCodeTitle;
return false;
}
else if(this.title == countryCodeTitle)
{
this.value = countryCodeEx;
return false;
}
});
}
}
function g_ShowPass(srcObj, tObjId){
var TypeOBJ = (srcObj);
var ParentObj = TypeOBJ.closest("div");
var PassObj = $("[id^="+tObjId+"][type='password']",ParentObj);
var TextObj = $("[id^="+tObjId+"][type='text']",ParentObj);
if(TypeOBJ.attr("src") == "../img/sleeping.png")
{
TypeOBJ.attr("src", "../img/awaking.png");
PassObj.addClass("PostIgnore").hide();
TextObj.removeClass("PostIgnore").show();
TextObj.val(PassObj.val());
}
else
{
TypeOBJ.attr("src", "../img/sleeping.png");
PassObj.removeClass("PostIgnore").show();
TextObj.addClass("PostIgnore").hide();
PassObj.val(TextObj.val());
}
}
function g_ChangePass2See(template,passID){
var passObj = $("#"+passID,template);
passObj.removeClass("SpecialPassword");
var textObj = passObj.next(":text");
if(textObj.length == 0){
textObj = $("<input type='text' id='"+passID+"' name='"+passID+"' class='PostIgnore' style='display:none'/>");
textObj.addClass(passObj.attr("class"));
passObj.after(textObj);
}
var chgBtn = textObj.next("img");
if(chgBtn.length == 0){
chgBtn = $("<img id='Show"+passID+"' src='../img/sleeping.png' style='width:16px; height:16px;'/>");
textObj.after(chgBtn);
}
chgBtn.bind("click",function(){
g_ShowPass($(this), passID);
});
}
function checkRight(right){
if(right == ""){
return true;
}
var curRightBit = 1 << (parseInt(curRight)-1);
right = parseInt(right);
return ((curRightBit & right) == curRightBit);
}
function ruleAction(rule,elementRow){
if(rule[2] == ""){
elementRow.find("input,select").disableIt(true);
}
else if(rule[2] == "hide"){
elementRow.find("input,select").disableIt(true);
elementRow.showIt(false);
}
else if(rule[2] == "remove"){
elementRow.remove();
}
else if(rule[2] == "show"){
elementRow.find("input,select").disableIt(false);
elementRow.showIt(true);
}
}
function singleElementCtrl(rule,template){
var elementRow;
if(/^<.+>$/g.test(rule[0])){
var eleStr = rule[0].match(/[^<>]+/g)[0];
elementRow = $("div.row:has("+eleStr+")",template);
if(elementRow.length == 0){
elementRow = $(eleStr,template);
}
}
else{
elementRow = $("div.row:has(#"+rule[0]+")",template);
}
ruleAction(rule,elementRow);
}
function singleElementCtrl4Multi(rule,template){
var elementRow = $("div.row:has([id^='"+rule[0]+":')",template);
ruleAction(rule,elementRow);
}
function g_runElementControl(templateList){
templateList.each(function(){
var template = $(this);
var id = template.attr("id");
var ruleStr = commConf.elementControl[id];
if(ruleStr == undefined){
return;
}
var ruleList = ruleStr.split("+");
for(i in ruleList) {
var rule = ruleList[i].split(":");
if(checkRight(rule[1]) == false){
continue;
}
if(rule[0] == "all"){
disable_all_templte(template);
if(rule[2] == "hideBtn"){
$("div.buttongroup",template).find(":button").showIt(false);
}
}
else{
singleElementCtrl(rule,template);
}
}
});
}
