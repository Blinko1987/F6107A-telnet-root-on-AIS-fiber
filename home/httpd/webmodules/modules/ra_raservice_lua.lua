require "data_assemble.common_lua"
local ErrorXML = ""
local InstXML = ""
local OutXML = ""
local tError = nil
local FP_OBJNAME = "OBJ_RAIS_ID"
local PARA =
{
"Enable",
"MaxRtrAdvInterval",
"MinRtrAdvInterval",
"IsPrefixAutoMode",
"AdvManagedFlag",
"AdvOtherConfigFlag",
"ManualPrefixes",
"AdvLinkMTU",
"AdvPreferredRouterFlag",
"AdvLinkMTUEnable",
"S_AdvLinkMTU",
}
local FP_ACTION = cgilua.cgilua.POST.IF_ACTION
local FP_IDENTITY = cgilua.cgilua.POST._InstID
if cgilua.cgilua.POST.AdvLinkMTUEnable == "0" then
cgilua.cgilua.POST.AdvLinkMTU = "0"
else
cgilua.cgilua.POST.AdvLinkMTU = cgilua.cgilua.POST.S_AdvLinkMTU
end
cgilua.cgilua.POST.AdvLinkMTUEnable = nil
cgilua.cgilua.POST.S_AdvLinkMTU = nil
local function callback(t, identity)
if t.AdvLinkMTU == "0" then
t.S_AdvLinkMTU = ""
t.AdvLinkMTUEnable = 0
else
t.S_AdvLinkMTU = t.AdvLinkMTU
t.AdvLinkMTUEnable = 1
end
return true
end
InstXML, tError = ManagerOBJ(FP_OBJNAME, FP_ACTION, FP_IDENTITY, PARA, nil, {xmlType = 2}, callback, "DEV")
ErrorXML = outputErrorXML(tError)
OutXML = ErrorXML .. InstXML
outputXML(OutXML)
