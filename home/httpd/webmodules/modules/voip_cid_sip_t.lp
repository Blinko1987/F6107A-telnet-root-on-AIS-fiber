<%
cgilua_lp.include("../../webmodules/modules/voip_cid_sip_js.lp", getfenv(1))
%>
<div id="VoIPCIDSIP" class="HeadDIV">
<address style="display:none">
<span class="form-action">/?_type=menuData&_tag=voip_cid_sip_lua.lua</span>
</address>
<h1 class="collapBarWithDataTrans" id="VoIPCIDSIPBar">&?voip_dtmf_001;</h1>
<div class="externErrorHint" style="display:none;">
<span class="caption1"></span>
</div>
<div id="VoIPCIDSIP_container">
<input type="hidden" id="DataHasBeenGot" value="0">
<div id="template_VoIPCIDSIP">
<form class="formTbl form_content">
<div id="changeArea_VoIPCIDSIP" class="ChangeArea formTblWrap">
<div id="errorHint" class="errorHint" style="display:none;">
<span class="caption1"></span>
</div>
<div class="succHint" style="display:none;">
<span class="caption1">&?public_021;</span>
</div>
<div class="formTbl">
<input type="hidden" id="_InstID" value="-1">
<input type="hidden" id="_InstID_CIDSIP" value="-1">
<input type="hidden" id="FskFrameType" value="-1">
<div class="row">
<label for="CIDMode" class="left w200">&?voip_dtmf_002;</label>
<div class="right">
<select name="CIDMode" id="CIDMode" class="selectNorm">
<option value="1" title='&?voip_dtmf_004;'>&?voip_dtmf_004;</option>
<option value="2" title='&?voip_dtmf_005;'>&?voip_dtmf_005;</option>
<%
local countrycode = env.getenv("CountryCode")
if countrycode ~= "21" then
%>
<option value="3" title='&?voip_dtmf_006;'>&?voip_dtmf_006;</option>
<%
end
%>
</select>
</div>
</div>
<div class="row">
<label for="ETSICallIDStandard" class="left w200">&?voip_dtmf_0014;</label>
<div id="ETSICallIDStandard" class="right">
<input type="radio" id="ETSICallIDStandard1" name="ETSICallIDStandard" value="0"/><label for="ETSICallIDStandard1">&?voip_dtmf_008;</label>&nbsp;&nbsp;
<input type="radio" id="ETSICallIDStandard0" name="ETSICallIDStandard" value="1"/><label for="ETSICallIDStandard0">&?voip_dtmf_007;</label>
</div>
</div>
<%
local voipProtocol = env.getenv("VoIPProtocal")
if voipProtocol == "SIP" then
%>
<div class="row">
<label for="TimeEnable" class="left w200">&?voip_dtmf_003;</label>
<div class="right">
<select name="TimeEnable" id="TimeEnable" class="selectNorm">
<option value="0" title='&?voip_dtmf_007;'>&?voip_dtmf_007;</option>
<option value="1" title='&?voip_dtmf_008;'>&?voip_dtmf_008;</option>
<option value="2" title='&?voip_dtmf_009;'>&?voip_dtmf_009;</option>
</select>
</div>
</div>
<div class="row">
<label for="PAssertedID" class="left w200">&?voip_dtmf_0010;</label>
<div class="right">
<select name="PAssertedID" id="PAssertedID" class="selectNorm">
<option value="0" title='&?voip_dtmf_0011;'>&?voip_dtmf_0011;</option>
<option value="1" title='&?voip_dtmf_0012;'>&?voip_dtmf_0012;</option>
</select>
</div>
</div>
<div class="row">
<label for="" class="left w200">&?voip_dtmf_0013;</label>
<div id="CallerNameAsCIDNumber" class="right">
<input type="radio" id="CallerNameAsCIDNumber1" name="CallerNameAsCIDNumber" value="1"/><label for="CallerNameAsCIDNumber1">&?voip_dtmf_008;</label>&nbsp;&nbsp;
<input type="radio" id="CallerNameAsCIDNumber0" name="CallerNameAsCIDNumber" value="0"/><label for="CallerNameAsCIDNumber0">&?voip_dtmf_007;</label>
</div>
</div>
<%
end
%>
<div class="buttongroup">
<input type="button" class="Button Btn_cancel" id="Btn_cancel_instCfgArea" name="Btn_cancel_instCfgArea" value="&?public_019;" />
<input type="button" class="Button Btn_apply" id="Btn_apply_instCfgArea" name="Btn_apply_instCfgArea" value="&?public_018;" />
</div>
</div>
</div>
</form>
</div>
</div>
</div>
