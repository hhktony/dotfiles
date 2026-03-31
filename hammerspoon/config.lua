kb = {
  app     = {"alt"},
  monitor = {"alt", "shift"},
  window  = {"ctrl", "cmd"},
  focus   = {"ctrl", "alt", "cmd"},
}

apps = {
  { name = 'Alacritty',      path = '/Applications/Alacritty.app',       shortcut = 'A', input = 'English' },
  -- { name = 'Arc',            path = '/Applications/Arc.app',             shortcut = 'A', input = 'English' },
  -- { name = 'Cursor',         path = '/Applications/Cursor.app',          shortcut = 'C', input = 'English' },
  { name = 'Microsoft Edge', path = '/Applications/Microsoft Edge.app',  shortcut = 'E', input = 'English' },
  { name = 'Google Chrome',  path = '/Applications/Google Chrome.app',   shortcut = 'G', input = 'English' },
  { name = 'Ghostty',        path = '/Applications/Ghostty.app',         shortcut = 'I', input = 'English' },
  -- { name = 'WezTerm',        path = '/Applications/WezTerm.app',         shortcut = 'I', input = 'English' },
  -- { name = 'Iterm',          path = '/Applications/iTerm.app',            shortcut = 'I', input = 'English' },
  -- { name = 'Warp',          path = '/Applications/Warp.app',            shortcut = 'I', input = 'English' },
  { name = 'IntelliJ IDEA',  path = '/Applications/IntelliJ IDEA.app',   shortcut = 'J', input = 'English' },
  -- { name = '印象笔记',       path = '/Applications/印象笔记.app',        shortcut = 'N', input = 'Chinese' },
  { name = 'Obsidian',       path = '/Applications/Obsidian.app',        shortcut = 'O', input = 'English' },
  { name = 'Sublime Text',   path = '/Applications/Sublime Text.app',    shortcut = 'S', input = 'English' },
  { name = '企业微信',       path = '/Applications/企业微信.app',        shortcut = 'T', input = 'Chinese' },
  { name = 'WeChat',         path = '/Applications/WeChat.app',          shortcut = 'W', input = 'Chinese' },
  { name = 'Zed',            path = '/Applications/Zed.app',             shortcut = 'Z', input = 'English' },
  -- System apps
  { name = 'Finder',             path = '/System/Library/CoreServices/Finder.app', input = 'English' },
  { name = 'System Preferences', path = '/Applications/System Preferences.app',    input = 'English' }
}

-- hs.hotkey.bind({ "alt" }, "i", function() hs.application.open("WezTerm.app") end)

hs.hotkey.alertDuration = 0
hs.hints.showTitleThresh = 0
