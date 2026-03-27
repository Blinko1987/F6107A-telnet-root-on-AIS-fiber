<script type="text/javascript">
(function () {
function init_template_WLANStatus(template)
{
template.bind("fillDataByCustom", function(event, suffix, template){
var beaconTypeMAP = {
"Basic" : "&?public_113;",
"WPA" : "&?public_114;",
"11i" : "&?public_115;",
"WPAand11i" : "&?public_116;",
"None" : "&?public_059;"
};
var beaconType = $("[id^='BeaconType']", template).val();
var beaconTypeOBJ = $("[id^='S_BeaconType']", template);
var beaconTypeLang = beaconTypeMAP[beaconType];
beaconTypeOBJ.fillDataByType(beaconTypeLang);
var channel = $("[id^='ChannelInUsed']", template).val();
var channelOBJ = $("[id^='S_ChannelInUsed']", template);
if (channel == 0)
{
channel = "&?public_142;";
}
channelOBJ.fillDataByType(channel);
});
}
$(document).ready(function(){
var HeadID = "WLANStatus";
var Head = $("#"+HeadID);
var WLANStatusServerAddr = $("address span", Head).text();
var template = $("#template_"+HeadID);
init_template_WLANStatus(template);
Head.succfunction = function(xml){
if (Head.hasError(xml) == 0)
{
var CARDOBJ = $(xml).find("OBJ_WLANSETTING_ID");
var RuleNum = $("Instance", CARDOBJ).length;
var OBJID = ["OBJ_WLANCONFIGDRV_ID",
"OBJ_WLANAP_ID", "OBJ_WLANSETTING_ID"];
Head.fillDataByCustom = undefined;
Head.createPageDataByClone(RuleNum, OBJID, xml,
Head.fillDataByCustom);
}
};
if ( $(".collapBarWithDataTrans",Head).length <= 0 )
{
Head.dataTransfer(WLANStatusServerAddr, "GET", Head.succfunction);
}
else
{
initial_collapBarWithDataTrans(Head);
}
RefreshClickHandle(Head);
});
})();
</script>
