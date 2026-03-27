require "data_assemble.common_lua"
local ErrorXML = ""
local InstXML1 = ""
local InstXML2 = ""
local OutXML = ""
local tError
local PARA =
{
"AuthUserName",
"DigestUserName"
}
local PARA_AD =
{
"VoIPRegStatus",
"DirectoryNumber"
}
if env.getenv("CountryCode") == "44" and tonumber(env.getenv("Right")) >= 2 then
InstXML1 = "<OBJ_VOIPSIPLINE_ID><Instance><ParaName>AuthUserName</ParaName><ParaValue>******</ParaValue></Instance><Instance><ParaName>AuthUserName</ParaName><ParaValue>******</ParaValue></Instance></OBJ_VOIPSIPLINE_ID>"
else
InstXML1 , tError = getAllInstXML("OBJ_VOIPSIPLINE_ID", "IGD", nil, nil, transToFilterTab(PARA))
end
InstXML2 , tError = getAllInstXML("OBJ_VOIPVPLINE_ID", "IGD", tError, nil, transToFilterTab(PARA_AD))
ErrorXML = ErrorXML .. outputErrorXML(tError)
OutXML = ErrorXML .. InstXML1 .. InstXML2
outputXML(OutXML)
