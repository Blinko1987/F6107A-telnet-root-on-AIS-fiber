require "data_assemble.common_lua"
local InstXML = ""
local InstXMLTMP = ""
local ErrorXML = ""
local OutXML = ""
local tError = {IF_ERRORID = 0}
local need2Get = 1
local sess_id = cgilua.cgilua.getCurrentSessID()
local uRight = session_get(sess_id, "Right")
local FP_OBJNAME = "OBJ_WLANSETTING_ID"
local PARA
local CHANNEL_OBJNAME
local CHANNEL_PARA
if uRight ~= "3" then
PARA =
{
"Standard",
"CardMode",
"BasicDataRates",
"OpDataRates",
"11nMode",
"GreenField",
"Channel",
"AutoChannelEnabled",
"Band",
"RadioStatus",
"CountryCode",
"MUMIMOEnable",
"BandWidth",
"PreambleType"
,"AutoChRange"
,
"DownLinkMUMIMO",
"UPLinkMUMIMO"
}
local NoRightDiff = false
if _G.ssidConf["NoRightDiff"] ~= nil then
if string.find(_G.ssidConf["NoRightDiff"],"WlanBasicAdConf") ~= nil then
NoRightDiff = true
end
elseif _G.ssidConf[uRight] ~= nil and _G.ssidConf[uRight].NoRightDiff ~= nil then
if string.find(_G.ssidConf[uRight].NoRightDiff,"WlanBasicAdConf") ~= nil then
NoRightDiff = true
end
end
if ((uRight=="1") or NoRightDiff or (env.getenv("CountryCode")=="14") or (env.getenv("CountryCode")=="112")
or (env.getenv("CountryCode")=="137") or (env.getenv("CountryCode")=="167") or (env.getenv("CountryCode")=="146")
or (env.getenv("CountryCode")=="3") or (env.getenv("CountryCode")=="1") or (env.getenv("CountryCode")=="128") or (env.getenv("CountryCode")=="20") or (env.getenv("CountryCode")=="95") or (env.getenv("CountryCode")=="37") ) then
local advParas = {
"SideBand",
"SSIDIsolationEnable",
"SGIEnabled",
"BeaconInterval",
"TxPower",
"WorkMode",
"QosType",
"RtsCts",
"DTIM"
};
table.foreach(advParas, function(i, v)
table.insert(PARA, v)
end);
end
CHANNEL_OBJNAME = "OBJ_CHANNEL_ID"
CHANNEL_PARA =
{
"CountryCode",
"Band",
"BandWidth",
"ChannelList"
}
end
local FP_ACTION = cgilua.cgilua.POST.IF_ACTION
local FP_IDENTITY = cgilua.cgilua.POST._InstID
if FP_ACTION == "Apply" then
need2Get = 0
tError = applyOrNewOrDelInst(FP_OBJNAME, FP_ACTION, FP_IDENTITY, transToPostTab(PARA), tError)
end
if FP_ACTION == "Cancel" then
need2Get = 0;
InstXMLTMP, tError = getSpecificInstXML(FP_OBJNAME, FP_IDENTITY, tError, nil, transToFilterTab(PARA))
InstXML = InstXML .. InstXMLTMP
end
if need2Get == 1 then
InstXMLTMP, tError = getAllInstXML(FP_OBJNAME, "IGD", tError, nil, transToFilterTab(PARA))
InstXML = InstXML .. InstXMLTMP
if uRight ~= "3" then
local CountryStr = _G.ssidConf["wlanCountryConf"]
local CountryCode = "IGD"
if CountryStr ~= nil then
CountryCode = CountryStr[1]
end
InstXMLTMP, tError = getAllInstXML(CHANNEL_OBJNAME, CountryCode, tError, nil, transToFilterTab(CHANNEL_PARA))
InstXML = InstXML .. InstXMLTMP
end
end
ErrorXML = outputErrorXML(tError)
OutXML = ErrorXML .. InstXML
outputXML(OutXML)
