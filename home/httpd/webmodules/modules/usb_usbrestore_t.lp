<%
cgilua_lp.include("../../webmodules/modules/usb_usbrestore_js.lp", getfenv(1))
%>
<div id="Usbrestore" class="HeadDIV">
<address style="display:none">
<span class="form-action">/?_type=menuData&_tag=usb_usbrestore_lua.lua</span>
</address>
<div class="externErrorHint" style="display:none;">
<span class="caption1"></span>
<span class="caption1"></span>
</div>
<h1 class="collapBarWithDataTrans" id="UsbrestoreBar">&?Usbrestore_001;</h1>
<div id="template_Usbrestore">
<div id="Usbrestore_container">
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
<p>&?Usbrestore_003;</p>
</div>
<input type="hidden" id="_InstID" value="">
<div class="row" id="Prefix_RstEnable">
<label for="RstEnable" class="left w150">&?Usbrestore_001;</label>
<div id="RstEnable" class="right">
<input type="radio" id="RstEnable0" name="RstEnable" value="1"/>
<label for="RstEnable0">&?public_033;</label>
&nbsp;&nbsp;
<input type="radio" id="RstEnable1" name="RstEnable" value="0"/>
<label for="RstEnable1">&?public_034;</label>
</div>
</div>
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
