<%
cgilua_lp.include("../../webmodules/modules/multicast_address_js.lp", getfenv(1))
%>
<div class="instCfgArea">
<div id="MulticastAddress" class="HeadDIV">
<address style="display:none">
<span class="form-action">/?_type=menuData&_tag=multicast_address_lua.lua</span>
</address>
<div class="externErrorHint" style="display:none;">
<span class="caption1"></span>
</div>
<h1 class="collapBarWithDataTrans" id="MulticastAddressBar">&?Multicast_007;</h1>
<input type="hidden" id="DataHasBeenGot" value="0">
<div id="MulticastAddress_container">
<div id="template_MulticastAddress" class="formTblWrap">
<form class="form_content">
<div class="errorHint" style="display:none;">
<span class="caption1"></span>
</div>
<div class="succHint" style="display:none;">
<span class="caption1">&?public_021;</span>
</div>
<div class="formTbl">
<input type="hidden" id="_InstNum">
<div class="row" id="div_MulticastAddressRule" style="display:none;">
<input type="hidden" id="_InstID" value="">
<input type="hidden" id="PortViewName" value="">
<label id="PortName" for="PortName" class="cfgLabel w130"></label>
<div class="right">
<input type="text" class="inputNorm" id="MaxNodeNum" name="MaxNodeNum" value=""/>
<span style="display:none;">&?public_072;1 ~ 1024</span>
</div>
</div>
<div class="buttongroup">
<input type="button" class="Button Btn_cancel" id="Btn_cancel_MulticastAddress" name="Btn_cancel_MulticastAddress" value="&?public_019;" />
<input type="button" class="Button Btn_apply" id="Btn_apply_MulticastAddress" name="Btn_apply_MulticastAddress" value="&?public_018;" />
</div>
</div>
</form>
</div>
</div>
</div>
</div>
