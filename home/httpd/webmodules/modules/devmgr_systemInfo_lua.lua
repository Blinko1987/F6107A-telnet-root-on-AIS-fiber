require "data_assemble.common_lua"
local ErrorXML = ""
local OutXML = ""
local tError = nil
local InstXML_CpuMemUsage = ""
local FP_OBJNAME_CpuMemUsage = "OBJ_CPUMEMUSAGE_ID"
local PARA_CpuMemUsage =
{
"MemUsage",
"CpuUsage1",
"CpuUsage2",
"CpuUsage3",
"CpuUsage4"
}
local InstXML_Time = ""
local FP_OBJNAME_TIME = "OBJ_POWERONTIME_ID"
local PARA_TIME =
{
"PowerOnTime"
}
local InstXML_Flash = ""
local FP_OBJNAME_FLASH = "OBJ_FLASHINFO_ID"
local PARA_FLASH =
{
"TotalFlash",
"Flash_Percent_Used"
}
InstXML_CpuMemUsage, tError =getAllInstXML( FP_OBJNAME_CpuMemUsage, "IGD", tError, nil,transToFilterTab(PARA_CpuMemUsage))
InstXML_Time, tError = getAllInstXML(FP_OBJNAME_TIME, "IGD", tError, nil,transToFilterTab(PARA_TIME))
InstXML_Flash, tError = getAllInstXML(FP_OBJNAME_FLASH, "IGD", tError, nil,transToFilterTab(PARA_FLASH))
ErrorXML = outputErrorXML(tError)
OutXML = ErrorXML .. InstXML_CpuMemUsage .. InstXML_Time .. InstXML_Flash
outputXML(OutXML)
