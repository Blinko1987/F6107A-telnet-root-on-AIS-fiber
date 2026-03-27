local cgilua = package.loaded["cgilua.cgilua"]
if cgilua then
return cgilua
else
cgilua = require("cgilua.cgilua")
return cgilua
end
