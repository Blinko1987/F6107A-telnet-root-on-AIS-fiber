<script type="text/javascript">
(function(){
var CpuNum = <%=env.getenv("CpuNum")%>;
$(document).ready(function(){
var RegStatusHeadID = "SystemInfo";
var RegStatusHead = $("#"+RegStatusHeadID);
var ServerAddr = $("address span", RegStatusHead).text();
RefreshClickHandle(RegStatusHead);
RegStatusHead.chanegeDataByCustom =function(xml){
colorTblRow(".colorTbl", "even", RegStatusHead);
};
RegStatusHead.succfunction = function(xml){
var cmapiErrorContainer = $(".errorHint",RegStatusHead);
if (cmapiErrorContainer.hasError(xml) == 0);
{
RegStatusHead.chanegeDataByCustom(xml);
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
$("#CPU_Usage").html(CpuUsage);
$("#Memory_Usage").html(getParaValueInXML(xml, "OBJ_CPUMEMUSAGE_ID", 0, "MemUsage")+"%");
var PowerOnTime = parseInt(getParaValueInXML(xml, "OBJ_POWERONTIME_ID", 0, "PowerOnTime"));
var tmpday = 0;
var tmphour = 0;
var tmpmon = 0;
var tmpsec = 0;
if(!isNaN(PowerOnTime))
{
tmpmon = parseInt((PowerOnTime%3600)/60);
tmpsec = PowerOnTime%60;
tmpday = parseInt(PowerOnTime/(3600*24));
tmphour = parseInt((PowerOnTime%(3600*24))/3600)
}
$("#Power_On_Time").html(tmpday + "&?SystemInfo_005;" + tmphour+"&?SystemInfo_006;"+tmpmon+"&?SystemInfo_007;"+tmpsec+"&?SystemInfo_008;");
var TotalFlash = parseInt(getParaValueInXML(xml, "OBJ_FLASHINFO_ID", 0, "TotalFlash"))/1024/1024;
var Flash_Percent_Used = parseInt(getParaValueInXML(xml, "OBJ_FLASHINFO_ID", 0, "Flash_Percent_Used"));
$("#Flash_Usage").html(Flash_Percent_Used + "% &?SystemInfo_003;" + TotalFlash + "MB" );
}
};
if ( $(".collapBarWithDataTrans",RegStatusHead).length <= 0 )
{
RegStatusHead.dataTransfer(ServerAddr, "GET", RegStatusHead.succfunction);
}
else
{
initial_collapBarWithDataTrans(RegStatusHead);
}
});
})();
</script>
