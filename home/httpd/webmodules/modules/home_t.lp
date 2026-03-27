<%
cgilua_lp.include("../../webmodules/modules/home_js.lp", getfenv(1))
%>
<style type="text/css">
<%
cgilua_lp.include("../../public/css/home.css")
if require"common_lib.file_utils".isFileExist("../../public/css/pro_style.css") then
cgilua_lp.include("../../public/css/pro_style.css")
end
%>
</style>
<div id="homeWrapper">
<div id="WANInfo" class="WAN">
<div id="WANUrlWrapper" class="">
<span id="WANUrl" class="emColor">&?Home_002;</span>
</div>
</div>
<div id="fwArea">
<div id="WANLine" class="WANLine"></div>
<div id="firewall" class="fwOff">
<span id="FWUrl" class="emColor">&?Home_006;</span>
<a id="fwSwitchLink">
</a>
</div>
</div>
<div id="HGWArea">
<%if env.getenv("wifiSupport") ~= "0" then%>
<div id="WLANRadio" class="">&nbsp;</div>
<%end%>
<div id="HGW">&nbsp;</div>
</div>
<div id = "Hint_ejectOK" class="succHint" style="display:none;">
<span >&?Home_032;</span>
</div>
<div id = "Hint_ejectFAIL" class="errorHint" style="display:none;">
<span >&?Home_032;</span>
</div>
<div id="home_adev_area">
<div id="home_adev_top">
<div id="home_adev_name">&?Home_018;</div>
<div id="home_devlist_category">
<div id="home_category_name"></div>
<div id="home_category_setting" style="display: none"><a></a></div>
</div>
</div>
<div id="home_adev_middle">
<div id="home_category_area">
<%if env.getenv("wifiSupport") ~= "0" then%>
<div class="home_category_item">
<div class="home_categroy_name" id="home_category_wlan"><a>&?Home_003;</a></div>
</div>
<%end%>
<div class="home_category_item">
<div class="home_categroy_name" id="home_category_lan"><a>&?Home_010;</a></div>
</div>
<%if env.getenv("usbSupport") ~= "0" then%>
<div class="home_category_item">
<div class="home_categroy_name" id="home_category_usb"><a>&?Home_004;</a></div>
</div>
<%end%>
<%if env.getenv("voipSupport") ~= "0" then%>
<div class="home_category_item" id="home_phone">
<div class="home_categroy_name" id="home_category_phone"><a>&?Home_005;</a></div>
</div>
<%end%>
<div id="home_adev_pointer" style="display: none"></div>
</div>
<div id="home_devlist_area">
<div id="home_devlist_table">
<div id="home_devlist_head" class="home_devlist_item">
<span class="home_devitem_para" title="">&nbsp;</span>
<span class="home_devitem_para" title="">&nbsp;</span>
<span class="home_devitem_para" title="">&nbsp;</span>
<span class="home_devitem_para" title="">&nbsp;</span>
</div>
<div id="home_devitem">
<div id="template_home_devitem" class="home_devlist_item" style="display: none">
<span class="home_devitem_para" id="" title=""></span>
<span class="home_devitem_para" id="" title=""></span>
<span class="home_devitem_para" id="" title=""></span>
<span class="home_devitem_para" id="" title=""></span>
</div>
</div>
</div>
<div id="home_devlist_foot">
<div id="home_devlist_more">
<a id="devlist_more" style="display:none;">&?Home_026;</a>
<%
if "66" == CountryCode then
%>
<input type="button" class="Button Btn_apply" id="Btn_apply_UsbEject" name="Btn_apply_UsbEject" value=&?public_160; >
<% end %>
</div>
</div>
</div>
</div>
<div id="home_adev_bottom"></div>
</div>
<div id="cmapiErr">
<div id="wanErr">
<div class="errorHint" style="display:none;">
<span class="caption1">Warning! WAN cmapi error</span>
</div>
</div>
<div id="wlanErr">
<div class="errorHint" style="display:none;">
<span class="caption1">Warning! WLAN cmapi error</span>
</div>
</div>
<div id="lanErr">
<div class="errorHint" style="display:none;">
<span class="caption1">Warning! LAN cmapi error</span>
</div>
</div>
<div id="usbErr">
<div class="errorHint" style="display:none;">
<span class="caption1">Warning! USB cmapi error</span>
</div>
</div>
<div id="voipErr">
<div class="errorHint" style="display:none;">
<span class="caption1">Warning! VoIP cmapi error</span>
</div>
</div>
<div id="fwErr">
<div class="errorHint" style="display:none;">
<span class="caption1">Warning! Firewall cmapi error</span>
</div>
</div>
</div>
<div id="ajaxErrArea" class="errorHint" style="display:none;">
<span class="caption1"></span>
</div>
</div>
<script type="text/javascript">
MenuShow("ClassOne", "Home_t.lp", "mmHome");
</script>
