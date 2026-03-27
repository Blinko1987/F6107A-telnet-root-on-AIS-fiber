<%
cgilua.lp.include("../../webmodules/modules/ManagDiag_DiagnosisManag_NsLookupDiagnosis_js.lp")
%>
<div id="NsLookupDiagnosis" class="HeadDIV" style="padding-top:0">
<address style="display:none">
<span class="form-action">/?_type=menuData&_tag=DiagnosisNsLookupReq_lua.lua</span>
</address>
<div class="externErrorHint" style="display:none;">
<span class="caption1"></span>
</div>
<div id="NsLookupDiagnosis_container">
<div id="template_NsLookupDiagnosis">
<div id="topLine_NsLookupDiagnosis" class="formTblCtrlBar">
<span id="instName_NsLookupDiagnosis" class="instName collapsibleInst" title="&?DiagnosisManag_051;">&?DiagnosisManag_051;</span>
</div>
<div id="changeArea_NsLookupDiagnosis" class="ChangeArea formTblWrap" style="display:none;">
<div class="errorHint" style="display:none;">
<span class="caption1"></span>
</div>
<form class="form_content formTbl">
<input type="hidden" id="_InstID" value="">
<div class="row">
<label for="Interface:NsLookupDiagnosis" class="cfgLabel w150">&?DiagnosisManag_023;</label>
<div class="right">
<select id="Interface:NsLookupDiagnosis" name="Interface:NsLookupDiagnosis" class="selectNorm" >
<option value="" title='&?public_094;'>&?public_094;</option>
<%
cgilua.put(_G.CreateIFOpStr("PING"))
%>
</select>
</div>
</div>
<div class="row">
<label for="HostName:NsLookupDiagnosis" class="cfgLabel w150">&?DiagnosisManag_052;</label>
<div class="right">
<input type="text" class="inputNorm" id="HostName:NsLookupDiagnosis" name="HostName:NsLookupDiagnosis" value=""/>
</div>
</div>
<div class="row">
<label for="ServerIP:NsLookupDiagnosis" class="cfgLabel w150">&?DiagnosisManag_057;</label>
<div class="right">
<input type="text" class="inputNorm" id="ServerIP:NsLookupDiagnosis" name="ServerIP:NsLookupDiagnosis" value=""/>
</div>
</div>
<div class="row">
<label for="IPVersion:TraceRouteDiagnosis" class="cfgLabel w150">&?InternetDE_019;</label>
<div class="right">
<select id="IPVersion:TraceRouteDiagnosis" name="IPVersion:TraceRouteDiagnosis" class="selectNorm" >
<% if "0" ~= env.getenv("DevIPv6Effect") then %>
<option value="Any" title="&?public_126;">&?public_126;</option>
<option value="IPv6" title="&?public_101;">&?public_101;</option>
<% end %>
<option value="IPv4" title="&?public_100;">&?public_100;</option>
</select>
</div>
</div>
<div class="buttongroup">
<input type="button" class="Button Btn_NsLookupDiagnosis" id="Btn_NsLookupDiagnosis" name="Btn_NsLookupDiagnosis" value="&?DiagnosisManag_001;" />
</div>
<div class="row">
<label class="cfgLabel w150">&?DiagnosisManag_014;</label>
</div>
<div class="textareaRow">
<textarea id="NLResult" value="" readonly="readonly"></textarea>
</div>
<div class="segmentRow"></div>
</form>
</div>
</div>
</div>
</div>
