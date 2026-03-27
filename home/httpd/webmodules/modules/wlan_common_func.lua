local cgilua = cgilua.cgilua
local WNICIdentityArr = {}
local WLANSSIDTableArr = {}
local WLANSSIDInstsArr = {}
local WLANNICNum = nil
local lastRight = ""
local function QueryWCardAndSSIDIdentity(NICNum)
local WLANNICOBJ = "OBJ_WLANSETTING_ID"
local SSIDOBJ = "OBJ_WLANAP_ID"
local sess_id = cgilua.getCurrentSessID()
local usrRight = session_get(sess_id, "Right")
if _G.ssidConf["PublicWifi"] ~= nil or lastRight ~= usrRight then
if table.getn(WNICIdentityArr) ~= 0 then
for i = #WNICIdentityArr, 1, -1 do
WNICIdentityArr[i] = nil
end
end
if table.getn(WLANSSIDTableArr) ~= 0 then
for i = #WLANSSIDTableArr, 1, -1 do
WLANSSIDTableArr[i] = nil
end
end
if table.getn(WLANSSIDInstsArr) ~= 0 then
for i = #WLANSSIDInstsArr, 1, -1 do
WLANSSIDInstsArr[i] = nil
end
end
end
if NICNum == WLANNICNum and lastRight == usrRight and table.getn(WNICIdentityArr) ~= 0 then
return WNICIdentityArr, WLANSSIDTableArr, WLANSSIDInstsArr
end
WLANNICNum = NICNum
lastRight = usrRight
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
local ssidFileter = ""
if _G.ssidConf[usrRight] ~= nil and _G.ssidConf[usrRight].hidden ~= nil then
ssidFileter = _G.ssidConf[usrRight].hidden .. ","
end
for _,NICID in ipairs(WNICIdentityArr) do
local WLANSSIDTable = {}
local WLANSSIDPara = {}
local WLANBasicIDTable = cmapi.querylist(SSIDOBJ, NICID)
local WLANSSIDCount = 0
for i, v in ipairs(WLANBasicIDTable) do
local instTbl = cmapi.getinst(SSIDOBJ, v)
local temp = v .. ","
if instTbl.LocalSetEnable == "1" and string.find(ssidFileter,temp) == nil then
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
local function QuerySSIDOutputTbl(NICNum)
local WLANNICOBJ = "OBJ_WLANSETTING_ID"
local SSIDOBJ = "OBJ_WLANAP_ID"
local WNICIdentityArr = {}
local WLANSSIDTableArr = {}
WNICIdentityArr,WLANSSIDTableArr = QueryWCardAndSSIDIdentity(NICNum)
local OptionTbl = {}
local cardNum = WNICIdentityArr.Count;
for index = 1, cardNum do
local WNICIdentity = WNICIdentityArr[index];
local WLANBasicIDTable = WLANSSIDTableArr[index];
for i, v in ipairs(WLANBasicIDTable) do
local SSIDName = ""
local instTbl = cmapi.getinst(SSIDOBJ, v)
if instTbl.IF_ERRORID == 0 then
SSIDName = instTbl.Alias
end
local ssidTbl = {}
ssidTbl.value = v
ssidTbl.text = SSIDName
table.insert(OptionTbl, ssidTbl)
end
end
return OptionTbl
end
local function QuerySSIDOutputOption(NICNum)
local WLANNICOBJ = "OBJ_WLANSETTING_ID"
local SSIDOBJ = "OBJ_WLANAP_ID"
local WNICIdentityArr = {};
local WLANSSIDTableArr = {};
WNICIdentityArr,WLANSSIDTableArr = QueryWCardAndSSIDIdentity(NICNum)
local OptionStr = ""
local cardNum = WNICIdentityArr.Count;
for index = 1, cardNum do
local WNICIdentity = WNICIdentityArr[index];
local WLANBasicIDTable = WLANSSIDTableArr[index];
for i, v in ipairs(WLANBasicIDTable) do
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
return OptionStr
end
local function getSSIDFilterByNIC(tblWLANSSID)
local WNICIdentityArr = {}
local WLANBasicIDTableArr = {}
if tblWLANSSID and type(tblWLANSSID) == "table" then
WLANBasicIDTableArr = tblWLANSSID
else
WNICIdentityArr,WLANBasicIDTableArr = QueryWCardAndSSIDIdentity()
end
local sess_id = cgilua.getCurrentSessID()
local uRight = session_get(sess_id, "Right")
function SSIDFilterByNIC(t, identity)
if uRight == "3" then
for _, ssidTbl in pairs(WLANBasicIDTableArr) do
if ssidTbl.IF_ERRORID == 0 and ssidTbl.Count > 0 then
if identity == ssidTbl[1] then
return true
end
end
end
return false
else
for _, ssidTbl in pairs(WLANBasicIDTableArr) do
if ssidTbl.IF_ERRORID == 0 and ssidTbl.Count > 0 then
for _,ssid in ipairs(ssidTbl) do
if identity == ssid then
return true
end
end
end
end
return false
end
end
return SSIDFilterByNIC;
end
local function filterSSIDByUserRight(WLANSSIDInstsArr)
local filteredArr = {}
local sess_id = cgilua.getCurrentSessID()
local usrRight = session_get(sess_id, "Right")
for _, tbSSIDInsts in ipairs(WLANSSIDInstsArr) do
local filteredInsts = {}
for i, v in ipairs(tbSSIDInsts) do
if (1 == i and usrRight == "3") or (usrRight ~= "3") then
table.insert(filteredInsts, v)
end
end
table.insert(filteredArr, filteredInsts)
end
return filteredArr
end
local function getSSIDNameFilter(WLANSSIDInstsArr)
if not WLANSSIDInstsArr then
_,_,WLANSSIDInstsArr = QueryWCardAndSSIDIdentity()
end
local finalSSIDInstsArr = filterSSIDByUserRight(WLANSSIDInstsArr)
local FilterBySSIDName = function ( AliasName )
for _,ssidInsts in ipairs(finalSSIDInstsArr) do
for _, ssidInst in ipairs(ssidInsts) do
if ssidInst.Alias == AliasName then
return true
end
end
end
return false
end
return FilterBySSIDName
end
return {
QuerySSIDOutputTbl = QuerySSIDOutputTbl,
QuerySSIDOutputOption = QuerySSIDOutputOption,
QueryWCardAndSSIDIdentity = QueryWCardAndSSIDIdentity,
getSSIDFilterByNIC = getSSIDFilterByNIC,
getSSIDNameFilter = getSSIDNameFilter,
}
