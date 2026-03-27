<%
cgilua.lp.include("../../webmodules/modules/mgts_bandsteer_js.lp")
%>
<div id="WLANBandSteer" class="HeadDIV">
<address style="display:none">
<span class="form-action">/?_type=menuData&_tag=mgts_bandsteer_lua.lua</span>
</address>
<div class="externErrorHint" style="display:none;">
<span class="caption1"></span>
</div>
<h1 class="collapBarWithDataTrans" id="WLANBandSteer">&?bandsteer_001;</h1>
<div id="WLANBandSteer_container">
<div id="enablesArea">
<div id="topLine_enablesArea" class="formTblCtrlBar">
<a id="instName_enablesArea" class="instName collapsibleInst" hidefocus="true" href="javascript:void(0);">&?wlanRoam_008;</a>
</div>
<div class="formTbl ChangeArea formTblWrap">
<input type="hidden" id="_InstID" value="">
<div class="errorHint" style="display:none;">
<span class="caption1"></span>
</div>
<div class="succHint" style="display:none;">
<span class="caption1">&?public_021;</span>
</div>
<div class="row">
<label for="EnBandSteer" class="left w180">&?wlanRoam_003;</label>
<div id="EnBandSteer" class="right">
<input type="radio" id="EnBandSteer0" name="EnBandSteer" value="1"/>
<label for="EnBandSteer0">&?public_033;</label>
&nbsp;&nbsp;
<input type="radio" id="EnBandSteer1" name="EnBandSteer" value="0"/>
<label for="EnBandSteer1">&?public_034;</label>
</div>
</div>
<div class="buttongroup">
<input type="button" class="Button Btn_cancel PostIgnore" id="Btn_cancel_Enable" name="Btn_cancel_Enable" value="&?public_019;" />
<input type="button" class="Button Btn_apply PostIgnore" id="Btn_apply_Enable" name="Btn_apply_Enable" value="&?public_018;" />
</div>
</div>
</div>
<input type="hidden" id="DataHasBeenGot" value="0">
<input type="hidden" id="_InstNum" value="0">
<div id="template_WLANBandSteer">
<form class="form_content">
<div id="topLine_WLANBandSteer" class="formTblCtrlBar">
<a id="instName_WLANBandSteer" class="instName collapsibleInst" hidefocus="true" href="javascript:void(0);"></a>
</div>
<div id="changeArea_WLANBandSteer" class="ChangeArea formTblWrap" style="display:none;">
<div class="errorHint" style="display:none;">
<span class="caption1"></span>
</div>
<div class="succHint" style="display:none;">
<span class="caption1">&?public_021;</span>
</div>
<div class="formTbl">
<input type="hidden" id="_InstID" value="">
<div id="24Garea">
<div class="row" id="div_BsRssiLmt24G" >
<label for="BsRssiLmt24G" class="left w180">&?bandsteer_002;</label>
<div class="right">
<input type="text" id="BsRssiLmt24G" name="BsRssiLmt24G" value="" class="inputNorm">
<span style="display: none;">&?public_072;-110 ~ -40</span>&?public_110;
</div>
</div>
<div class="row" id="div_BsVhtChk24G" >
<label class="cfgLabel w180" for="BsVhtChk24G">&?bandsteer_003;</label>
<div class="right">
<select name="BsVhtChk24G" id="BsVhtChk24G" class="selectNorm">
<option value="0">ALLOW_ALL</option>
<option value="1">VHT_ONLY</option>
<option value="2">NON_VHT_ONLY</option>
</select>
</div>
</div>
<div class="row" id="div_BsActiveStaChk24G" >
<label for="BsActiveStaChk24G" class="left w180">&?bandsteer_004;</label>
<div id="BsActiveStaChk24G" class="right">
<input type="radio" id="BsActiveStaChk24G0" name="BsActiveStaChk24G" value="1"/>
<label for="BsActiveStaChk24G0">&?public_033;</label>
&nbsp;&nbsp;
<input type="radio" id="BsActiveStaChk24G1" name="BsActiveStaChk24G" value="0"/>
<label for="BsActiveStaChk24G1">&?public_034;</label>
</div>
</div>
<div class="row" id="div_BsStaIdleRateLmt24G" >
<label for="BsStaIdleRateLmt24G" class="left w180">&?bandsteer_005;</label>
<div class="right">
<input type="text" id="BsStaIdleRateLmt24G" name="BsStaIdleRateLmt24G" value="" class="inputNorm">
<span style="display: none;">&?public_072;0 ~ 100</span>Mbps
</div>
</div>
<div class="row" id="div_BsBwUtil24G" >
<label for="BsBwUtil24G" class="left w180">&?bandsteer_006;</label>
<div class="right">
<input type="text" id="BsBwUtil24G" name="BsBwUtil24G" value="" class="inputNorm">
<span style="display: none;">&?public_072;0 ~ 100</span>%
</div>
</div>
<div class="row" id="div_BsAcceptBwUtil24G" >
<label for="BsAcceptBwUtil24G" class="left w180">&?bandsteer_007;</label>
<div class="right">
<input type="text" id="BsAcceptBwUtil24G" name="BsAcceptBwUtil24G" value="" class="inputNorm">
<span style="display: none;">&?public_072;0 ~ 100</span>%
</div>
</div>
<div class="row" id="div_BsAcceptRssi24G" >
<label for="BsAcceptRssi24G" class="left w180">&?bandsteer_008;</label>
<div class="right">
<input type="text" id="BsAcceptRssi24G" name="BsAcceptRssi24G" value="" class="inputNorm">
<span style="display: none;">&?public_072;-2147483648 ~ -1</span>&?public_110;
</div>
</div>
<div class="row" id="div_BsAcceptVhtCheck24G" >
<label for="BsAcceptVhtCheck24G" class="left w180">&?bandsteer_009;</label>
<div id="BsAcceptVhtCheck24G" class="right">
<input type="radio" id="BsAcceptVhtCheck24G0" name="BsAcceptVhtCheck24G" value="1"/>
<label for="BsAcceptVhtCheck24G0">&?public_033;</label>
&nbsp;&nbsp;
<input type="radio" id="BsAcceptVhtCheck24G1" name="BsAcceptVhtCheck24G" value="0"/>
<label for="BsAcceptVhtCheck24G1">&?public_034;</label>
</div>
</div>
</div>
<div id="5Garea">
<div class="row" id="div_BsRssiLmt5G" >
<label for="BsRssiLmt5G" class="left w180">&?bandsteer_002;</label>
<div class="right">
<input type="text" id="BsRssiLmt5G" name="BsRssiLmt5G" value="" class="inputNorm">
<span style="display: none;">&?public_072;-110 ~ -40</span>&?public_110;
</div>
</div>
<div class="row" id="div_BsVhtChk5G" >
<label class="cfgLabel w180" for="UserRight">&?bandsteer_003;</label>
<div class="right">
<select name="BsVhtChk5G" id="BsVhtChk5G" class="selectNorm">
<option value="0">ALLOW_ALL</option>
<option value="1">VHT_ONLY</option>
<option value="2">NON_VHT_ONLY</option>
</select>
</div>
</div>
<div class="row" id="div_BsActiveStaChk5G" >
<label for="BsActiveStaChk5G" class="left w180">&?bandsteer_004;</label>
<div id="BsActiveStaChk5G" class="right">
<input type="radio" id="BsActiveStaChk5G0" name="BsActiveStaChk5G" value="1"/>
<label for="BsActiveStaChk5G0">&?public_033;</label>
&nbsp;&nbsp;
<input type="radio" id="BsActiveStaChk5G1" name="BsActiveStaChk5G" value="0"/>
<label for="BsActiveStaChk5G1">&?public_034;</label>
</div>
</div>
<div class="row" id="div_BsStaIdleRateLmt5G" >
<label for="BsStaIdleRateLmt5G" class="left w180">&?bandsteer_005;</label>
<div class="right">
<input type="text" id="BsStaIdleRateLmt5G" name="BsStaIdleRateLmt5G" value="" class="inputNorm">
<span style="display: none;">&?public_072;0 ~ 100</span>Mbps
</div>
</div>
<div class="row" id="div_BsBwUtil5G">
<label for="BsBwUtil5G" class="left w180">&?bandsteer_006;</label>
<div class="right">
<input type="text" id="BsBwUtil5G" name="BsBwUtil5G" value="" class="inputNorm">
<span style="display: none;">&?public_072;0 ~ 100</span>%
</div>
</div>
<div class="row" id="div_BsAcceptBwUtil5G" >
<label for="BsAcceptBwUtil5G" class="left w180">&?bandsteer_007;</label>
<div class="right">
<input type="text" id="BsAcceptBwUtil5G" name="BsAcceptBwUtil5G" value="" class="inputNorm">
<span style="display: none;">&?public_072;0 ~ 100</span>%
</div>
</div>
<div class="row" id="div_BsAcceptRssi5G" >
<label for="BsAcceptRssi5G" class="left w180">&?bandsteer_008;</label>
<div class="right">
<input type="text" id="BsAcceptRssi5G" name="BsAcceptRssi5G" value="" class="inputNorm">
<span style="display: none;">&?public_072;-2147483648 ~ -1</span>&?public_110;
</div>
</div>
<div class="row" id="div_BsAcceptVhtCheck5G" >
<label for="BsAcceptVhtCheck5G" class="left w180">&?bandsteer_009;</label>
<div id="BsAcceptVhtCheck5G" class="right">
<input type="radio" id="BsAcceptVhtCheck5G0" name="BsAcceptVhtCheck5G" value="1"/>
<label for="BsAcceptVhtCheck5G0">&?public_033;</label>
&nbsp;&nbsp;
<input type="radio" id="BsAcceptVhtCheck5G1" name="BsAcceptVhtCheck5G" value="0"/>
<label for="BsAcceptVhtCheck5G1">&?public_034;</label>
</div>
</div>
</div>
<div class="row">
<label for="BsBounceDetectTimeLmt" class="left w180">&?bandsteer_010;</label>
<div class="right">
<input type="text" id="BsBounceDetectTimeLmt" name="BsBounceDetectTimeLmt" value="" class="inputNorm">
<span style="display: none;">&?public_072;1 ~ 2147483647</span>&?public_013;
</div>
</div>
<div class="row">
<label for="BsBounceCountsLmt" class="left w180">&?bandsteer_011;</label>
<div class="right">
<input type="text" id="BsBounceCountsLmt" name="BsBounceCountsLmt" value="" class="inputNorm">
<span style="display: none;">&?public_072;1 ~ 2147483647</span>
</div>
</div>
<div class="row">
<label for="BsBounceDwellTimeLmt" class="left w180">&?bandsteer_012;</label>
<div class="right">
<input type="text" id="BsBounceDwellTimeLmt" name="BsBounceDwellTimeLmt" value="" class="inputNorm">
<span style="display: none;">&?public_072;1 ~ 2147483647</span>&?public_013;
</div>
</div>
<div class="buttongroup">
<input type="button" class="Button Btn_cancel PostIgnore" id="Btn_cancel_params" name="Btn_cancel_params" value="&?public_019;" />
<input type="button" class="Button Btn_apply PostIgnore" id="Btn_apply_params" name="Btn_apply_params" value="&?public_018;" />
</div>
</div>
</div>
</form>
</div>
</div>
</div>
