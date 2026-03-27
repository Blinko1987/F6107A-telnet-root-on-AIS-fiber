<%
cgilua_lp.include("../../webmodules/modules/ra_raservice_js.lp", getfenv(1))
local MaxBrportMTU = 1500
%>
<div id="RAService" class="HeadDIV">
<address style="display:none">
<span class="form-action">/?_type=menuData&_tag=ra_raservice_lua.lua</span>
</address>
<div class="externErrorHint" style="display:none;">
<span class="caption1"></span>
</div>
<h1 class="collapBarWithDataTrans" id="RAServiceBar">&?LanMgrIpv6_018;</h1>
<input type="hidden" id="DataHasBeenGot" value="0">
<div id="RAService_container">
<div class="sceneTip">
<div class="sceneTipLink"><a>&?LanMgrIpv6_034;</a></div>
<div class="sceneTip_container">
<p>
<span>&?LanMgrIpv6_035;</span><br/>
<span>&?LanMgrIpv6_036;</span><br/>
<span>&?LanMgrIpv6_048;</span><br/>
<span>&?LanMgrIpv6_049;</span><br/>
<span>&?LanMgrIpv6_050;</span><br/>
</p>
<p class="sceneTip_close"><a>&?public_020;</a></p>
</div>
</div>
<div id="template_RAService">
<form class="form_content">
<div id="changeArea_RAService" class="ChangeArea formTblWrap">
<div class="errorHint" style="display:none;">
<span class="caption1"></span>
</div>
<div class="succHint" style="display:none;">
<span class="caption1">&?public_021;</span>
</div>
<div class="formTbl">
<input type="hidden" id="_InstID" value="">
<input type="hidden" id="IsPrefixAutoMode" value="">
<input type="hidden" id="ManualPrefixes" value="">
<div class="row">
<label class="cfgLabel w200">&?LanMgrIpv6_018;</label>
<div id="Enable:RAService" class="right">
<input type="radio" id="Enable1:RAService" name="Enable:RAService" value="1"/><label for="Enable1:RAService">&?public_033;</label>&nbsp;&nbsp;&nbsp;&nbsp;
<input type="radio" id="Enable0:RAService" name="Enable:RAService" value="0"/><label for="Enable0:RAService">&?public_034;</label>
</div>
</div>
<div class="row">
<label class="cfgLabel w200">&?LanMgrIpv6_055;</label>
<div id="AdvLinkMTUEnable" class="right">
<input type="radio" id="AdvLinkMTUEnable1" name="AdvLinkMTUEnable" value="1"/><label for="AdvLinkMTUEnable1">&?public_033;</label>&nbsp;&nbsp;&nbsp;&nbsp;
<input type="radio" id="AdvLinkMTUEnable0" name="AdvLinkMTUEnable" value="0"/><label for="AdvLinkMTUEnable0">&?public_034;</label>
</div>
</div>
<div class="row" id="div_S_AdvLinkMTU">
<label for="S_AdvLinkMTU" class="cfgLabel w200">&?public_104;</label>
<div class="right">
<input type="text" class="w200" id="S_AdvLinkMTU" name="S_AdvLinkMTU" value=""/>
<span class="dTip" style="display: none;">&?public_072;1280 ~ <%=MaxBrportMTU%></span>
</div>
</div>
<div class="row">
<label for="AdvPreferredRouterFlag" class="left w200">&?LanMgrIpv6_051;</label>
<div class="right">
<select name="AdvPreferredRouterFlag" id="AdvPreferredRouterFlag" class="w200">
<option value="1" title='&?LanMgrIpv6_052;'>&?LanMgrIpv6_052;</option>
<option value="0" title='&?LanMgrIpv6_053;'>&?LanMgrIpv6_053;</option>
<option value="3" title='&?LanMgrIpv6_054;'>&?LanMgrIpv6_054;</option>
</select>
</div>
</div>
<div class="row">
<label for="MinRtrAdvInterval" class="cfgLabel w200">&?LanMgrIpv6_019;</label>
<div class="right">
<input type="text" class="w200" id="MinRtrAdvInterval" name="MinRtrAdvInterval" value=""/>&?public_013;
<span class="dTip" style="display: none;">&?public_072;3 ~ 1350</span>
</div>
</div>
<div class="row">
<label for="MaxRtrAdvInterval" class="cfgLabel w200">&?LanMgrIpv6_020;</label>
<div class="right">
<input type="text" class="w200" id="MaxRtrAdvInterval" name="MaxRtrAdvInterval" value=""/>&?public_013;
<span class="dTip" style="display: none;">&?public_072;4 ~ 1800</span>
</div>
</div>
<div class="row">
<label class="cfgLabel w200">&?LanMgrIpv6_021;</label>
<div id="AdvManagedFlag" class="right">
<input type="radio" id="AdvManagedFlag1" name="AdvManagedFlag" value="1"/><label for="AdvManagedFlag1">&?public_033;</label>&nbsp;&nbsp;&nbsp;&nbsp;
<input type="radio" id="AdvManagedFlag0" name="AdvManagedFlag" value="0"/><label for="AdvManagedFlag0">&?public_034;</label>
</div>
</div>
<div class="row">
<label class="cfgLabel w200">&?LanMgrIpv6_022;</label>
<div id="AdvOtherConfigFlag" class="right">
<input type="radio" id="AdvOtherConfigFlag1" name="AdvOtherConfigFlag" value="1"/><label for="AdvOtherConfigFlag1">&?public_033;</label>&nbsp;&nbsp;&nbsp;&nbsp;
<input type="radio" id="AdvOtherConfigFlag0" name="AdvOtherConfigFlag" value="0"/><label for="AdvOtherConfigFlag0">&?public_034;</label>
</div>
</div>
<div class="row">
<label for="PrefixMode:RAService" class="left w200">&?LanMgrIpv6_042;</label>
<div class="right">
<select name="PrefixMode:RAService" id="PrefixMode:RAService" class="w200">
<option value="Auto" title='&?public_094;'>&?public_094;</option>
<option value="Manual" title='&?public_093;'>&?public_093;</option>
</select>
</div>
</div>
<div id="RAPrefixZone" style="display:none;">
</div>
<div class="buttongroup">
<input type="button" class="Button Btn_cancel" id="Btn_cancel_RAService" name="Btn_cancel_RAService" value="&?public_019;" />
<input type="button" class="Button Btn_apply" id="Btn_apply_RAService" name="Btn_apply_RAService" value="&?public_018;" />
<input type="button" class="Button" id="Btn_PrefixUpd_RAService" name="Btn_PrefixUpd_RAService" style="display:none;" />
<input type="button" class="Button" id="Btn_SelfUpd_RAService" name="Btn_SelfUpd_RAService" style="display:none;" />
</div>
</div>
</div>
</form>
</div>
</div>
</div>
