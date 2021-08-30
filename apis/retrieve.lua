local listInv = require("apis.list_inv")

retrieve = {}


-- takes the item's display name, requested ammount and the target chest, and moves the items to it.
function retrieve.retrieveItem(item_name, reqAmmount, targetChest)
  if listInv.getAllInvs() == {} then
    listInv.updateAllInvs(targetChest)
  end
  local item = listInv.findItem(item_name, targetChest, "displayName", listInv.getAllInvs())
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