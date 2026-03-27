<%
cgilua_lp.include("../model/js/single_page_js.lp", getfenv(1))
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
<div id="template_<%=page.id%>">
<div id="changeArea_<%=page.id%>" class="ChangeArea formTblWrap">
<div class="errorHint" style="display:none;">
<span class="caption1"></span>
</div>
<div class="succHint" style="display:none;">
<span class="caption1">&?public_021;</span>
</div>
<form class="form_content formTbl">
<input type="hidden" id="_InstID" value="">
<%=page.content%>
<div class="buttongroup">
<input type="button" class="Button Btn_cancel" id="Btn_cancel_<%=page.id%>" name="Btn_cancel_<%=page.id%>" value="&?public_019;" />
<input type="button" class="Button Btn_apply" id="Btn_apply_<%=page.id%>" name="Btn_apply_<%=page.id%>" value="&?public_018;" />
</div>
</form>
</div>
</div>
</div>
</div>
