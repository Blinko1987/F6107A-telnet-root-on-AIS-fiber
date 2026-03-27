local modulesPath = "../../webmodules/modules/"
local hiddenTable = {
{basicType="view", urlPath="http2httpsRedirectPage.lp", fileName="../template/http2httpsRedirectPage.lp", needLogin=false, right=nil},
{basicType="view", urlPath="frRequestTimeout.lp", fileName="../template/frRequestTimeout.lp", needLogin=false, right=nil},
{basicType="data", urlPath="switchlang_entry", fileName="../view_assemble/lang_switch_data.lua", needLogin=false, right=nil},
{basicType="data", urlPath="sntp_data", fileName=modulesPath.."sntp_lua.lua", needLogin=true, right=nil, needSessUpdate=false},
{basicType="data", urlPath="sntp_tem_data", fileName=modulesPath.."sntp_tem_lua.lua", needLogin=true, right=nil, needSessUpdate=false},
{basicType="data", urlPath="accessdev_data", fileName=modulesPath.."accessdev_query_lua.lua", needLogin=true, right=nil},
{basicType="data", urlPath="captcha_data", fileName="../user_mgr/login_captcha_lua.lua", needLogin=false, right=nil},
}
return hiddenTable
