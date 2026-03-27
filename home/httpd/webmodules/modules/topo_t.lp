<%
%>
<%
cgilua.lp.include("../../webmodules/modules/topo_js.lp", getfenv(1))
if env.getenv("TopoPageVer") == "v2" then
%>
<style type="text/css">
<%
cgilua.lp.include("../../public/css/topo_v2.css")
%>
</style>
<%
cgilua.lp.include("../../webmodules/modules/topo_v2_common_t.lp", getfenv(1))
else
%>
<style type="text/css">
<%
cgilua.lp.include("../../public/css/topo.css")
%>
</style>
<%
cgilua.lp.include("../../webmodules/modules/topo_common_t.lp", getfenv(1))
end
%>
