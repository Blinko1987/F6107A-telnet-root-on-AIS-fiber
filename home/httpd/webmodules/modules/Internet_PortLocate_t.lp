<%
cgilua_lp.include("../../webmodules/modules/Internet_PortLocate_js.lp", getfenv(1))
%>
<div id="PortLocate" class="HeadDIV">
<address style="display:none">
<span class="form-action">/?_type=menuData&_tag=Internet_PortLocate_lua.lua</span>
</address>
<div class="externErrorHint" style="display:none;">
<span class="caption1"></span>
</div>
<h1 class="collapBarWithDataTrans" id="PortLocateBar">&?PortLocate_001;</h1>
<div id="PortLocate_container">
<input id="DataHasBeenGot" type="hidden" value="0">
<div id="template_PortLocate" style="display:none;">
<div id="changeArea_PortLocate" class="ChangeArea formTblWrap">
<div class="errorHint" style="display:none;">
<span class="caption1"></span>
</div>
<div class="succHint" style="display:none;">
<span class="caption1">&?public_021;</span>
</div>
<div class="formTbl">
<form class="form_content">
<input type="hidden" id="_InstID" value="">
<div class="row">
<label for="AuthenticationMethID" class="left w150">&?PortLocate_003;</label>
<div id="DhcpEnable" class="right">
<input type="radio" id="DhcpEnable1" name="DhcpEnable" value="1"/>
<label for="DhcpEnable1">&?public_033;</label>
&nbsp;&nbsp;
<input type="radio" id="DhcpEnable0" name="DhcpEnable" value="0"/>
<label for="DhcpEnable0">&?public_034;</label>
</div>
</div>
<div class="row">
<label for="PppoeEnable" class="left w150">&?PortLocate_004;</label>
<div id="PppoeEnable" class="right">
<input type="radio" id="PppoeEnable1" name="PppoeEnable" value="1"/>
<label for="PppoeEnable1">&?public_033;</label>
&nbsp;&nbsp;
<input type="radio" id="PppoeEnable0" name="PppoeEnable" value="0"/>
<label for="PppoeEnable0">&?public_034;</label>
</div>
</div>
<div class="row">
<label for="DHCPv6Enable" class="left w150">&?PortLocate_010;</label>
<div class="right">
<select name="DHCPv6Enable" id="DHCPv6Enable" class="selectNorm">
<option value="0" title='&?PortLocate_011;' selected="selected">&?PortLocate_011;</option>
<option value="1" title='&?PortLocate_006;' >&?PortLocate_006;</option>
<option value="2" title='&?PortLocate_012;' >&?PortLocate_012;</option>
</select>
</div>
</div>
<%
if env.getenv("CountryCode") == "4" then
%>
<div class="row">
<label for="VoipEnable" class="left w150">&?PortLocateVoip_001;</label>
<div id="VoipEnable" class="right">
<input type="radio" id="VoipEnable1" name="VoipEnable" value="1"/>
<label for="VoipEnable1">&?public_033;</label>
&nbsp;&nbsp;
<input type="radio" id="VoipEnable0" name="VoipEnable" value="0"/>
<label for="VoipEnable0">&?public_034;</label>
</div>
</div>
<%
else
%>
<div class="row">
<label for="PortLocateFormatSelect" class="left w150">&?PortLocate_005;</label>
<div class="right">
<select name="PortLocateFormatSelect" id="PortLocateFormatSelect" class="selectNorm">
<option value="" title='&?PortLocate_006;' selected="selected">&?PortLocate_006;</option>
</select>
</div>
</div>
<div class="row beCtrl">
<label for="PortLocateFormat" class="left w150">&?PortLocate_007;</label>
<div class="right">
<input type="text" id="PortLocateFormat" name="PortLocateFormat" value="" class="inputNorm">
<span style="display: none;">&?PortLocate_008;&?public_073;1 ~ 60</span>
</div>
</div>
<%
end
%>
</form>
<div class="buttongroup">
<input type="button" class="Button Btn_cancel PostIgnore" id="Btn_cancel_PortLocate" name="Btn_cancel_PortLocate" value="&?public_019;" />
<input type="button" class="Button Btn_apply PostIgnore" id="Btn_apply_PortLocate" name="Btn_apply_PortLocate" value="&?public_018;" />
</div>
</div>
</div>
</div>
</div>
</div>
