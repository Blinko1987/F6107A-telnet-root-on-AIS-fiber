<%
cgilua_lp.include("../../webmodules/modules/Voip_Voip_QoS_js.lp", getfenv(1))
%>
<div id="VoIPQoSConf" class="HeadDIV">
<address style="display:none">
<span class="form-action">/?_type=menuData&_tag=Voip_Voip_QoS_lua.lua</span>
</address>
<h1 class="collapBarWithDataTrans" id="VoIPQoSConfBar">&?VoipQoS_007;</h1>
<div class="externErrorHint" style="display:none;">
<span class="caption1"></span>
</div>
<div id="VoIPQoSConf_container" style="display:none;">
<input type="hidden" id="_InstNum" value="0">
<input type="hidden" id="DataHasBeenGot" value="0">
<div id="template_VoIPQoSConf" class="formTblWrap" style="display:none;">
<div id="topLine_VoIPQoSConf" class="formTblCtrlBar">
<span id="instName_VoIPQoSConf" class="instName collapsibleInst instNameExp">&?public_041;</span>
</div>
<div id="changeArea_VoIPQoSConf" class="ChangeArea formTblWrap">
<div id="errorHint" class="errorHint" style="display:none;">
<span class="caption1"></span>
</div>
<div class="succHint" style="display:none;">
<span class="caption1">&?public_021;</span>
</div>
<form class="form_content formTbl">
<input type="hidden" id="_InstID" value="-1">
<div class="row">
<label for="DSCPMarkSignalling" class="cfgLabel w150">&?VoipQoS_003;</label>
<div class="right">
<input type="text" id="DSCPMarkSignalling" name="DSCPMarkSignalling" value="" class="inputNorm"/>
<span style="display: none;">&?public_072;0 ~ 63</span>
</div>
</div>
<div class="row">
<label for="EthernetPriorityMark" class="cfgLabel w150">&?VoipQoS_004;</label>
<div class="right">
<input type="text" id="EthernetPriorityMark" name="EthernetPriorityMark" value="" class="inputNorm"/>
<span style="display: none;">&?public_072;-1 ~ 7</span>
</div>
</div>
<div class="buttongroup">
<input type="button" class="Button Btn_cancel" id="Btn_cancel_VoIPQoSConf" name="Btn_cancel_VoIPQoSConf" value="&?public_019;" />
<input type="button" class="Button Btn_apply" id="Btn_apply_VoIPQoSConf" name="Btn_apply_VoIPQoSConf" value="&?public_018;" />
</div>
</form>
</div>
</div>
<div class="fakeHeadDIV"></div>
</div>
</div>
