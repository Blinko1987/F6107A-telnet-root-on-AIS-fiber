<%
cgilua_lp.include("../../webmodules/modules/route_rip_js.lp", getfenv(1))
%>
<div id="RIP" class="HeadDIV">
<address style="display:none">
<span class="form-action">/?_type=menuData&_tag=rip_lua.lua</span>
</address>
<div class="externErrorHint" style="display:none;">
<span class="caption1"></span>
</div>
<h1 class="collapBarWithDataTrans" id="RIPBar">&?RIP_010;</h1>
<div id="RIP_container">
<input type="hidden" id="DataHasBeenGot" value="0">
<div id="template_RIP" style="display:block;">
<div id="changeArea_RIP" class="ChangeArea formTblWrap">
<div id="errorHint" class="errorHint" style="display:none;">
<span class="caption1"></span>
</div>
<div class="succHint" style="display:none;">
<span class="caption1">&?public_021;</span>
</div>
<form class="form_content formTbl">
<input type="hidden" id="_InstID" value="">
<div class="row ControlWrapper">
<label for="RipEnabled" class="left w150" style="width:250px">&?RIP_003;</label>
<div id="RipEnabled" class="right">
<input type="radio" id="RipEnabled0" name="RipEnabled" value="1"/>
<label for="RipEnabled0">&?public_033;</label>
&nbsp;&nbsp;
<input type="radio" id="RipEnabled1" name="RipEnabled" value="0"/>
<label for="RipEnabled1">&?public_034;</label>
</div>
</div>
<div class="row ControlWrapper">
<label for="RipProtocol" class="cfgLabel w150" style="width:250px">&?RIP_004;</label>
<div class="right">
<select name="RipProtocol" id="RipProtocol" class="selectNorm">
<option value="0" title="&?RIP_013;">&?RIP_013;</option>
<option value="1" title="&?RIP_014;">&?RIP_014;</option>
<option value="2" title="&?RIP_015;">&?RIP_015;</option>
</select>
</div>
</div>
<div class="row ControlWrapper" id="div_RipAuthType">
<label for="RipAuthType" class="cfgLabel w150" style="width:250px">&?RIP_005;</label>
<div class="right">
<select name="RipAuthType" id="RipAuthType" class="selectNorm">
<option value="0" title="&?public_074;">&?public_074;</option>
<option value="2" title="&?RIP_007;">&?RIP_007;</option>
<option value="3" title="&?RIP_008;">&?RIP_008;</option>
</select>
</div>
</div>
<div class="row ControlWrapper" id="div_RipAuthKey" style="display:none;">
<label for="RipAuthKey" class="cfgLabel w150" style="width:250px">&?RIP_009;</label>
<div class="right">
<input class="inputNorm" type="password" id="RipAuthKey" name="RipAuthKey" value=""/>
<span style="display: none;">&?public_073;1 ~ 16</span>
</div>
</div>
<div class="buttongroup">
<input type="button" class="Button Btn_cancel" id="Btn_cancel_RIP" name="Btn_cancel_RIP" value="&?public_019;" />
<input type="button" class="Button Btn_apply" id="Btn_apply_RIP" name="Btn_apply_RIP" value="&?public_018;" />
</div>
</form>
</div>
</div>
</div>
</div>
