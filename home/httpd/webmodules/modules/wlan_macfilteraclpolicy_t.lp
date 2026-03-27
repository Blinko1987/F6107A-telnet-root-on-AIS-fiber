<%
cgilua_lp.include("../../webmodules/modules/wlan_macfilteraclpolicy_js.lp", getfenv(1))
%>
<div id="MACFilterACLPolicy" class="HeadDIV">
<address style="display:none">
<span class="form-action">/?_type=menuData&_tag=wlan_macfilteraclpolicy_lua.lua</span>
</address>
<div class="externErrorHint" style="display:none;">
<span class="caption1"></span>
</div>
<h1 class="collapBarWithDataTrans" id="MACFilterACLPolicyBar">&?WlanAdvanced_002;-&?WlanAdvanced_003;</h1>
<div id="MACFilterACLPolicy_container">
<input type="hidden" id="DataHasBeenGot" value="0">
<div id="template_MACFilterACLPolicy" class="formTblWrap">
<div class="errorHint" style="display:none;">
<span class="caption1"></span>
</div>
<div class="succHint" style="display:none;">
<span class="caption1">&?public_021;</span>
</div>
<div class="formTbl">
<input type="hidden" id="_InstNum">
<div class="row" id="div_ACLPolicy" style="display:none;">
<form>
<input type="hidden" id="_InstID" value="">
<input type="hidden" id="Alias" value="" class="PostIgnore">
<input type="hidden" id="WLANViewName" class="PostIgnore" value="">
<input type="hidden" id="LockStatus" class="PostIgnore" value="">
<label for="ACLPolicy" class="left w150"></label>
<div id="ACLPolicy" class="right">
<input type="radio" id="ACLPolicy0" name="ACLPolicy" value="Disabled"/>
<label for="ACLPolicy0">&?WlanAdvanced_005;</label>
&nbsp;&nbsp;
<input type="radio" id="ACLPolicy1" name="ACLPolicy" value="Ban"/>
<label for="ACLPolicy1">&?WlanAdvanced_007;</label>
&nbsp;&nbsp;
<input type="radio" id="ACLPolicy2" name="ACLPolicy" value="Allow"/>
<label for="ACLPolicy2">&?WlanAdvanced_006;</label>
</div>
</form>
</div>
<div class="buttongroup">
<input type="button" class="Button Btn_cancel" id="Btn_cancel_MACFilterACLPolicy" name="Btn_cancel_MACFilterACLPolicy" value="&?public_019;" />
<input type="button" class="Button Btn_apply" id="Btn_apply_MACFilterACLPolicy" name="Btn_apply_MACFilterACLPolicy" value="&?public_018;" />
</div>
</div>
</div>
</div>
</div>
