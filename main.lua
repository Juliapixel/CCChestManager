local store = require("apis.store")
local retrieve = require("apis.retrieve")
local button = require("apis.buttons")

local w, h = term.getSize()

local header = window.create(term.current(), 1, 1, w, 1)
local main = window.create(term.current(), 1, 2, w, h - 2)
local chin = window.create(term.current(), 1, h, w, 1)

header.setBackgroundColor(colors.blue)
header.clear()
header.write(" Deposit ")
header.write(" Withdraw ")

chin.setBackgroundColor(colors.gray)
chin.clear()
chin.setCursorPos(w - #"Settings" + 1, 1)
chin.write("Settings ")

local deposit = button.new(1, 1, #" Deposit ", 1)

while true do
  if deposit.waitForClick() then
    print("bruh")
  end
end
