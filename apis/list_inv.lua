listInv = {}

function getInvs(playerChest)
  playerChestName = playerChest
  local invs = peripheral.getNames()
  for i, v in pairs(invs) do
    type = peripheral.getType(v)
    if type ~= "minecraft:chest" then
      invs[i] = nil
    elseif v == playerChest then
      invs[i] = nil
    end
  end
  return invs
end

-- returns a table with inventory names' as indexes and their items as their contents.
function listInv.listAllInvs(playerChest)
  local allInvs = {}
  for i, v in pairs(getInvs(playerChest)) do
    allInvs[v] = {}
    local curInv = peripheral.wrap(v)
    for j, w in pairs(curInv.list()) do
      local curItem = curInv.getItemDetail(j)
      allInvs[v][j] = curItem
    end
  end
  return allInvs
end

return listInv