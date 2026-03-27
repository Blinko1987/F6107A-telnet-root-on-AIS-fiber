local oopclass = require("common_lib.oop_class")
local class = oopclass.class
local assertlib = require("common_lib.assert_utils")
local typeAssert = assertlib.typeAssert
local valueAssert = assertlib.valueAssert
local cgilua = require("cgilua.cgilua")
local getinst = cmapi.getinst
local setinst = cmapi.nocsrf.setinst
local langTableMgr = require("view_assemble.lang_table_mgr")
local LangLogicImplClass = class()
LangLogicImplClass.__init__ = function ( self )
self.langName = nil
self.lang_source = nil
end
LangLogicImplClass.__getLangName = function (self)
t = getinst("OBJ_USERIF_ID", "")
if type(t) == "table" then
return t.Language
end
return nil
end
LangLogicImplClass.__setLangName = function (self, langName)
typeAssert(langName, "string")
local t = {Language=langName}
setinst("OBJ_LANGUAGEUSERIF_ID", "", t)
end
LangLogicImplClass.__recordCurrLang = function (self)
local langName = self:__getLangName()
self.langName = langName
end
LangLogicImplClass.__loadLangRules = function ( self )
langTableMgr:loadStaticConfig({
tableFile="view_assemble.lang_table_conf",
modifierFile="view_assemble.lang_table_modifier"
})
end
LangLogicImplClass.__loadSource = function (self)
local langName = self.langName
local langItem = langTableMgr:findItem(langName)
if not langItem then
langItem = langTableMgr:findItemByIndex(1)
if not langItem then
error("there is no instance in langtable.")
end
end
local langFileName = langItem:getAttribute("langFileName")
require("config.".. langFileName)
local langTableName = langItem:getAttribute("langTableName")
self.lang_source = _G[langTableName]
env.setenv("gw_lang", langName)
end
LangLogicImplClass.initialize = function (self)
local langName = env.getenv("gw_lang")
if langName == "N/A"
or not self.lang_source then
self:__recordCurrLang()
self:__loadSource()
end
return self.lang_source
end
LangLogicImplClass.switchLangName = function (self, langName)
typeAssert(langName, "string")
self:__setLangName(langName)
env.unsetenv("gw_lang")
end
local langLogicImpl = LangLogicImplClass()
langLogicImpl:__loadLangRules()
return langLogicImpl
