<%
cgilua_lp.include("../../webmodules/modules/poninfo_loid_js.lp", getfenv(1))
%>
<div id="PonLoidHead" class="HeadDIV">
<address style="display:none">
<span class="form-action">/?_type=menuData&_tag=poninfo_loid_lua.lua</span>
</address>
<div class="externErrorHint" style="display:none;">
<span class="caption1"></span>
</div>
<h1 class="collapBarWithDataTrans" id="PonLoidBar">&?PON_003;</h1>
<div id="template_PonLoidHead">
<div id="PonLoidHead_container">
<input type="hidden" id="DataHasBeenGot" value="0">
<div class="formTblWrap">
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
<label for="PonLoid" class="cfgLabel w150">&?PON_003;</label>
<div class="right">
<input class="inputNorm" type="text" id="PonLoid" name="PonLoid" value=""/>
<span class="dTip" style="display: none;">&?public_073;1 ~ 24</span>
</div>
</div>
<% if "1" == CountryCode then %>
<div class="row">
<label for="LoidPasswd" class="cfgLabel w150">&?PON_004;</label>
<div class="right">
<input class="inputNorm" type="text" id="LoidPasswd" name="LoidPasswd" value=""/>
<span class="dTip" style="display: none;">&?public_073;0 ~ 12</span>
</div>
</div>
<% else %>
<div class="row">
<label for="LoidPasswd" class="cfgLabel w150">&?PON_004;</label>
<div class="right">
<input class="inputNorm SpecialPassword" type="password" id="LoidPasswd" name="LoidPasswd" value="						" autocomplete="new-password"/>
<span class="dTip" style="display: none;">&?public_073;0 ~ 12</span>
</div>
</div>
<% end %>
</form>
<div class="buttongroup">
<input type="button" class="Button Btn_cancel" id="Btn_cancel" name="Btn_cancel" value="&?public_019;" />
<input type="button" class="Button Btn_apply" id="Btn_apply" name="Btn_apply" value="&?public_018;" />
</div>
</div>
</div>
</div>
</div>
</div>
