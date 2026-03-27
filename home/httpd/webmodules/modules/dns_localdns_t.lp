<%
cgilua_lp.include("../../webmodules/modules/dns_localdns_js.lp", getfenv(1))
%>
<div id="LocalDns" class="HeadDIV">
<address style="display:none">
<span class="form-action">/?_type=menuData&_tag=dns_localdns_lua.lua</span>
</address>
<div class="externErrorHint" style="display:none;">
<span class="caption1"></span>
</div>
<h1 class="collapBarWithDataTrans" id="LocalDnsBar">&?DNS_003;</h1>
<div id="LocalDns_container">
<input type="hidden" id="DataHasBeenGot" value="0">
<div id="template_LocalDns">
<form class="form_content">
<div id="changeArea_LocalDns" class="ChangeArea formTblWrap">
<div class="errorHint" style="display:none;">
<span class="caption1"></span>
</div>
<div class="succHint" style="display:none;">
<span class="caption1">&?public_021;</span>
</div>
<div class="formTbl">
<input type="hidden" id="_InstID" value="">
<div class="row">
<label for="DomainName" class="cfgLabel w150">&?DNS_003;</label>
<div class="right">
<input class="inputLong" type="text" id="DomainName" name="DomainName" value=""/>
<span class="dTip" style="display: none;">&?public_073;0 ~ 255</span>
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
