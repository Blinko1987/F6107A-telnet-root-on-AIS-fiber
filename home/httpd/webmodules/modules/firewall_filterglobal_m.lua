local cbi = require("data_assemble.comapi")
local util = require("data_assemble.util")
module(..., package.seeall)
local FunctionArea = cbi.FunctionArea
local SetArea = cbi.SetArea
local ParRadio = cbi.ParRadio
local ParSelect = cbi.ParSelect
local SegmentRow = cbi.SegmentRow
functionId = "FWBASE"
dataObjId = "OBJ_FWBASE_ID"
modelArea = FunctionArea(functionId, nil, lang.Security_067)
SetArea = SetArea(functionId, 0, util.PathSeparatorChar.. util.luaPath2LocalPath(_NAME))
mfEnable = ParRadio(functionId, dataObjId, "MacFilterEnable", lang.Security_042, {{value="1", text=lang.public_033}, {value="0", text=lang.public_034}})
SetArea:append(mfEnable)
mftOpt = {{text=lang.Security_039,value="Discard"},
{text=lang.Security_040,value="Permit"}}
MFT = ParSelect(functionId, dataObjId, "MacFilterTarget", lang.public_068, mftOpt)
SetArea:append(MFT)
Segm = SegmentRow("")
SetArea:append(Segm)
ufEnable = ParRadio(functionId, dataObjId, "UrlFilterEnable", lang.Security_043, {{value="1", text=lang.public_033}, {value="0", text=lang.public_034}})
SetArea:append(ufEnable)
rftOpt = {{text=lang.Security_039,value="0"},
{text=lang.Security_040,value="1"}}
UFT = ParSelect(functionId, dataObjId, "UrlFilterTarget", lang.public_068, rftOpt)
SetArea:append(UFT)
modelArea:append(SetArea)
