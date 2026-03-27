<%
%>
<div id="TraceRouteDiagnosis" class="HeadDIV" style="padding-top:0">
<address style="display:none">
<span class="form-action">/?_type=menuData&_tag=networkdiag_traceroute_lua.lua</span>
</address>
<div class="externErrorHint" style="display:none;">
<span class="caption1"></span>
</div>
<div id="TraceRouteDiagnosis_container">
<div id="template_TraceRouteDiagnosis">
<div id="topLine_TraceRouteDiagnosis" class="formTblCtrlBar">
<span id="instName_TraceRouteDiagnosis" class="instName collapsibleInst" title="&?DiagnosisManag_025;">&?DiagnosisManag_025;</span>
</div>
<div id="changeArea_TraceRouteDiagnosis" class="ChangeArea formTblWrap" style="display:none;">
<div class="errorHint" style="display:none;">
<span class="caption1"></span>
</div>
<form class="form_content formTbl">
<input type="hidden" id="_InstID" value="">
<input type="hidden" id="Control" value="">
<div class="row">
<label for="Host:TraceRouteDiagnosis" class="cfgLabel w150">&?DiagnosisManag_022;</label>
<div class="right">
<input type="text" class="inputNorm" id="Host:TraceRouteDiagnosis" name="Host:TraceRouteDiagnosis" value=""/>
</div>
</div>
<div class="row">
<label for="Interface:TraceRouteDiagnosis" class="cfgLabel w150">&?public_015;</label>
<div class="right">
<select id="Interface:TraceRouteDiagnosis" name="Interface:TraceRouteDiagnosis" class="selectNorm" >
<option value="" title='&?public_094;'>&?public_094;</option>
<%
if env.getenv("CountryCode") == "41" and session_get(sess_id, "Right") ~= "1" then
cgilua.put(_G.CreateIFOpStr("TracertInternet"))
else
cgilua.put(_G.CreateIFOpStr("Tracert",nil,{"WANServlist"}))
end
%>
</select>
</div>
</div>
<div class="row">
<label for="MaxHopCount" class="cfgLabel w150">&?DiagnosisManag_026;</label>
<div class="right">
<input type="text" class="inputNorm" id="MaxHopCount" name="MaxHopCount" value=""/>
<span style="display: none;">&?public_072;1~64</span>
</div>
</div>
<div class="row">
<label for="Timeout:TraceRouteDiagnosis" class="cfgLabel w150">&?DiagnosisManag_027;</label>
<div class="right">
<input type="text" class="inputNorm" id="Timeout:TraceRouteDiagnosis" name="Timeout:TraceRouteDiagnosis" value=""/>&?public_052;
<span style="display: none;">&?public_072;2000~10000</span>
</div>
</div>
<div class="row">
<label for="Protocol" class="cfgLabel w150">&?public_053;</label>
<div class="right">
<select id="Protocol" name="Protocol" class="selectNorm" >
<option value="UDP" title='&?public_037;'>&?public_037;</option>
<option value="ICMP" title='&?public_038;'>&?public_038;</option>
</select>
</div>
</div>
<div class="row">
<label for="IPVersion:TraceRouteDiagnosis" class="cfgLabel w150">&?InternetDE_019;</label>
<div class="right">
<select id="IPVersion:TraceRouteDiagnosis" name="IPVersion:TraceRouteDiagnosis" class="selectNorm" >
<option value="IPv6" title="&?public_101;">&?public_101;</option>
<option value="IPv4" title="&?public_100;">&?public_100;</option>
</select>
</div>
</div>
<div class="buttongroup">
<input type="button" class="Button Btn_TraceRouteDiagnosis" id="Btn_TraceRouteDiagnosis" name="Btn_TraceRouteDiagnosis" value="&?DiagnosisManag_001;" />
</div>
<div class="row">
<label class="cfgLabel w150">&?DiagnosisManag_014;</label>
</div>
<div class="textareaRow">
<textarea id="Result" value="" readonly="readonly"></textarea>
</div>
<div class="segmentRow"></div>
</form>
</div>
</div>
</div>
</div>
