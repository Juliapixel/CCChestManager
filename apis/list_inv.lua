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

local function listAllInvs()
  local allInvs = {}
  for i, v in pairs(getInvs()) do
    local curInv = peripheral.wrap(v)
    allInvs[v] = curInv.list()
  end
  return allInvs
end

print(listAllInvs())

return listInv