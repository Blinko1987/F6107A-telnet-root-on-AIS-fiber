local function QueryDongleCardStatus()
local Flag = nil
local SimStatus = nil
local DevType = nil
local DevStatus = nil
local DongleType = nil
local retTable = cmapi.getinst("OBJ_WWANDONGLEINFO_ID", "IGD")
if retTable.IF_ERRORID == 0 then
DevType = retTable.DevType
DevStatus = retTable.DevStatus
DongleType = retTable.DongleType
end
local retTable = cmapi.getinst("OBJ_WWANPINCFG_ID", "IGD")
if retTable.IF_ERRORID == 0 then
Flag = retTable.Flag
SimStatus = retTable.SimStatus
end
local DongleStatus = nil
if "-1" == Flag then
DongleStatus = "Dev_FAILURE"
else
if "0" == DevStatus then
DongleStatus = "Dev_IDENTYING"
elseif "2" == DevStatus then
DongleStatus = "Dev_IDENTYNOK"
else
if "2" == DongleType then
DongleStatus = "Dev_IDENTYOKONLY"
elseif "1" == DongleType then
if "0" == SimStatus then
if "0" == DevType then
DongleStatus = "GenSIM_READY"
else
DongleStatus = "SIM_READY"
end
elseif "1" == SimStatus then
if "0" == DevType then
DongleStatus = "SIM_FAILURE"
else
DongleStatus = "INPUT_PIN"
end
elseif "2" == SimStatus then
if "0" == DevType then
DongleStatus = "SIM_FAILURE"
else
DongleStatus = "INPUT_PUK"
end
elseif "3" == SimStatus then
DongleStatus = "SIM_BUSY"
elseif "4" == SimStatus then
DongleStatus = "SIM_FAILURE"
else
DongleStatus = "PAGE_OTHER_STATE"
end
else
DongleStatus = "PAGE_OTHER_STATE"
end
end
end
return DongleStatus, DevType, DongleType
end
return {
QueryDongleCardStatus = QueryDongleCardStatus
}
