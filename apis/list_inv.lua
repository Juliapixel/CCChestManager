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
-- takes a minecraft display name and returns a table of all instances of that item with their positions and ammounts
-- {[1] = {"chest" = "", "slot" = number, "count" = number, "spaceAvailable" = number} }
function listInv.findItem(item_name, playerChest, nameType)
  local chest = ""
  local slot = 0
  local count = 0
  local spaceAvailable = 0
  local instance = {}
  local num = 1
  for i, v in pairs(listInv.listAllInvs(playerChest)) do
    for j, w in pairs(v) do
      if w[nameType] == item_name then
        chest = i
        slot = j
        count = w["count"]
        spaceAvailable = w["maxCount"] - w["count"]
        instance[num] = {chest = chest, slot = slot, count = count, spaceAvailable = spaceAvailable}
        num = num + 1
      end
    end
  end
  if instance == {} then
    return false
  else
    return instance
  end
end

return listInv