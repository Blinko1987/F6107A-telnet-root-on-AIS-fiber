<%
cgilua_lp.include("../../webmodules/modules/Localnet_LanDevDHCPSource_js.lp", getfenv(1))
%>
<%
if "108" ~= env.getenv("CountryCode") and ( "41" ~= env.getenv("CountryCode") or "1" == session_get(sess_id, "Right"))then
%>
<div id="LanDevDHCPSource" class="HeadDIV">
<address style="display:none">
<span class="form-action">/?_type=menuData&_tag=Localnet_LanDevDHCPSource_lua.lua</span>
</address>
<div class="externErrorHint" style="display:none;">
<span class="caption1"></span>
</div>
<h1 class="collapBarWithDataTrans" id="LanDevDHCPSourceBar">&?LanDevDHCPSourceIpv4_001;</h1>
<input type="hidden" id="DataHasBeenGot" value="0">
<div id="LanDevDHCPSource_container">
<div class="noDataHint" style="display:none;">
<span>&?public_023;</span>
</div>
<div id="template_LanDevDHCPSource" class="formTblWrap">
<div class="errorHint" style="display:none;">
<span class="caption1"></span>
</div>
<div class="succHint" style="display:none;">
<span class="caption1">&?public_021;</span>
</div>
<div class="formTbl">
<input type="hidden" id="_InstNum">
<div class="row" id="div_LanDevDHCPSourceRule" style="display:none;">
<form>
<input type="hidden" id="_InstID" value="">
<label id="VendorClassID" class="cfgLabel w100"></label>
<div class="right" id="ProcFlag">
<input type="radio" id="ProcFlag3" name="ProcFlag" value="3"/>
<label for="ProcFlag3">&?LanDevDHCPSourceIpv4_003;</label>&nbsp;&nbsp;
<input type="radio" id="ProcFlag2" name="ProcFlag" value="2"/>
<label for="ProcFlag2">&?LanDevDHCPSourceIpv4_005;</label>&nbsp;&nbsp;
<input type="radio" id="ProcFlag1" name="ProcFlag" value="1"/>
<label for="ProcFlag1">&?LanDevDHCPSourceIpv4_004;</label>&nbsp;&nbsp;
</div>
</form>
</div>
<div class="buttongroup">
<input type="button" class="Button Btn_cancel" id="Btn_cancel_LanDevDHCPSource" name="Btn_cancel_LanDevDHCPSource" value="&?public_019;" />
<input type="button" class="Button Btn_apply" id="Btn_apply_LanDevDHCPSource" name="Btn_apply_LanDevDHCPSource" value="&?public_018;" />
</div>
</div>
</div>
</div>
</div>
<%
end
%>
