<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=&?CHARSET;" />
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<link rel="shortcut icon" href="/img/favicon.ico" />
<title><%=_G.encodeHTML(env.getenv("WEBTitle"))%></title>
<style type="text/css">
<%
local getfenv,require,encodeHTML = _G.getfenv,_G.require,_G.encodeHTML
local sessmgr = require("user_mgr.session_mgr")
local usermgr = require("user_mgr.usermgr_logic_impl")
local token = cmapi.nocsrf.tokenRandom()
sessmgr.SetCurrentSessAttr("sess_token", token)
cgilua_lp.include("../../public/css/template.css")
cgilua_lp.include("../../public/css/commonpage.css")
cgilua_lp.include("../../public/css/home.css")
if _G.cmapi.file_exists("../../public/css/pro_style.css") == 1 then
cgilua_lp.include("../../public/css/pro_style.css")
end
cgilua_lp.include("../../thinklua/template/template_menu_js.lp",getfenv(1))
cgilua_lp.include("../../thinklua/template/template_help_js.lp",getfenv(1))
cgilua_lp.include("../../thinklua/template/jquery_validate_extjs.lp",getfenv(1))
if _G.cmapi.file_exists("template/pro_interface.lp") == 1 then
cgilua.lp.include("../../thinklua/template/pro_interface.lp",getfenv(1))
end
local cjson = require"common_lib.json"
%>
</style>
<script type="text/javascript" src="jquery/jquery.min.js"></script>
<!--[if lte IE 8]>
<script type="text/javascript" src="jquery/jquery-3.0.0-alpha1-compat.min.js"></script>
<![endif]-->
<script type="text/javascript" src="jquery/crypto-js.min.js"></script>
<script type="text/javascript" src="jquery/jsencrypt.min.js"></script>
<script type="text/javascript" src="jquery/common_lib.js"></script>
<script type="text/javascript">
var _sessionTmpToken = "<%=_G.encodeJS(session_get(sess_id, "sess_token"))%>";
var preLoadImg = [];
preLoadImg[0] = "/img/nv_s.gif";
preLoadImg[1] = "/img/nv_left.gif";
preLoadImg[2] = "/img/nv_right.gif";
preLoadImg[3] = "/img/nv_middle.gif";
preLoadImg[4] = "/img/waiting.gif";
preLoadImg[5] = "/img/info_m.png";
preLoadImg[6] = "/img/waiting_w.gif";
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
var commConf = {};
commConf = JSON.parse('<%=cjson.encode(_G.commConf)%>');
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
$.post( "/?_type=loginData&_tag=logout_entry", {IF_LogOff:1}, undefined, "json" )
.done(function( data ) {
if ( data.need_refresh )
{
top.location.href = "/";
}
});
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
</div>
</div>
<div id="page_container">
<div id="page_header">
<div id="banner">
<div id="logo" class="logo"></div>
<div id="banner_switchArea">
<div id="logOff" class="emColor clickable" onclick="LogOff()" style="display:none;">
<div id="LogOffLnk">&?public_079;</div>
<div id="logUser" class="logUser" title="<%=_G.encodeHTML(NowLoginAccount)%>">
<%=_G.encodeHTML(NowLoginAccount)%>
</div>
</div>
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
local sess_id = cgilua.getCurrentSessID()
local loginStatus = session_get(sess_id, "status_login")
cgilua_lp.include("../../thinklua/template/common_eventtriggering.lp",getfenv(1))
cgilua_lp.include("../../webmodules/modules/Fastway_js.lp", getfenv(1))
%>
<div id="DocsisCtr" class="HeadDIV">
<address style="display:none">
<span class="form-action">/?_type=hiddenData&_tag=fastway</span>
</address>
<div id="homeWrapper">
<input id="DataHasBeenGot" type="hidden" value="0">
<div id="template_DocsisCtr">
<div id="changeArea_DocsisCtr" class="ChangeArea">
<form class="form_content formTblnopadding">
<div id="wizard_wrapper_paddingMod" class="ChangeArea formTblWrap">
<div class="sceneTip">
<div name="registerout" id="registerout">
<a href="/">&?sshpage_001;</a>
</div>
</div>
<div class="externErrorHint" style="display:none;">
<span class="caption1"></span>
</div>
<div id="wizardContainer" class="wizardContainer">
<div id="errorHint" class="errorHint" style="display:none;">
<span class="caption1"></span>
</div>
<div class="succHint" style="display:none;">
<span class="caption1">&?public_021;</span>
</div>
<div id="wizardChildPage" class="wizardChildPage">
<h1 id="DocsisCtrHead" class="emColor emFont">&?fastway001;</h1>
<div class="rowhid">
<label class="cfgLabel w200" for="EthBasedOnRegEn">&?fastway002;</label>
<div id="EthBasedOnRegEn" class="right">
<input type="radio" value="1" name="EthBasedOnRegEn" id="EthBasedOnRegEn1"><label for="EthBasedOnRegEn1">&?public_033;</label>&nbsp;&nbsp;
<input type="radio" value="0" name="EthBasedOnRegEn" id="EthBasedOnRegEn0"><label for="EthBasedOnRegEn0">&?public_034;</label>
</div>
</div>
<div class="segmentRow"></div>
<div class="segmentRow"></div>
</div>
</div>
<div class="buttongroup">
<input type="button" class="Button Btn_cancel PostIgnore" id="Btn_cancel_ssh" name="Btn_cancel_ssh" value="&?public_019;" />
<input type="button" class="Button Btn_apply PostIgnore" id="Btn_apply_ssh" name="Btn_apply_ssh" value="&?public_018;" />
</div>
</div>
</form>
</div>
</div>
</div>
</div>
</div>
<div id="page_footer">
<%
local footerStr
if pro_footer then
footerStr = pro_footer()
end
if footerStr == nil then
%>
<span id="copyRight">&?public_161;<%=_G.encodeHTML(env.getenv("VerDate"))%>&?public_162;</span>&nbsp;&nbsp;|&nbsp;&nbsp;
<span id="pdtVer"><%=_G.encodeHTML(env.getenv("WEBTitle"))%>&nbsp;<%=_G.encodeHTML(env.getenv("SoftwareVer"))%></span>
<%
else
cgilua.put(footerStr)
end
%>
</div>
</div>
<script type="text/javascript">
$(document).ready(function(){
var loginStatus = "<%=loginStatus%>";
if ( loginStatus == "logined" )
{
$("#logOff").show();
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
