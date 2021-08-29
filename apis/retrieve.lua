local listInv = require("apis.list_inv")

retrieve = {}

-- takes a minecraft display name and returns the inventory's name and slot it is located in and the ammount
local function findItem(item_name)
  local chest = ""
  local slot = 0
  local count = 0
  for i, v in pairs(listInv.listAllInvs()) do
    for j, w in pairs(v) do
      if w["name"] == item_name then
        chest = v
        slot = w
        count = w["count"]
        return chest, slot, count
      end
    end
  end
end

return retrieve