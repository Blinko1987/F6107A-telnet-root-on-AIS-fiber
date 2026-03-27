<%
cgilua_lp.include("../template/common_eventtriggering.lp",getfenv(1))
local sess_id = cgilua.getCurrentSessID()
local Menu3Location = cgilua.QUERY.Menu3Location
if Menu3Location ~= nil then
session_set(sess_id, "Menu3Location",Menu3Location)
end
local model = require("model.modelParse")
local handleViewRequest = model.handleViewRequest
local token = cmapi.nocsrf.tokenRandom()
session_set(sess_id, "sess_token", token)
local nextpage = session_get(sess_id, "nextpage");
local loginName = session_get(sess_id, "login_name")
local supId, midId, thdId = "", "", ""
local pageObj = menutree:findMenu(nextpage)
local parentObj = pageObj.__parentMenu
local DisablePage = pageObj:getAttribute("extData2")
if DisablePage == nil then
DisablePage = 0
elseif tonumber(DisablePage) == nil then
local right,name = string.match(DisablePage,"(%d+)%:(%a+)")
if name == loginName then
DisablePage = right
else
DisablePage = 0
end
end
local DisableArea
if parentObj == menutree.__root then
supId = pageObj:getAttribute("id")
else
local grandPaObj = parentObj.__parentMenu
if grandPaObj == menutree.__root then
supId = parentObj:getAttribute("id")
midId = pageObj:getAttribute("id")
else
supId = grandPaObj:getAttribute("id")
midId = parentObj:getAttribute("id")
thdId = pageObj:getAttribute("id")
end
end
%>
<div id="_MenuInfo" style="display:none;">
<div id="_NextPageInfo"><%=_G.encodeHTML(nextpage)%></div>
<div id="_NowSupIdInfo"><%=_G.encodeHTML(supId)%></div>
<div id="_NowMidIdInfo"><%=_G.encodeHTML(midId)%></div>
<div id="_NowThdIdInfo"><%=_G.encodeHTML(thdId)%></div>
<div id="_Menu3Location"><%=_G.encodeHTML(session_get(sess_id, "Menu3Location"))%></div>
</div>
<%
local filedir = ""
if _G.commConf.oneWholePage[nextpage] ~= nil then
filedir = "../../webmodules/modules/" .. _G.commConf.oneWholePage[nextpage]
end
if filedir ~= "" then
cgilua_lp.include(filedir, getfenv(1))
elseif nextpage == "homePage" then
local pageAreas = pageObj.__areas
local targetAreaPage= "home_t.lp"
pageObj:searchCollection(pageAreas, function ( item, index )
targetAreaPage = item:getAttribute("area")
end)
if targetAreaPage ~= "home_t.lp" then
cgilua_lp.include("../../webmodules/modules/".. targetAreaPage,getfenv(1))
else
cgilua_lp.include("../../webmodules/modules/home_t.lp",getfenv(1))
local libUtil = require("common_lib.file_utils")
if libUtil.isFileExist("../../webmodules/modules/home_t_modifier.lp") then
cgilua_lp.include("../../webmodules/modules/home_t_modifier.lp", getfenv(1))
end
end
elseif nextpage == "mmTopology" then
cgilua_lp.include("../../webmodules/modules/topo_t.lp",getfenv(1))
else
%>
<div id="commLeft">
<div id="class2Menu" class="class2Menu">
<ul id="class2MenuItem" class="">
</ul>
</div>
</div>
<div id="commRight">
<input id='_totalTabWidth' type='hidden' value=''>
<div id="class3Menu">
<div id="scrollLeftBtn" class="scrollLeftBtn"><p ></p></div>
<div id="class3MenuMainContent">
<ul></ul>
</div>
<div id="scrollRightBtn" class="scrollRightBtn"><p></p></div>
</div>
<div class="tabContent">
<div id="pageIntroduce" class="pageIntroduce">
<span>&?public_014;</span>
</div>
<%if _G.commConf.helpNoEncode == true then%>
<p class="pIntroContent"><%=pageObj:getAttribute("pageHelp")%></p>
<%else%>
<p class="pIntroContent"><%=_G.encodeHTML(pageObj:getAttribute("pageHelp"))%></p>
<%end%>
<div id="childPage">
<div class="instCfgArea">
<%
local areaViewFiles = renderFiles
pageObj:searchCollection(areaViewFiles, function ( item, index )
local areafile = item.file
local startIndex = string.find(areafile, "%_m.lua$")
local modelIndex = string.find(areafile, "%_model.lua$")
if startIndex then
local util = require("data_assemble.util")
areafile = util.strippath(areafile)
local areaObj = pageObj:findArea(areafile)
local DisableArea = areaObj:getAttribute("extData2")
if DisableArea == Right then
%>
<div id="AreaHideAttr" style="display:none;"> <%=_G.encodeHTML(DisableArea)%></div>
<%
end
local modelName = remove_suffix_filename(areafile)
doModelViewRender(modelName, getfenv(1))
elseif modelIndex then
local util = require("data_assemble.util")
areafile = util.strippath(areafile)
local areaObj = pageObj:findArea(areafile)
local DisableArea = areaObj:getAttribute("extData2")
if DisableArea == Right then
%>
<div id="AreaHideAttr" style="display:none;"> <%=_G.encodeHTML(DisableArea)%></div>
<%
end
local modelName = remove_suffix_filename(areafile)
handleViewRequest(modelName,getfenv(1))
else
local libUtil = require("common_lib.file_utils")
local areaObj = pageObj:findArea(libUtil.strippath(areafile))
local DisableArea = areaObj:getAttribute("extData2")
if DisableArea == Right then
%>
<div id="AreaHideAttr" style="display:none;"> <%=_G.encodeHTML(DisableArea)%></div>
<%
end
local premodifierPage = libUtil.stripextension(areafile) .. "_premodifier.lp"
if libUtil.isFileExist(premodifierPage) then
cgilua_lp.include(premodifierPage, getfenv(1))
end
cgilua_lp.include(areafile, getfenv(1))
local modifierPage = libUtil.stripextension(areafile) .. "_modifier.lp"
if libUtil.isFileExist(modifierPage) then
cgilua_lp.include(modifierPage, getfenv(1))
end
end
end)
%>
</div>
</div>
</div>
</div>
<%
end
%>
<script type="text/javascript">
$(document).ready(function(){
if(<%=DisablePage%>)
{
if(<%=Right%> == <%=DisablePage%>)
{
$("input,texteare,select").attr("disabled",true).attr("hideattr",true);
$("[class^='Button']").addClass("disableBtn");
$("[class^='longBtn']").addClass("disableBtn");
$("[class^='instDelete Btn_delete']").remove();
$("[class^='addInstBar AddContentContainer']").remove();
$("[id^='Btn_cancel_'],[id^='Btn_apply_']").unbind();
$("[class^='Button Btn_refresh']").removeClass("disableBtn").attr("disabled",false);
}
}
_sessionTmpToken = "<%=_G.encodeJS(session_get(sess_id, "sess_token"))%>";
var childPage = $("#childPage");
var HeadDIVList = $(".HeadDIV", childPage);
var FstHeadDIV = HeadDIVList.eq(0);
var collapBarToUnfold = $(".collapBarWithDataTrans",FstHeadDIV).eq(0);
var containerMainID = FstHeadDIV.attr("id") + "_container";
var UnderControlContainer = $("#"+containerMainID, FstHeadDIV);
g_runElementControl(HeadDIVList);
if ( UnderControlContainer.is(":hidden") )
{
$(".collapBarWithDataTrans",FstHeadDIV).eq(0).click();
}
});
</script>
