require "data_assemble.common_lua"
local ErrorXML = ""
local InstXML1 = ""
local InstXML2 = ""
local OutXML = ""
local tError = nil
local FP_OBJNAME = "OBJ_AIS_BANDSTEERING_ID"
local PARA =
{
"SSIDSync"
}
local FP_SSID_OBJNAME = "OBJ_WLANAP_ID"
local SSID_PARA =
{
"ESSID"
}
local FP_ACTION = cgilua.POST.IF_ACTION
local FP_IDENTITY = cgilua.POST._InstID
InstXML1, tError = ManagerOBJ(FP_OBJNAME, FP_ACTION, FP_IDENTITY, PARA, tError)
if FP_ACTION == "Apply" then
if cgilua.POST.BsSSIDName0 ~=nil then
tError = cmapi.setinst(FP_SSID_OBJNAME, "DEV.WIFI.AP1", {ESSID=cgilua.POST.BsSSIDName0})
end
if cgilua.POST.BsSSIDName1 ~=nil then
tError = cmapi.setinst(FP_SSID_OBJNAME, "DEV.WIFI.AP2", {ESSID=cgilua.POST.BsSSIDName1})
end
if cgilua.POST.BsSSIDName2 ~=nil then
tError = cmapi.setinst(FP_SSID_OBJNAME, "DEV.WIFI.AP3", {ESSID=cgilua.POST.BsSSIDName2})
end
if cgilua.POST.BsSSIDName3 ~=nil then
tError = cmapi.setinst(FP_SSID_OBJNAME, "DEV.WIFI.AP4", {ESSID=cgilua.POST.BsSSIDName3})
end
else
if tError.IF_ERRORID == 0 then
InstXML2, tError = getAllInstXML(FP_SSID_OBJNAME, "IGD", tError, nil, transToFilterTab(SSID_PARA))
InstXML1 = InstXML1 .. InstXML2
end
end
ErrorXML = outputErrorXML(tError)
OutXML = ErrorXML .. InstXML1
outputXML(OutXML)
