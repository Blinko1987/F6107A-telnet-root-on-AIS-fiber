<%
cgilua.lp.include("../../webmodules/modules/CPEAgent_js.lp", getfenv(1))
%>
<div id="AgentConf" class="HeadDIV">
<address style="display:none">
<span class="form-action">/?_type=menuData&_tag=CPEAgent_lua.lua</span>
</address>
<div class="externErrorHint" style="display:none;">
<span class="caption1"></span>
</div>
<h1 class="collapBarWithDataTrans" id="AgentConfBar">&?pro_CPEAgent_001;</h1>
<input type="hidden" id="DataHasBeenGot" value="0">
<div id="AgentConf_container">
<div id="template_AgentConf">
<form class="form_content">
<div id="changeArea_AgentConf" class="ChangeArea formTblWrap">
<div class="errorHint" style="display:none">
<span class="caption1"></span>
</div>
<div class="succHint" style="display:none">
<span class="caption1">&?public_021;</span>
</div>
<div class="formTbl locationchangge">
<div class="row">
<table class="aisAgentTable">
<tr>
<td class="td1">
<label class="cfgLabel w100">&?pro_CPEAgent_003;</label>
</td>
<td class="td2">
<label class="cfgLabel w100">&?pro_CPEAgent_004;</label>
</td>
<td>
<label class="cfgLabel w50">&?pro_CPEAgent_005;</label>
</td>
</tr>
<tr>
<td>
<input type="text" style="width:260px" id="FirstServer" name="FirstServer" value="">
</td>
<td>
<input type="text" class="w100" id="FirstIntervalTime" name="FirstIntervalTime" value="">&nbsp;sec
<span class="dTip" style="display: none;">Range: 1~86400</span>
</td>
<td class="tdCent">
<input type="radio" id="FirstServerEnable" name="FirstServerEnable" value="1">
</td>
</tr>
<tr>
<td colspan="3">
<label for="FirstServerStat">&?pro_CPEAgent_009;</label>
<input style="width:500px" class="inputstatus" id="FirstServerStat" value="">
</td>
</tr>
<tr style="height: 10px"></tr>
<tr>
<td>
<label class="cfgLabel w100">&?pro_CPEAgent_006;</label>
</td>
<td>
<label class="cfgLabel w100">&?pro_CPEAgent_004;</label>
</td>
<td>
<label class="cfgLabel w50">&?pro_CPEAgent_005;</label>
</td>
</tr>
<tr>
<td>
<input type="text" style="width:260px" id="SecondServer" name="SecondServer" value="">
</td>
<td>
<input type="text" class="w100" id="SecondIntervalTime" name="SecondIntervalTime" value="">&nbsp;sec
<span class="dTip" style="display: none;">Range: 1~86400</span>
</td>
<td class="tdCent">
<input type="radio" id="SecondServerEnable" name="SecondServerEnable" value="0">
</td>
</tr>
<tr>
<td colspan="3">
<label for="SecondServerStat">&?pro_CPEAgent_009;</label>
<input style="width:500px" class="inputstatus" id="SecondServerStat" value="">
</td>
</tr>
<tr style="height: 10px"></tr>
</table>
</div>
<div class="row">
<label class="cfgLabel w200">&?pro_CPEAgent_011;</label>
<div class="right">
<input id="SecretKeyVersion" type="text" class="inputLong">
</div>
</div>
<div class="row">
<label class="cfgLabel w200">&?pro_CPEAgent_012;</label>
<div class="right">
<input id="SecretKey" type="text" class="inputLong">
</div>
</div>
<div class="buttongroup">
<input type="button" class="Button Btn_apply" id="Btn_apply_aisagent"
name="Btn_apply_aisagent" value="&?public_018;" />
</div>
</div>
<span id="errortip" class="externErrorHint" style="display:none">&?pro_CPEAgent_010;</span>
<div class="row">
<label class="cfgLabel w320">&?pro_CPEAgent_007;</label>
<div class="row">
<button class="Button change" id="ImmediatelySend" value="0">&?pro_CPEAgent_008;</button>
</div>
<div class="Immediately">
<label for="ImmediatelySendStat">&?pro_CPEAgent_009;</label>
<input style="width:500px" class="inputstatus" id="ImmediatelySendStat" value="">
</div>
</div>
<div class="row"></div>
</div>
</form>
</div>
</div>
</div>
