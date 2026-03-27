<%
%>
<div id="PingDiagnosis" class="HeadDIV" style="padding-top:0">
<address style="display:none">
<span class="form-action">/?_type=menuData&_tag=networkdiag_ping_lua.lua</span>
</address>
<div class="externErrorHint" style="display:none;">
<span class="caption1"></span>
</div>
<div id="PingDiagnosis_container">
<div id="template_PingDiagnosis">
<form class="form_content">
<div id="topLine_PingDiagnosis" class="formTblCtrlBar">
<span id="instName_PingDiagnosis" class="instName collapsibleInst" title="&?DiagnosisManag_024;">&?DiagnosisManag_024;</span>
</div>
<div id="changeArea_PingDiagnosis" class="ChangeArea formTblWrap" style="display:none;">
<div class="errorHint" style="display:none;">
<span class="caption1"></span>
</div>
<div class="formTbl">
<input type="hidden" id="_InstID" value="">
<div class="row">
<label for="Host:PingDiagnosis" class="cfgLabel w150">&?DiagnosisManag_022;</label>
<div class="right">
<input type="text" class="inputNorm" id="Host:PingDiagnosis" name="Host:PingDiagnosis" value=""/>
</div>
</div>
<div class="row">
<label for="Interface:PingDiagnosis" class="cfgLabel w150">&?DiagnosisManag_023;</label>
<div class="right">
<select id="Interface:PingDiagnosis" name="Interface:PingDiagnosis" class="selectNorm" >
<option value="" title='&?public_094;'>&?public_094;</option>
<%
if env.getenv("CountryCode") == "41" and session_get(sess_id, "Right") ~= "1" then
cgilua.put(_G.CreateIFOpStr("PINGINTERNET"))
else
cgilua.put(_G.CreateIFOpStr("PING",nil,{"WANServlist"}))
end
%>
</select>
</div>
</div>
<div class="row">
<label for="IPVersion:PingDiagnosis" class="cfgLabel w150">&?InternetDE_019;</label>
<div class="right">
<select id="IPVersion:PingDiagnosis" name="IPVersion:PingDiagnosis" class="selectNorm" >
<% if "0" ~= env.getenv("DevIPv6Effect") then %>
<option value="Any" title="&?public_126;">&?public_126;</option>
<option value="IPv6" title="&?public_101;">&?public_101;</option>
<% end %>
<option value="IPv4" title="&?public_100;">&?public_100;</option>
</select>
</div>
</div>
<div class="buttongroup">
<input type="button" class="Button Btn_PingDiagnosis" id="Btn_PingDiagnosis" name="Btn_PingDiagnosis" value="&?DiagnosisManag_001;" />
</div>
<div class="row">
<label class="cfgLabel w150">&?DiagnosisManag_014;</label>
</div>
<div class="textareaRow">
<textarea id="PingAck" value="" readonly="readonly"></textarea>
</div>
<div class="segmentRow"></div>
</div>
</div>
</form>
</div>
</div>
</div>
