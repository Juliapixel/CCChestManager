local listInv = require("apis.list_inv")

retrieve = {}

-- takes a minecraft display name and returns the inventory's name and slot it is located in and the ammount
local function findItem(item_name)
  local chest = ""
  local slot = 0
  local count = 0
  local instance = {}
  local num = 1
  for i, v in pairs(listInv.listAllInvs()) do
    for j, w in pairs(v) do
      if w["displayName"] == item_name then
        chest = i
        slot = j
        count = w["count"]
        instance[num] = {chest, slot, count}
        num = num + 1
      end
    end
  end
  return instance
end

local function get()

end

return retrieve