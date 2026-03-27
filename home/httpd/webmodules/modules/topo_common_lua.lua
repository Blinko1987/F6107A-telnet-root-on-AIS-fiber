local OBJ_TOPO = "OBJ_LISTAPTOPO_ID"
local OBJ_AD = "OBJ_GETTOPOAD_ID"
local function getAccessDevInfoByType(parentId, accessType)
local moreadnum = 0
local morecascade={
master={},
slave={},
ad={}
}
local parentAD = cmapi.querylist(OBJ_AD, parentId)
local parentADcounts = parentAD.Count
for j=1, parentADcounts do
local inst_id = parentAD[j].InstName or parentAD[j]
local ADTemp = cmapi.getinst(OBJ_AD, inst_id)
if ADTemp.AccessType == accessType then
table.insert(morecascade.ad, ADTemp)
moreadnum = moreadnum + 1
end
end
morecascade.ad["MGET_INST_NUM"] = moreadnum
return morecascade
end
local function getTopoCascade()
local cascade={
master={},
slave={},
ad={}
}
local adnum = 0
local reTable = cmapi.querylist(OBJ_TOPO, "IGD")
if reTable.IF_ERRORID == 0 then
local count = reTable.Count
for i=1, count do
local id = reTable[i].InstName or reTable[i]
local master = cmapi.getinst(OBJ_TOPO, id)
master.instID = id
cascade.master = master
local masterAD = cmapi.querylist(OBJ_AD, id)
local masterADcounts = masterAD.Count
for j=1, masterADcounts do
local inst_id = masterAD[j].InstName or masterAD[j]
local ADTemp = cmapi.getinst(OBJ_AD, inst_id)
ADTemp.parent = id
table.insert (cascade.ad, ADTemp)
adnum = adnum + 1
end
local slaveTable = cmapi.querylist(OBJ_TOPO, id)
local counts = slaveTable.Count
if slaveTable.IF_ERRORID == 0 and counts > 0 then
for i=1, counts do
local inst_id = slaveTable[i].InstName or slaveTable[i]
local slaveTemp = cmapi.getinst(OBJ_TOPO, inst_id)
slaveTemp.flag = 2
slaveTemp.instID = inst_id
local slaverAD = cmapi.querylist(OBJ_AD, inst_id)
local slaverADcounts = slaverAD.Count
for k=1, slaverADcounts do
local inst_AD = slaverAD[k].InstName or slaverAD[k]
local ADTemp = cmapi.getinst(OBJ_AD, inst_AD)
ADTemp.parent = inst_id
table.insert (cascade.ad, ADTemp)
adnum = adnum + 1
end
local slaveThird = cmapi.querylist(OBJ_TOPO, inst_id)
local slaveCount = slaveThird.Count
if slaveThird.IF_ERRORID == 0 and slaveCount > 0 then
for i=1, slaveCount do
local slave3_inst_id = slaveThird[i].InstName or slaveThird[i]
local slave3 = cmapi.getinst(OBJ_TOPO, slave3_inst_id)
slaveTemp.slave3 = slave3
slaveTemp.slave3.instID = slave3_inst_id
local slaverAD = cmapi.querylist(OBJ_AD, slave3_inst_id)
local slaverADcounts = slaverAD.Count
for k=1, slaverADcounts do
local inst_id = slaverAD[k].InstName or slaverAD[k]
local ADTemp = cmapi.getinst(OBJ_AD, inst_id)
ADTemp.parent = slave3_inst_id
table.insert (cascade.ad, ADTemp)
adnum = adnum + 1
end
end
end
cascade.slave[i] = slaveTemp
end
end
end
cascade.ad["MGET_INST_NUM"] = adnum
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
getAccessDevInfoByType = getAccessDevInfoByType,
getTopoCascade = getTopoCascade,
setAlias = setAlias
}
