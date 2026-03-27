<%
cgilua_lp.include("../../webmodules/modules/firewall_alg_js.lp", getfenv(1))
%>
<div id="Alg" class="HeadDIV">
<address style="display:none">
<span class="form-action">/?_type=menuData&_tag=firewall_alg_lua.lua</span>
</address>
<div class="externErrorHint" style="display:none;">
<span class="caption1"></span>
</div>
<h1 class="collapBarWithDataTrans" id="AlgBar">&?Alg_001;</h1>
<div id="Alg_container">
<input id="DataHasBeenGot" type="hidden" value="0">
<div id="template_Alg">
<form class="form_content">
<div id="changeArea_Alg" class="ChangeArea formTblWrap">
<div class="errorHint" style="display:none;">
<span class="caption1"></span>
</div>
<div class="succHint" style="display:none;">
<span class="caption1">&?public_021;</span>
</div>
<div class="formTbl">
<input type="hidden" id="_InstID" value="">
<div class="row">
<label class="cfgLabel w130">&?Alg_003;</label>
<div class="right" id="IsFTPAlg">
<input type="radio" id="IsFTPAlg1" name="IsFTPAlg" value="1"/><label for="IsFTPAlg1">&?public_033;</label>&nbsp;&nbsp;
<input type="radio" id="IsFTPAlg0" name="IsFTPAlg" value="0"/><label for="IsFTPAlg0">&?public_034;</label>
</div>
</div>
<div class="row">
<label class="cfgLabel w130">&?Alg_007;</label>
<div class="right" id="IsH323Alg">
<input type="radio" id="IsH323Alg1" name="IsH323Alg" value="1"/><label for="IsH323Alg1">&?public_033;</label>&nbsp;&nbsp;
<input type="radio" id="IsH323Alg0" name="IsH323Alg" value="0"/><label for="IsH323Alg0">&?public_034;</label>
</div>
</div>
<div class="row" id="IPSECAlg" style="display:none">
<label class="cfgLabel w130">&?Alg_010;</label>
<div class="right" id="IsIPSECAlg">
<input type="radio" id="IsIPSECAlg1" name="IsIPSECAlg" value="1"/><label for="IsIPSECAlg1">&?public_033;</label>&nbsp;&nbsp;
<input type="radio" id="IsIPSECAlg0" name="IsIPSECAlg" value="0"/><label for="IsIPSECAlg0">&?public_034;</label>
</div>
</div>
<div class="row" id="L2TPAlg" style="display:none">
<label class="cfgLabel w130">&?Alg_006;</label>
<div class="right" id="IsL2TPAlg">
<input type="radio" id="IsL2TPAlg1" name="IsL2TPAlg" value="1"/><label for="IsL2TPAlg1">&?public_033;</label>&nbsp;&nbsp;
<input type="radio" id="IsL2TPAlg0" name="IsL2TPAlg" value="0"/><label for="IsL2TPAlg0">&?public_034;</label>
</div>
</div>
<div class="row">
<label class="cfgLabel w130">&?Alg_009;</label>
<div class="right" id="IsPPTPAlg">
<input type="radio" id="IsPPTPAlg1" name="IsPPTPAlg" value="1"/><label for="IsPPTPAlg1">&?public_033;</label>&nbsp;&nbsp;
<input type="radio" id="IsPPTPAlg0" name="IsPPTPAlg" value="0"/><label for="IsPPTPAlg0">&?public_034;</label>
</div>
</div>
<div class="row">
<label class="cfgLabel w130">&?Alg_008;</label>
<div class="right" id="IsRTSPAlg">
<input type="radio" id="IsRTSPAlg1" name="IsRTSPAlg" value="1"/><label for="IsRTSPAlg1">&?public_033;</label>&nbsp;&nbsp;
<input type="radio" id="IsRTSPAlg0" name="IsRTSPAlg" value="0"/><label for="IsRTSPAlg0">&?public_034;</label>
</div>
</div>
<div class="row">
<label class="cfgLabel w130">&?Alg_005;</label>
<div class="right" id="IsSIPAlg">
<input type="radio" id="IsSIPAlg1" name="IsSIPAlg" value="1"/><label for="IsSIPAlg1">&?public_033;</label>&nbsp;&nbsp;
<input type="radio" id="IsSIPAlg0" name="IsSIPAlg" value="0"/><label for="IsSIPAlg0">&?public_034;</label>
</div>
</div>
<div class="row">
<label class="cfgLabel w130">&?Alg_004;</label>
<div class="right" id="IsTFTPAlg">
<input type="radio" id="IsTFTPAlg1" name="IsTFTPAlg" value="1"/><label for="IsTFTPAlg1">&?public_033;</label>&nbsp;&nbsp;
<input type="radio" id="IsTFTPAlg0" name="IsTFTPAlg" value="0"/><label for="IsTFTPAlg0">&?public_034;</label>
</div>
</div>
<div class="buttongroup">
<input type="button" class="Button Btn_cancel" id="Btn_cancel_Alg" name="Btn_cancel_Alg" value="&?public_019;" />
<input type="button" class="Button Btn_apply" id="Btn_apply_Alg" name="Btn_apply_Alg" value="&?public_018;" />
<span class="AllOn emColor ctrlFont" id="allOn_Alg" name="allOn_Alg">&?public_042;</span>
&nbsp;&nbsp;|&nbsp;&nbsp;
<span class="AllOff emColor ctrlFont" id="allOff_Alg" name="allOff_Alg">&?public_043;</span>
</div>
</div>
</div>
</form>
</div>
</div>
</div>
