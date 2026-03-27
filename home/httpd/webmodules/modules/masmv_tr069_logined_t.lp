<%
cgilua_lp.include("../../thinklua/template/common_eventtriggering.lp",getfenv(1))
cgilua_lp.include("../../webmodules/modules/masmv_tr069_remotemgr_js.lp", getfenv(1))
%>
<div id="TR069BasicConf" class="HeadDIV">
<address style="display:none">
<span class="form-action">/?_type=hiddenData&_tag=TR069settings_data</span>
</address>
<div class="externErrorHint" style="display:none;">
<span class="caption1"></span>
</div>
<div id="TR069BasicConf_container">
<div id="template_TR069BasicConf" style="display:block;">
<div id="changeArea_TR069BasicConf" class="ChangeArea formTblWrap">
<div id="errorHint" class="errorHint" style="display:none;">
<span class="caption1"></span>
</div>
<div class="succHint" style="display:none;">
<span class="caption1">&?public_021;</span>
</div>
<form class="form_content formTbl">
<input type="hidden" id="CertList" value="">
<input type="hidden" id="CertID" value="">
<div class="row">
<label class="cfgLabel w200" for="DefaultWan">&?public_015;</label>
<div class="right">
<select name="DefaultWan" id="DefaultWan" class="selectLong">
<option value="" title='&?public_039;'>&?public_039;</option>
<%
cgilua.put(_G.CreateIFOpStr("TR069"))
%>
</select>
</div>
</div>
<div class="row">
<label class="cfgLabel w200" for="URL">&?RemoteManag_005;</label>
<div class="right">
<input class="inputLong" type="text" id="URL" name="URL" value=""/>
</div>
</div>
<div class="row">
<label class="cfgLabel w200" for="UserName">&?public_026;</label>
<div class="right">
<input class="inputLong" type="text" id="UserName" name="UserName" value=""/>
</div>
</div>
<div class="row">
<label class="cfgLabel w200" for="UserPassword">&?public_027;</label>
<div class="right">
<input class="inputLong SpecialPassword" type="password" id="UserPassword" name="UserPassword" value="" autocomplete="new-password"/>
</div>
</div>
<div class="row">
<label class="cfgLabel w200" for="ConnectionRequestURL">&?RemoteManag_008;</label>
<div class="right">
<input class="inputLong readonlyInputBg PostIgnore" readonly="" type="text" id="ConnectionRequestURL" name="ConnectionRequestURL" value=""/>
</div>
</div>
<div class="row">
<label class="cfgLabel w200" for="ConnectionRequestUsername">&?RemoteManag_009;</label>
<div class="right">
<input class="inputLong" type="text" id="ConnectionRequestUsername" name="ConnectionRequestUsername" value=""/>
</div>
</div>
<div class="row">
<label class="cfgLabel w200" for="ConnectionRequestPassword">&?RemoteManag_010;</label>
<div class="right">
<input class="inputLong SpecialPassword" type="password" id="ConnectionRequestPassword" name="ConnectionRequestPassword" value="" autocomplete="new-password"/>
</div>
</div>
<div class="row">
<label class="cfgLabel w200" for="PeriodicInformEnable">&?RemoteManag_011;</label>
<div id="PeriodicInformEnable" class="right">
<input type="radio" value="1" name="PeriodicInformEnable" id="PeriodicInformEnable1"><label for="PeriodicInformEnable1">&?public_033;</label>&nbsp;&nbsp;
<input type="radio" value="0" name="PeriodicInformEnable" id="PeriodicInformEnable0"><label for="PeriodicInformEnable0" >&?public_034;</label>
</div>
</div>
<div class="row" id="div_PeriodicInformInterval">
<label class="cfgLabel w200" for="PeriodicInformInterval">&?RemoteManag_012;</label>
<div class="right">
<input class="inputNorm" type="text" id="PeriodicInformInterval" name="PeriodicInformInterval" value=""/>&?public_013;
<span style="display:none;">&?public_072;1 ~ 42 949 672</span>
</div>
</div>
<div class="row">
<label class="cfgLabel w200" for="SupportCertAuth">&?RemoteManag_020;</label>
<div id="SupportCertAuth" class="right">
<input type="radio" value="1" name="SupportCertAuth" id="SupportCertAuth1"><label for="SupportCertAuth1">&?public_033;</label>&nbsp;&nbsp;
<input type="radio" value="0" name="SupportCertAuth" id="SupportCertAuth0"><label for="SupportCertAuth0" >&?public_034;</label>
</div>
</div>
<div class="row" id="div_select_CertID" style="display:none">
<label class="cfgLabel w200" for="select_CertID">&?RemoteManag_014;</label>
<div class="right" id="div_CertID">
<select name="select_CertID" id="select_CertID" class="selectNorm">
</select>
</div>
</div>
<div class="row">
<label class="cfgLabel w200" for="RemoteUpgradeCertAuth">&?RemoteManag_021;</label>
<div id="RemoteUpgradeCertAuth" class="right">
<input type="radio" value="1" name="RemoteUpgradeCertAuth" id="RemoteUpgradeCertAuth1"><label for="RemoteUpgradeCertAuth1">&?public_033;</label>&nbsp;&nbsp;
<input type="radio" value="0" name="RemoteUpgradeCertAuth" id="RemoteUpgradeCertAuth0"><label for="RemoteUpgradeCertAuth0" >&?public_034;</label>
</div>
</div>
<div class="row" id="div_DSCPRemark" style="display:none">
<label class="cfgLabel w200" for="DSCPRemark">&?RemoteManag_026;</label>
<div class="right">
<input class="inputNorm PostIgnore" type="text" id="DSCPRemark" name="DSCPRemark" value=""/>
<span style="display:none;">&?public_072;0 ~ 63</span>
</div>
</div>
<div class="row" id="div_VLanPrioRemark" style="display:none">
<label class="cfgLabel w200" for="VLanPrioRemark">&?RemoteManag_027;</label>
<div class="right" id="div_CertID">
<select name="VLanPrioRemark" id="VLanPrioRemark" class="selectNorm PostIgnore">
<option value="0">0</option>
<option value="1">1</option>
<option value="2">2</option>
<option value="3">3</option>
<option value="4">4</option>
<option value="5">5</option>
<option value="6">6</option>
<option value="7">7</option>
</select>
</div>
</div>
<div class="buttongroup">
<input type="button" class="Button Btn_cancel" id="Btn_cancel_TR069BasicConf" name="Btn_cancel_TR069BasicConf" value="&?public_019;" />
<input type="button" class="Button Btn_apply" id="Btn_apply_TR069BasicConf" name="Btn_apply_TR069BasicConf" value="&?public_018;" />
</div>
</form>
</div>
</div>
</div>
</div>
