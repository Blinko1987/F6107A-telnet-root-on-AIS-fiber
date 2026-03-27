require "data_assemble.common_lua"
local sessmgr = require "user_mgr.session_mgr"
local ErrorXML = ""
local InstXML1 = ""
local InstXML2 = ""
local OutXML = ""
local need2Get = 1
local tError = nil
local FP_OBJNAME = "OBJ_Br0AndDhcpsHosCfg_ID"
local PARA ={
"IPAddr",
"SubMask",
"ServerEnable",
"SubnetMask",
"MinAddress",
"MaxAddress",
"DnsServerSource",
"DNSServer1",
"DNSServer2",
"LeaseTime"
}
local FP_OBJNAME1 = "OBJ_LANDNS_ID"
local PARA1 ={
"Ipv4DnsOrigin",
"Ipv6DnsOrigin",
"IPv4AssignLANIP",
"IPv6AssignLANIP"
}
local OPT_XML = ""
local OPT_OBJNAME = "OBJ_OPTTFTPSERV_ID"
local OPTPARA ={
"OptEnable",
"OptCode",
"OptValue"
}
local tError_IPAddr =nil
local FP_ACTION = cgilua.cgilua.POST.IF_ACTION
local FP_IDENTITY = cgilua.cgilua.POST._InstID
local FP_IPAddr = cgilua.cgilua.POST.IPAddr
local Coun = env.getenv("CountryCode")
if FP_ACTION == "Apply" then
if tError_IPAddr==nil then
local t = cmapi.getinst(FP_OBJNAME, "")
local IPAddr = t.IPAddr
tError = applyOrNewOrDelInst(FP_OBJNAME, FP_ACTION, FP_IDENTITY, transToPostTab(PARA))
if tError.IF_ERRORID == -1381 or (cgilua.cgilua.POST.IF_URL_HOST ==IPAddr and IPAddr ~=cgilua.cgilua.POST.IPAddr and tError.IF_ERRORID == 0) then
local sess_id = cgilua.getCurrentSessID()
sessmgr.session_destroy(sess_id)
end
end
end
if FP_ACTION == "Cancel" then
need2Get = 0
InstXML1, tError = getSpecificInstXML(FP_OBJNAME, "", tError, nil,transToFilterTab(PARA))
end
if tError_IPAddr==nil then
if need2Get == 1 then
InstXML1, tError = getAllInstXML(FP_OBJNAME, "DEV", tError, nil, transToFilterTab(PARA))
end
InstXML2, tError = ManagerOBJ(FP_OBJNAME1, FP_ACTION, FP_IDENTITY, PARA1, tError)
else
tError=tError_IPAddr
end
ErrorXML = outputErrorXML(tError)
OutXML = ErrorXML .. InstXML1.. InstXML2 .. OPT_XML
outputXML(OutXML)
