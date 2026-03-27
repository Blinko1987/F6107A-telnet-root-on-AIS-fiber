<%
cgilua.lp.include("../../webmodules/modules/Voip_Voip_QoSMedia_js.lp", getfenv(1))
%>
<div id="VoIPQoSConf_Media" class="HeadDIV">
<address style="display:none">
<span class="form-action">/?_type=menuData&_tag=Voip_Voip_QoS_Media_lua.lua</span>
</address>
<div class="externErrorHint" style="display:none;">
<span class="caption1"></span>
</div>
<h1 class="collapBarWithDataTrans" id="VoIPQoSConf_MediaBar">&?VoipQoS_008;</h1>
<div id="VoIPQoSConf_Media_container" style="display:none;">
<input type="hidden" id="_InstNum" value="0">
<input type="hidden" id="DataHasBeenGot" value="0">
<div id="template_VoIPQoSConf_Media" class="formTblWrap" style="display:none;">
<div id="topLine_VoIPQoSConf_Media" class="formTblCtrlBar">
<span id="instName_VoIPQoSConf_Media" class="instName collapsibleInst instNameExp">&?public_041;</span>
</div>
<div id="changeArea_VoIPQoSConf_Media" class="ChangeArea formTblWrap">
<div id="errorHint" class="errorHint" style="display:none;">
<span class="caption1"></span>
</div>
<div class="succHint" style="display:none;">
<span class="caption1">&?public_021;</span>
</div>
<form class="form_content formTbl">
<input type="hidden" id="_InstID" value="-1">
<div class="row">
<label for="DSCPMarkMedia" class="cfgLabel w150">&?VoipQoS_005;</label>
<div class="right">
<input type="text" id="DSCPMarkMedia" name="DSCPMarkMedia" value="" class="inputNorm"/>
<span style="display: none;">&?public_072;0 ~ 63</span>
</div>
</div>
<div class="row">
<label for="RTPEthernetPriorityMark" class="cfgLabel w150">&?VoipQoS_006;</label>
<div class="right">
<input type="text" id="RTPEthernetPriorityMark" name="RTPEthernetPriorityMark" value="" class="inputNorm"/>
<span style="display: none;">&?public_072;-1 ~ 7</span>
</div>
</div>
<div class="buttongroup">
<input type="button" class="Button Btn_cancel" id="Btn_cancel_VoIPQoSConf_Media" name="Btn_cancel_VoIPQoSConf_Media" value="&?public_019;" />
<input type="button" class="Button Btn_apply" id="Btn_apply_VoIPQoSConf_Media" name="Btn_apply_VoIPQoSConf_Media" value="&?public_018;" />
</div>
</form>
</div>
</div>
<div class="fakeHeadDIV"></div>
</div>
</div>
