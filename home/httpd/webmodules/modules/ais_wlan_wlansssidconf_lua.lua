require "data_assemble.common_lua"
local InstXML = ""
local ErrorXML = ""
local OutXML = ""
local tError = {IF_ERRORID = 0}
local need2Get = 1
local xmlStr = ""
local sess_id = cgilua.cgilua.getCurrentSessID()
local uRight = session_get(sess_id, "Right")
local wlanCommFunc = require "modules.wlan_common_func"
local PARA
local FP_OBJNAME = "OBJ_WLANAP_ID";
if uRight == "3" then
PARA =
{
"ESSID",
"Alias",
"BeaconType",
"WEPAuthMode",
"WEPKeyIndex",
"WPAAuthMode",
"WPAEncryptType",
"11iAuthMode",
"11iEncryptType",
"WPA3AuthMode",
"WPA3EncryptType",
"WLANViewName"
}
else
PARA =
{
"Enable",
"ESSID",
"Alias",
"BeaconType",
"WEPAuthMode",
"WEPKeyIndex",
"WPAAuthMode",
"WPAEncryptType",
"WPAGroupRekey",
"ESSIDHideEnable",
"VapIsolationEnable",
"MaxUserNum",
"11iAuthMode",
"11iEncryptType",
"WPA3AuthMode",
"WPA3EncryptType",
"WLANViewName"
,"ForceWiFi5"
}
end
local WLANSETTING_OBJNAME = "OBJ_WLANSETTING_ID"
local WLANSETTING_PARA =
{
"Band",
"RadioStatus"
,"Standard"
}
local WEP_OBJNAME = "OBJ_WLANWEPKEY_ID"
local WEP_PARA =
{
"WEPKey"
}
local wep_para_table = {}
wep_para_table.para = WEP_PARA
wep_para_table.encrypt = {"WEPKey"}
local PSK_OBJNAME = "OBJ_WLANPSK_ID"
local PSK_PARA =
{
"KeyPassphrase"
}
local psk_para_table = {}
psk_para_table.para = PSK_PARA
psk_para_table.encrypt = {"KeyPassphrase"}
local FP_OBJNAME1 = "OBJ_MAP_MASTER_ID"
local PARA1 =
{
"EnBandSteer"
}
local FP_BS_OBJNAME = "OBJ_AIS_BANDSTEERING_ID"
local BS_PARA =
{
"SSIDSync"
}
local WNICIdentityArr = {}
local WLANBasicIDTableArr = {}
WNICIdentityArr,WLANBasicIDTableArr = wlanCommFunc.QueryWCardAndSSIDIdentity()
local FP_ACTION = cgilua.cgilua.POST.IF_ACTION
local _PSKCONIG = cgilua.cgilua.POST._PSKCONIG
local _WEPCONIG = cgilua.cgilua.POST._WEPCONIG
local _EAPCONIG = cgilua.cgilua.POST._EAPCONIG
local GUE_IDENTITY = cgilua.cgilua.POST._InstID_GUEST
local FP_IDENTITY = cgilua.cgilua.POST._InstID
local WEP_IDENTITY0 = cgilua.cgilua.POST._InstID_WEP0
local WEP_IDENTITY1 = cgilua.cgilua.POST._InstID_WEP1
local WEP_IDENTITY2 = cgilua.cgilua.POST._InstID_WEP2
local WEP_IDENTITY3 = cgilua.cgilua.POST._InstID_WEP3
local PSK_IDENTITY = cgilua.cgilua.POST._InstID_PSK
local xmlTable = {}
local WEP_PARA_FILTER = transToFilterTab(wep_para_table)
local function decodeWEP(inputStr)
local decodeWEP = ""
local decodeKV = cmapi.nocsrf.rsa_decrypt(cgilua.cgilua.POST.encode)
local key,iv = string.match(decodeKV,"(%d+)%+(%d+)")
decodeWEP = cmapi.nocsrf.aes_decrypt(inputStr, key, iv)
return decodeWEP
end
if FP_ACTION == "Apply" then
need2Get = 0
if "Y" ~= _WEPCONIG then
cgilua.cgilua.POST.WEPKeyIndex = nil
end
if tError.IF_ERRORID == 0 then
tError = applyOrNewOrDelInst(FP_OBJNAME, FP_ACTION, FP_IDENTITY, transToPostTab(PARA))
end
if "Y" == _WEPCONIG then
local WEP_PARA_POST = transToPostTab(wep_para_table)
if tError.IF_ERRORID == 0 then
WEP_PARA_POST.WEPKey = decodeWEP(cgilua.cgilua.POST.WEPKey00)
tError = applyOrNewOrDelInst(WEP_OBJNAME, FP_ACTION, WEP_IDENTITY0, WEP_PARA_POST)
end
if tError.IF_ERRORID == 0 then
WEP_PARA_POST.WEPKey = decodeWEP(cgilua.cgilua.POST.WEPKey01)
tError = applyOrNewOrDelInst(WEP_OBJNAME, FP_ACTION, WEP_IDENTITY1, WEP_PARA_POST)
end
if tError.IF_ERRORID == 0 then
WEP_PARA_POST.WEPKey = decodeWEP(cgilua.cgilua.POST.WEPKey02)
tError = applyOrNewOrDelInst(WEP_OBJNAME, FP_ACTION, WEP_IDENTITY2, WEP_PARA_POST)
end
if tError.IF_ERRORID == 0 then
WEP_PARA_POST.WEPKey = decodeWEP(cgilua.cgilua.POST.WEPKey03)
tError = applyOrNewOrDelInst(WEP_OBJNAME, FP_ACTION, WEP_IDENTITY3, WEP_PARA_POST)
end
end
if "Y" == _PSKCONIG then
if tError.IF_ERRORID == 0 then
tError = applyOrNewOrDelInst(PSK_OBJNAME, FP_ACTION, PSK_IDENTITY, transToPostTab(psk_para_table))
end
end
end
if FP_ACTION == "Cancel" then
need2Get = 0;
InstXML, tError = getSpecificInstXML(FP_OBJNAME, FP_IDENTITY, tError, nil, transToFilterTab(PARA))
table.insert(xmlTable, InstXML)
InstXML, tError = getSpecificInstXML(WEP_OBJNAME, WEP_IDENTITY0, tError, nil, WEP_PARA_FILTER)
table.insert(xmlTable, InstXML)
InstXML, tError = getSpecificInstXML(WEP_OBJNAME, WEP_IDENTITY1, tError, nil, WEP_PARA_FILTER)
table.insert(xmlTable, InstXML)
InstXML, tError = getSpecificInstXML(WEP_OBJNAME, WEP_IDENTITY2, tError, nil, WEP_PARA_FILTER)
table.insert(xmlTable, InstXML)
InstXML, tError = getSpecificInstXML(WEP_OBJNAME, WEP_IDENTITY3, tError, nil, WEP_PARA_FILTER)
table.insert(xmlTable, InstXML)
InstXML, tError = getSpecificInstXML(PSK_OBJNAME, PSK_IDENTITY, tError, nil, transToFilterTab(psk_para_table))
table.insert(xmlTable, InstXML)
InstXML, tError = getSpecificInstXML(FP_BS_OBJNAME, "IGD", tError, nil, transToFilterTab(BS_PARA))
table.insert(xmlTable, InstXML)
end
function EnKeyFilterBySSID(t, identity)
if uRight == "3" then
for _, ssidTbl in pairs(WLANBasicIDTableArr) do
if ssidTbl.IF_ERRORID == 0 and ssidTbl.Count > 0 then
if t.WLANViewName == ssidTbl[1] then
return true
end
end
end
return false
else
for _, ssidTbl in pairs(WLANBasicIDTableArr) do
if ssidTbl.IF_ERRORID == 0 and ssidTbl.Count > 0 then
for _,ssid in ipairs(ssidTbl) do
if t.WLANViewName == ssid then
return true
end
end
end
end
return false
end
end
if need2Get == 1 then
local SSIDFilterByNIC = wlanCommFunc.getSSIDFilterByNIC(WLANBasicIDTableArr);
if env.getenv("CountryCode") == "1" then
SSIDFilterByNIC = nil
end
InstXML, tError = getAllInstXML(FP_OBJNAME, "IGD", tErr, SSIDFilterByNIC, transToFilterTab(PARA))
table.insert(xmlTable, InstXML)
InstXML, tError = getAllInstXML(WLANSETTING_OBJNAME, "IGD", tError, nil, transToFilterTab(WLANSETTING_PARA))
table.insert(xmlTable, InstXML)
InstXML, tError = getAllInstXML(WEP_OBJNAME, "IGD", tErr, EnKeyFilterBySSID, WEP_PARA_FILTER)
table.insert(xmlTable, InstXML)
InstXML, tError = getAllInstXML(PSK_OBJNAME, "IGD", tErr, EnKeyFilterBySSID, transToFilterTab(psk_para_table))
table.insert(xmlTable, InstXML)
InstXML, tError = getAllInstXML(FP_OBJNAME1, "IGD", tErr, nil, transToFilterTab(PARA1))
table.insert(xmlTable, InstXML)
InstXML, tError = getAllInstXML(FP_BS_OBJNAME, "IGD", tErr, nil, transToFilterTab(BS_PARA))
table.insert(xmlTable, InstXML)
end
xmlStr = table.concat(xmlTable)
ErrorXML = outputErrorXML(tError)
OutXML = ErrorXML .. xmlStr
outputXML(OutXML)
