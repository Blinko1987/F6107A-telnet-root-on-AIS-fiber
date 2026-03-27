require "data_assemble.common_lua"
local OutXML = ""
local InstXML_DMTTIMER = ""
local ErrorXML_DMTTIMER = ""
local tError_DMTTIMER = nil
local FP_OBJNAME_DMTTIMER = "OBJ_VOIPDMTIMER_ID"
local PARA_DMTTIMER =
{
"StartTimer",
"ShortTimer",
"LongTimer"
}
InstXML_DMTTIMER, tError_DMTTIMER = getAllInstXML(FP_OBJNAME_DMTTIMER, "IGD", nil, nil,transToFilterTab(PARA_DMTTIMER))
ErrorXML_DMTTIMER = outputErrorXML(tError_DMTTIMER)
OutXML = ErrorXML_DMTTIMER .. InstXML_DMTTIMER
outputXML(OutXML)
