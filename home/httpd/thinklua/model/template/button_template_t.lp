<%
cgilua_lp.include("../model/js/button_page_js.lp", getfenv(1))
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
<div id="<%=page.id%>_container" class="formTblWrap">
<input type="hidden" id="DataHasBeenGot" value="1">
<input type="hidden" id="Msg">
<div id="template_<%=page.id%>" class="formTbl">
<%=page.content%>
<div class="errorHint" style="display:none;">
<span class="caption1"></span>
</div>
<div class="unfloatBtnGroup">
<input type="button" class="Button <%=page.style%> <%=page.action%>" id="<%=page.action%>" name="<%=page.action%>" value="<%=page.actionName%>" />
</div>
</div>
</div>
</div>
