dmenu:addModifierLoader( function ()
dmenu:newPage(
{
id="HardwareDiag",
name=lang.hwdiag_001,
right=3,
pageHelp=lang.hwdiag_016,
areas={
{area="hardware_diag_t.lp", backendFile="hardware_diag_lua.lua"},
}
}
)
:appendTo("diagnosis")
end)
