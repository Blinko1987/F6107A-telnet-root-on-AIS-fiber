local cgilua = cgilua.cgilua
local WNICIdentityArr = {}
local WLANSSIDTableArr = {}
local WLANSSIDInstsArr = {}
local WLANNICNum = nil
local function CLAROQueryWCardAndSSIDIdentity(NICNum)
local WLANNICOBJ = "OBJ_WLANSETTING_ID"
local SSIDOBJ = "OBJ_WLANAP_ID"
if NICNum == WLANNICNum and table.getn(WNICIdentityArr) ~= 0 then
return WNICIdentityArr, WLANSSIDTableArr, WLANSSIDInstsArr
end
WLANNICNum = NICNum
local reTable = cmapi.querylist("OBJ_WLANSETTING_ID", "IGD")
if reTable.IF_ERRORID == 0 and reTable.Count > 0 then
if nil ~= NICNum then
table.insert(WNICIdentityArr, reTable[NICNum]);
WNICIdentityArr.Count = 1;
else
WNICIdentityArr = reTable;
end
else
g_logger:warn("get WNICIdentity fail.")
end
for _,NICID in ipairs(WNICIdentityArr) do
local WLANSSIDTable = {}
local WLANSSIDPara = {}
local WLANBasicIDTable = cmapi.querylist(SSIDOBJ, NICID)
local WLANSSIDCount = 0
for i, v in ipairs(WLANBasicIDTable) do
local instTbl = cmapi.getinst(SSIDOBJ, v)
if instTbl.LocalSetEnable == "1" then
table.insert(WLANSSIDTable,v)
WLANSSIDCount = WLANSSIDCount + 1
table.insert(WLANSSIDPara, instTbl)
end
end
WLANSSIDTable.IF_ERRORID = WLANBasicIDTable.IF_ERRORID
WLANSSIDTable.Count = WLANSSIDCount
table.insert(WLANSSIDTableArr, WLANSSIDTable)
table.insert(WLANSSIDInstsArr, WLANSSIDPara)
end
return WNICIdentityArr, WLANSSIDTableArr, WLANSSIDInstsArr
end
local function CLAROQuerySSIDOutputOption(NICNum)
local WLANNICOBJ = "OBJ_WLANSETTING_ID"
local SSIDOBJ = "OBJ_WLANAP_ID"
local WNICIdentityArr = {};
local WLANSSIDTableArr = {};
WNICIdentityArr,WLANSSIDTableArr = CLAROQueryWCardAndSSIDIdentity(NICNum)
local OptionStr = ""
local cardNum = WNICIdentityArr.Count;
for index = 1, cardNum do
local WNICIdentity = WNICIdentityArr[index];
local WLANBasicIDTable = WLANSSIDTableArr[index];
local sess_id = cgilua.getCurrentSessID()
for i, v in ipairs(WLANBasicIDTable) do
if ("2" == session_get(sess_id, "Right") and (i == 1 or i == 2 or i == 5 or i == 6)) or
"1" == session_get(sess_id, "Right") then
local SSIDName = ""
local instTbl = cmapi.getinst(SSIDOBJ, v)
if instTbl.IF_ERRORID == 0 then
SSIDName = instTbl.Alias
end
OptionStr = OptionStr .. "<option value='" .. v .. "' title='"
.. SSIDName.. "'>"
.. SSIDName.."</option>"
end
end
end
return OptionStr
end
return {
CLAROQuerySSIDOutputOption = CLAROQuerySSIDOutputOption,
CLAROQueryWCardAndSSIDIdentity = CLAROQueryWCardAndSSIDIdentity,
}
