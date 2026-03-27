<%
cgilua_lp.include("../../webmodules/modules/dns_dnsserver_js.lp", getfenv(1))
%>
<div id="LocalDnsServer" class="HeadDIV">
<address style="display:none">
<span class="form-action">/?_type=menuData&_tag=dns_localdns_lua.lua</span>
</address>
<div class="externErrorHint" style="display:none;">
<span class="caption1"></span>
</div>
<h1 class="collapBarWithDataTrans" id="LocalDnsServerBar">&?DNS_001;</h1>
<div id="LocalDnsServer_container">
<input type="hidden" id="DataHasBeenGot" value="0">
<div id="template_LocalDnsServer">
<form class="form_content">
<div id="changeArea_LocalDnsServer" class="ChangeArea formTblWrap">
<div class="errorHint" style="display:none;">
<span class="caption1"></span>
</div>
<div class="succHint" style="display:none;">
<span class="caption1">&?public_021;</span>
</div>
<div class="formTbl">
<input type="hidden" id="_InstID" value="">
<input type="hidden" id="SerIPAddress1" _LuQUID_splitIPID="sub_SerIPAddress1" value="">
<input type="hidden" id="SerIPAddress2" _LuQUID_splitIPID="sub_SerIPAddress2" value="">
<div class="row" id="Prefix_sub_SerIPAddress10">
<label for="SerIPAddress1" class="cfgLabel w150">&?DNS_009;</label>
<div class="right">
<input class="ip" name="sub_SerIPAddress10" type="text" maxlength="3" id="sub_SerIPAddress10" value="0"/>.
<input class="ip" name="sub_SerIPAddress11" type="text" maxlength="3" id="sub_SerIPAddress11" value="0"/>.
<input class="ip" name="sub_SerIPAddress12" type="text" maxlength="3" id="sub_SerIPAddress12" value="0"/>.
<input class="ip" name="sub_SerIPAddress13" type="text" maxlength="3" id="sub_SerIPAddress13" value="0"/>
</div>
</div>
<div class="row" id="Prefix_sub_SerIPAddress20">
<label for="SerIPAddress2" class="cfgLabel w150">&?DNS_010;</label>
<div class="right">
<input class="ip" name="sub_SerIPAddress20" type="text" maxlength="3" id="sub_SerIPAddress20" value="0"/>.
<input class="ip" name="sub_SerIPAddress21" type="text" maxlength="3" id="sub_SerIPAddress21" value="0"/>.
<input class="ip" name="sub_SerIPAddress22" type="text" maxlength="3" id="sub_SerIPAddress22" value="0"/>.
<input class="ip" name="sub_SerIPAddress23" type="text" maxlength="3" id="sub_SerIPAddress23" value="0"/>
</div>
</div>
<div class="row">
<label for="SerIPv6Address1" class="cfgLabel w150">&?DNS_011;</label>
<div class="right">
<input class="inputNorm" type="text" id="SerIPv6Address1" name="SerIPv6Address1" value=""/>
</div>
</div>
<div class="row">
<label for="SerIPv6Address2" class="cfgLabel w150">&?DNS_012;</label>
<div class="right">
<input class="inputNorm" type="text" id="SerIPv6Address2" name="SerIPv6Address2" value=""/>
</div>
</div>
<div class="buttongroup">
<input type="button" class="Button Btn_cancel" id="Btn_cancel_LocalDnsServer" name="Btn_cancel_LocalDnsServer" value="&?public_019;" />
<input type="button" class="Button Btn_apply" id="Btn_apply_LocalDnsServer" name="Btn_apply_LocalDnsServer" value="&?public_018;" />
</div>
</div>
</div>
</form>
</div>
</div>
</div>
