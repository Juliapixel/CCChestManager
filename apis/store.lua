local listInv = require("apis.list_inv")

store = {}

local function storeAnywhere(chest, slot)
  local invs = listInv.getFreeSpaces(chest)
  for i, v in pairs(invs) do
    if invs[i]["freeSlots"] > 0 then
      peripheral.call(chest, "pushItems", invs[i]["chest"], slot)
    end
  end
end

function store.storeItems(chest)
  local inputChest = peripheral.wrap(chest)
  local inputInv = inputChest.list()
  local index = 1
  if listInv.getAllInvs() == {} then
    listInv.updateAllInvs(chest)
  end
  for i, v in pairs(inputInv) do
    local instancesFound = listInv.findItem(v["name"], chest, "name", listInv.getAllInvs())
    if instancesFound == {} then
      storeAnywhere(chest, i)
    end
    for j, w in pairs(instancesFound) do
      if instancesFound[j]["spaceAvailable"] > 0 then
        local pushed = inputChest.pushItems(instancesFound[j]["chest"], i, nil, instancesFound[j]["slot"])
        inputInv[i]["count"] = inputInv[i]["count"] - pushed
        if inputInv[i]["count"] <= 0 then
          break
        end
      end
    end
    if inputInv[i]["count"] > 0 then
      storeAnywhere(chest, i)
    end
  end
  listInv.updateAllInvs(chest)
end

return store