<%
cgilua_lp.include("../model/js/diagnosis_page_js.lp", getfenv(1))
%>
<div id="<%=page.id%>" class="HeadDIV" style="padding-top:0">
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
<div id="template_<%=page.id%>">
<div id="changeArea_<%=page.id%>" class="ChangeArea formTblWrap">
<div class="errorHint" style="display:none;">
<span class="caption1"></span>
</div>
<form class="form_content formTbl">
<input type="hidden" id="_InstID" value="">
<%=page.content%>
<div class="buttongroup">
<input type="button" class="Button Btn_<%=page.id%>" id="Btn_<%=page.id%>" name="Btn_<%=page.id%>" value="<%=page.buttonName%>" />
</div>
<div class="row">
<label class="cfgLabel <%=page.style%>"><%=page.areaLabel%></label>
</div>
<div class="textareaRow">
<textarea id="<%=page.areaId%>" value="" readonly="readonly"></textarea>
</div>
<div class="segmentRow"></div>
</form>
</div>
</div>
</div>
</div>
