local listInv = require("apis.list_inv")

retrieve = {}

-- takes a minecraft display name and returns a table of all instances of that item with their positions and ammounts
-- {[1] = {"chest" = "", "slot" = number, "count" = number} }
local function findItem(item_name, playerChest)
  local chest = ""
  local slot = 0
  local count = 0
  local spaceAvailable = 0
  local instance = {}
  local num = 1
  for i, v in pairs(listInv.listAllInvs(playerChest)) do
    for j, w in pairs(v) do
      if w["displayName"] == item_name then
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

-- takes the item's display name, requested ammount and the target chest, and moves the items to it.
function retrieve.retrieveItem(item_name, reqAmmount, targetChest)
  local item = findItem(item_name, targetChest)
  if item == {} then
    print("No items found!")
    return false
  end
  local availAmmount = 0
  for i, v in pairs(item) do
    availAmmount = availAmmount + tonumber(v["count"])
  end
  local playerChest = peripheral.wrap(targetChest)
  for i, v in pairs(item) do
    local pulled = 0
    pulled = playerChest.pullItems(v["chest"], v["slot"], tonumber(reqAmmount))
    reqAmmount = reqAmmount - pulled
    if reqAmmount <= 0 then
      return true
    end
  end
  if reqAmmount > 0 then
    print("not enough of this item available!")
    return false
  end
end

return retrieve