listInv = {}

local allInvs = {}
local allItems = {}

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
function listInv.updateAllInvs(playerChest)
  for i, v in pairs(listInv.getInvs(playerChest)) do
    allInvs[v] = {}
    for j, w in pairs(peripheral.call(v, "list")) do
      allInvs[v][j] = peripheral.call(v, "getItemDetail", j)
      
    end
  end
end

function listInv.getAllInvs()
  return allInvs
end
-- takes a minecraft display name and returns a table of all instances of that item with their positions and ammounts
-- {[1] = {"chest" = "", "slot" = number, "count" = number, "spaceAvailable" = number} }
function listInv.findItem(item_name, playerChest, nameType, inputAllInvs)
  local chest = ""
  local slot = 0
  local count = 0
  local spaceAvailable = 0
  local instance = {}
  local num = 1
  local allInvs = {}
  if inputAllInvs == nil then
    allInvs = listInv.updateAllInvs(playerChest)
  else
    allInvs = inputAllInvs
  end
  for i, v in pairs(allInvs) do
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