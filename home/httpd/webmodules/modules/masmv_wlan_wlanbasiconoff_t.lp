<%
cgilua_lp.include("../../webmodules/modules/masmv_wlan_wlanbasiconoff_js.lp", getfenv(1))
%>
<div id="WlanBasicAdOnOff" class="HeadDIV">
<address style="display:none">
<span class="form-action">/?_type=menuData&_tag=masmv_wlan_wlanbasiconoff_lua.lua</span>
</address>
<h1 class="collapBarWithDataTrans" id="WlanBasicAdOnOffBar">&?WlanBasicAd_076;</h1>
<div id="WlanBasicAdOnOff_container">
<input type="hidden" id="DataHasBeenGot" value="0">
<div class="sceneTip">
<div class="sceneTipLink"><a>&?WlanBasic_020;</a></div>
<div class="sceneTip_container">
<p>&?public_085;</p>
<p class="sceneTip_close"><a>&?public_020;</a></p>
</div>
</div>
<div id="template_WlanBasicAdOnOff" class="formTblWrap" style="display:block;">
<div class="errorHint" style="display:none;">
<span class="caption1"></span>
</div>
<div class="succHint" style="display:none;">
<span class="caption1">&?public_021;</span>
</div>
<form class="form_content formTbl">
<input type="hidden" id="RadioStatus" value="">
<div class="row" id="div_TimerEnable">
<label for="TimerEnable" class="left w150">&?public_068;</label>
<div id="TimerEnable" class="right">
<input type="radio" id="TimerEnable1" name="TimerEnable" value="0"/>
<label for="TimerEnable1">&?WlanBasicAd_078;</label>
&nbsp;&nbsp;
<input type="radio" id="TimerEnable0" name="TimerEnable" value="1"/>
<label for="TimerEnable0">&?WlanBasicAd_052;</label>
</div>
</div>
<div id="TRCtl_WLANRadioStatus" style="display:none;">
<div class="row" id="div_WLANRadioStatus" style="display:none;">
<input type="hidden" id="_InstID" value="">
<input type="hidden" id="Band" value="">
<input type="hidden" id="LockStatusBase" value="" class="PostIgnore">
<label for="RadioStatus" class="left w150">&?WlanBasicAd_004;</label>
<div id="RadioStatus" class="right">
<input type="radio" id="RadioStatus0" name="RadioStatus" value="1"/>
<label for="RadioStatus0">&?public_033;</label>
&nbsp;&nbsp;
<input type="radio" id="RadioStatus1" name="RadioStatus" value="0"/>
<label for="RadioStatus1">&?public_034;</label>
</div>
</div>
</div>
<div id="TR_OnTime" style="display:none;">
<div class="row">
<label class="left w150">&?WlanBasicAd_053;</label>
<div class="right">
<select name="TimeStartHour" id="TimeStartHour" class="w80">
</select>&?public_011;&nbsp;
<select name="TimeStartMin" id="TimeStartMin" class="w80">
</select>&?public_012;
</div>
</div>
<div class="row">
<label class="left w150">&?WlanBasicAd_059;</label>
<div class="right">
<select name="TimeEndHour" id="TimeEndHour" class="w80">
</select>&?public_011;&nbsp;
<select name="TimeEndMin" id="TimeEndMin" class="w80">
</select>&?public_012;
</div>
</div>
</div>
<div class="buttongroup">
<input type="button" class="Button Btn_cancel" id="Btn_cancel_WlanBasicAdConf" name="Btn_cancel_WlanBasicAdConf" value="&?public_019;" />
<input type="button" class="Button Btn_apply" id="Btn_apply_WlanBasicAdConf" name="Btn_apply_WlanBasicAdConf" value="&?public_018;" style="display:none;"/>
<input type="button" class="Button" id="Btn_apply_WlanBasicAdConf_Confirm" name="Btn_apply_WlanBasicAdConf_Confirm" value="&?public_018;"/>
</div>
</form>
</div>
</div>
</div>
