<script type="text/javascript">
(function(){
var pageConf = JSON.parse("<%=page.jsInfo%>");
$(document).ready(function(){
var commStatusHeadID = pageConf.id;
var commStatusHead = $("#"+commStatusHeadID);
var commStatusContainer = $("#"+commStatusHeadID+"_container");
var commStatusTemplate = $("#template_"+commStatusHeadID);
var ServerAddr = $("address span", commStatusHead).text();
RefreshClickHandle(commStatusHead);
commStatusHead.chanegeDataByCustom =function(xml){
colorTblRow(".colorTbl", "even", commStatusHead);
};
commStatusHead.fillDataByCustom =function(xml){
};
commStatusHead.succfunction = function(xml){
var cmapiErrorContainer = $(".errorHint",commStatusHead);
if (cmapiErrorContainer.hasError(xml) == 0){
commStatusHead.chanegeDataByCustom(xml);
if(pageConf.mode=="single"){
commStatusHead.fillDataByOBJID(xml, pageConf.objList, commStatusContainer, 0);
}
else{
var OBJName = pageConf.objList[0];
var instNum = xml[OBJName].Instance.length;
commStatusHead.createPageDataByClone(instNum, pageConf.objList, xml, commStatusHead.fillDataByCustom);
}
}
};
if ( $(".collapBarWithDataTrans",commStatusHead).length <= 0 ){
commStatusHead.dataTransfer(ServerAddr,"GET",commStatusHead.succfunction);
}
else{
initial_collapBarWithDataTrans(commStatusHead);
}
});
})();
</script>
