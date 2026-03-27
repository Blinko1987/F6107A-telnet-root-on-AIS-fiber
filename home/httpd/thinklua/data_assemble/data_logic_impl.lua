local oopclass = require("common_lib.oop_class")
local class = oopclass.class
local assertlib = require("common_lib.assert_utils")
local typeAssert = assertlib.typeAssert
local valueAssert = assertlib.valueAssert
local AttrNode = require("common_lib.attr_node_class")
local cgilua = require("cgilua.cgilua")
local cgilua_lp = require "cgilua.lp"
local cbi = require("data_assemble.comapi")
local doModelRequest = cbi.doModelRequest
local model = require("model.modelParse")
local handleDataRequest = model.handleDataRequest
local fileutils = require"common_lib.file_utils"
local remove_suffix_filename = fileutils.remove_suffix_filename
local dataTableMgr = require("data_assemble.data_table_mgr")
local DataAssembleLogic = class()
DataAssembleLogic.loadDataRules = function ( self )
dataTableMgr:loadStaticConfig({
tableFile="data_assemble.data_table_conf",
modifierFile="data_assemble.data_table_modifier"
})
end
DataAssembleLogic.run = function ( self, fileList, routerType )
g_logger:debug("routerType="..tostring(routerType))
routerType = routerType or ""
fileList = fileList or {}
cgilua.contentheader ("text", "xml; charset="..lang.CHARSET)
local assembleRule = dataTableMgr:findItem(routerType)
if assembleRule then
local assembleFile = assembleRule:getAttribute("assembleFile")
if type(assembleFile) == "function" then
assembleFile(fileList)
elseif type(assembleFile) == "string" then
dofile(assembleFile)
end
else
local firstFile = fileList[1]
if firstFile then
local filePath = firstFile.file
if string.find(filePath, "_m%.lua") then
local util = require("data_assemble.util")
local datafile = util.strippath(filePath)
local modelName = remove_suffix_filename(datafile)
local modelPath = "modules."..modelName
doModelRequest(modelPath, cgilua)
elseif string.find(filePath, "_model%.lua") then
local util = require("data_assemble.util")
local datafile = util.strippath(filePath)
local modelName = remove_suffix_filename(datafile)
handleDataRequest(modelName)
else
dofile(firstFile.file)
end
else
cgilua_lp.include("../template/NotFoundData.xml", {cgilua=cgilua})
end
end
end
local dataAssembler = DataAssembleLogic()
dataAssembler:loadDataRules()
return dataAssembler
