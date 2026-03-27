<%
cgilua_lp.include("../../webmodules/modules/firewall_ipfilter_js.lp", getfenv(1))
%>
<div id="IPFilter" class="HeadDIV">
<address style="display:none">
<span class="form-action">/?_type=menuData&_tag=firewall_ipfilter_lua.lua</span>
</address>
<div class="externErrorHint" style="display:none;">
<span class="caption1"></span>
</div>
<h1 class="collapBarWithDataTrans" id="IPFilterBar">&?Security_202;</h1>
<div id="IPFilter_container">
<input id="DataHasBeenGot" type="hidden" value="0">
<input id="_InstNum" type="hidden" value="0">
<input class="maxInstNum" type="hidden" value="0">
<div id="template_IPFilter" style="display:none;">
<form class="form_content">
<div id="topLine_IPFilter" class="formTblCtrlBar">
<span id="instName_IPFilter" class="instName collapsibleInst">&?public_041;</span>
<span class="instSwitch">
<div id="Enable:IPFilter">
<input type="radio" id="Enable1" name="Enable" value="1"/><label for="Enable1">&?public_033;</label>&nbsp;&nbsp;
<input type="radio" id="Enable0" name="Enable" value="0" checked="checked"/><label for="Enable0" >&?public_034;</label>
</div>
</span>
<span id="instDelete_IPFilter" class="instDelete Btn_delete"><img src="img/del.png" alt="delete" /></span>
</div>
<div id="changeArea_IPFilter" class="ChangeArea formTblWrap" style="display:none;">
<div class="errorHint" style="display:none;">
<span class="caption1"></span>
</div>
<div class="succHint" style="display:none;">
<span class="caption1">&?public_021;</span>
</div>
<div class="formTbl">
<input type="hidden" id="_InstID" value="-1">
<div class="row">
<label for="Name" class="cfgLabel w180">&?public_016;</label>
<div class="right">
<input type="text" class="inputNorm" id="Name" name="Name" value=""/>
<span class="utf8Compatible" style="display: none;">&?public_073;1~32</span>
</div>
</div>
<div class="row">
<label for="FilterTarget" class="cfgLabel w180">&?Security_031;</label>
<div id="FilterTarget" class="right">
<input type="radio" id="FilterTarget1" name="FilterTarget" value="1" checked="checked"/><label for="FilterTarget1">&?Security_032;</label>&nbsp;&nbsp;
<input type="radio" id="FilterTarget0" name="FilterTarget" value="0"/><label for="FilterTarget0">&?Security_033;</label>
</div>
</div>
<div class="row">
<label for="FilterIndex" class="cfgLabel w180">&?Security_079;</label>
<div class="right">
<select class="selectNorm" id="FilterIndex" name="FilterIndex">
<%
local max = 20
for i=1,max do
%>
<option value="<%=i%>" title='<%=i%>'><%=i%></option>
<%
end
%>
</select>
</div>
</div>
<div class="segmentRow">
</div>
<div class="row" id="Prefix_IpMode">
<label for="IPVersion" class="cfgLabel w180 ">&?InternetDE_019;</label>
<div class="right">
<select class="selectNorm" id="IPVersion" name="IPVersion">
<option value="-1" title="&?public_039;">&?public_039;</option>
<option value="4" title="&?public_100;">&?public_100;</option>
<option value="6" title="&?public_101;">&?public_101;</option>
</select>
</div>
</div>
<input type="hidden" id="SourceIPMask" value="">
<input type="hidden" id="DestIPMask" value="">
<div class="row">
<label for="SourceIPAddr" class="left w180">&?Security_082;</label>
<div class="right">
<input type="text" id="SourceIP" name="SourceIP" value="" class="inputNorm"/>
/
<input type="text" id="SMask" name="SourceIPMask" value="" class="w37"/>
</div>
</div>
<div class="row">
<label for="DestIPAddr" class="left w180">&?Security_083;</label>
<div class="right">
<input type="text" id="DestIP" name="DestIP" value="" class="inputNorm"/>
/
<input type="text" id="DMask" name="DestIPMask" value="" class="w37"/>
</div>
</div>
<input type="hidden" id="Protocol" value="">
<div class="row">
<label for="hiddenProtocol" class="cfgLabel w180">&?public_053;</label>
<div class="right">
<select class="selectNorm" id="hiddenProtocol" name="hiddenProtocol">
<option value="256" title="&?public_039;" portattr="0">&?public_039;</option>
<option value="1" title="&?public_038;" portattr="0">&?public_038;</option>
<option value="6" title="&?public_036;" portattr="1">&?public_036;</option>
<option value="17" title="&?public_037;" portattr="1">&?public_037;</option>
<option value="58" title="&?Security_075;" portattr="0">&?Security_075;</option>
<option value="257" title="&?public_040;" portattr="1">&?public_040;</option>
<option value="other" title="&?Security_080;" portattr="2">&?Security_080;</option>
</select>
</div>
</div>
<div class="row" id="textinput" style="display: none;">
<label for="inputProtocol" class="cfgLabel w180">&nbsp;</label>
<div class="right">
<input type="text" class="inputNorm" id="inputProtocol" name="inputProtocol" value="">
<span class="dTip" style="display: none;">&?public_072;-1 ~ 255</span>
</div>
</div>
<div class="bgColorRow" id="PortPara" style="display: none;">
<div class="row">
<label for="MinSrcPort" class="cfgLabel w180">&?Security_025;</label>
<div class="right">
<input type="text" class="port" id="MinSrcPort" name="MinSrcPort" value=""/>
<span class="dTip" style="display: none;">&?public_072;1 ~ 65535</span>
~
<input type="text" class="port" id="MaxSrcPort" name="MaxSrcPort" value=""/>
<span class="dTip" style="display: none;">&?public_072;1 ~ 65535</span>
</div>
</div>
<div class="row">
<label for="MinDstPort" class="cfgLabel w180">&?Security_027;</label>
<div class="right">
<input type="text" class="port" id="MinDstPort" name="MinDstPort" value=""/>
<span class="dTip" style="display: none;">&?public_072;1 ~ 65535</span>
~
<input type="text" class="port" id="MaxDstPort" name="MaxDstPort" value=""/>
<span class="dTip" style="display: none;">&?public_072;1 ~ 65535</span>
</div>
</div>
</div>
<div class="row" id="Ingress">
<label for="INCViewName" class="cfgLabel w180">&?Security_029;</label>
<div class="right">
<select class="selectNorm" id="INCViewName" name="INCViewName" >
<option value="">&?public_039;</option>
<%
cgilua.put(_G.CreateIFOpStr("IPFilter",nil,{"IPMode","WANServlist"}))
%>
</select>
</div>
</div>
<div class="row"id="Egress">
<label for="OUTCViewName" class="cfgLabel w180">&?Security_030;</label>
<div class="right">
<select class="selectNorm" id="OUTCViewName" name="OUTCViewName">
<option value="">&?public_039;</option>
<%
cgilua.put(_G.CreateIFOpStr("IPFilter",nil,{"IPMode","WANServlist"}))
%>
</select>
</div>
</div>
<div class="row" id="div_DSCP">
<label for="DSCP" class="cfgLabel w180">&?SNTP_009;</label>
<div class="right">
<input type="text" class="inputNorm" id="DSCP" name="DSCP" value=""/>
<span class="dTip" style="display: none;">&?public_072;0~63</span>
</div>
</div>
<div class="buttongroup">
<input type="button" class="Button Btn_cancel" id="Btn_cancel_IPFilter" name="Btn_cancel_IPFilter" value="&?public_019;" />
<input type="button" class="Button Btn_apply" id="Btn_apply_IPFilter" name="Btn_apply_IPFilter" value="&?public_018;" />
</div>
</div>
</div>
</form>
</div>
<div class="addInstBar AddContentContainer">
<span id="addInstBar_IPFilter" class="instNew addInst">&?public_098;</span>
</div>
</div>
</div>
