local gd = require"gd"
local sessmgr = require("user_mgr.session_mgr")
local function genCaptcha()
local CHAR = "ABCDEFGHIJKLMNPQRSTUVWXYZ123456789"
CHAR = "ABCDEFGHJKLMNPQRSTUVWXYZ23456789abcdefghijkmnopqrstuvwxyz"
local length = CHAR:len()
local TEXT_NUM = 5
local captcha = ""
local IMG_WIDTH, IMG_HEIGHT = 60, 20
TEXT_NUM = 6
IMG_WIDTH = 70
local im = gd.createTrueColor(IMG_WIDTH,IMG_HEIGHT)
local fg = im:colorAllocate(0,143,213)
local bg = im:colorAllocate(247,247,247)
im:filledRectangle(0,0,IMG_WIDTH,IMG_HEIGHT,bg)
for i = 1, TEXT_NUM do
local n = math.random(length)
captcha = captcha .. CHAR:sub(n, n)
end
im:string(gd.FONT_GIANT, 5, 2, captcha, fg)
if env.getenv("CountryCode") == "36" then
local l1 = math.random(IMG_HEIGHT-1)
local l2 = math.random(IMG_HEIGHT-1)
local l3 = math.random(IMG_HEIGHT-1)
local l4 = math.random(IMG_HEIGHT-1)
local w1 = math.random(20)
im:line(0,l1,30-w1,l2,fg)
im:line(30-w1,l2,30+w1,l3,fg)
im:line(30+w1,l3,IMG_WIDTH,l4,fg)
end
im:jpeg("/var/tmp/webimg/captcha.jpg", 100)
sessmgr.SetCurrentSessAttr("CAPTCHA", captcha)
end
sessmgr.setCaptchaImgDir("/var/tmp/webimg/")
genCaptcha()
