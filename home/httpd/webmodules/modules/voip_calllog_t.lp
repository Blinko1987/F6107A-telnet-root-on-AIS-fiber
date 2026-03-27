<%
cgilua_lp.include("../../webmodules/modules/voip_calllog_js.lp", getfenv(1))
%>
<%
local voipProtocol = env.getenv("VoIPProtocal")
if voipProtocol == "SIP" then
%>
<div id="VOIPCallLog" class="HeadDIV">
<address style="display:none">
<span class="form-action">/?_type=menuData&_tag=voipCallLog_lua.lua</span>
</address>
<div class="externErrorHint" style="display:none;">
<span class="caption1"></span>
</div>
<h1 class="collapBarWithDataTrans" id="VOIPCallLogBar">&?VoipStatus_003;</h1>
<div id="VOIPCallLog_container">
<div class="errorHint" style="display:none;">
<span class="caption1"></span>
</div>
<div class="noDataHint" style="display:none;">
<span>&?public_023;</span>
</div>
<input type="hidden" id="DataHasBeenGot" value="0">
<div class="colorTbl form_content">
<div id="VOIPCallLog_title" class="colorTblRow emFont titleRow">
<span class="w150" title="&?VoipStatus_004;">&?VoipStatus_004;</span>
<span class="w150" title="&?VoipStatus_005;">&?VoipStatus_005;</span>
<span class="w150" title="&?VoipStatus_006;">&?VoipStatus_006;</span>
<span class="w100" title="&?VoipStatus_007;">&?VoipStatus_007;</span>
<span class="w100" title="&?VoipStatus_008;">&?VoipStatus_008;</span>
</div>
<div id="template_VOIPCallLog" class="colorTblRow" style="display:none;">
<span class="w150" id="BeginTime" title=""></span>
<span class="w150" id="LocNumber" title=""></span>
<span class="w150" id="RmtNumber" title=""></span>
<span class="w100" id="Duration" title=""></span>
<span class="w100" id="Result" title=""></span>
</div>
</div>
<div class="buttongroup">
<input type="button" class="Button Btn_refresh" id="Btn_refresh_VOIPCallLog" name="Btn_refresh_VOIPCallLog" value="&?public_003;" />
</div>
</div>
</div>
<%
end
%>
