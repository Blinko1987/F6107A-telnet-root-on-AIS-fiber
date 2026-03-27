<%
cgilua_lp.include("../../webmodules/modules/mgts_roam_js.lp", getfenv(1))
%>
<div id="ROAM" class="HeadDIV">
<address style="display:none">
<span class="form-action">/?_type=menuData&_tag=mgts_roam_lua.lua</span>
</address>
<div class="externErrorHint" style="display:none;">
<span class="caption1"></span>
</div>
<h1 class="collapBarWithDataTrans" id="ROAMBar">&?roaming_001;</h1>
<div id="ROAM_container">
<input type="hidden" id="DataHasBeenGot" value="0">
<div id="template_ROAM">
<form class="form_content">
<div id="changeArea_ROAM" class="ChangeArea formTblWrap">
<div class="errorHint" style="display:none;">
<span class="caption1"></span>
</div>
<div class="succHint" style="display:none;">
<span class="caption1">&?public_021;</span>
</div>
<div class="formTbl">
<input type="hidden" id="_InstID" value="">
<div class="row">
<label for="TimeInverval" class="left w150">&?roaming_002;</label>
<div class="right">
<input type="text" id="TimeInverval" name="TimeInverval" value="" class="inputNorm" />
<span style="display:none;">&?public_072;1 ~ 2147483647</span>&?public_013;
</div>
</div>
<div class="row">
<label for="ReqTimeout" class="left w150">&?roaming_003;</label>
<div class="right">
<input type="text" id="ReqTimeout" name="ReqTimeout" value="" class="inputNorm" />
<span style="display:none;">&?public_072;0 ~ 2147483647</span>&?public_013;
</div>
</div>
<div class="row">
<label for="RoamRssiLmt24G" class="left w150">&?roaming_004;</label>
<div class="right">
<input type="text" id="RoamRssiLmt24G" name="RoamRssiLmt24G" value="" class="inputNorm" />
<span style="display:none;">&?public_072;-110 ~ -40</span>&?public_110;
</div>
</div>
<div class="row">
<label for="RoamRssiLmt5G" class="left w150">&?roaming_005;</label>
<div class="right">
<input type="text" id="RoamRssiLmt5G" name="RoamRssiLmt5G" value="" class="inputNorm">
<span style="display: none;">&?public_072;-110 ~ -40</span>&?public_110;
</div>
</div>
<div class="row">
<label for="RssiDelta" class="left w150">&?roaming_006;</label>
<div class="right">
<input type="text" id="RssiDelta" name="RssiDelta" value="" class="inputNorm" />
<span style="display:none;">&?public_072;-2147483648 ~ 19</span>&?public_110;
</div>
</div>
<div class="row">
<label for="RoamBounceDetectTimeLmt" class="left w150">&?roaming_007;</label>
<div class="right">
<input type="text" id="RoamBounceDetectTimeLmt" name="RoamBounceDetectTimeLmt" value="" class="inputNorm">
<span style="display: none;">&?public_072;1 ~ 2147483647</span>&?public_013;
</div>
</div>
<div class="row">
<label for="RoamBounceCountsLmt" class="left w150">&?roaming_008;</label>
<div class="right">
<input type="text" id="RoamBounceCountsLmt" name="RoamBounceCountsLmt" value="" class="inputNorm">
<span style="display: none;">&?public_072;1 ~ 2147483647</span>
</div>
</div>
<div class="row">
<label for="RoamBounceDwellTimeLmt" class="left w150">&?roaming_009;</label>
<div class="right">
<input type="text" id="RoamBounceDwellTimeLmt" name="RoamBounceDwellTimeLmt" value="" class="inputNorm">
<span style="display: none;">&?public_072;1 ~ 2147483647</span>&?public_013;
</div>
</div>
<div class="buttongroup">
<input type="button" class="Button Btn_cancel" id="Btn_cancel_instCfgArea" name="Btn_cancel_instCfgArea" value="&?public_019;" />
<input type="button" class="Button Btn_apply" id="Btn_apply_instCfgArea" name="Btn_apply_instCfgArea" value="&?public_018;" />
</div>
</div>
</div>
</form>
</div>
</div>
</div>
