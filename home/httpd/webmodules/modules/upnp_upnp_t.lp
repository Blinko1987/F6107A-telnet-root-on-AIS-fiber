<%
cgilua_lp.include("../../webmodules/modules/upnp_upnp_js.lp", getfenv(1))
%>
<div id="LocalUPnP" class="HeadDIV">
<address style="display:none">
<span class="form-action">/?_type=menuData&_tag=upnp_upnp_lua.lua</span>
</address>
<div class="externErrorHint" style="display:none;">
<span class="caption1"></span>
</div>
<h1 class="collapBarWithDataTrans" id="LocalUPnPBar">&?UPnP_001;</h1>
<div id="LocalUPnP_container">
<input type="hidden" id="DataHasBeenGot" value="0">
<div id="template_LocalUPnP">
<div id="changeArea_LocalUPnP" class="ChangeArea">
<div id="errorHint" class="errorHint" style="display:none;">
<span class="caption1"></span>
</div>
<div class="succHint" style="display:none;">
<span class="caption1">&?public_021;</span>
</div>
<form class="formTbl formTblWrap">
<input type="hidden" id="_InstID" value="">
<div class="row">
<label for="EnableUPnPIGD" class="cfgLabel w200">&?UPnP_001;</label>
<div class="right" id="EnableUPnPIGD">
<input type="radio" id="EnableUPnPIGD1" name="EnableUPnPIGD" value="1"/><label class="input-radio" for="EnableUPnPIGD1">&?public_033;</label>&nbsp;&nbsp;
<input type="radio" id="EnableUPnPIGD0" name="EnableUPnPIGD" value="0"/><label class="input-radio" for="EnableUPnPIGD0">&?public_034;</label>
</div>
</div>
<br>
<div class="row">
<b>&?public_100;</b>
</div>
<div class="row">
<label for="WanName" class="cfgLabel w200">&?UPnP_005;</label>
<div class="right">
<select id="WanName" name="WanName" class="selectNorm">
<option value="" title='&?public_094;' selected="selected">&?public_094;</option>
<%
cgilua.put(_G.CreateIFOpStr("IPv4UPnP"))
%>
</select>
</div>
</div>
<div class="row">
<label for="ADPeriod" class="cfgLabel w200">&?UPnP_003;</label>
<div class="right">
<input type="text" id="ADPeriod" name="ADPeriod" value="" class="inputNorm"/>&?public_012;
<span style="display:none;">&?public_072;4 ~ 1440</span>
</div>
</div>
<div class="row">
<label for="TTL" class="cfgLabel w200">&?UPnP_004;</label>
<div class="right">
<input type="text" id="TTL" name="TTL" value="" class="inputNorm"/>&?public_091;
<span style="display:none;">&?public_072;1 ~ 255</span>
</div>
</div>
<br>
<div class="row">
<b>&?public_101;</b>
</div>
<div class="row">
<label for="Wanv6Name" class="cfgLabel w200">&?UPnP_006;</label>
<div class="right">
<select id="Wanv6Name" name="Wanv6Name" class="selectNorm">
<option value="" title='&?public_094;' selected="selected">&?public_094;</option>
<%
cgilua.put(_G.CreateIFOpStr("IPv6UPnP"))
%>
</select>
</div>
</div>
<br>
<div class="buttongroup">
<input type="button" class="Button Btn_cancel PostIgnore" id="Btn_cancel_LocalUPnP" name="Btn_cancel_LocalUPnP" value="&?public_019;" />
<input type="button" class="Button Btn_apply PostIgnore" id="Btn_apply_LocalUPnP" name="Btn_apply_LocalUPnP" value="&?public_018;" />
</div>
</form>
</div>
</div>
</div>
</div>
