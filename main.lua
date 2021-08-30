local store = require("apis.store")
local retrieve = require("apis.retrieve")

local w, h = term.getSize()

local header = window.create(term.current(), 1, 1, w, 1)
local main = window.create(term.current(), 1, 2, w, h - 2)
local chin = window.create(term.current(), 1, h, w, 1)

header.setBackGroundColor(colors.blue)
header.clear()
header.write(" Store ")
header.write("Retrieve")

chin.setBackGroundColor(colors.gray)
chin.clear()
chin.setCursorPos(w - #"Settings" + 1, 1)
chin.write("Settings")