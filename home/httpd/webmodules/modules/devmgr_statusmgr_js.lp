<script type="text/javascript">
(function(){
var CpuNum = <%=env.getenv("CpuNum")%>;
$(document).ready(function(){
var RegStatusHeadID = "ManagStatus";
var RegStatusHead = $("#"+RegStatusHeadID);
var ServerAddr = $("address span", RegStatusHead).text();
RefreshClickHandle(RegStatusHead);
$("#div_OnuAlias").hide();
<%
if "17" == CountryCode then
%>
$("#dev_sVerExtent").hide();
$("#ModelName_text").attr("title","&?StatusManag_012;");
$("#ModelName_text").text("&?StatusManag_012;");
$("#SoftwareVerExtent_text").attr("title","&?StatusManag_014;");
$("#SoftwareVerExtent_text").text("&?StatusManag_014;");
$("#BootVer_text").attr("title","&?StatusManag_013;");
$("#BootVer_text").text("&?StatusManag_013;");
$("#div_VerDate").show();
$("#div_ManuFacturer").show();
<%
end
%>
RegStatusHead.chanegeDataByCustom =function(xml){
colorTblRow(".colorTbl", "even", RegStatusHead);
};
RegStatusHead.succfunction = function(xml){
var cmapiErrorContainer = $(".errorHint",RegStatusHead);
if (cmapiErrorContainer.hasError(xml) == 0);
{
RegStatusHead.chanegeDataByCustom(xml);
var InternetSipLineOBJ = $(xml).find("OBJ_DEVINFO_ID");
var RegStatusRuleNum = $("Instance", InternetSipLineOBJ).length;
var OBJID = ["OBJ_DEVINFO_ID"];
RegStatusHead.fillDataByOBJID(xml, OBJID, $("#ManagStatus_container"), 0);
var Oui = getParaValueInXML(xml, "OBJ_DEVINFO_ID", 0, "ManuFacturerOui");
var SN = getParaValueInXML(xml, "OBJ_DEVINFO_ID", 0, "SerialNumber");
<%
if "66" == CountryCode then
%>
$("#SerialNumber").html(SN);
<%
else
%>
$("#SerialNumber").html(Oui+"-"+SN);
<%
end
%>
$.publish("/some/SNShow", [RegStatusHead]);
<%
if "17" == CountryCode then
%>
var HVerStr = getParaValueInXML(xml, "OBJ_DEVINFO_ID", 0, "HardwareVer");
var SVerStr = getParaValueInXML(xml, "OBJ_DEVINFO_ID", 0, "SoftwareVer");
var BVerStr = getParaValueInXML(xml, "OBJ_DEVINFO_ID", 0, "BootVer");
$("#SoftwareVer").html(SVerStr.replace(/\./g, "M"));
$("#HardwareVer").html(HVerStr.replace(/\./g, "M"));
$("#BootVer").html(BVerStr.replace(/\./g, "M"));
<%
end
%>
var ReuseCPE_cycles = getParaValueInXML(xml, "OBJ_SSUBVERSION_ID", 0, "ReuseCPE_cycles");
var ReuseCPE_status = getParaValueInXML(xml, "OBJ_SSUBVERSION_ID", 0, "ReuseCPE_status");
var SubVersion=ReuseCPE_cycles+"."+ReuseCPE_status;
$("#ReuseSubVersion").html(SubVersion);
var CpuUsage = "";
for (var i = 1;i <=CpuNum;i++)
{
if(i != 1)
CpuUsage = CpuUsage + "/";
var tmp = getParaValueInXML(xml, "OBJ_CPUMEMUSAGE_ID", 0, "CpuUsage"+i);
if(tmp == "0")
CpuUsage = CpuUsage + tmp;
else
CpuUsage = CpuUsage + tmp + "%";
}
$("#CpuUsage").html(CpuUsage);
$("#MemUsage").html(getParaValueInXML(xml, "OBJ_CPUMEMUSAGE_ID", 0, "MemUsage")+"%");
$.publish("/some/softVersionModify", [RegStatusHead]);
var PowerOnTime = parseInt(getParaValueInXML(xml, "OBJ_POWERONTIME_ID", 0, "PowerOnTime"));
var tmphour = 0;
var tmpmon = 0;
var tmpsec = 0;
if(!isNaN(PowerOnTime))
{
tmphour = parseInt(PowerOnTime/3600);
tmpmon = parseInt((PowerOnTime%3600)/60);
tmpsec = (PowerOnTime%3600)%60;
}
$("#PoweronTime").html(tmphour+"&?public_011;"+tmpmon+"&?public_012;"+tmpsec+"&?public_013;");
var data = {};
data.template = RegStatusHead;
data.CpuNum = CpuNum;
data.xml = xml;
$.callModifier("ManagStatus/paramsCtr",data);
}
};
if ( $(".collapBarWithDataTrans",RegStatusHead).length <= 0 )
{
RegStatusHead.dataTransfer(ServerAddr,
"GET",
RegStatusHead.succfunction);
}
else
{
initial_collapBarWithDataTrans(RegStatusHead);
}
});
})();
</script>
