local Button = {
  x = 1,
  y = 1,
  w = 1,
  h = 1,
  active = true
}

function Button:new(x, y, w, h, activity)
  local object
  object = setmetatable({}, self)
  self.__index = self
  object.x = x or self.x
  object.y = y or self.y
  object.w = w or self.w
  object.h = h or self.h
  object.active = activity or self.active
  return object
end

function Button:waitForClick()
  local event, butt, clickX, clickY= os.pullEvent("mouse_click")
  if clickX >= self.x and clickX < self.x + self.w and clickY >= self.y and clickY < self.y + self.h and self.active == true then
    return true
  end
end

function Button:setActive(activity)
  self.active = activity
end

return Button