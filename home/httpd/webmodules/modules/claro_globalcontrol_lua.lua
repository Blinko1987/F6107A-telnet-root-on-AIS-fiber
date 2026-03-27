require "data_assemble.common_lua"
local UPNP_InstXML = ""
local BLOCKWAN_InstXML = ""
local ALG_InstXML = ""
local MULTICAST_InstXML = ""
local ErrorXML = ""
local OutXML = ""
local tError = nil
local UPNP_OBJNAME = "OBJ_UPNPCONFIG_ID"
local UPNP_PARA =
{
"EnableUPnPIGD"
}
local BLOCKWAN_OBJNAME = "OBJ_BLOCKWAN_ID"
local BLOCKWAN_PARA =
{
"BLOCKWANEnable"
}
local ALG_OBJNAME = "OBJ_FWALG_ID"
local ALG_PARA =
{
"IsPPTPAlg",
"IsIPSECAlg"
}
local MULTICAST_OBJNAME = "OBJ_IGMPMODE_ID"
local MULTICAST_PARA =
{
"multicastmode"
}
local FP_ACTION = cgilua.cgilua.POST.IF_ACTION
local FP_IDENTITY = "IGD"
UPNP_InstXML, tError = ManagerOBJ(UPNP_OBJNAME, FP_ACTION, FP_IDENTITY, UPNP_PARA, nil, {xmlType = 1})
BLOCKWAN_InstXML, tError = ManagerOBJ(BLOCKWAN_OBJNAME, FP_ACTION, FP_IDENTITY, BLOCKWAN_PARA, nil, {xmlType = 1})
ALG_InstXML, tError = ManagerOBJ(ALG_OBJNAME, FP_ACTION, FP_IDENTITY, ALG_PARA, nil, {xmlType = 1})
MULTICAST_InstXML, tError = ManagerOBJ(MULTICAST_OBJNAME, FP_ACTION, FP_IDENTITY, MULTICAST_PARA, nil, {xmlType = 1})
ErrorXML = outputErrorXML(tError)
OutXML = ErrorXML .. UPNP_InstXML .. BLOCKWAN_InstXML .. ALG_InstXML .. MULTICAST_InstXML
outputXML(OutXML)
