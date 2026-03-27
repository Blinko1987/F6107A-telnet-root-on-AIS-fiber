<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=&?CHARSET;"/>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<link rel="shortcut icon" href="/img/favicon.ico" />
<title><%=_G.encodeHTML(env.getenv("WEBTitle"))%></title>
<style type="text/css">
<%
local getfenv,require,encodeHTML = _G.getfenv,_G.require,_G.encodeHTML
local sessmgr = require("user_mgr.session_mgr")
local usermgr = require("user_mgr.usermgr_logic_impl")
local token = cmapi.nocsrf.tokenRandom()
sessmgr.SetCurrentSessAttr("sess_token", token)
cgilua_lp.include("../../public/css/template.css")
cgilua_lp.include("../../public/css/commonpage.css")
%>
.title1 {font-family:Arial;font-weight:black;font-size:21px;line-height:27px;}
.title2 {font-family:Arial;font-weight:bold;font-size:21px;line-height:27px;color:#008DEF;}
.title3 {font-family:Arial;font-weight:bold;font-size:18px;line-height:24px;}
.title5 {font-family:Arial;font-weight:regular;font-size:16px;line-height:24px;}
.title6 {font-weight:regular;font-size:21px;line-height:24px;float:left;margin-top:1%; width:100%;text-align: center; }
.title7 {font-weight:regular;font-size:21px;line-height:24px;float:left;margin-top:1%; width:100%;text-align: center; }
.title8 {font-weight:bold;font-size:21px;line-height:24px;float:left;margin-top:3%; width:100%;text-align: center; color:#FF0000; }
.title9 {font-weight:regular;font-size:14px;line-height:24px;float:left;margin-top:3%;margin-left:30%; width:40%;text-align: center; }
.input {font-family:Arial;font-weight:regular;font-size:16px;line-height:24px;border:1px solid #bfbfbf;}
.button {background:#008DEF;border-radius:30px;font-family:Arial;font-weight:bold;font-size:15px;line-height:18px;}
.blue {color:#008DEF;}
.red {color:#FF0000;}
</style>
<script type="text/javascript" src="jquery/jquery.min.js"></script>
<script type="text/javascript" src="jquery/crypto-js.min.js"></script>
<script type="text/javascript" src="jquery/jsencrypt.min.js"></script>
<script type="text/javascript" src="jquery/common_lib.js"></script>
<script type="text/javascript">
var _sessionTmpToken = "<%=_G.encodeJS(session_get(sess_id, "sess_token"))%>";
<%
cgilua_lp.include("../../thinklua/template/template_menu_js.lp",getfenv(1))
cgilua_lp.include("../../thinklua/template/template_help_js.lp",getfenv(1))
cgilua_lp.include("../../thinklua/template/jquery_validate_extjs.lp",getfenv(1))
cgilua_lp.include("../../thinklua/template/commpage_status_comm.lp",getfenv(1))
%>
</script>
</head>
<body>
<div id="page_container">
<div id="page_header">
<div id="banner">
<div id="logo" class="logo"></div>
<div id="banner_switchArea">
<div class="type" style="">
<select id="languageId">
<option value="ES">ES</option>
<option value="EU">EU</option>
<option value="GL">GL</option>
<option value="CAT">CAT</option>
</select>
</div>
</div>
</div>
</div>
<div id="page_content">
<div id="SNPwd" class="HeadDIV">
<address style="display:none">
<span class="form-action">/?_type=hiddenData&_tag=mirrorcfg_data</span>
</address>
<div class="externErrorHint" style="display:none;">
<span class="caption1"></span>
</div>
<div id="SNPwd_container" >
<div id="template_SNPwd">
<div id="changeArea_SNPwd" class="ChangeArea">
<div class="errorHint" style="display:none;">
<span class="caption1"></span>
</div>
<div class="row">
<span class="title1" id="span1">Bienvenido a la instalación del equipo</span>
</div>
<div class="row">
<span class="title2" id="span2">ZTE ZXHN <%=_G.encodeHTML(env.getenv("WEBTitle"))%></span>
</div>
<br>
<div class="row">
<span class="title3" id="span3">Introduce la clave que encontrás en la documentación que te hemos enviado junto con el equipamiento</span>
</div>
<form class="form_content formTbl">
<input type="hidden" id="_InstID" value="-1">
<div class="row">
<span class="title5" id="span5">Introduce la clave</span>
</div>
<div class="row">
<div>
<input type="text" id="Ridpw" name="Ridpw" value="" class="input" />
</div>
</div>
<br>
<div class="row">
<input type="button" class="button" id="Btn_apply_SNPwd" name="Btn_apply_SNPwd" value="Continuar"/>
</div>
</form>
</div>
<div id="timesDiv">
<span id="span6" class="title6">Configurando la conexión a Internet.</span>
<div class="title7" >
<span id="span7">Este proceso tardará</span>
<span id="showtime" class="blue">60</span>
<span id="span8"> segundos.</span>
</div>
<br>
<span id="span9" class="title8">No desconectes el dispositivo</span>
</div>
<div id="internetOkDiv" style = "display:none">
<div class="row">
<span id="span10" class="title6">¡Configuración realizada con éxito!</span>
</div>
<div class="row">
<span id="span11" class="title9">Ya deberías poder navegar por Internet. Consulta el manual para continuar con la instalación.</span>
</div>
</div>
</div>
</div>
</div>
</div>
</div>
</body>
</html>
<script language="javascript">
var timeleft = 59;
var oneInt;
var languageText =
{
ES:
{
span1:"Bienvenido a la instalación del equipo",
span2:"Continuar",
span3:"Introduce la clave que encontrás en la documentación que te hemos enviado junto con el equipamiento",
span5:"Introduce la clave",
span6:"Configurando la conexión a Internet.",
span7:"Este proceso tardará ",
span8:" segundos.",
span9:"No desconectes el dispositivo",
span10:"¡Configuración realizada con éxito!",
span11:"Ya deberías poder navegar por Internet. Consulta el manual para continuar con la instalación."
},
EU:
{
span1:"Ongi etorri ekipoaren instalaziora",
span2:"Jarraitu",
span3:"Sartu gakoa; ekipamenduarekin batera bidali dizugun dokumentazioan dago",
span5:"Sartu gakoa",
span6:"Interneteko konexioa konfiguratzen.",
span7:"Prozesu honek ",
span8:" segundo beharko ditu.",
span9:"Ez deskonektatu gailua",
span10:"Konfigurazioa behar bezala burutu da!",
span11:"Interneten nabigatzeko moduan egon behar zenuke. Kontsultatu eskuliburua instalatzen jarraitzeko."
},
GL:
{
span1:"Benvido á instalación do equipo",
span2:"Continuar",
span3:"Introduce a chave que atoparás na documentación que che enviamos xunto co equipamento",
span5:"Introduce a chave",
span6:"Configurando a conexión a Internet.",
span7:"Este proceso tardará ",
span8:" segundos.",
span9:"Non desconecte o dispositivo",
span10:"Configuración realizada con éxito!",
span11:"Xa debería poder navegar por Internet. Consulte o manual para continuar coa instalación."
},
CAT:
{
span1:"Benvingut a la instal·lació de l'equip",
span2:"Continua",
span3:"Introdueix la clau que trobaràs en la documentació que t'hem enviat amb l'equip",
span5:"Introdueix la clau",
span6:"S’està configurant la connexió a Internet.",
span7:"Aquest procés tardarà ",
span8:" segons.",
span9:"No desconnectis el dispositiu",
span10:"Configuració realitzada amb èxit!",
span11:"Ja hauries de poder navegar per Internet. Consulta el manual per continuar amb la instal·lació."
},
ErrorStr:
{
error1:"Password cannot be empty, please input again.",
error2:"Please make the length of characters within 1-10 ",
error3:"Please input legal characters"
}
}
function Changelang()
{
var langValue = getValue("languageId");
for(var i = 1;i < 12; i++)
{
var spanId="span"+i;
var spanStr=languageText[langValue][spanId];
if(i!=2 && i!=4)
getObj(spanId).innerHTML = spanStr;
else if(i==2)
setValue("submit",spanStr);
}
}
function startRegister(xml, template, TitleValueReferID)
{
var isError = template.hasError(xml);
if (isError == 0)
{
$("#showtime").html("60");
$("#internetOkDiv").hide();
$("#timesDiv").show();
$("#changeArea_SNPwd").hide();
timeleft = 59;
oneInt = window.setInterval(function(){uploadTimes();},1000);
}
}
function initial_template_SNPwd(templateID)
{
var template = $("#"+templateID);
var instForm = template.find("form");
instForm.validate({
"rules": {
"Ridpw": {
"required":true,
"ASCII": true,
"rangelength":[1,10]
}
},
"messages": {
}
});
template.bind("callbackBySetPwd", function(event,xml, template){
startRegister(xml, template);
});
template.bind("redirectFunc", function(event,xml, template){
var isError = template.hasError(xml);
if (isError == 0)
{
var RegisterStatus = $("RegisterStatus", $(xml)).text();
if(RegisterStatus == "Register_OK" )
{
window.clearInterval(oneInt);
$("#pwdArea").hide();
$("#timesDiv").hide();
$("#internetOkDiv").show();
}
}
});
$("#Btn_apply_SNPwd", template).bind("click", function(event){
var formOBJ = $(".form_content", template);
if ( formOBJ.length > 0 && false == formOBJ.valid() )
{
return;
}
var buttonOBJ = $(this);
var action = "Apply";
var ServerAddr = "/?_type=hiddenData&_tag=Register_data";
var RidpwVal = $("#Ridpw").val();
var PostData = "IF_ACTION=Apply"+"&"
+ "Ridpw="+RidpwVal;
dataPost(action, "callbackBySetPwd", ServerAddr, template, PostData);
});
}
function uploadTimes()
{
var template = $("#template_SNPwd");
$("#showtime").html(timeleft);
if (timeleft > 0)
{
if(!(timeleft%3))
{
var action = "registeWait";
var ServerAddr = "/?_type=hiddenData&_tag=Register_data";
var PostData = "IF_ACTION=registeWait";
dataPost(action, "redirectFunc", ServerAddr, template, PostData);
}
}
else
{
window.clearInterval(oneInt);
$("#showtime").html("60");
$("#internetOkDiv").hide();
$("#timesDiv").hide();
$("#changeArea_SNPwd").show();
}
timeleft = timeleft - 1;
}
$(document).ready(function(){
var HeadID = "SNPwd";
var Head = $("#"+HeadID);
var templateID = "template_"+ HeadID;
var ServerAddr = "/?_type=hiddenData&_tag=Register_data";
$("#showtime").html("60");
$("#internetOkDiv").hide();
$("#timesDiv").hide();
$("#changeArea_SNPwd").show();
initial_template_SNPwd(templateID);
$("#languageId").change(function(){
var langValue = $("#languageId").val();
for(var i = 1;i < 12; i++)
{
var spanId="span"+i;
var spanStr=languageText[langValue][spanId];
if(i!=2 && i!=4)
$("#"+spanId).html(spanStr);
else if(i==2)
$("#Btn_apply_SNPwd").val(spanStr);
}
});
});
</script>
