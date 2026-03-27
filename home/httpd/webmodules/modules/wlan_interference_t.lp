<style type="text/css">
<% cgilua_lp.include("../../public/css/jedate.css")
%>
</style>
<script type="text/javascript">
<%
cgilua_lp.include("../../public/jquery/jedate.js")
%>
</script>
<%
cgilua_lp.include("../../webmodules/modules/wlan_interference_js.lp")
%>
<div id="WlanInterference" class="HeadDIV">
<address style="display:none">
<span class="form-action">/?_type=menuData&_tag=wlan_interference_lua.lua</span>
</address>
<div class="externErrorHint" style="display:none;">
<span class="caption1"></span>
</div>
<h1 class="collapBarWithDataTrans" id="WlanInterferenceBar">&?pro_Interference_003;</h1>
<div id="WlanInterference_container">
<input type="hidden" id="DataHasBeenGot" value="0">
<div id="template_WlanInterference" class="formTblWrap">
<div class="errorHint" style="display:none;">
<span class="caption1"></span>
</div>
<div class="succHint" style="display:none;">
<div>&?public_023;</div>
</div>
<form class="form_content formTbl">
<input type="hidden" id="_InstID" value="-1">
<div class="row">
<label class="left w50">&?pro_Interference_004;:</label>
<div class="right">
<div class="InstSwitch">
<input id="Active" class="cmn-toggle cmn-toggle-round" name="Active" type="checkbox">
<label for="Active"></label>
</div>
</div>
</div>
<div class="row">
<label for="StartTime" class="left w50">&?pro_Interference_005;:</label>
<div class="right">
<input type="text" class="inputNorm" id="StartTime" name="StartTime" value="00:00:00">
</div>
</div>
<div class="row">
<label for="EndTime" class="left w50">&?pro_Interference_006;:</label>
<div class="right">
<input type="text" class="inputNorm" id="EndTime" name="EndTime" value="23:59:59">
</div>
</div>
<div class="row">
<label class="left w50">&?pro_Interference_007;:</label>
<div class="right">
<input type="text" class="inputNorm" id="PeriodTime" name="PeriodTime"> seconds
</div>
</div>
<div class="buttongroup">
<input type="button" class="Button Btn_cancel" id="Btn_cancel_WlanBasicAdConf" name="Btn_cancel_WlanInterferenceConf" value="Cancel">
<input type="button" class="Button Btn_apply" id="Btn_apply_WlanBasicAdConf" name="Btn_apply_WlanInterferenceConf" value="Apply">
<input type="button" class="Button" id="Btn_Forced_startup" name="Btn_Forced_startup" value="WLAN Interference Handling">
</div>
</form>
</div>
</div>
</div>
