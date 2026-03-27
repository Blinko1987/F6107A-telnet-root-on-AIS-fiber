<div id="commPageContainer" class="commPageContainer">
<script type="text/javascript">
<%
cgilua_lp.include("../template/commpage_status_comm.lp", getfenv(1))
%>
</script>
<%
cgilua_lp.include("../template/subcommonpageFrame.lp", getfenv(1))
%>
</div>
<div id="sideShortCut" class="sideShortCut" style="display:none;">
<a id="BackToTop" class="BackToTop" titile="TOP"></a>
</div>
<script type="text/javascript">
var _MenuInfo = $("#_MenuInfo");
var NowNextpage = $("#_NextPageInfo",_MenuInfo).text();
var NowSupId = $("#_NowSupIdInfo",_MenuInfo).text();
var NowMidId = $("#_NowMidIdInfo",_MenuInfo).text();
var NowThdId = $("#_NowThdIdInfo",_MenuInfo).text();
MenuShow("ClassAll", NowNextpage, NowSupId, NowMidId, NowThdId);
$('#sideShortCut').click(function(){
$(document).scrollTop(0);
});
function showTopAnchor()
{
var distanceFromTop = $(document).scrollTop();
if( distanceFromTop > 135 )
{
if ("1"[0])
{
$('#sideShortCut').show();
}
}
else
{
$('#sideShortCut').hide();
}
}
$(window).scroll(function(){
showTopAnchor();
});
</script>
