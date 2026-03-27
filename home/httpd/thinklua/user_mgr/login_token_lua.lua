require "data_assemble.common_lua"
local logintoken = _G.math.random(10000000,99999999)
env.setenv("logintoken", logintoken)
outputXML(logintoken)
