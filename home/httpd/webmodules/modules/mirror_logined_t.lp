<%
cgilua_lp.include("../../thinklua/template/common_eventtriggering.lp",getfenv(1))
cgilua_lp.include("../../webmodules/modules/mirror_js.lp", getfenv(1))
%>
<style type="text/css">
.row_new{
margin-left:260px;
}
.errorLabelWraper{
width:130px !important;
margin-left:-150px !important;
}
</style>
<div id="MirroManag" class="HeadDIV">
<address style="display:none">
<span class="form-action">/?_type=hiddenData&_tag=mirrorcfg_data</span>
</address>
<div class="externErrorHint" style="display:none;">
<span class="caption1"></span>
</div>
<h1 id="MirroManagBar">&?MirroManag_001;</h1>
<div id="MirroManag_container">
<input type="hidden" id="_InstNum" value="0">
<input id="DataHasBeenGot" type="hidden" value="0">
<div id="template_MirroManag">
<div id="changeArea_MirroManag" class="ChangeArea formTblWrap">
<div class="errorHint" style="display:none;">
<span class="caption1"></span>
</div>
<div class="succHint" style="display:none;">
<span class="caption1">&?public_021;</span>
</div>
<form class="form_content formTbl">
<input type="hidden" id="_InstID" value="-1">
<div class="row row_new">
<div>
<label class="cMirroManag_containerfgLabel w180" style="float:left">&?MirroManag_007;</label>
<div id="MirrorEnable" class="right">
<input type="radio" value="1" name="MirrorEnable" id="MirrorEnable1" checked="checked"><label for="MirrorEnable1">&?public_033;</label>&nbsp;&nbsp;
<input type="radio" value="0" name="MirrorEnable" id="MirrorEnable0"><label for="MirrorEnable0">&?public_034;</label>
</div>
</div>
</div>
<div class="row row_new">
<div>
<label for="MirrorSrc" class="cfgLabel w180">&?MirroManag_002;</label>
<div class="right">
<select id="MirrorSrc" name="MirrorSrc" class="selectNorm" >
<option value="IGD.WANALL" title="&?MirroManag_006;">&?MirroManag_006;</option>
<%
cgilua.put(_G.CreateIFOpStr("MirrorSrc"))
%>
</select>
</div>
</div>
</div>
<div class="row row_new">
<div>
<label for="MirrorDest" class="cfgLabel w180">&?MirroManag_003;</label>
<div class="right">
<select id="MirrorDest" name="MirrorDest" class="selectNorm">
<option value="" title="&?public_089;">&?public_089;</option>
<%
cgilua.put(_G.CreateIFOpStr("MirroDes"))
%>
</select>
</div>
</div>
</div>
<div class="buttongroup">
<input type="button" class="Button Btn_cancel" id="Btn_cancel_MirroManag" name="Btn_cancel_MirroManag" value="&?public_019;" />
<input type="button" class="Button Btn_apply" id="Btn_apply_MirroManag" name="Btn_apply_MirroManag" value="&?public_018;" />
</div>
</form>
</div>
</div>
</div>
</div>
