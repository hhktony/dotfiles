-- window management
local application = require "hs.application"
local window = require "hs.window"
local screen = require "hs.screen"

-- default 0.2
window.animationDuration = 0

-- full screen
hs.hotkey.bind(kb.window, 'F', function()
  window.focusedWindow():toggleFullScreen()
end)

hs.hotkey.bind(kb.window, 'M', function()
  window.focusedWindow():centerOnScreen()
end)

-- left half
hs.hotkey.bind(kb.window, "Left", function()
  if window.focusedWindow() then
    window.focusedWindow():moveToUnit(hs.layout.left50)
  else
    hs.alert.show("No active window")
  end
end)

-- right half
hs.hotkey.bind(kb.window, "Right", function()
  window.focusedWindow():moveToUnit(hs.layout.right50)
end)

-- top half
hs.hotkey.bind(kb.window, "Up", function()
  window.focusedWindow():moveToUnit'[0,0,100,50]'
end)

-- bottom half
hs.hotkey.bind(kb.window, "Down", function()
  window.focusedWindow():moveToUnit'[0,50,100,100]'
end)

--[[
-- left top quarter
hs.hotkey.bind(kb.window, "Left", function()
  window.focusedWindow():moveToUnit'[0,0,50,50]'
end)

-- right bottom quarter
hs.hotkey.bind(kb.window, "Right", function()
  window.focusedWindow():moveToUnit'[50,50,100,100]'
end)

-- right top quarter
hs.hotkey.bind(kb.window, "Up", function()
  window.focusedWindow():moveToUnit'[50,0,100,50]'
end)

-- left bottom quarter
hs.hotkey.bind(kb.window, "Down", function()
  window.focusedWindow():moveToUnit'[0,50,50,100]'
end)
--]]

-- 4分屏 左上
hs.hotkey.bind(kb.window, "1", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.x = max.x
  f.y = max.y
  f.w = max.w / 2
  f.h = max.h / 2
  win:setFrame(f)
end)

-- 4分屏 左下
hs.hotkey.bind(kb.window, "2", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.x = max.x
  f.y = max.y + max.h/2
  f.w = max.w / 2
  f.h = max.h / 2
  win:setFrame(f)
end)

-- 4分屏 右上
hs.hotkey.bind(kb.window, "3", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.x = max.x + max.w/2
  f.y = max.y
  f.w = max.w / 2
  f.h = max.h / 2
  win:setFrame(f)
end)

-- 4分屏 右下
hs.hotkey.bind(kb.window, "4", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.x = max.x + max.w/2
  f.y = max.y + max.h/2
  f.w = max.w / 2
  f.h = max.h / 2
  win:setFrame(f)
end)

-- maximize window
-- hs.hotkey.bind(kb.window, 'M', function() toggle_maximize() end)

-- defines for window maximize toggler
local frameCache = {}
-- toggle a window between its normal size, and being maximized
function toggle_maximize()
  local win = window.focusedWindow()
  if frameCache[win:id()] then
    win:setFrame(frameCache[win:id()])
    frameCache[win:id()] = nil
  else
    frameCache[win:id()] = win:frame()
    win:maximize()
  end
end

-- display a keyboard hint for switching focus to each window
hs.hotkey.bind(kb.window, '/', function()
    hs.hints.windowHints()
    -- Display current application window
    -- hs.hints.windowHints(hs.window.focusedWindow():application():allWindows())
end)

-- switch active window
-- hs.hotkey.bind(kb.window, "H", function()
--   window.switcher.nextWindow()
-- end)

--------------------------------------------
-- monitor
--------------------------------------------
-- move active window to previous monitor
hs.hotkey.bind(kb.monitor, "Left", function()
  window.focusedWindow():moveOneScreenWest()
end)

-- move active window to next monitor
hs.hotkey.bind(kb.monitor, "Right", function()
  window.focusedWindow():moveOneScreenEast()
end)

-- move cursor to previous monitor
-- hs.hotkey.bind(kb.focus, "Left", function ()
  -- focusScreen(window.focusedWindow():screen():previous())
-- end)

-- move cursor to next monitor
-- hs.hotkey.bind(kb.focus, "Right", function ()
  -- focusScreen(window.focusedWindow():screen():next())
-- end)

--Predicate that checks if a window belongs to a screen
function isInScreen(screen, win)
  return win:screen() == screen
end

function focusScreen(screen)
  -- Get windows within screen, ordered from front to back.
  -- If no windows exist, bring focus to desktop. Otherwise, set focus on
  -- front-most application window.
  local windows = hs.fnutils.filter(
    window.orderedWindows(),
    hs.fnutils.partial(isInScreen, screen))
  local windowToFocus = #windows > 0 and windows[1] or window.desktop()
  windowToFocus:focus()

  -- move cursor to center of screen
  local pt = hs.geometry.rectMidPoint(screen:fullFrame())
  hs.mouse.setAbsolutePosition(pt)
end

-- maximized active window and move to selected monitor
moveto = function(win, n)
  local screens = screen.allScreens()
  if n > #screens then
    hs.alert.show("Only " .. #screens .. " monitors ")
  else
    local toWin = screen.allScreens()[n]:name()
    hs.alert.show("Move " .. win:application():name() .. " to " .. toWin)

    hs.layout.apply({{nil, win:title(), toWin, hs.layout.maximized, nil, nil}})
  end
end

-- move cursor to monitor 1 and maximize the window
hs.hotkey.bind(kb.monitor, "1", function()
  local win = window.focusedWindow()
  moveto(win, 1)
end)

-- move cursor to monitor 2 and maximize the window
hs.hotkey.bind(kb.monitor, "2", function()
  local win = window.focusedWindow()
  moveto(win, 2)
end)
