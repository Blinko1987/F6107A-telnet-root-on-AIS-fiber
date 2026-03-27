<script type="text/javascript">
var NsLookup_Time = 3;
var tmp1 = "&?DiagnosisManag_053;" ;
var tmp2 = "\n" + "&?DiagnosisManag_054;" + ": " ;
var tmp3 = "\n" + "&?DiagnosisManag_055;" + ": " ;
var tmp4 = "\n" + "&?DiagnosisManag_056;" + " " ;
function NsLookupReGetResult()
{
var HeadID = "NsLookupDiagnosis";
var Head = $("#"+HeadID);
var ServerAddr = $("address span", Head).text();
Head.succfunction = function(xml){
ReGetNsLookupDiagnosis(xml);
};
Head.dataTransfer(ServerAddr, "GET", Head.succfunction,
Head.failfunction, false);
}
function ReGetNsLookupDiagnosis(xml)
{
var template = $("#template_NsLookupDiagnosis");
var NLResult1 = "";
var ErrorString = $("IF_ERRORSTR", $(xml)).text();
if (template.hasError(xml) == 0)
{
var ToOperParaArr = {
"IPAddresses" : {ValueOrigin: ""}
};
xmlParaInInstOperate(xml, "OBJ_DEV_GETRESULT_NSLOOKUP_ID", 0, ToOperParaArr);
NLResult1 = ToOperParaArr.IPAddresses.ValueOrigin;
}
if( ErrorString == "SUCC" && NsLookup_Time > 0 && ( NLResult1 == "NULL" || NLResult1 == "" ) )
{
NsLookup_Time--;
setTimeout("NsLookupReGetResult()", 3000);
}
else
{
NsLookup_Time = 3;
showWaitTip(false);
if (template.hasError(xml) == 0)
{
succHintShow(template);
var OBJID = ["OBJ_DEV_GETRESULT_NSLOOKUP_ID"];
var Hostname = $("[id^='HostName']", template).val();
if( NLResult1 != "NULL" && NLResult1 != "" )
{
template.fillDataByOBJID( xml ,OBJID, template, 0 );
$("#NLResult").val(tmp1 + tmp2 + Hostname + tmp3 + NLResult1);
}
else
{
$("#NLResult").val(tmp1 + tmp4 + Hostname);
}
return;
}
}
}
function initial_template_NsLookupDiagnosis(templateID)
{
var template = $("#"+templateID);
var instForm = template.find("form");
instForm.validate({
"rules": {
"HostName:NsLookupDiagnosis": {
"required": true
},
},
"messages": {
}
});
template.bind("fillDataByNLDiagnosisResult", function(event,xml, template){
if ( template.hasError(xml) == 0 )
{
NsLookupReGetResult();
}
else
{
showWaitTip(false);
}
});
$("[id^='Interface']",template).change(function(){
var ip=$("[id^='ServerIP']", template);
if($(this).find("option:selected").prop("title") == "LAN"){
ip.rules("add",{"required":true});
}
else{
ip.rules("remove","required");
}
});
}
$(document).ready(function(){
var NLHeadID = "NsLookupDiagnosis";
var NLHead = $("#"+NLHeadID);
var NLtemplateID = "template_"+ NLHeadID;
var NLServerAddr = $("address span", NLHead).text();
var x = $("#Interface:NsLookupDiagnosis");
for ( var i=0; i<x.length; i++ )
{
if ( 'LAN' == x.options[i].title )
{
$(x.options[i]).val("");
}
}
initial_template_NsLookupDiagnosis(NLtemplateID);
$(".Btn_NsLookupDiagnosis").bind("click", {templateOBJ:NLtemplateID}, function(event){
if ( false == $(".form_content", $("#"+NLtemplateID)).valid() )
{
return;
}
var Hostname = $("[id^='HostName']", NLHead).val();
if ( true==checkIPv4Addr(Hostname) || true==checkIPv6Addr(Hostname))
{
$(".errorHint", $("#"+NLtemplateID)).hide();
$("#NLResult").val(tmp1 + tmp2 + Hostname + tmp3 + Hostname);
return;
}
var NsLookuptemplate = $(this).parents("[id^='template']");
NLHead.find("textarea").val("");
showWaitTip(false);
showWaitTip(true,"&?cmret_004;");
dataPost("NsLookupDiagnosis", "fillDataByNLDiagnosisResult",
NLServerAddr, NsLookuptemplate, undefined, false);
});
NLHead.succfunction = function(xml){
NLHead.hasError(xml,"externErrorHint");
var ContainerOBJ = $("[id^='template_']",NLHead)
$.publish("/some/networkdiag_nslookup", [ContainerOBJ]);
};
NLHead.dataTransfer(NLServerAddr,
"GET",
NLHead.succfunction);
});
</script>
