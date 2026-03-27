local loginTable = {
{basicType="view", loginType="preempt", fileName="../template/login_preempt_t.lp", needLogin=false},
{basicType="view", loginType="unchecked", fileName="../template/login_t.lp", needLogin=false},
{basicType="view", loginType="locked", fileName="../template/login_t.lp", needLogin=false},
{basicType="view", loginType="timeout", fileName="../template/login_t.lp", needLogin=false},
{basicType="view", loginType="block", fileName="../template/login_t.lp", needLogin=false},
{basicType="view", loginType="chpwd", fileName="../template/login_chpwd_t.lp", needLogin=false},
{basicType="view", loginType="checkAccessFrom", fileName="../template/login_checkaccessfrom_t.lp", needLogin=false},
{basicType="view", loginType="autoAuth", fileName="../template/login_autoauth_t.lp", needLogin=false},
{basicType="view", loginType="wanneedchpwd", fileName="../template/login_wanneedchgpwd_t.lp", needLogin=false},
{basicType="data", loginType="login_entry", fileName="../user_mgr/login_data.lua", needLogin=false},
{basicType="data", loginType="login_preempt", fileName="../user_mgr/login_preempt_data.lua", needLogin=false},
{basicType="data", loginType="login_changepwd", fileName="../user_mgr/login_chpwd_data.lua", needLogin=false},
{basicType="data", loginType="login_token", fileName="../user_mgr/login_token_lua.lua", needLogin=false},
{basicType="data", loginType="logout_entry", fileName="../user_mgr/logout_data.lua", needLogin=true},
{basicType="data", loginType="modeswitch_entry", fileName="../user_mgr/mode_switch_data.lua", needLogin=true},
}
return loginTable
