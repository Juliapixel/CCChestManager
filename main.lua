local store = require("apis.store")
local retrieve = require("apis.retrieve")
local button = require("apis.buttons")

local w, h = term.getSize()

local header = window.create(term.current(), 1, 1, w, 1)
local main = window.create(term.current(), 1, 2, w, h - 2)
local chin = window.create(term.current(), 1, h, w, 1)
local depositOpts = window.create(term.current(), 1, 2, #"Confirm depositButton?", 4, false)
local settings = {}

local function getSettings()
  local settings_path = fs.getDir(shell.getRunningProgram()) .. "/settings.txt"
  settingsFile = fs.open(settings_path, "r")
  settings["chest"] = settingsFile.readLine()
  settingsFile.close()
end

getSettings()

depositOpts.setBackgroundColor(colors.gray)
depositOpts.clear()
depositOpts.write("Confirm depositButton?")
depositOpts.setCursorPos(4, 2)
depositOpts.write("Yes")
depositOpts.setCursorPos(11, 2)
depositOpts.write("No")

header.setBackgroundColor(colors.blue)
header.clear()
header.write(" Deposit ")
header.write(" Withdraw ")

chin.setBackgroundColor(colors.gray)
chin.clear()
chin.setCursorPos(w - #"Settings" + 1, 1)
chin.write("Settings ")

local depositButton = button:new(1, 1, #" Deposit ", 1)
local withdrawButton = button:new(#" Deposit " + 1, 1, #"Withdraw ", 1)
local settingsButton = button:new(w - #"Settings" + 1, h, #"Settings", 1)

local function depositMode()
  depositOpts.setVisible(true)
  depositButton:setActive(false)
  withdrawButton:setActive(false)
  settingsButton:setActive(false)
  local yes = button:new(4, 3, 3, 1)
  if yes.waitForClick then
    store.storeItems(settings.chest)
  end
  depositOpts.setVisible(false)
  depositButton:setActive(true)
  withdrawButton:setActive(true)
  settingsButton:setActive(true)
  yes:setActive(false)
end

local function withdrawMode()

end

local function settingsMode()

end

local function waitForDeposit()
  while true do
    if depositButton:waitForClick() then
      depositMode()
    end
  end
end

local function waitForWithdraw()
  while true do
    if withdrawButton:waitForClick() then
      withdrawMode()
    end
  end
end

local function waitForSettings()
  while true do
    if withdrawButton:waitForClick() then
      settingsMode()
    end
  end
end

while true do
  parallel.waitForAny(waitForDeposit, waitForWithdraw, waitForSettings)
end