<%
cgilua_lp.include("../../webmodules/modules/poninfo_sn_js.lp", getfenv(1))
%>
<div id="PonSn" class="HeadDIV">
<address style="display:none">
<span class="form-action">/?_type=menuData&_tag=poninfo_sn_lua.lua</span>
</address>
<div class="externErrorHint" style="display:none;">
<span class="caption1"></span>
</div>
<h1 class="collapBarWithDataTrans" id="PonSnBar">&?PON_005;</h1>
<div id="template_PonSn">
<div id="PonSn_container">
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
<div class="staticInfoHint">
<p>&?PON_006;</p>
</div>
<input type="hidden" id="_InstID" value="">
<div class="row">
<label for="Sn" class="cfgLabel w150">&?PON_005;</label>
<div class="right">
<input class="inputNorm" type="text" id="Sn" name="Sn" value="" disabled/>
<% if CountryCode == "20" then %>
<span id="hexSN"></span>
<% end %>
</div>
</div>
<% if "173" == CountryCode then %>
<div id="IsInform" class="row">
<label class="cfgLabel w150">&?PON_012;</label>
<input id="IsInform1" type="radio" value="1" name="IsInform" checked="checked">
<label for="IsInform1">&?public_033;</label>&nbsp;&nbsp;
<input id="IsInform0" type="radio" value="0" name="IsInform" >
<label for="IsInform0">&?public_034;</label>
</div>
<% end
if ("131" == CountryCode or CountryCode == "1"or CountryCode == "21" or CountryCode == "4") then %>
<div class="row">
<label for="Pwd" class="cfgLabel w150">&?PON_004;</label>
<div class="right">
<input class="inputNorm" type="text" id="Pwd" name="Pwd" value=""/>
<span class="dTip" style="display: none;">&?public_073;1 ~ 10</span>
</div>
</div>
<% else %>
<div class="row">
<label for="Pwd" class="cfgLabel w150">&?PON_004;</label>
<div class="right">
<input class="inputNorm SpecialPassword" type="password" id="Pwd" name="Pwd" value="						" autocomplete="new-password"/>
<span class="dTip" style="display: none;">&?public_073;1 ~ 10</span>
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
