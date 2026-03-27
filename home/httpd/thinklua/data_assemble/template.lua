local cgilua = require "cgilua.cgilua"
local util = require "data_assemble.util"
local tostring, pairs, loadstring, string = tostring, pairs, loadstring, string
local setmetatable, loadfile = setmetatable, loadfile
local getfenv, setfenv, rawget = getfenv, setfenv, rawget
local assert, type, error = assert, type, error
local io, print = io, print
local _G = _G
local g_logger = g_logger
local sess_id = sess_id
local lang = lang
local table = table
local logapi = logapi
local cgilualp = require "cgilua.lp"
local include = cgilualp.include4lp
local readfile = cgilualp.readfile
local getoutfunc = cgilualp.getoutfunc
local setoutfunc = cgilualp.setoutfunc
module("data_assemble.template")
local viewdir = "../template/luquid_template/"
function setTemplatePath(pathName)
if nil == string.find(viewdir,pathName) then
viewdir = viewdir .. pathName .. "/"
end
end
Template = util.class()
Template.cache = setmetatable({}, {__mode = "v"})
function Template.__init__(self, name, sessionID)
self.name = name
self.tmpCache = {}
self.oldOutFunc = nil
self.sessionID = sessionID or sess_id
end
function Template.runTemplate(self, tmplateItem)
table.insert(self.tmpCache, tmplateItem)
end
function Template.SetUp(self)
local outfunc = "temp:runTemplate"
Template.oldOutFunc = Template.oldOutFunc or getoutfunc()
setoutfunc(outfunc)
end
function Template.TearDown(self)
setoutfunc(Template.oldOutFunc)
end
function Template.procTemplate(self, userObj, env, sourcefile)
self.tmpCache = {}
local parentObj = env.self or {}
local parentTemp = env.temp or {}
env.self = userObj
env.temp = self
include(sourcefile, env, true)
env.self = parentObj
env.temp = parentTemp
return table.concat(self.tmpCache)
end
function Template.render(self, userObj, env)
if self.name == nil then
g_logger:warn("self.name nil")
return ""
end
local sourcefile = viewdir .. "/" .. self.name .. ".tlp"
return self:procTemplate(userObj, env, sourcefile)
end
function Template.getScript(self, userObj, env)
if self.name == nil then
return ""
end
local sourcefile = viewdir .. "/" .. self.name .. ".tjp"
local tempScript = self:procTemplate(userObj, env, sourcefile)
return tempScript
end
function Template.getScriptClass(self, userObj, env)
if self.name == nil then
return ""
end
local sourcefile = viewdir .. "/" .. self.name .. ".js"
local classScript = readfile(sourcefile)
return classScript
end
function Template.output(self, userObj, content, env)
_G.sapi.Response.write(content)
end
