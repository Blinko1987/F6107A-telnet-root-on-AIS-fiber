<%
cgilua_lp.include("../../webmodules/modules/voip_sipmedia_js.lp", getfenv(1))
local contrlStr = ""
if _G.voipConf["SIPMediaConf"] ~= nil then
contrlStr = _G.voipConf["SIPMediaConf"]
end
%>
<div id="SIPMediaConf" class="HeadDIV">
<address style="display:none">
<span class="form-action">/?_type=menuData&_tag=voip_sipmedia_lua.lua</span>
</address>
<div class="externErrorHint" style="display:none;">
<span class="caption1"></span>
</div>
<div id="template_SIPMediaConf" style="display:none;">
<h1 class="collapsibleBar" id="SIPMediaBar">&?SIPMedia_003;</h1>
<div id="SIPMediaConf_container" style="display:none;">
<div class="formTblWrap">
<div id="errorHint" class="errorHint" style="display:none;">
<span class="caption1"></span>
</div>
<div class="succHint" style="display:none;">
<span class="caption1">&?public_021;</span>
</div>
<form class="form_content formTbl">
<input type="hidden" id="_InstID" value="">
<input type="hidden" id="_InstID_G722" value="">
<input type="hidden" id="_InstID_G711U" value="">
<input type="hidden" id="_InstID_G711A" value="">
<input type="hidden" id="_InstID_G729" value="">
<input type="hidden" id="_InstID_G726" value="">
<input type="hidden" id="_InstID_G723" value="">
<input type="hidden" id="_InstID_G726_24k" value="">
<input type="hidden" id="_InstID_G726_32k" value="">
<input type="hidden" id="_InstID_Other" value="">
<div class="staticInfoHint">
<p>&?SIPMedia_002;</p>
</div>
<div id="div_G722" class="row">
<div class="left w80">
<input type="checkbox" id="MediaVEnable_G722" name="MediaVEnable_G722" value=""/>
<label for="MediaVEnable_G722">&?SIPMedia_005;</label>
</div>
<div class="right w80">
<input type="checkbox" id="MediaSSuprs_G722" name="MediaSSuprs_G722" value=""/>
<label for="MediaSSuprs_G722">&?SIPMedia_006;</label>
</div>
<%if string.find(contrlStr,"MediaRSSuprs") ~= nil then%>
<div class="right w80">
<input type="checkbox" id="MediaRSSuprs_G722" name="MediaRSSuprs_G722" value=""/>
<label for="MediaRSSuprs_G722">&?SIPMedia_014;</label>
</div>
<% end %>
<div class="right">
<input type="text" size="2" maxlength="2" id="MediaVPri_G722" name="MediaVPri_G722"/>
<span style="display:none;">&?public_072;1 ~ 16</span>
<label for="MediaVPri_G722">&?SIPMedia_007;</label>
</div>
</div>
<div id="div_G711U" class="row">
<div class="left w80">
<input type="checkbox" id="MediaVEnable_G711U" name="MediaVEnable_G711U" value=""/>
<label for="MediaVEnable_G711U">&?SIPMedia_008;</label>
</div>
<div class="right w80">
<input type="checkbox" id="MediaSSuprs_G711U" name="MediaSSuprs_G711U" value=""/>
<label for="MediaSSuprs_G711U">&?SIPMedia_006;</label>
</div>
<%if string.find(contrlStr,"MediaRSSuprs") ~= nil then%>
<div class="right w80">
<input type="checkbox" id="MediaRSSuprs_G711U" name="MediaRSSuprs_G711U" value=""/>
<label for="MediaRSSuprs_G711U">&?SIPMedia_014;</label>
</div>
<% end %>
<div class="right">
<input type="text" size="2" maxlength="2" id="MediaVPri_G711U" name="MediaVPri_G711U"/>
<span style="display:none;">&?public_072;1 ~ 16</span>
<label for="MediaVPri_G711U">&?SIPMedia_007;</label>
</div>
</div>
<div id="div_G711A" class="row">
<div class="left w80">
<input type="checkbox" id="MediaVEnable_G711A" name="MediaVEnable_G711A" value=""/>
<label for="MediaVEnable_G711A">&?SIPMedia_009;</label>
</div>
<div class="right w80">
<input type="checkbox" id="MediaSSuprs_G711A" name="MediaSSuprs_G711A" value=""/>
<label for="MediaSSuprs_G711A">&?SIPMedia_006;</label>
</div>
<%if string.find(contrlStr,"MediaRSSuprs") ~= nil then%>
<div class="right w80">
<input type="checkbox" id="MediaRSSuprs_G711A" name="MediaRSSuprs_G711A" value=""/>
<label for="MediaRSSuprs_G711A">&?SIPMedia_014;</label>
</div>
<% end %>
<div class="right">
<input type="text" size="2" maxlength="2" id="MediaVPri_G711A" name="MediaVPri_G711A"/>
<span style="display:none;">&?public_072;1 ~ 16</span>
<label for="MediaVPri_G711A">&?SIPMedia_007;</label>
</div>
</div>
<div id="div_G729" class="row">
<div class="left w80">
<input type="checkbox" id="MediaVEnable_G729" name="MediaVEnable_G729" value=""/>
<label for="MediaVEnable_G729" id="MediaVEnable_G729_Lab">&?SIPMedia_010;</label>
</div>
<div class="right w80">
<input type="checkbox" id="MediaSSuprs_G729" name="MediaSSuprs_G729" value=""/>
<label for="MediaSSuprs_G729">&?SIPMedia_006;</label>
</div>
<%if string.find(contrlStr,"MediaRSSuprs") ~= nil then%>
<div class="right w80">
<input type="checkbox" id="MediaRSSuprs_G729" name="MediaRSSuprs_G729" value=""/>
<label for="MediaRSSuprs_G729">&?SIPMedia_014;</label>
</div>
<% end %>
<div class="right">
<input type="text" size="2" maxlength="2" id="MediaVPri_G729" name="MediaVPri_G729"/>
<span style="display:none;">&?public_072;1 ~ 16</span>
<label for="MediaVPri_G729">&?SIPMedia_007;</label>
</div>
</div>
<div id="div_G726" class="row">
<div class="left w80">
<input type="checkbox" id="MediaVEnable_G726" name="MediaVEnable_G726" value=""/>
<label for="MediaVEnable_G726">&?SIPMedia_011;</label>
</div>
<div class="right w80">
<input type="checkbox" id="MediaSSuprs_G726" name="MediaSSuprs_G726" value=""/>
<label for="MediaSSuprs_G726">&?SIPMedia_006;</label>
</div>
<%if string.find(contrlStr,"MediaRSSuprs") ~= nil then%>
<div class="right w80">
<input type="checkbox" id="MediaRSSuprs_G726" name="MediaRSSuprs_G726" value=""/>
<label for="MediaRSSuprs_G726">&?SIPMedia_014;</label>
</div>
<% end %>
<div class="right">
<input type="text" size="2" maxlength="2" id="MediaVPri_G726" name="MediaVPri_G726"/>
<span style="display:none;">&?public_072;1 ~ 16</span>
<label for="MediaVPri_G726">&?SIPMedia_007;</label>
</div>
</div>
<div id="div_G723" class="row">
<div class="left w80">
<input type="checkbox" id="MediaVEnable_G723" name="MediaVEnable_G723" value=""/>
<label for="MediaVEnable_G723">&?SIPMedia_012;</label>
</div>
<div class="right w80">
<input type="checkbox" id="MediaSSuprs_G723" name="MediaSSuprs_G723" value=""/>
<label for="MediaSSuprs_G723">&?SIPMedia_006;</label>
</div>
<%if string.find(contrlStr,"MediaRSSuprs") ~= nil then%>
<div class="right w80">
<input type="checkbox" id="MediaRSSuprs_G723" name="MediaRSSuprs_G723" value=""/>
<label for="MediaRSSuprs_G723">&?SIPMedia_014;</label>
</div>
<% end %>
<div class="right">
<input type="text" size="2" maxlength="2" id="MediaVPri_G723" name="MediaVPri_G723"/>
<span style="display:none;">&?public_072;1 ~ 16</span>
<label for="MediaVPri_G723">&?SIPMedia_007;</label>
</div>
</div>
<div id="div_G726_24k" class="row">
<div class="left w80">
<input type="checkbox" id="MediaVEnable_G726_24k" name="MediaVEnable_G726_24k" value=""/>
<label for="MediaVEnable_G726_24k">&?SIPMedia_015;</label>
</div>
<div class="right w80">
<input type="checkbox" id="MediaSSuprs_G726_24k" name="MediaSSuprs_G726_24k" value=""/>
<label for="MediaSSuprs_G726_24k">&?SIPMedia_006;</label>
</div>
<%if string.find(contrlStr,"MediaRSSuprs") ~= nil then%>
<div class="right w80">
<input type="checkbox" id="MediaRSSuprs_G726_24k" name="MediaRSSuprs_G726_24k" value=""/>
<label for="MediaRSSuprs_G726_24k">&?SIPMedia_014;</label>
</div>
<% end %>
<div class="right">
<input type="text" size="2" maxlength="2" id="MediaVPri_G726_24k" name="MediaVPri_G726_24k"/>
<span style="display:none;">&?public_072;1 ~ 16</span>
<label for="MediaVPri_G726_24k">&?SIPMedia_007;</label>
</div>
</div>
<div id="div_G726_32k" class="row">
<div class="left w80">
<input type="checkbox" id="MediaVEnable_G726_32k" name="MediaVEnable_G726_32k" value=""/>
<label for="MediaVEnable_G726_32k">&?SIPMedia_016;</label>
</div>
<div class="right w80">
<input type="checkbox" id="MediaSSuprs_G726_32k" name="MediaSSuprs_G726_32k" value=""/>
<label for="MediaSSuprs_G726_32k">&?SIPMedia_006;</label>
</div>
<%if string.find(contrlStr,"MediaRSSuprs") ~= nil then%>
<div class="right w80">
<input type="checkbox" id="MediaRSSuprs_G726_32k" name="MediaRSSuprs_G726_32k" value=""/>
<label for="MediaRSSuprs_G726_32k">&?SIPMedia_014;</label>
</div>
<% end %>
<div class="right">
<input type="text" size="2" maxlength="2" id="MediaVPri_G726_32k" name="MediaVPri_G726_32k"/>
<span style="display:none;">&?public_072;1 ~ 16</span>
<label for="MediaVPri_G726_32k">&?SIPMedia_007;</label>
</div>
</div>
<div id="div_Other" class="row">
<div class="left w80">
<input type="checkbox" id="MediaVEnable_Other" name="MediaVEnable_Other" value=""/>
<label for="MediaVEnable_Other">&?SIPMedia_013;</label>
</div>
<div class="right w80">
<input type="checkbox" id="MediaSSuprs_Other" name="MediaSSuprs_Other" value=""/>
<label for="MediaSSuprs_Other">&?SIPMedia_006;</label>
</div>
<%if string.find(contrlStr,"MediaRSSuprs") ~= nil then%>
<div class="right w80">
<input type="checkbox" id="MediaRSSuprs_Other" name="MediaRSSuprs_Other" value=""/>
<label for="MediaRSSuprs_Other">&?SIPMedia_014;</label>
</div>
<% end %>
<div class="right">
<input type="text" size="2" maxlength="2" id="MediaVPri_Other" name="MediaVPri_Other"/>
<span style="display:none;">&?public_072;1 ~ 16</span>
<label for="MediaVPri_Other">&?SIPMedia_007;</label>
</div>
</div>
<div class="buttongroup">
<input type="button" class="Button Btn_cancel" id="Btn_cancel_SIPMediaConf" name="Btn_cancel_SIPMediaConf" value="&?public_019;" />
<input type="button" class="Button Btn_apply" id="Btn_apply_SIPMediaConf" name="Btn_apply_SIPMediaConf" value="&?public_018;" />
</div>
</form>
</div>
</div>
<div class="fakeHeadDIV"></div>
</div>
</div>
