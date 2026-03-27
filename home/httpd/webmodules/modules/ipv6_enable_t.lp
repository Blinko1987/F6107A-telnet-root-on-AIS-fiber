<%
cgilua_lp.include("../../webmodules/modules/ipv6_enable_js.lp", getfenv(1))
%>
<div id="IPv6Switch" class="HeadDIV">
<address style="display:none">
<span class="form-action">/?_type=menuData&_tag=ipv6_enable_lua.lua</span>
</address>
<div class="externErrorHint" style="display:none;">
<span class="caption1"></span>
</div>
<h1 class="collapBarWithDataTrans" id="IPv6SwitchBar">&?IPV6Switch_001;</h1>
<div id="IPv6Switch_container">
<div class="sceneTip">
<div class="sceneTipLink"><a>&?IPV6Switch_006;</a></div>
<div class="sceneTip_container">
<p>
<span>&?IPV6Switch_004;</span><br/>
<span>&?IPV6Switch_005;</span><br/>
</p>
<p class="sceneTip_close"><a>&?public_020;</a></p>
</div>
</div>
<input id="DataHasBeenGot" type="hidden" value="0">
<div id="template_IPv6Switch" style="display:;">
<form class="form_content">
<div id="changeArea_IPv6Switch" class="ChangeArea formTblWrap">
<div id="errorHint" class="errorHint" style="display:none;">
<span class="caption1"></span>
</div>
<div class="succHint" style="display:none;">
<span class="caption1">&?public_021;</span>
</div>
<div class="formTbl">
<input type="hidden" id="_InstID" value="">
<input type="hidden" id="DataHasBeenGot" value="0">
<input type="hidden" id="OldSwitchSet" value="">
<input type="hidden" id="Msg">
<div class="row">
<label for="IPv6EnableSet" class="left w150">&?IPV6Switch_002;</label>
<div class="right">
<select name="IPv6EnableSet" id="IPv6EnableSet" class="selectNorm">
<option value="0" title='&?public_034;'>&?public_034;</option>
<option value="1" title='&?public_033;'>&?public_033;</option>
</select>
</div>
</div>
<div class="buttongroup">
<input type="button" class="Button Btn_cancel PostIgnore" id="Btn_cancel_VoIPPtclSwitch" name="Btn_cancel_VoIPPtclSwitch" value="&?public_019;" />
<input type="button" class="Button PostIgnore" id="Apply_VoIPPtclSwitch" name="Apply_IPv6Switch" value="&?public_018;" />
<input type="hidden" class="Button Btn_restart PostIgnore" id="Btn_restart" name="Btn_restart" value="&?DeviceManag_006;" />
</div>
</div>
</div>
</form>
</div>
</div>
</div>
