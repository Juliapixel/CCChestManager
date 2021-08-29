local store = require("apis.store")
local retrieve = require("apis.retrieve")

local args = {...}
if args[1] == "store" then
  store.storeItems(args[2])
else
  retrieve.retrieveItem(args[1], args[2], args[3])
end