<%
cgilua_lp.include("../../webmodules/modules/wwan_pin_public_js.lp", getfenv(1))
%>
<%
local wwanCommFunc = require "modules.wwan_common_func"
local PageStatus = wwanCommFunc.QueryDongleCardStatus()
if "Dev_FAILURE" == PageStatus then
cgilua_lp.include("../../webmodules/modules/wwan_pin_devfail_t.lp", getfenv(1))
elseif "Dev_IDENTYING" == PageStatus then
cgilua_lp.include("../../webmodules/modules/wwan_pin_devidentying_t.lp", getfenv(1))
elseif "Dev_IDENTYNOK" == PageStatus then
cgilua_lp.include("../../webmodules/modules/wwan_pin_devidentynok_t.lp", getfenv(1))
elseif "Dev_IDENTYOKONLY" == PageStatus or "GenSIM_READY" == PageStatus then
cgilua_lp.include("../../webmodules/modules/wwan_pin_devidentyokonly_t.lp", getfenv(1))
elseif "SIM_READY" == PageStatus then
cgilua_lp.include("../../webmodules/modules/wwan_pin_pinreadystatus_t.lp", getfenv(1))
elseif "INPUT_PIN" == PageStatus then
cgilua_lp.include("../../webmodules/modules/wwan_pin_pininput_t.lp", getfenv(1))
elseif "INPUT_PUK" == PageStatus then
cgilua_lp.include("../../webmodules/modules/wwan_pin_pukinput_t.lp", getfenv(1))
elseif "SIM_BUSY" == PageStatus then
cgilua_lp.include("../../webmodules/modules/wwan_pin_pinsimbusy_t.lp", getfenv(1))
elseif "SIM_FAILURE" == PageStatus then
cgilua_lp.include("../../webmodules/modules/wwan_pin_pinsimfail_t.lp", getfenv(1))
elseif "PAGE_OTHER_STATE" == PageStatus then
cgilua_lp.include("../../webmodules/modules/wwan_pin_pinexcept_t.lp", getfenv(1))
end
%>
