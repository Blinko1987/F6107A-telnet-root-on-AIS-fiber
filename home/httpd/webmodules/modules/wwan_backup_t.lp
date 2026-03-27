<%
cgilua_lp.include("../../webmodules/modules/wwan_backup_js.lp", getfenv(1))
%>
<div id="DongleSet" class="HeadDIV">
<address style="display:none">
<span class="form-action">/?_type=menuData&_tag=wwan_backup_lua.lua</span>
</address>
<div class="externErrorHint" style="display:none;">
<span class="caption1"></span>
</div>
<h1 class="collapBarWithDataTrans" id="DongleSetBar">&?DongleSet_001;</h1>
<div id="template_DongleSet">
<div id="DongleSet_container">
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
<label for="Enable" class="left w200">&?DongleSet_002;</label>
<div id="Enable" class="right">
<input type="radio" id="Enable1" name="Enable" value="1"/>
<label for="Enable0">&?DongleSet_004;</label>
&nbsp;&nbsp;
<input type="radio" id="Enable0" name="Enable" value="0"/>
<label for="Enable1">&?DongleSet_005;</label>
</div>
</div>
<div class="row" id="DelayUpTime_div">
<label for="DelayUpTime" class="cfgLabel w200">&?DongleSet_003;</label>
<div class="right">
<input type="text" id="DelayUpTime" name="DelayUpTime" value=""/>
<label>&?public_013;</label>
<span style="display: none;">&?public_073;0 ~ 2147483647</span>
</div>
</div>
<div class="row" id="DelayDownTime_div">
<label for="DelayDownTime" class="cfgLabel w200">&?DongleSet_006;</label>
<div class="right">
<input type="text" id="DelayDownTime" name="DelayDownTime" value=""/>
<label>&?public_013;</label>
<span style="display: none;">&?public_073;0 ~ 2147483647</span>
</div>
</div>
</form>
<div class="buttongroup">
<input type="button" class="Button Btn_cancel" id="Btn_cancel_DongleSet" name="Btn_cancel_DongleSet" value="&?public_019;" />
<input type="button" class="Button Btn_apply" id="Btn_apply_DongleSet" name="Btn_apply_DongleSet" value="&?public_018;" />
</div>
</div>
</div>
</div>
</div>
</div>
