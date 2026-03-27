local fwscServCtl = ""
if _G.commConf.serviceCtl["fwscServCtl"] ~= nil then
fwscServCtl = _G.commConf.serviceCtl["fwscServCtl"]
end
local Right = ""
local uRight = nil
local sess_id = nil
local function CreateFwSCChkBoxGroup( IPMode )
sess_id = cgilua.cgilua.getCurrentSessID()
Right = session_get(sess_id, "Right")
uRight = string.match(fwscServCtl, "(%d+)")
local TmpStr = ""
local pctlTbl = cmapi.ListServCtlByMode(IPMode)
local scAddStr = ""
if IPMode == "IPv6" then
scAddStr = ":IPv6serviceCtl"
end
for i,v in ipairs(pctlTbl) do
local ProtocolNameTmp = v.ProtocolName .. ","
local findLocation = nil
if uRight == nil or uRight == Right then
findLocation = string.find(fwscServCtl,ProtocolNameTmp,1)
end
if findLocation == nil then
local InputStrHead = "<input type=\"checkbox"
.. "\" name=\"Servise_" .. v.ProtocolName .. scAddStr
.. "\" id=\"Servise_" .. v.ProtocolName.. scAddStr
.. "\" serviceName=\"".. v.ProtocolName
.. "\">"
local LabelStr = "<label for=\"Servise_".. v.ProtocolName .. scAddStr
.. "\">" .. v.ProtocolName
.. "</label>"
local StrTail = "&nbsp;&nbsp"
TmpStr = TmpStr .. InputStrHead .. LabelStr .. StrTail
end
end
return TmpStr
end
local function CreateFwSCSelectGroup( IPMode )
sess_id = cgilua.cgilua.getCurrentSessID()
Right = session_get(sess_id, "Right")
uRight = string.match(fwscServCtl, "(%d+)")
local IFOpStr = ""
local pctlTbl = cmapi.ListServCtlByMode(IPMode)
for i,v in ipairs(pctlTbl) do
local ProtocolNameTmp = v.ProtocolName .. ","
local findLocation = nil
if uRight == nil or uRight == Right then
findLocation = string.find(fwscServCtl,ProtocolNameTmp,1)
end
if findLocation == nil then
local IFOpStrHead = "<option value='" .. encodeHTML(v.ProtocolName)
.. "' title='" .. encodeHTML(v.ProtocolName)
.. "' "
local IFOpStrTail = ">"
.. encodeHTML(v.ProtocolName)
.. "</option>"
IFOpStr = IFOpStr .. IFOpStrHead .. IFOpStrTail
end
end
return IFOpStr
end
return {
CreateFwSCChkBoxGroup = CreateFwSCChkBoxGroup,
CreateFwSCSelectGroup = CreateFwSCSelectGroup
}
