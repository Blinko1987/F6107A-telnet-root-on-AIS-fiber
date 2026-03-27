<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=&?CHARSET;" />
<meta http-equiv="X-UA-Compatible" content="IE=edge">
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
</head>
<body>
<script type="text/javascript">
</script>
<div id="page_container">
<div id="page_header">
<div id="banner">
<div id="logo" class="logo"></div>
<div id="banner_switchArea">
</div>
</div>
</div>
<div id="page_content">
<div class="lock">
<div>
<img src="../img/lock.png" width="85" height="80" />
</div>
<div>
<span>The network used is not an AIS network, the device is locked.</span>
</div>
</div>
</div>
<div id="wizard_footer">
<span id="copyRight">&?public_092;</span>&nbsp;&nbsp;|&nbsp;&nbsp;
<span id="pdtVer"><%=_G.encodeHTML(env.getenv("WEBTitle"))%>&nbsp;<%=_G.encodeHTML(env.getenv("SoftwareVer"))%></span>
</div>
</div>
</body>
</html>
