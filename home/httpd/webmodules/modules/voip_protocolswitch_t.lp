<%
cgilua_lp.include("../../webmodules/modules/voip_protocolswitch_js.lp", getfenv(1))
%>
<div id="VoIPPtclSwitch" class="HeadDIV">
<address style="display:none">
<span class="form-action">/?_type=menuData&_tag=voip_protocolswitch_lua.lua</span>
</address>
<div class="externErrorHint" style="display:none;">
<span class="caption1"></span>
</div>
<h1 class="collapBarWithDataTrans" id="VoIPPtclSwitchBar">&?VoIPPtclSwitch_003;</h1>
<div id="VoIPPtclSwitch_container">
<input id="DataHasBeenGot" type="hidden" value="0">
<div id="template_VoIPPtclSwitch" style="display:;">
<form class="form_content">
<div id="changeArea_VoIPPtclSwitch" class="ChangeArea formTblWrap">
<div id="errorHint" class="errorHint" style="display:none;">
<span class="caption1"></span>
</div>
<div class="succHint" style="display:none;">
<span class="caption1">&?public_021;</span>
</div>
<div class="formTbl">
<input type="hidden" id="_InstID" value="">
<input type="hidden" id="DataHasBeenGot" value="0">
<input type="hidden" id="OldProtocolSet" value="">
<div class="staticInfoHint">
<p>&?VoIPPtclSwitch_004; </p>
</div>
<div class="row">
<label for="ProtocolSet" class="left w150">&?VoIPPtclSwitch_003;</label>
<div class="right">
<select name="ProtocolSet" id="ProtocolSet" class="selectNorm">
<option value="1" title='&?VoIPPtclSwitch_005;'>&?VoIPPtclSwitch_005;</option>
<option value="4" title='&?VoIPPtclSwitch_007;'>&?VoIPPtclSwitch_007;</option>
</select>
</div>
</div>
<div class="buttongroup">
<input type="button" class="Button Btn_cancel PostIgnore" id="Btn_cancel_VoIPPtclSwitch" name="Btn_cancel_VoIPPtclSwitch" value="&?public_019;" />
<input type="button" class="Button PostIgnore" id="Apply_VoIPPtclSwitch" name="Apply_VoIPPtclSwitch" value="&?public_018;" />
<input type="hidden" class="Button Btn_restart PostIgnore" id="Btn_restart" name="Btn_restart" value="&?DeviceManag_006;" />
</div>
</div>
</div>
</form>
</div>
</div>
</div>
