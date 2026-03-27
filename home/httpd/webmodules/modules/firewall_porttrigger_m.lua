local cbi = require("data_assemble.comapi")
local dataruleModel = require("data_assemble.datarule")
local util = require("data_assemble.util")
module(..., package.seeall)
local FunctionArea = cbi.FunctionArea
local SetArea = cbi.SetArea
local AddInstBar = cbi.AddInstBar
local SetHeadCtrlBar = cbi.SetHeadCtrlBar
local ParRadio = cbi.ParRadio
local ParTextBox = cbi.ParTextBox
local ParTime = cbi.ParTime
local ServerHideComponent = cbi.ServerHideComponent
local BrowersHideComponent = cbi.BrowersHideComponent
local DataRuleInteger = dataruleModel.DataRuleInteger
local DataRuleUtf8 = dataruleModel.DataRuleUtf8
local DataRuleIPv4Addr = dataruleModel.DataRuleIPv4Addr
local ParPasswordText = cbi.ParPasswordText
local ComponentStyle = cbi.ComponentStyle
local ParSelect = cbi.ParSelect
local ParIPv4 = cbi.ParIPv4
local RangeBox = cbi.RangeBox
functionId = "portTrigger"
modelArea = FunctionArea(functionId, nil, lang.PortTrigger_001)
local instSwitchTbl = {
dataID = "OBJ_FWPT_ID",
dataField = "Enable",
switchTable = { {value="1", text=lang.public_033}, {value="0", text=lang.public_034} },
deftValue = "0"
}
ptSetArea = SetArea(functionId, 1, util.PathSeparatorChar.. util.luaPath2LocalPath(_NAME), instSwitchTbl)
ptSetArea.dataModel = "IGD"
name = ParTextBox(functionId, "OBJ_FWPT_ID", "Name", lang.public_016)
local nameRule = DataRuleUtf8(true, 1, 32)
name:bindDataRule(nameRule)
ptSetArea:append(name)
ptSetArea:bindInstName(name)
ipAddr = ParIPv4(functionId, "OBJ_FWPT_ID", "TriggleIpAddress", lang.PortTrigger_003)
AddrIPv4Rule = DataRuleIPv4Addr(true)
ipAddr:bindDataRule(AddrIPv4Rule)
ptSetArea:append(ipAddr)
trigProtocol = ParSelect(functionId, "OBJ_FWPT_ID", "TriggleProtocol", lang.PortTrigger_004, {{text=lang.public_036,value="0"},{text=lang.public_037,value="1"}, {text=lang.public_040, value="2"}}, "0")
ptSetArea:append(trigProtocol)
port = ParTextBox(functionId, "OBJ_FWPT_ID", "TriggleDestPort", lang.PortTrigger_005)
portRule = DataRuleInteger(true, 1, 65535)
port:bindDataRule(portRule)
ptSetArea:append(port)
incProtocol = ParSelect(functionId, "OBJ_FWPT_ID", "IncomeProtocol", lang.PortTrigger_006, {{text=lang.public_036,value="0"},{text=lang.public_037,value="1"}, {text=lang.public_040, value="2"}}, "0")
ptSetArea:append(incProtocol)
function setPortWidth(self, env)
self.__parent.render(self, env)
self:replaceAttributeValByID(self.id, "class", "inputNorm", "port")
return self.html
end
minPort = ParTextBox(functionId, "OBJ_FWPT_ID", "IncomeMinPort",lang.PortTrigger_007)
minPort:bindDataRule(portRule)
minPort.render = setPortWidth
maxPort = ParTextBox(functionId, "OBJ_FWPT_ID", "IncomeMaxPort",lang.PortTrigger_007)
maxPort:bindDataRule(portRule)
maxPort.render = setPortWidth
portRange = RangeBox(minPort, "<=", maxPort, true, 9)
ptSetArea:append(portRange)
timeout = ParTextBox(functionId, "OBJ_FWPT_ID", "Timeout", lang.PortTrigger_009,lang.public_013)
timeout.deftValue = "1200"
timeout:bindDataRule(DataRuleInteger(true, 60, 1800))
ptSetArea:append(timeout)
modelArea:append(ptSetArea)
