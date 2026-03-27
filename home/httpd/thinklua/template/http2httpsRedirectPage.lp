<%
local servervariable = cgilua.servervariable
local httpsURL = "https://" .. servervariable"REMOTE_HDRHOST"
httpsURL = httpsURL .. "/" .. servervariable"SCRIPT_NAME"
cgilua.header("Location", httpsURL)
%>
<html>
<head>
<title>302 Found</title>
</head>
<body bgcolor="#FFFFFF" text="#000000" link="#2020ff" vlink="#4040cc">
<h2>302 Found</h2>
<span>The requested URL is going to be https.</span>
<div style="display:none">
<span>Padding so that MSIE deigns to show this error instead of its own canned one.</span>
<span>Padding so that MSIE deigns to show this error instead of its own canned one.</span>
<span>Padding so that MSIE deigns to show this error instead of its own canned one.</span>
<span>Padding so that MSIE deigns to show this error instead of its own canned one.</span>
<span>Padding so that MSIE deigns to show this error instead of its own canned one.</span>
<span>Padding so that MSIE deigns to show this error instead of its own canned one.</span>
</div>
<hr/>
</body>
</html>
