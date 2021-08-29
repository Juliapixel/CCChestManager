local store = require("apis.store")
local retrieve = require("apis.retrieve")

local args = {...}

if args[1] == "store" then
  store.storeItems()
end