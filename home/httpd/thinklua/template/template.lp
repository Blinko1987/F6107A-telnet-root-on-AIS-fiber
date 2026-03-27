<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=&?CHARSET;" />
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<%
local faviconStr = "/img/favicon.ico"
local showIcon = true
if _G.commConf.favicon ~= nil then
if _G.commConf["favicon"] == "remove" then
showIcon = false
else
faviconStr = string.format("/img/%s", _G.commConf["favicon"])
end
end
if showIcon then
%>
<link rel="shortcut icon" href="<%=faviconStr%>" />
<%end%>
<title><%=_G.encodeHTML(env.getenv("WEBTitle"))%></title>
<style type="text/css">
<%
cgilua_lp.include("../../public/css/template.css")
cgilua_lp.include("../../public/css/commonpage.css")
local fileutils = require "common_lib.file_utils"
if fileutils.isFileExist("../../public/css/pro_style.css") then
cgilua_lp.include("../../public/css/pro_style.css")
end
%>
</style>
<script type="text/javascript" src="/jquery/jquery.min.js"></script>
<!--[if lte IE 8]>
<script type="text/javascript" src="jquery/jquery-3.0.0-alpha1-compat.min.js"></script>
<![endif]-->
<script type="text/javascript" src="/jquery/crypto-js.min.js"></script>
<script type="text/javascript" src="/jquery/jsencrypt.min.js"></script>
<script type="text/javascript" src="/jquery/common_lib.js"></script>
<script type="text/javascript">
<%
cgilua_lp.include("../template/template_menu_js.lp",getfenv(1))
cgilua_lp.include("../template/template_help_js.lp",getfenv(1))
cgilua_lp.include("../template/jquery_validate_extjs.lp",getfenv(1))
if fileutils.isFileExist("../template/pro_interface.lp") then
cgilua.lp.include("../template/pro_interface.lp",getfenv(1))
end
local menuTreeJSON = ""
if NowStatus ~= "showCommonPage" then
menuTreeJSON = menutree:OutputMenuJSData_unlogined();
else
menuTreeJSON = menutree:OutputMenuJSData_logined();
end
%>
var menuTreeJSON = <%=menuTreeJSON%>;
var menuTreeObj = new MenuTreeClass(menuTreeJSON);
var _sessionTmpToken = "<%=_G.encodeJS(session_get(sess_id, "sess_token"))%>";
var preLoadImg = [];
preLoadImg[0] = "/img/nv_s.gif";
preLoadImg[1] = "/img/nv_left.gif";
preLoadImg[2] = "/img/nv_right.gif";
preLoadImg[3] = "/img/nv_middle.gif";
preLoadImg[4] = "/img/English_s.gif";
preLoadImg[5] = "/img/Chinese.gif";
preLoadImg[6] = "/img/Chinese_s.gif";
preLoadImg[7] = "/img/English.gif";
preLoadImg[8] = "/img/waiting.gif";
preLoadImg[9] = "/img/info_m.png";
preLoadImg[10] = "/img/waiting_w.gif";
function preload(Img)
{
var imgTmp = [];
for (var i=0; i<Img.length; i++)
{
imgTmp[i] = new Image();
imgTmp[i].src = Img[i];
}
}
preload(preLoadImg);
</script>
</head>
<body>
<script type="text/javascript">
if(top != self)
{
document.getElementsByTagName("body")[0].style.display = 'none';
top.location = self.location;
}
function LogOff()
{
showWaitTip(true);
$.post( "/?_type=loginData&_tag=logout_entry", {IF_LogOff:1}, undefined)
.done(function( data ) {
if($.isPlainObject(data))
{
if ( data.need_refresh )
{
top.location.href = top.location.href;
}
}
else
{
top.location.href = top.location.href;
}
});
}
function LogUser()
{
openLink("accountMgr" + "&Menu3Location=0");
}
</script>
<div id="blackMask" class="black_overlay" style="display:none;"></div>
<div id="tipLayer" class="white_content">
<div id="confirmLayer" style="display:none;">
<div id="confirmMsg">
<p>are you sure?</p>
</div>
<div id="waitingImgArea" style="display:none;">
</div>
<div id="confirmBtnArea" style="display:none;">
<input type="button" class="button" id="confirmCancel" value="&?public_019;" />
<input type="button" class="button" id="confirmOK" value="&?public_067;" />
<input type="button" class="button" id="confirmStop" value="&?public_065;" />
</div>
</div>
</div>
<div id="page_container">
<div id="page_header">
<div id="banner">
<%
local styleStr = 'class="logo"'
local showLogo = true
if _G.commConf.logo ~= nil then
if type(_G.commConf.logo) == "string" then
if _G.commConf["logo"] == "remove" then
showLogo = false
else
styleStr = string.format('class="%s"',_G.commConf["logo"])
end
else
styleStr = string.format('style="background: url(../img/%s) no-repeat 5px 30px;width: %dpx;height: %dpx;float: left;"',_G.commConf.logo[1],_G.commConf.logo[2],_G.commConf.logo[3])
end
end
if showLogo then
%>
<div id="logo" <%=styleStr%>></div>
<%end%>
<div class="timeArea" id="timeArea" style="display:none;">
&?public_086;<span id="_DevCurrTime">&?public_087;</span>
</div>
<div id="banner_switchArea">
<div id="logOff" class="emColor clickable" onclick="LogOff()">
<div id="LogOffLnk">&?public_079;</div>
<%if string.find(_G.commConf.template,"LogUser") == nil then%>
<div id="logUser" class="logUser" title="<%=_G.encodeHTML(NowLoginAccount)%>">
<%=_G.encodeHTML(NowLoginAccount)%>
</div>
<%end%>
</div>
<%if string.find(_G.commConf.template,"LogUser") ~= nil then%>
<div class="emColor clickable" onclick="LogUser()">
<div id="logUser" class="logUser" title="<%=_G.encodeHTML(NowLoginAccount)%>">
<%=_G.encodeHTML(NowLoginAccount)%>
</div>
</div>
<%end%>
</div>
</div>
<div id="mainNavigator">
<div id="mn_first"></div>
<div id="mn_li"></div>
<div id="mn_last"></div>
</div>
</div>
<div id="page_content">
<%
local file = renderFiles[1].file
renderFiles = renderFiles[1].children
cgilua_lp.include(file, getfenv(1))
%>
<div style="clear:left;height:1px;">&nbsp;</div>
</div>
<div id="page_footer">
<%
local showpagefooter = true
if _G.commConf.pagefooter~=nil and _G.commConf.pagefooter=="remove" then
showpagefooter = false
end
if showpagefooter then
%>
<span id="copyRight">&?public_161;<%=_G.encodeHTML(env.getenv("VerDate"))%>&?public_162;</span>&nbsp;&nbsp;|&nbsp;&nbsp;
<%
if NowStatus == "showCommonPage" then
%>
<span id="pdtVer"><%=_G.encodeHTML(env.getenv("WEBTitle"))%>&nbsp;<%=_G.encodeHTML(env.getenv("SoftwareVer"))%></span>
<%
else
%>
<span id="pdtVer"><%=_G.encodeHTML(env.getenv("WEBTitle"))%></span>
<%
end
end
%>
</div>
</div>
<script type="text/javascript">
function LanguageSwitch(nowLanguage)
{
var changeLanguage = "";
if ( "English" == nowLanguage)
{
changeLanguage = "<%=chLanguage%>";
}
else
{
changeLanguage = "English";
}
showWaitTip(true);
$.post( "/?_type=hiddenData&_tag=switchlang_entry", {IF_LanguageSwitch:changeLanguage}, undefined, "json" )
.done(function( data ) {
if ( data.need_refresh )
{
top.location.href = top.location.href;
}
});
}
function MenuModeSwitch(ModeNow)
{
var ChangeModeSwitch = "";
if ( "Basic" == ModeNow )
{
ChangeModeSwitch = "Advanced";
}
else
{
ChangeModeSwitch = "Basic";
}
showWaitTip(true);
$.post( "/?_type=loginData&_tag=modeswitch_entry", {IF_ModeSwitch:ChangeModeSwitch}, undefined, "json" )
.done(function( data ) {
if ( data.need_refresh )
{
top.location.href = top.location.href;
}
});
}
var UpdateTimeTimerID;
function UpdateCurrTime()
{
var CurrTimeObj = $("#_DevCurrTime");
var CurrTimeDiv = $("#timeArea");
CurrTimeObj.succfunction = function(xml){
if (CurrTimeDiv.hasError(xml,"_noExist") == 0)
{
var currTimeByXML = "";
$(xml).find('ParaName').each(function(){
var tmp = $(this);
if ( tmp.text() == "CurrentLocalTime" )
{
currTimeByXML = tmp.next().text();
return false;
}
});
if(typeof(customTimeStyle) == "function")
{
customTimeStyle(CurrTimeObj, currTimeByXML, "template");
}
else
{
var timeStr = timeTranslate(currTimeByXML);
if ( currTimeByXML != "")
{
var SecTimeLocation = currTimeByXML.lastIndexOf(":");
var currTimeNotSec = currTimeByXML.substring(0, SecTimeLocation);
CurrTimeObj.text(currTimeNotSec);
}
}
}
};
CurrTimeObj.failfunction = function(xml){
};
CurrTimeObj.dataTransfer("/?_type=hiddenData&_tag=sntp_data",
"GET",
CurrTimeObj.succfunction,
CurrTimeObj.failfunction,
false);
UpdateTimeTimerID = setTimeout("UpdateCurrTime()", 30*1000);
}
$(document).ready(function(){
<%
if NowStatus ~= "showCommonPage" then
%>
FakeClass1MenuShow();
<%
end
%>
clearTimeout(UpdateTimeTimerID);
var NowStatus = "<%=_G.encodeJS(NowStatus)%>";
var IsShowTimeZone = {
'showloginPage' : false,
'showWizardPage' : true,
'showCommonPage' : true
};
if ( !IsShowTimeZone[NowStatus] )
{
$("#timeArea").hide();
}
else
{
$("#timeArea").show();
UpdateCurrTime();
}
<%
if "108" == env.getenv("CountryCode") and "2" == env.getenv("OnuMode") then
%>
$("#timeArea").hide();
<%
end
%>
var logoLink = "<%
cgilua.put(menutree:getDefaultPage())
%>";
var IsShowlogOff = {
'showloginPage' : false,
'showWizardPage' : false,
'showCommonPage' : true
};
if ( !IsShowlogOff[NowStatus] )
{
$("#logOff").hide();
}
else
{
var obj = $("#logo");
obj.addClass("clickable");
obj.click(function(){
openLink(logoLink + "&Menu3Location=0");
});
}
var modeSwitchAction = {
'showloginPage' : null,
'showWizardPage' : null,
'showCommonPage' : MenuModeSwitch
};
if ( <%=Right%> == 1 || <%=Right%> == 4)
{
modeSwitchAction.showCommonPage = null;
}
if ( modeSwitchAction[NowStatus] != null )
{
var modeSwitchButContent = "<%=_G.encodeJS(ModeSwitchEnv)%>";
var modeOBJ = $("#modeSwitch");
var modeBasic = $("#modeBisic",modeOBJ);
var ModeAdvanced = $("#ModeAdvanced",modeOBJ);
if ( modeSwitchButContent == "Basic" )
{
ModeAdvanced.attr("class", "emColor clickable");
modeBasic.attr("class", "");
}
else if ( modeSwitchButContent == "Advanced" )
{
modeBasic.attr("class", "emColor clickable");
ModeAdvanced.attr("class", "");
}
else
{
}
}
$("span", modeOBJ).each(function(){
var tempOBJ = $(this);
tempOBJ.click(function(){
if ( ! $(this).hasClass("clickable")
|| modeSwitchAction[NowStatus] == null)
{
return;
}
var ModeNow = "<%=_G.encodeJS(ModeSwitchEnv)%>";
MenuModeSwitch(ModeNow);
});
});
function bindLanguageSwitchOld(){
var languageButContent = "<%=_G.encodeJS(gw_lang)%>";
var languageOBJ = $("#languageSwitch");
var languageEnglishOBJ = $("#EnglishModify",languageOBJ);
var languageChineseOBJ = $("#"+"<%=idstr%>",languageOBJ);
if ( languageButContent == "English" )
{
languageEnglishOBJ.attr("src","/img/English_s.gif");
languageChineseOBJ.attr("src","<%=srcstr%>");
languageChineseOBJ.addClass("clickable");
}
else if ( languageButContent == "Chinese" )
{
languageEnglishOBJ.attr("src","/img/English.gif");
languageEnglishOBJ.addClass("clickable");
languageChineseOBJ.attr("src","/img/Chinese_s.gif");
}
else if ( languageButContent == "Spanish" )
{
languageEnglishOBJ.attr("src","/img/English.gif");
languageEnglishOBJ.addClass("clickable");
languageChineseOBJ.attr("src","/img/Spanish_s.gif");
}
else if ( languageButContent == "Japanese" )
{
languageEnglishOBJ.attr("src","/img/English.gif");
languageEnglishOBJ.addClass("clickable");
languageChineseOBJ.attr("src","/img/Japanese_s.gif");
}
else if ( languageButContent == "Portuguese" )
{
languageEnglishOBJ.attr("src","/img/English.gif");
languageEnglishOBJ.addClass("clickable");
languageChineseOBJ.attr("src","/img/Portuguese_s.gif");
}else if( languageButContent == "French" ){
languageEnglishOBJ.attr("src","/img/English.gif");
languageEnglishOBJ.addClass("clickable");
languageChineseOBJ.attr("src","/img/French_s.gif");
}else if( languageButContent == "Russian" ){
languageEnglishOBJ.attr("src","/img/English.gif");
languageEnglishOBJ.addClass("clickable");
languageChineseOBJ.attr("src","/img/Russian_s.gif");
}
else
{
}
$("img", languageOBJ).each(function(){
var LanguageModifyOBJ = $(this);
LanguageModifyOBJ.click(function(){
if ( ! $(this).hasClass("clickable") )
{
return;
}
var LanguageNow = "<%=_G.encodeJS(gw_lang)%>";
LanguageSwitch(LanguageNow);
});
});
}
function bindLanguageSwitch(){
var languageButContent = "<%=_G.encodeJS(gw_lang)%>";
var languageOBJ = $("#languageSwitch");
var languageEnglishOBJ = $("#EnglishModify",languageOBJ);
var languageUnEnglishOBJ = $("#UnEnglishModify",languageOBJ);
if ( languageButContent == "English" )
{
languageEnglishOBJ.attr("class","currentlang");
languageUnEnglishOBJ.attr("class", "bannerswtch clickable");
}
else
{
languageEnglishOBJ.attr("class", "bannerswtch clickable");
languageUnEnglishOBJ.attr("class","currentlang");
}
$("span", languageOBJ).each(function(){
var LanguageModifyOBJ = $(this);
LanguageModifyOBJ.click(function(){
if ( ! $(this).hasClass("clickable") )
{
return;
}
var LanguageNow = "<%=_G.encodeJS(gw_lang)%>";
LanguageSwitch(LanguageNow);
});
});
}
<%
if _G.commConf["language"] ~= nil and _G.commConf["language"][1]=="word" then
%>
bindLanguageSwitch();
<% else %>
bindLanguageSwitchOld();
<% end %>
try{
if((templateModify!=undefined) && (typeof(templateModify)=="function")){
templateModify();
}
}catch(e){
}
});
window.onresize = function()
{
if ($("#tipLayer").css("display") != "none")
{
reposition_box("tipLayer");
consoleLog("window reseze!");
}
}
</script>
</body>
</html>
