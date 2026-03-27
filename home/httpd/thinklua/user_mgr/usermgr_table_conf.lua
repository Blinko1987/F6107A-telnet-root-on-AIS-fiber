local function getUsersBeKicked( ... )
return {}
end
local userMgrAttrTable = {
{attr="needAuth", value="ALL", opts={dftUser="1"}, func=nil},
{attr="userLevel", value="0", func=nil},
{attr="fromLANorWAN", value="ALL"},
{attr="authType", value="form", func=nil},
{attr="autofillUsername", value=0, opts={disableUsername=false}},
{attr="autofillPassword", value=0, opts={disablePassword=false}},
{attr="loginPolicy", value="preempt", opts={beKickedUsers=getUsersBeKicked}},
{attr="chpwdMode", value="optional", opts={typeofOptional="repeat-until"}},
{attr="sessMax", value=100},
{attr="userMax", value=1},
{attr="lockTimeout", value=60},
{attr="lockMaxTime", value=3},
}
return userMgrAttrTable
