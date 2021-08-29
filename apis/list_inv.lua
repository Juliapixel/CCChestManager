listInv = {}

function listInv.getInvs(playerChest)
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

--returns the name of all connected inventories and the ammount of free slots in them
function listInv.getFreeSpaces(playerChest)
  local invs = listInv.getInvs(playerChest)
  local freeInvs = {}
  for i, v in pairs(invs) do
    freeInvs[i] = {}
    freeInvs[i]["chest"] = v
    freeInvs[i]["freeSlots"] = peripheral.call(invs[i], "size") - #peripheral.call(invs[i], "list")
  end
  return freeInvs
end

-- returns a table with inventory names' as indexes and their items as their contents.
function listInv.listAllInvs(playerChest)
  local allInvs = {}
  for i, v in pairs(listInv.getInvs(playerChest)) do
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