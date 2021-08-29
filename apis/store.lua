local listInv = require("apis.list_inv")

store = {}

function store.storeItems(chest)
  local inputChest = peripheral.wrap(chest)
  local inputInv = inputChest.list()
  local index = 1
  for i, v in pairs(inputInv) do
    local instancesFound = listInv.findItem(v["name"], chest, "name")
    for j, w in pairs(instancesFound) do
      if instancesFound[j]["spaceAvailable"] > 0 then
        local pushed = inputChest.pushItems(instancesFound[j]["chest"], i)
        inputInv[i]["count"] = inputInv[i]["count"] - pushed
        if inputInv[i]["count"] <= 0 then
          break
        end
      end
    end
  end
end

return store