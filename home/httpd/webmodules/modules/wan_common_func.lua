local function CreateServlistChkBoxGroup()
local TmpStr = ""
local pctlTbl = cmapi.ListServlist()
for i,v in ipairs(pctlTbl) do
local InputStrHead = "<input type=\"checkbox"
.. "\" name=\"Servlist_" .. v.ServlistName
.. "\" id=\"Servlist_" .. v.ServlistName
.. "\" servlistName=\"".. v.ServlistName
.. "\" IsPd=\"".. v.IsPd
.. "\" checked= \"checked\">"
local LabelStr = "<label for=\"Servlist_".. v.ServlistName
.. "\">" .. v.ServlistName
.. "</label>"
local StrTail = "&nbsp;&nbsp"
TmpStr = TmpStr .. InputStrHead .. LabelStr .. StrTail
end
return TmpStr
end
local function Create3GServlistChkBoxGroup()
local TmpStr = ""
local pctlTbl = cmapi.ListServlist()
for i,v in ipairs(pctlTbl) do
local InputStrHead = "<input type=\"checkbox"
.. "\" name=\"Servlist_" .. v.ServlistName
.. "\" id=\"Servlist_" .. v.ServlistName
.. "\" servlistName=\"".. v.ServlistName
.. "\" IsPd=\"".. v.IsPd
.. "\" checked= \"checked\">"
local LabelStr = "<label for=\"Servlist_".. v.ServlistName
.. "\">" .. v.ServlistName
.. "</label>"
local StrTail = "&nbsp;&nbsp"
if v.Is3GShow == 1 then
TmpStr = TmpStr .. InputStrHead .. LabelStr .. StrTail
end
end
return TmpStr
end
return {
CreateServlistChkBoxGroup = CreateServlistChkBoxGroup,
Create3GServlistChkBoxGroup = Create3GServlistChkBoxGroup,
}
