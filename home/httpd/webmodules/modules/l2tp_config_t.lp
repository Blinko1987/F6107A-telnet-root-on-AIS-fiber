<%
cgilua_lp.include("../../webmodules/modules/l2tp_config_js.lp", getfenv(1))
%>
<div id="L2TPCONF" class="HeadDIV">
<address style="display:none">
<span class="form-action">/?_type=menuData&_tag=l2tp_lua.lua</span>
</address>
<div class="externErrorHint" style="display:none;">
<span class="caption1"></span>
</div>
<h1 class="collapBarWithDataTrans" id="L2TPCONFBar">&?L2TP_003;</h1>
<div id="L2TPCONF_container">
<input type="hidden" id="_InstNum" value="0">
<input type="hidden" id="DataHasBeenGot" value="0">
<div id="template_L2TPCONF" style="display:none;">
<div id="changeArea_L2TPCONF" class="ChangeArea formTblWrap">
<div class="errorHint" style="display:none;">
<span class="caption1"></span>
</div>
<div class="succHint" style="display:none;">
<span class="caption1">&?public_021;</span>
</div>
<form class="form_content formTbl">
<input type="hidden" id="_InstID" value="-1">
<div class="row">
<label for="SessionName" class="left w150">&?L2TP_004;</label>
<div class="right">
<input class="inputNorm" type="text" id="SessionName" name="SessionName" value=""/>
<span class="utf8Compatible" style="display:none;">&?public_073;1 ~ 64</span>
</div>
</div>
<div class="row">
<label class="cfgLabel w150">&?L2TP_003;</label>
<div class="right" id="Enable">
<input type="radio" id="Enable1" name="Enable" value="1"/><label for="Enable1">&?public_033;</label>&nbsp;&nbsp;
<input type="radio" id="Enable0" name="Enable" value="0"/><label for="Enable0" >&?public_034;</label>
</div>
</div>
<div class="row">
<label class="left w150">&?public_015;</label>
<div id="Method" class="right">
<input type="radio" id="AutoSense" name="Method" value="1" checked="checked"><label for="AutoSense">&?public_094;</label>&nbsp;&nbsp;
<input type="radio" id="Manual" name="Method" value="0"><label for="Manual">&?public_093;</label>
</div>
</div>
<div class="row" id="Row_LowIFID" style="display:none;">
<label for="LowIFID" class="left w150">&nbsp;</label>
<div class="right">
<select name="LowIFID" id="LowIFID" class="selectNorm">
<option value="" title='&?public_089;' selected="selected">&?public_089;</option>
<%
cgilua.put(_G.CreateIFOpStr("L2TP"))
%>
</select>
</div>
</div>
<div class="row">
<label for="L2tpServer1" class="left w150" >&?L2TP_006;</label>
<div class="right">
<input class="inputNorm" type="text" id="L2tpServer1" name="L2tpServer1" value=""/>
<span class="dTip" style="display: none;">&?L2TP_012;</span>
</div>
</div>
<div class="row">
<label for="UserName" class="left w150">&?public_026;</label>
<div class="right">
<input type="text" class="inputNorm" id="UserName" name="UserName" value=""/>
<span style="display:none;">&?public_073;1 ~ 64</span>
</div>
</div>
<div class="row">
<label for="Password" class="left w150">&?public_027;</label>
<div class="right">
<input type="password" class="inputNorm SpecialPassword" id="Password" name="Password" value="						" autocomplete="new-password"/>
<span style="display:none;">&?public_073;1 ~ 64</span>
</div>
</div>
<div class="row">
<label for="AuthType" class="left w150">&?L2TP_007;</label>
<div class="right">
<select id="AuthType" name="AuthType" class="selectNorm" >
<option value="0" title="&?public_071;" selected="selected">&?public_071;</option>
<option value="1" title="&?public_124;">&?public_124;</option>
<option value="2" title="&?public_125;">&?public_125;</option>
</select>
</div>
</div>
<div class="buttongroup">
<input type="button" class="Button Btn_cancel PostIgnore" id="Btn_cancel_L2TPCONF" name="Btn_cancel_L2TPCONF" value="&?public_019;" />
<input type="button" class="Button Btn_apply PostIgnore" id="Btn_apply_L2TPCONF" name="Btn_apply_L2TPCONF" value="&?public_018;" />
</div>
</form>
</div>
</div>
</div>
</div>
