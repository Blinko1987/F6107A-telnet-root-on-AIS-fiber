local date = os.date
local gsub,format = string.gsub,string.format
local function readfile(filename)
local fh = assert (io.open (filename))
local src = fh:read("*a")
fh:close()
return src
end
function web_service_erroroutput()
sapi.Response.contenttype ("text/html")
local notFoundHtml = readfile("../template/NotFoundPage.html")
sapi.Response.write (notFoundHtml)
end
function my_default_erroroutput(msg)
if type(msg) ~= "string" and type(msg) ~= "number" then
msg = format ("bad argument #1 to 'error' (string expected, got %s)", type(msg))
end
web_service_erroroutput()
sapi.Response.errorlog (msg)
sapi.Response.errorlog (" ")
sapi.Response.errorlog (sapi.Request.servervariable"REMOTE_ADDR")
sapi.Response.errorlog (" ")
sapi.Response.errorlog (date())
sapi.Response.errorlog ("\n")
end
function web_service_go2_login_page()
sapi.Response.contenttype ("text/html")
local notFoundHtml = readfile("../template/NotFoundPage_reload.html")
sapi.Response.write (notFoundHtml)
end
