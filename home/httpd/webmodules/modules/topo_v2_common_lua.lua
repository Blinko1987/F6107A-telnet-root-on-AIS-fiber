local OBJ_LISTAP_TOPO = "OBJ_LISTAPTOPO_ID"
local OBJ_GETTOPO_AD = "OBJ_GETTOPOAD_ID"
local function getPopDataBaseParentID(parentId)
local morelannum = 0
local morewlan2Gnum = 0
local morewlan5Gnum = 0
local morecascade={
master={},
lan={},
wlan2G={},
wlan5G={}
}
local master = cmapi.getinst(OBJ_LISTAP_TOPO, parentId)
master.instID = id
morecascade.master = master
local parentAD = cmapi.querylist(OBJ_GETTOPO_AD, parentId)
local parentADcounts = parentAD.Count
for j=1, parentADcounts do
local master_id = parentAD[j].InstName or parentAD[j]
local master_adtab = cmapi.getinst(OBJ_GETTOPO_AD, master_id)
if master_adtab.AccessType == "0" then
table.insert(morecascade.lan, master_adtab)
morelannum = morelannum + 1
elseif master_adtab.AccessType == "1" then
table.insert(morecascade.wlan2G, master_adtab)
morewlan2Gnum = morewlan2Gnum + 1
else
table.insert(morecascade.wlan5G, master_adtab)
morewlan5Gnum = morewlan5Gnum + 1
end
end
morecascade.lan["MGET_INST_NUM"] = morelannum
morecascade.wlan2G["MGET_INST_NUM"] = morewlan2Gnum
morecascade.wlan5G["MGET_INST_NUM"] = morewlan5Gnum
return morecascade
end
local function getTopoSvgData()
local cascade={
controllerData={},
agentlay1={},
agentlay2={}
}
local agentlay1num = 0
local agentlay2num = 0
local reTable = cmapi.querylist(OBJ_LISTAP_TOPO, "IGD")
if reTable.IF_ERRORID == 0 then
local count = reTable.Count
for i=1, count do
local master_id = reTable[i].InstName or reTable[i]
local master = cmapi.getinst(OBJ_LISTAP_TOPO, master_id)
master.instID = master_id
cascade.controllerData = master
local masterAD = cmapi.querylist(OBJ_GETTOPO_AD, master_id)
cascade.controllerData.accdevCount = masterAD.Count
local slave1_querytab = cmapi.querylist(OBJ_LISTAP_TOPO, master_id)
local slave1_counts = slave1_querytab.Count
if slave1_querytab.IF_ERRORID == 0 and slave1_counts > 0 then
for i=1, slave1_counts do
local slave1_instid = slave1_querytab[i].InstName or slave1_querytab[i]
local slave1_gettab = cmapi.getinst(OBJ_LISTAP_TOPO, slave1_instid)
slave1_gettab.instID = slave1_instid
local slave1_adtab = cmapi.querylist(OBJ_GETTOPO_AD, slave1_instid)
slave1_gettab.accdevCount = slave1_adtab.Count
cascade.agentlay1[agentlay1num] = slave1_gettab
agentlay1num = agentlay1num + 1
local slave2_querytab = cmapi.querylist(OBJ_LISTAP_TOPO, slave1_instid)
local slave2_count = slave2_querytab.Count
if slave2_querytab.IF_ERRORID == 0 and slave2_count > 0 then
for i=1, slave2_count do
local slave2_instid = slave2_querytab[i].InstName or slave2_querytab[i]
local slave2_gettab = cmapi.getinst(OBJ_LISTAP_TOPO, slave2_instid)
local slave2_adtab = cmapi.querylist(OBJ_GETTOPO_AD, slave2_instid)
slave2_gettab.accdevCount = slave2_adtab.Count
slave2_gettab.instID = slave2_instid
slave2_gettab.instID_Parent = slave1_instid
cascade.agentlay2[agentlay2num] = slave2_gettab
agentlay2num = agentlay2num + 1
end
end
end
end
end
cascade.agentlay1["MGET_INST_NUM"] = agentlay1num
cascade.agentlay2["MGET_INST_NUM"] = agentlay2num
end
return cascade
end
local function getALLAP()
local cascade={
apData={}
}
local apnum = 0
local reTable = cmapi.querylist(OBJ_LISTAP_TOPO, "IGD")
if reTable.IF_ERRORID == 0 then
local count = reTable.Count
for i=1, count do
local master_id = reTable[i].InstName or reTable[i]
local master_tab = cmapi.getinst(OBJ_LISTAP_TOPO, master_id)
master_tab.instID = master_id
master_tab.role = "controller"
table.insert (cascade.apData, master_tab)
apnum = apnum + 1
local slave1_quetab = cmapi.querylist(OBJ_LISTAP_TOPO, master_id)
local counts = slave1_quetab.Count
if slave1_quetab.IF_ERRORID == 0 and counts > 0 then
for i=1, counts do
local slave1_id = slave1_quetab[i].InstName or slave1_quetab[i]
local slave1_gettab = cmapi.getinst(OBJ_LISTAP_TOPO, slave1_id)
slave1_gettab.instID = slave1_id
slave1_gettab.role = "agent"
table.insert (cascade.apData, slave1_gettab)
apnum = apnum + 1
local slave2_quetab = cmapi.querylist(OBJ_LISTAP_TOPO, slave1_id)
local slaveCount = slave2_quetab.Count
if slave2_quetab.IF_ERRORID == 0 and slaveCount > 0 then
for i=1, slaveCount do
local slave2_id = slave2_quetab[i].InstName or slave2_quetab[i]
local slave2_gettab = cmapi.getinst(OBJ_LISTAP_TOPO, slave2_id)
slave2_gettab.instID = slave2_id
slave2_gettab.instID_Parent = slave1_id
slave2_gettab.role = "agent"
table.insert (cascade.apData, slave2_gettab)
apnum = apnum + 1
end
end
end
end
end
cascade.apData["MGET_INST_NUM"] = apnum
end
return cascade
end
local function getALLClients()
local cascade={
clientsData = {}
}
local clientnum = 0
local reTable = cmapi.querylist(OBJ_LISTAP_TOPO, "IGD")
if reTable.IF_ERRORID == 0 then
local count = reTable.Count
for i=1, count do
local master_id = reTable[i].InstName or reTable[i]
local master_adquerytab = cmapi.querylist(OBJ_GETTOPO_AD, master_id)
local masterADcounts = master_adquerytab.Count
for j=1, masterADcounts do
local master_adid = master_adquerytab[j].InstName or master_adquerytab[j]
local master_adtab = cmapi.getinst(OBJ_GETTOPO_AD, master_adid)
master_adtab.parent = master_id
master_adtab.parentType = "controller"
table.insert (cascade.clientsData, master_adtab)
clientnum = clientnum + 1
end
local slave1_querytbl = cmapi.querylist(OBJ_LISTAP_TOPO, master_id)
local counts = slave1_querytbl.Count
if slave1_querytbl.IF_ERRORID == 0 and counts > 0 then
for i=1, counts do
local slave1_id = slave1_querytbl[i].InstName or slave1_querytbl[i]
local slave1_adquerytab = cmapi.querylist(OBJ_GETTOPO_AD, slave1_id)
local slave1_counts = slave1_adquerytab.Count
for k=1, slave1_counts do
local slave1_adinst = slave1_adquerytab[k].InstName or slave1_adquerytab[k]
local slave1_adtab = cmapi.getinst(OBJ_GETTOPO_AD, slave1_adinst)
slave1_adtab.parent = slave1_id
slave1_adtab.parentType = "agent"
table.insert (cascade.clientsData, slave1_adtab)
clientnum = clientnum + 1
end
local slave2_querytbl = cmapi.querylist(OBJ_LISTAP_TOPO, slave1_id)
local slaveCount = slave2_querytbl.Count
if slave2_querytbl.IF_ERRORID == 0 and slaveCount > 0 then
for i=1, slaveCount do
local slave2_id = slave2_querytbl[i].InstName or slave2_querytbl[i]
local slave2_adquetbl = cmapi.querylist(OBJ_GETTOPO_AD, slave2_id)
local slave2_counts = slave2_adquetbl.Count
for k=1, slave2_counts do
local slave2_adinst = slave2_adquetbl[k].InstName or slave2_adquetbl[k]
local slave2_adtbl = cmapi.getinst(OBJ_GETTOPO_AD, slave2_adinst)
slave2_adtbl.parent = slave2_id
slave2_adtbl.parentType = "agent"
table.insert (cascade.clientsData, slave2_adtbl)
clientnum = clientnum + 1
end
end
end
end
end
end
cascade.clientsData["MGET_INST_NUM"] = clientnum
end
return cascade
end
local function setAlias()
local id = cgilua.POST.InstIdentity
local setData = {}
setData["Alias"] = cgilua.POST.Alias
setData["InstIdentity"] = id
cgilua.POST._sessionTOKEN = session_get(cgilua.getCurrentSessID(), "sess_token")
return cmapi.setinst("OBJ_TOPOALIAS_ID", id, setData)
end
return {
getPopDataBaseParentID = getPopDataBaseParentID,
getALLAP = getALLAP,
getALLClients = getALLClients,
getTopoSvgData = getTopoSvgData,
setAlias = setAlias
}
