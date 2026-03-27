require "data_assemble.common_lua"
local ErrorXML = ""
local InstXML1 = ""
local InstXML2 = ""
local InstXML3 = ""
local OutXML = ""
local tError
local PARA =
{
"AuthUserName",
}
local PARA_AD =
{
"IsOnline",
"VoIPRegStatus"
}
local PARA3 =
{
"LanPortStatus"
}
if env.getenv("CountryCode") == "44" and tonumber(env.getenv("Right")) >= 2 then
InstXML1 = "<OBJ_VOIPSIPLINE_ID><Instance><ParaName>AuthUserName</ParaName><ParaValue>******</ParaValue></Instance><Instance><ParaName>AuthUserName</ParaName><ParaValue>******</ParaValue></Instance></OBJ_VOIPSIPLINE_ID>"
else
InstXML1 , tError = getAllInstXML("OBJ_VOIPSIPLINE_ID", "IGD", nil, nil, transToFilterTab(PARA))
end
InstXML2 , tError = getAllInstXML("OBJ_VOIPVPLINE_ID", "IGD", tError, nil, transToFilterTab(PARA_AD))
InstXML3 , tError = getAllInstXML("OBJ_VOIPVPPHYINTERFACE_ID", "IGD", tError, nil, transToFilterTab(PARA3))
ErrorXML = ErrorXML .. outputErrorXML(tError)
OutXML = ErrorXML .. InstXML1 .. InstXML2 .. InstXML3
outputXML(OutXML)
