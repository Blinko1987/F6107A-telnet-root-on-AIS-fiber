<%
cgilua_lp.include("../model/js/status_page_js.lp", getfenv(1))
%>
<div id="<%=page.id%>" class="HeadDIV">
<address style="display:none">
<span class="form-action">/?_type=menuData&_tag=<%=page.dataFile%></span>
</address>
<div class="externErrorHint" style="display:none;">
<span class="caption1"></span>
</div>
<%if #page.title > 0 then%>
<h1 class="collapBarWithDataTrans" id="<%=page.id%>Bar"><%=page.title%></h1>
<%end%>
<div id="<%=page.id%>_container">
<input id="DataHasBeenGot" type="hidden" value="0">
<div class="errorHint" style="display:none;">
<span class="caption1"></span>
</div>
<div class="noDataHint" style="display:none;">
<span>&?public_023;</span>
</div>
<div id="template_<%=page.id%>" class="colorTbl" style="<%=page.display%>">
<%=page.content%>
</div>
<div class="buttongroup">
<input type="button" class="Button Btn_refresh" id="Btn_refresh_<%=page.id%>" name="Btn_refresh_<%=page.id%>" value=&?public_003; />
</div>
</div>
</div>
