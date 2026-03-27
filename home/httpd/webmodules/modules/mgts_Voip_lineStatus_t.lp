<%
cgilua_lp.include("../../webmodules/modules/mgts_Voip_lineStatus_js.lp", getfenv(1))
local voipProtocol = env.getenv("VoIPProtocal")
%>
<div id="VOIPRegStatus" class="HeadDIV">
<address style="display:none">
<span class="form-action">/?_type=menuData&_tag=mgts_voipRegStatus_lua.lua</span>
</address>
<div class="externErrorHint" style="display:none;">
<span class="caption1"></span>
</div>
<h1 class="collapBarWithDataTrans" id="VOIPRegStatusBar">&?VoipStatus_002;</h1>
<div id="VOIPRegStatus_container">
<div class="errorHint" style="display:none;">
<span class="caption1"></span>
</div>
<div class="noDataHint" style="display:none;">
<div>&?public_023;</div>
</div>
<input type="hidden" id="DataHasBeenGot" value="0">
<div class="colorTbl form_content">
<div id="VOIPRegStatus_title" class="colorTblRow emFont titleRow">
<%
if voipProtocol == "SIP" then
%>
<span class="w180" title="&?InternetAIS_090;">&?InternetAIS_090;</span>
<span class="w180" title="&?VoipStatus_036;">&?VoipStatus_036;</span>
<%
else
%>
<span class="w250" title="&?InternetAIS_090;">&?InternetAIS_090;</span>
<%
end
%>
<span class="w180" title="&?public_001;">&?public_001;</span>
</div>
<div id="template_VOIPRegStatus" class="colorTblRow" style="display:none;" >
<input type="hidden" id="DigestUserName" value="" class="PostIgnore">
<input type="hidden" id="DirectoryNumber" value="" class="PostIgnore">
<%
if voipProtocol == "SIP" then
%>
<span class="w180" id="lineName" title=""></span>
<span class="w180" id="AuthUserName" title=""></span>
<%
else
%>
<span class="w250" id="lineName" title=""></span>
<%
end
%>
<span class="w180" id="VoIPRegStatus" title=""></span>
</div>
</div>
<div class="buttongroup">
<input type="button" class="Button Btn_refresh" id="Btn_refresh_VOIPRegStatus" name="Btn_refresh_VOIPRegStatus" value="&?public_003;" />
</div>
</div>
</div>
