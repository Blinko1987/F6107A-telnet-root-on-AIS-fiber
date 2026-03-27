<%
cgilua_lp.include("../../webmodules/modules/radhcp6s_portctrl_js.lp", getfenv(1))
%>
<div id="IPv6DHCPPortCtl" class="HeadDIV">
<address style="display:none">
<span class="form-action">/?_type=menuData&_tag=radhcp6s_portctrl_lua.lua</span>
</address>
<div class="externErrorHint" style="display:none;">
<span class="caption1"></span>
</div>
<h1 class="collapBarWithDataTrans" id="IPv6DHCPPortCtlBar">&?LanMgrIpv6_017;</h1>
<input type="hidden" id="DataHasBeenGot" value="0">
<div id="IPv6DHCPPortCtl_container">
<div id="template_IPv6DHCPPortCtl" class="formTblWrap">
<div class="errorHint" style="display:none;">
<span class="caption1"></span>
</div>
<div class="succHint" style="display:none;">
<span class="caption1">&?public_021;</span>
</div>
<div class="formTbl">
<input type="hidden" id="_InstNum">
<div class="row" id="div_PortCtlRule" style="display:none;">
<form>
<input type="hidden" id="_InstID" value="">
<input type="hidden" id="PortID" value="">
<label id="PortName" for="PortName" class="cfgLabel w130"></label>
<div class="right">
<input id="AllowDHCP6S" type="checkbox" name="AllowDHCP6S"><label for="AllowDHCP6S">&?LanMgrIpv6_026;</label>&nbsp;&nbsp;&nbsp;&nbsp;
<input id="AllowRA" type="checkbox" name="AllowRA"><label for="AllowRA">&?LanMgrIpv6_027;</label>
</div>
</form>
</div>
<div class="buttongroup">
<input type="button" class="Button Btn_cancel" id="Btn_cancel_IPv6DHCPPortCtl" name="Btn_cancel_IPv6DHCPPortCtl" value="&?public_019;" />
<input type="button" class="Button Btn_apply" id="Btn_apply_IPv6DHCPPortCtl" name="Btn_apply_IPv6DHCPPortCtl" value="&?public_018;" />
<span class="AllOn emColor ctrlFont" id="allOn_IPv6DHCPPortCtl" name="allOn_IPv6DHCPPortCtl">&?public_042;</span>
&nbsp;&nbsp;|&nbsp;&nbsp;
<span class="AllOff emColor ctrlFont" id="allOn_IPv6DHCPPortCtl" name="allOn_IPv6DHCPPortCtl">&?public_043;</span>
</div>
</div>
</div>
</div>
</div>
