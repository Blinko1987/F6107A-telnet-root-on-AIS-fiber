require "data_assemble.common_lua"
local instTable = {
ssid1 = "DEV.WIFI.AP1",
ssid2 = "DEV.WIFI.AP2",
ssid3 = "DEV.WIFI.AP3",
ssid4 = "DEV.WIFI.AP4",
ssid5 = "DEV.WIFI.AP5",
ssid6 = "DEV.WIFI.AP6",
ssid7 = "DEV.WIFI.AP7",
ssid8 = "DEV.WIFI.AP8"
}
local result = 0
local function setSsidConf(paraTbl,ssid)
local auth = paraTbl[ssid .."_authen"]
local encry = paraTbl[ssid .."_encryptmode"]
local wep = false
local wpa = false
local ssidConf = {}
local tError = {IF_ERRORID = 0}
ssidConf["ESSID"] = paraTbl[ssid]
ssidConf["Enable"] = paraTbl[ssid .."_enable"]
ssidConf["ESSIDHideEnable"] = paraTbl[ssid .."_hidden"]
if auth == "None" then
ssidConf["BeaconType"] = "none"
elseif auth == "WEP" then
ssidConf["BeaconType"] = "Basic"
ssidConf["WEPKeyIndex"] = "1"
if encry == "SharedKey" then
ssidConf["WEPAuthMode"] = "SharedAuthentication"
else
ssidConf["WEPAuthMode"] = "None"
end
wep = true
elseif auth == "WPA" then
ssidConf["BeaconType"] = "WPA"
ssidConf["WPAAuthMode"] = "PSKAuthentication"
if encry == "AES" then
ssidConf["WPAEncryptType"] = "AESEncryption"
elseif encry == "TKIP" then
ssidConf["WPAEncryptType"] = "PSKAuthentication"
else
ssidConf["WPAEncryptType"] = "TKIPandAESEncryption"
end
wpa = true
elseif auth == "WPA2" then
ssidConf["BeaconType"] = "11i"
ssidConf["11iAuthMode"] = "PSKAuthentication"
if encry == "AES" then
ssidConf["11iEncryptType"] = "AESEncryption"
elseif encry == "TKIP" then
ssidConf["11iEncryptType"] = "PSKAuthentication"
else
ssidConf["11iEncryptType"] = "TKIPandAESEncryption"
end
wpa = true
elseif auth == "WPA-PSK/WPA2-PSK" then
ssidConf["BeaconType"] = "WPAand11i"
ssidConf["WPAAuthMode"] = "PSKAuthentication"
ssidConf["11iAuthMode"] = "PSKAuthentication"
if encry == "AES" then
ssidConf["WPAEncryptType"] = "AESEncryption"
ssidConf["11iEncryptType"] = "AESEncryption"
elseif encry == "TKIP" then
ssidConf["WPAEncryptType"] = "PSKAuthentication"
ssidConf["11iEncryptType"] = "PSKAuthentication"
else
ssidConf["WPAEncryptType"] = "TKIPandAESEncryption"
ssidConf["11iEncryptType"] = "TKIPandAESEncryption"
end
wpa = true
elseif auth == "WPA3" then
ssidConf["BeaconType"] = "WPA3"
ssidConf["WPA3EncryptType"] = "AESEncryption"
if encry == "OWN" then
ssidConf["WPA3AuthMode"] = "OWEAuthentication"
elseif encry == "SAE" then
ssidConf["WPA3AuthMode"] = "SAEAuthentication"
end
wpa = true
elseif auth == "WPA2/WPA3" then
ssidConf["BeaconType"] = "11iandWPA3"
ssidConf["WPA3EncryptType"] = "AESEncryption"
ssidConf["11iAuthMode"] = "TKIPandAESEncryption"
ssidConf["11iEncryptType"] = "TKIPandAESEncryption"
if encry == "OWN" then
ssidConf["WPA3AuthMode"] = "OWEAuthentication"
elseif encry == "SAE" then
ssidConf["WPA3AuthMode"] = "SAEAuthentication"
end
wpa = true
end
tError = cmapi.nocsrf.setinst("OBJ_WLANAP_ID", instTable[ssid], ssidConf)
if tError.IF_ERRORID ~= 0 then
result = 0
g_logger:warn("wlan set ssid fail return" .. tError.IF_ERRORID)
end
if wap == true then
local identity = instTable[ssid] .. ".PSK1"
local wpaConf = {}
wpaConf["KeyPassphrase"] = paraTbl[ssid .."_password"]
tError = cmapi.nocsrf.setinst("OBJ_WLANPSK_ID", identity, wpaConf)
if tError.IF_ERRORID ~= 0 then
result = 0
g_logger:warn("wlan set wpa key fail return" .. tError.IF_ERRORID)
end
elseif wep == true then
local identity = instTable[ssid] .. ".WEP1"
local wepConf = {}
wepConf["WEPKey"] = paraTbl[ssid .."_password"]
tError = cmapi.nocsrf.setinst("OBJ_WLANWEPKEY_ID", identity, wepConf)
if tError.IF_ERRORID ~= 0 then
result = 0
g_logger:warn("wlan set wep key fail return" .. tError.IF_ERRORID)
end
end
end
local function setwifi(paraTbl)
result = 1
local wlanConf = {}
local tError = {IF_ERRORID = 0}
wlanConf["RadioStatus"] = paraTbl["24g_enable"]
wlanConf["Channel"] = paraTbl["24g_channel"]
wlanConf["BandWidth"] = paraTbl["24g_channel_bandwith"]
wlanConf["Standard"] = paraTbl["24g_wifi_mode"]
wlanConf["TxPower"] = paraTbl["24g_tx_power"]
tError = cmapi.nocsrf.setinst("OBJ_WLANSETTING_ID", "DEV.WIFI.RD1", wlanConf)
if tError.IF_ERRORID ~= 0 then
result = 0
g_logger:warn("wlan set 24g fail return" .. tError.IF_ERRORID)
end
wlanConf = {}
tError = {IF_ERRORID = 0}
wlanConf["RadioStatus"] = paraTbl["5g_enable"]
wlanConf["Channel"] = paraTbl["5g_channel"]
wlanConf["BandWidth"] = paraTbl["5g_channel_bandwith"]
wlanConf["Standard"] = paraTbl["5g_wifi_mode"]
wlanConf["TxPower"] = paraTbl["5g_tx_power"]
tError = cmapi.nocsrf.setinst("OBJ_WLANSETTING_ID", "DEV.WIFI.RD2", wlanConf)
if tError.IF_ERRORID ~= 0 then
result = 0
g_logger:warn("wlan set 5g fail return" .. tError.IF_ERRORID)
end
wlanConf = {}
tError = {IF_ERRORID = 0}
wlanConf["CmWLANGetBandSteer"] = paraTbl["steering_enable"]
tError = cmapi.nocsrf.setinst("OBJ_WLAN_BANDSTEERV2_ID", "IGD", wlanConf)
if tError.IF_ERRORID ~= 0 then
result = 0
g_logger:warn("wlan set 5g fail return" .. tError.IF_ERRORID)
end
wlanConf = {}
tError = {IF_ERRORID = 0}
wlanConf["BsRssiLmt24G"] = paraTbl["steering_threshold_low"]
wlanConf["BsRssiLmt5G"] = paraTbl["steering_threshold_high"]
tError = cmapi.nocsrf.setinst("OBJ_MULTIAP_BANDSTEER_ID", "IGD.WiFi.RD1.BS", wlanConf)
if tError.IF_ERRORID ~= 0 then
result = 0
g_logger:warn("wlan set 5g fail return" .. tError.IF_ERRORID)
end
wlanConf = {}
tError = {IF_ERRORID = 0}
wlanConf["EnStaRoam"] = paraTbl["roaming_switch"]
wlanConf["BsRssiLmt5G"] = paraTbl["RoamRssiLmt24G"]
wlanConf["BsRssiLmt5G"] = paraTbl["RoamRssiLmt5G"]
tError = cmapi.nocsrf.setinst("OBJ_MAP_DOMAIN_ID", "MULTIAPDOMAIN1", wlanConf)
if tError.IF_ERRORID ~= 0 then
result = 0
g_logger:warn("wlan set 5g fail return" .. tError.IF_ERRORID)
end
setSsidConf(paraTbl,"ssid1")
setSsidConf(paraTbl,"ssid2")
setSsidConf(paraTbl,"ssid3")
setSsidConf(paraTbl,"ssid4")
setSsidConf(paraTbl,"ssid5")
setSsidConf(paraTbl,"ssid6")
setSsidConf(paraTbl,"ssid7")
setSsidConf(paraTbl,"ssid8")
wlanConf = {}
tError = {IF_ERRORID = 0}
wlanConf["result"] = result
tError = cmapi.nocsrf.setinst("OBJ_WIFI_UPDATE_ID", "IGD", wlanConf)
if tError.IF_ERRORID ~= 0 then
g_logger:warn("send message fail return" .. tError.IF_ERRORID)
end
end
return {
setwifi = setwifi
}
