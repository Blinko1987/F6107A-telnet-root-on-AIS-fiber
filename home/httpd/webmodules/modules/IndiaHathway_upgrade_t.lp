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
<script type="text/javascript" src="jquery/jquery.min.js"></script>
<!--[if lte IE 8]>
<script type="text/javascript" src="jquery/jquery-3.0.0-alpha1-compat.min.js"></script>
<![endif]-->
<script type="text/javascript" src="jquery/common_lib.js"></script>
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
%>
</style>
<script type="text/javascript" src="jquery/crypto-js.min.js"></script>
<script type="text/javascript" src="jquery/jsencrypt.min.js"></script>
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
</script>
</head>
<body>
<script type="text/javascript">
if(top != self)
{
document.getElementsByTagName("body")[0].style.display = 'none';
top.location = self.location;
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
</div>
<div id="mainNavigator">
<div id="mn_first"></div>
<div id="mn_li"></div>
<div id="mn_last"></div>
</div>
</div>
<div id="page_content">
<script type="text/javascript">
<%
cgilua_lp.include("../../thinklua/template/template_help_js.lp",getfenv(1))
cgilua_lp.include("../../thinklua/template/commpage_status_comm.lp", getfenv(1))
%>
</script>
<%
cgilua_lp.include("../../webmodules/modules/IndiaHathway_upgrade_js.lp", getfenv(1))
local sess_id = cgilua.getCurrentSessID()
local sessToken = _G.encodeHTML(session_get(sess_id, "sess_token"))
%>
<div id="FirmwareUpgr" class="HeadDIV">
<div class="sceneTip">
<div name="registerout" id="registerout">
<a href="/">&?IndiaHathway_upgrade_001;</a>
</div>
</div>
<div id="homeWrapper">
<input id="DataHasBeenGot" type="hidden" value="1">
<div id="template_FirmwareUpgr">
<div class="formTblWrap">
<form class="form_content formTbl" name="fUpload" id="fUpload" method="POST" enctype="multipart/form-data" onsubmit="return false;">
<div class="staticInfoHint">
<p>&?FirmwareUpgr_004;</p>
</div>
<div id="wizard_wrapper_paddingMod">
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
<div class="row">
<label for="VersionUpload">&?FirmwareUpgr_003;</label>
</div>
<div class="row">
<div class="left">
<input type="file" name="VersionUpload" size="54" id="VersionUpload" value="">
</div>
</div>
<div class="unfloatBtnGroup">
<input type="button" class="longBtn" id="Btn_Upload" name="Btn_Upload" value="&?FirmwareUpgr_005;"/>
</div>
<input type="hidden" id="TOKEN_UPLOAD" name="TOKEN_UPLOAD" value="<%=sessToken%>"/>
<div class="segmentRow"></div>
<div class="segmentRow"></div>
</div>
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
local showpagefooter = true
if _G.commConf.pagefooter~=nil and _G.commConf.pagefooter=="remove" then
showpagefooter = false
end
if showpagefooter then
%>
<span id="copyRight">&?public_161;<%=_G.encodeHTML(env.getenv("VerDate"))%>&?public_162;</span>&nbsp;&nbsp;|&nbsp;&nbsp;
<span id="pdtVer"><%=_G.encodeHTML(env.getenv("WEBTitle"))%>&nbsp;<%=_G.encodeHTML(env.getenv("SoftwareVer"))%></span>
<%
end
%>
</div>
</div>
</body>
</html>
