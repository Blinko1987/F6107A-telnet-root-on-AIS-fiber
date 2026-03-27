<script type="text/javascript">
(function () {
var rootPath = "";
var g_open = 0;
var g_path = "";
var g_file = "";
var g_browseIndex = "";
var paths = new Array();
var files = new Array();
var xmlhttp;
function loadXMLDoc(url, index)
{
g_browseIndex = index;
$.get(url, function(result){
if (typeof(result) == "undefined")
{
alert("&?DMS_015;");
return;
}
if(result.indexOf("<IF_ERRORSTR>SessionTimeout</IF_ERRORSTR>") != -1)
{
top.location.href = top.location.href;
return 0;
}
if ( "/" == result.charAt(1) )
{
result=result.substring(1,result.length);
}
if(result.charAt(0) == '|')
{
alert("&?DMS_015;");
return;
}
openNewDiv("DMSPathSelectDiv", result);
});
}
function prepareOpenNewDiv(str)
{
var msg = "";
g_open = "1";
g_path = str.substring(0, str.indexOf("|"));
if(g_path.length > 0)
{
if(g_path.charAt(g_path.length - 1) != '/')
{
g_path = g_path + "/";
}
}
g_file = str.substring(str.indexOf("|") + 1, str.length);
if(g_file.length > 0)
{
if(g_file.charAt(g_file.length - 1) != '/')
{
g_file = g_file + "/";
}
}
}
function prepareCloseNewDiv()
{
g_file = "";
g_open = "0";
files.length = 0;
paths.length = 0;
$("#DMSPathSelectDiv").remove();
IsDisableButton(false);
}
var tempStr = "";
function getPathOrFile()
{
var pathStr = "";
pathStr = tempStr.substring(0, tempStr.indexOf("/"));
tempStr = tempStr.substring(tempStr.indexOf("/") + 1, tempStr.length);
return pathStr;
}
function setPath()
{
g_path = "";
for(var i = 0; i < paths.length; i++)
{
if('/' != g_path.charAt(g_path.length - 1) && '/' != paths[i].charAt(0))
{
g_path = g_path + "/";
}
g_path = g_path + paths[i];
}
$("#Path"+g_browseIndex).val(g_path);
}
function changeDir(hierarchy)
{
if(hierarchy == paths.length - 1)
{
return;
}
var url = "/?_type=menuData&_tag=dms_querydir_lua.lua&querydir=";
g_path = rootPath;
for(var i = 1; i <= hierarchy; i++)
{
if('/' != g_path.charAt(g_path.length - 1))
{
g_path = g_path + "/";
}
g_path = g_path + encodeURIComponent(paths[i]);
}
if('/' != g_path.charAt(g_path.length - 1))
{
g_path = g_path + "/";
}
url = url + g_path;
prepareCloseNewDiv();
loadXMLDoc(url, g_browseIndex);
}
window.changeDir = changeDir;
function cdDir(hierarchy)
{
var url = "/?_type=menuData&_tag=dms_querydir_lua.lua&querydir=";
g_path = rootPath;
for(var i = 1; i < paths.length; i++)
{
if('/' != g_path.charAt(g_path.length - 1))
{
g_path = g_path + "/";
}
g_path = g_path + encodeURIComponent(paths[i]);
}
if('/' != g_path.charAt(g_path.length - 1))
{
g_path = g_path + "/";
}
g_path = g_path + encodeURIComponent(files[hierarchy]) + "/";
url = url + g_path;
prepareCloseNewDiv();
loadXMLDoc(url, g_browseIndex);
}
window.cdDir = cdDir;
function getHref(id, strmethod, str, css)
{
return ("<a" + ' '+ "href=\"javascript:void(0)\" class=\"hreftext " + css + "\" onmouseup=\""+ strmethod + "\" id=\""
+ id + "\">" + str+ "</a>&nbsp;&nbsp;");
}
function popNewDiv(divID)
{
var newDiv = document.createElement("div");
newDiv.id = divID;
newDiv.className = "DMSPathDiv";
$(".formTbl").append(newDiv);
}
function showFile(divID)
{
var newDiv = document.getElementById(divID);
tempStr = g_file;
if(g_file.length > 0)
{
var file = "file";
while(tempStr.length != 0)
{
var fileStr = getPathOrFile();
if(fileStr.length == 0)
{
return;
}
files.push(fileStr);
hierarchy = files.length - 1;
strmethod = "cdDir(" + hierarchy + ")";
var newFile = document.createElement(file + hierarchy);
newFile.innerHTML = getHref(file + hierarchy, strmethod, fileStr,"");
newFile.innerHTML = "<p>" + newFile.innerHTML + "</p>";
newDiv.appendChild(newFile);
}
}
}
function showPath(divID)
{
var path = "path";
var newDiv = document.getElementById(divID);
var num = 0;
var pathStr = rootPath;
var rootPathLen = 0;
if("/" == rootPath)
{
rootPathLen = 1;
}
else
{
rootPathLen = rootPath.length + 1;
}
tempStr = g_path;
paths.length = 0;
var newPath = document.createElement(path);
newPath.innerHTML = "<label>"+"&?DMS_013;"+"</label>";
newDiv.appendChild(newPath);
paths.push(pathStr);
var hierarchy = 0;
var strmethod = "changeDir(" + hierarchy + ")";
newPath.innerHTML += getHref(path, strmethod, pathStr,"");
newDiv.appendChild(newPath);
tempStr = tempStr.substring(rootPathLen, tempStr.length);
while(tempStr.length != 0)
{
pathStr = getPathOrFile();
if(pathStr.length == 0)
{
break;
}
paths.push(pathStr);
hierarchy = paths.length - 1;
strmethod = "changeDir(" + hierarchy + ")";
newPath = document.createElement(path + hierarchy);
newPath.innerHTML = "/";
newPath.innerHTML += getHref(path + hierarchy, strmethod, pathStr,"");
newDiv.appendChild(newPath);
}
}
function showButton(divID)
{
var newDiv = document.getElementById(divID);
var newSelect = document.createElement("button");
newSelect.className = "Button BrowseBtn";
newSelect.innerHTML = "&?DMS_011;";
newSelect.onclick = function()
{
setPath();
prepareCloseNewDiv();
return false;
}
newDiv.appendChild(newSelect);
var newNbsp = document.createElement("e");
newNbsp.innerHTML = "&nbsp;&nbsp;";
newDiv.appendChild(newNbsp);
var newQuit = document.createElement("button");
newQuit.className = "Button BrowseBtn";
newQuit.innerHTML = "&?DMS_012;";
newQuit.onclick = function()
{
prepareCloseNewDiv();
return false;
}
var newDiv = document.getElementById(divID);
newDiv.appendChild(newQuit);
var newBr = document.createElement("d");
newBr.innerHTML = "<br/>";
document.getElementById(divID).appendChild(newBr);
}
function IsDisableButton(Tag)
{
$("input[class^=Button]",$(".formTbl")).each(function(){
var obj = $(this);
if(true==Tag)
{
obj.addClass("disableBtn");
}
else
{
obj.disableButton(false);
}
});
}
function openNewDiv(divID, str)
{
prepareOpenNewDiv(str);
if ($("#"+divID).length)
{
$("#"+divID).remove();
}
IsDisableButton(true);
popNewDiv(divID);
if(g_path != rootPath)
{
showPath(divID);
}
var newBr = document.createElement("d");
newBr.innerHTML = "<br/>";
document.getElementById(divID).appendChild(newBr);
var newHR=document.createElement("hr");
newHR.className = "hr0";
document.getElementById(divID).appendChild(newHR);
showFile(divID);
showButton(divID);
}
jQuery.validator.addMethod(
"PathMatch",
function(value, element, params) {
if(value.match("[|:*?\"<>]") != null || value.indexOf("\\") != -1)
{
return false;
}
return true;
},
"&?DMS_010;"
);
function initial_template_DMS(templateID)
{
template = $("#"+templateID);
var PathCheckRules = {
"utf8": true,
"PathMatch":true,
"utf8LengthRange":[0,255]
};
var instForm = template.find("form");
instForm.validate({
"rules": {
"DmsName": {
"ASCII": true,
"required": true,
"rangelength":[1,128]
},
"RescanTimeValue": {
"integer": true,
"required": true,
"range":[1,1440]
},
"Path0": PathCheckRules,
"Path1": PathCheckRules,
"Path2": PathCheckRules,
"Path3": PathCheckRules
},
"messages": {
}
});
template.bind("fillDataByApplyResult", function(event,xml, template){
ActionByApplyResult(xml, template);
});
template.bind("fillDataByCancelResult", function(event,xml, template){
var templateID = template.attr("id");
var isError = template.hasError(xml);
if (isError == 0)
{
var OBJID = ["OBJ_DMS_ID"];
ChanegeDataByCustom(xml);
template.fillDataByOBJID(xml ,OBJID, template,0);
$("#RescanTime").change();
}
});
template.bind("PostDataChangeByCustom", function(event, NameValueJson){
var ElemsID = NameValueJson.ElemsMainID;
if (ElemsID == "ContentList")
{
var contentList = "";
var subpath = "";
for(var i = 0; i < 4; i++)
{
subpath = $("#Path"+i).val();
if("" != subpath)
{
contentList = contentList + subpath + "|";
}
}
NameValueJson.ElemsValue = contentList;
}
if(ElemsID == "RescanTime")
{
if("1" == NameValueJson.ElemsValue)
{
NameValueJson.ElemsValue = $("#RescanTimeValue").val();
}
}
});
$("#RescanTime").change(function(){
var RescanTimeValue = $("#RescanTime").val();
if("1"==RescanTimeValue)
{
$("#TR_RescanTimeValue").slideDown();
$("#TR_RescanTimeValue").removeClass("PostIgnore");
}
else
{
$("#TR_RescanTimeValue").hide();
$("#TR_RescanTimeValue").addClass("PostIgnore");
}
var TimeValue = $("#RescanTimeValue").val();
if("" != TimeValue)
{
instForm.validate().element($("#RescanTimeValue"));
}
});
$("[id^='Browse']").click(function(){
if ($(this).hasClass("disableBtn"))
{
return;
}
var DMSURL = "";
var index = "";
var ElemsID=$(this).attr("id");
index = ElemsID.substring(ElemsID.length-1,ElemsID.length);
DMSURL = "/?_type=menuData&_tag=dms_querydir_lua.lua&querydir=" + rootPath;
if('/' != DMSURL.charAt(DMSURL.length - 1))
{
DMSURL = DMSURL + "/";
}
loadXMLDoc(DMSURL, index);
});
}
function ChanegeDataByCustom(xml)
{
var ToOperParaArr = {
"PathRoot" : {ValueOrigin: ""},
"RescanTime" : {
ValueOrigin: "",
setAction: function(ParaNameSel, ParaValSel, SelfVal){
if( ("-1" != SelfVal) && ("0" != SelfVal) )
{
$("#RescanTimeValue").val(SelfVal);
ParaValSel.text("1");
}
}
},
"ContentList" : {ValueOrigin: ""}
};
xmlParaInInstOperate(xml, "OBJ_DMS_ID", 0, ToOperParaArr);
rootPath = ToOperParaArr.PathRoot.ValueOrigin;
if ( "" == rootPath )
{
rootPath = "/";
}
g_path = rootPath;
var contentList = ToOperParaArr.ContentList.ValueOrigin;
$("input[id^='Path']",$(".form_content")).each(function(){
var obj = $(this);
obj.val("");
});
if('|' == contentList.charAt(0))
{
contentList = contentList.substring(1, contentList.length);
}
for(var i = 0; (i < 4) && (contentList != ""); i++)
{
if(-1 == contentList.indexOf("|"))
{
$("#Path"+i).val(contentList);
break;
}
else
{
var pathStr = contentList.substring(0, contentList.indexOf("|"));
$("#Path"+i).val(pathStr);
contentList = contentList.substring(contentList.indexOf("|") + 1,
contentList.length);
}
}
};
$(document).ready(function(){
var HeadID = "DMS";
var Head = $("#"+HeadID);
var templateID = "template_"+ HeadID;
var ServerAddr = $("address span", Head).text();
initial_template_DMS(templateID);
Head.succfunction = function(xml){
Head.hasError(xml,"externErrorHint");
ChanegeDataByCustom(xml);
var OBJID = ["OBJ_DMS_ID"];
Head.fillDataByOBJID(xml, OBJID, $("#DMS_container"), 0);
$("#RescanTime").change();
};
if ( $(".collapBarWithDataTrans",Head).length <= 0 )
{
Head.dataTransfer(ServerAddr,
"GET",
Head.succfunction);
}
else
{
initial_collapBarWithDataTrans(Head);
}
})
})();
</script>
