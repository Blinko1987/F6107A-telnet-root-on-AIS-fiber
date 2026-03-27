local json = require("common_lib.json")
local cgilua = require("cgilua.cgilua")
local langLogicImpl = require("view_assemble.lang_logic_impl")
local DBLangCtr = ""
local t = cmapi.getinst("OBJ_USERIF_ID", "")
if t.IF_ERRORID == 0 then
if t.LanguageCtr == "" then
DBLangCtr = "cn"
else
DBLangCtr = t.LanguageCtr
end
end
local newLanguage = cgilua.POST.IF_LanguageSwitch
local LangCtr = ""
local isSwitch = false
if newLanguage == "English" then
isSwitch = true
else
if newLanguage == "Chinese" then
LangCtr = "cn"
elseif newLanguage == "Spanish" then
LangCtr = "sp"
elseif newLanguage == "Japanese" then
LangCtr = "jp"
elseif newLanguage == "Portuguese" then
LangCtr = "pt"
elseif newLanguage == "French" then
LangCtr = "fr"
elseif newLanguage == "Russian" then
LangCtr = "rus"
elseif newLanguage == "Romanian" then
LangCtr = "ro"
elseif newLanguage == "Italian" then
LangCtr = "it"
elseif newLanguage == "Turkey" then
LangCtr = "tu"
end
if LangCtr == DBLangCtr then
isSwitch = true
end
end
if newLanguage and isSwitch==true and
newLanguage ~= "" then
langLogicImpl:switchLangName(newLanguage)
g_logger:debug("language is set to  " .. tostring(newLanguage))
cgilua.put( json.encode({need_refresh=true}) )
end
cgilua.contentheader ("application", "json; charset="..lang.CHARSET)
