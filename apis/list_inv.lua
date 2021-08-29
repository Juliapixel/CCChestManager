listInv = {}

local function getInvs()
  local invs = peripheral.getNames()
  for i, v in pairs(invs) do
    type = peripheral.getType(v)
    if type ~= "minecraft:chest" then
      table.remove(invs, i)
    end
  end
  return invs
end

function listInv.listAllInvs()
  local allInvs = {}
  for i, v in pairs(getInvs()) do
    local curInv = peripheral.wrap(v)
    for j, w in pairs(curInv.list()) do
      local curItem = curInv.getItemDetail(w)
      allInvs[v][w] = curItem
    end
  end
  return allInvs
end

print(textutils.serialise(listInv.listAllInvs()))

return listInv