local wezterm = require 'wezterm'
-- local mux = wezterm.mux
local act = wezterm.action

local launch_menu = {}
local default_prog = {}
local set_environment_variables = {}

-- Using shell
if wezterm.target_triple == 'x86_64-pc-windows-msvc' then
  -- require("key-bind-windows")
  term = '' -- Set to empty so FZF works on windows
  table.insert(launch_menu, {
    label = 'PowerShell',
    args = { 'c:\\Users\\darkl\\scoop\\apps\\pwsh\\current\\pwsh.exe' },
    cwd = wezterm.home_dir,
    domain = { DomainName = 'local' }
  })
  table.insert(launch_menu, {
    label = 'PowerShell2', args = {'powershell.exe', '-NoLogo'}
  })
  table.insert(launch_menu, {
    label = "WSL", args = {"wsl.exe", "--cd", "/home/tony"}
  })
  -- default_prog = { 'pwsh' }
  -- default_prog = {"C:\\Windows\\System32\\WindowsPowerShell\\v7.3\\7\\pwsh.exe"}
  default_prog = {'powershell.exe', '-NoLogo'}

-- elseif wezterm.target_triple == 'x86_64-unknown-linux-gnu' then
-- elseif wezterm.target_triple == 'x86_64-apple-darwin' then
-- elseif wezterm.target_triple == 'aarch64-apple-darwin' then

else
  table.insert(launch_menu, {
    label = 'Zsh', args = {'zsh', '-l'}
   })
  default_prog = {'zsh', '-l'}
end

-- Title
function basename(s)
  return string.gsub(s, '(.*[/\\])(.*)', '%2')
end

--[[
wezterm.on('format-tab-title', function(tab, tabs, panes, config, hover, max_width)
  local pane = tab.active_pane

  local index = ""
  if #tabs > 1 then
    index = string.format("%d: ", tab.tab_index + 1)
  end

  local process = basename(pane.foreground_process_name)

  return {{
    Text = ' ' .. index .. process .. ' '
  }}
end)
--]]

-- Initial startup
wezterm.on('gui-startup', function(cmd)
  local tab, pane, window = wezterm.mux.spawn_window(cmd or {})
  window:gui_window():maximize()
end)

local config = {
  check_for_updates = false,
  audible_bell = "Disabled",
  automatically_reload_config = true,
  -- exit_behavior = 'CloseOnCleanExit', -- if the shell program exited with a successful status
  switch_to_last_active_tab_when_closing_tab = false,
  selection_word_boundary = " \\()\"'`:,;<>~!@#$%^&*|+=[]{}~?",


  -- Window
  native_macos_fullscreen_mode = true,
  adjust_window_size_when_changing_font_size = true,
  window_background_opacity = 0.91, -- 如果设置为1.0会明显卡顿
  window_padding = {
    left = 5,
    right = 5,
    top = 5,
    bottom = 5
  },
  window_background_image_hsb = {
    brightness = 0.8,
    hue = 1.0,
    saturation = 1.0
  },
  window_close_confirmation = "NeverPrompt",

  -- Font
  font = wezterm.font_with_fallback({ "JetBrains Mono" }),
  -- font = wezterm.font "IntelOne Mono",
  font_size = 14,
  -- freetype_load_target = "Mono",

  enable_scroll_bar = false,

  -- Tab bar
  enable_tab_bar = true,
  hide_tab_bar_if_only_one_tab = true,
  show_tab_index_in_tab_bar = true,
  tab_max_width = 51,
  scrollback_lines = 99999,
  -- tab_bar_at_bottom = true,
  -- use_fancy_tab_bar = false,

  hide_mouse_cursor_when_typing = false,

  -- color_scheme = 'matrix',
  -- color_scheme = 'Mirage',
  -- color_scheme = 'AdventureTime',
  color_scheme = 'shades-of-purple',
  -- color_scheme = 'Dracula',

  -- Light
  -- color_scheme = 'ayu_light',
  -- color_scheme = 'AtomOneLight',
  -- color_scheme = 'Builtin Solarized Light',
  -- color_scheme = 'Solarized Light (Gogh)',
  colors = {
    -- cursor_bg = '#FFFFFF',
    -- cursor_fg = '#eaeaea',
    selection_bg = '#93BCCF',
    selection_fg = '#222226'
  },

  pane_focus_follows_mouse = true,
  inactive_pane_hsb = { hue = 1.0, saturation = 1.0, brightness = 1.0 },

  -- SteadyBlock, BlinkingBlock, SteadyUnderline, BlinkingUnderline, SteadyBar, and BlinkingBar.
  default_cursor_style = 'BlinkingBlock',

  -- Keys
  -- Allow using ^ with single key press.
  use_dead_keys = false,
  disable_default_key_bindings = true,

  leader = { key = 'x', mods = 'CTRL', timeout_milliseconds = 2000 },
  -- default keys: https://github.com/viperML/dotfiles/blob/d5d3e68b53d801718db2fa615375572240312d12/wrappers/wezterm/wezterm.lua#L163
  keys = {
    { -- TODO
      key = 'k',
      mods = 'CMD',
      action = act.Multiple {
        act.ClearScrollback 'ScrollbackAndViewport', act.SendKey {
          key = 'L',
          mods = 'CTRL'
        }
      }
    },
    { key = 'Enter', mods = 'ALT',  action = act.ToggleFullScreen },
    { key = 'Enter', mods = 'CMD',  action = act.ToggleFullScreen },

    -- fontsize
    { key = '0', mods = 'CTRL', action = 'ResetFontSize' },
    { key = '0', mods = 'CMD', action = 'ResetFontSize' },
    { key = '=', mods = 'CTRL', action = 'IncreaseFontSize' },
    { key = '=', mods = 'CMD', action = 'IncreaseFontSize' },
    { key = '-', mods = 'CTRL', action = 'DecreaseFontSize' },
    { key = '-', mods = 'CMD', action = 'DecreaseFontSize' },

    -- tabs
    { key = 't', mods = 'SHIFT|CTRL',   action = act.SpawnTab 'CurrentPaneDomain' },
    { key = 't', mods = 'CMD',          action = act.SpawnTab 'CurrentPaneDomain' },
    { key = 'c', mods = 'LEADER',          action = act.SpawnTab 'CurrentPaneDomain' },
    { key = 'w', mods = 'SHIFT|CTRL',   action = act.CloseCurrentTab { confirm = false } },
    { key = 'w', mods = 'CMD',          action = act.CloseCurrentTab { confirm = false } },
    { key = 'j', mods = "SHIFT|CTRL",   action = act.MoveTabRelative(-1) },
    { key = 'j', mods = "SHIFT|CMD",   action = act.MoveTabRelative(-1) },
    { key = 'k', mods = "SHIFT|CTRL",   action = act.MoveTabRelative(1) },
    { key = 'k', mods = "SHIFT|CMD",   action = act.MoveTabRelative(1) },

    -- panes
    { key = '-', mods = 'LEADER',       action = act.SplitVertical { domain = 'CurrentPaneDomain' } },
    { key = '|', mods = 'LEADER|SHIFT', action = act.SplitHorizontal { domain = 'CurrentPaneDomain' } },
    { key = 'l', mods = 'LEADER',       action = act.ActivatePaneDirection('Right') },
    { key = 'h', mods = 'LEADER',       action = act.ActivatePaneDirection('Left') },
    { key = 'j', mods = 'LEADER',       action = act.ActivatePaneDirection 'Down'},
    { key = 'k', mods = 'LEADER',       action = act.ActivatePaneDirection 'Up'},
    { key = 'z', mods = "LEADER",       action = act.TogglePaneZoomState}, 

    -- CaseSensitiveString
    { key = 'f', mods = 'CMD', action = act.Search { CaseInSensitiveString = '' } },

    { key = 'p', mods = 'SHIFT|CTRL', action = act.ShowLauncher },

    -- Copy/paste buffer
    { key = '[', mods = 'LEADER', action = 'ActivateCopyMode' },
    { key = ']', mods = 'LEADER', action = 'QuickSelect' },
    { key = 'c', mods = 'CTRL|SHIFT', action = act.CopyTo('Clipboard') },
    { key = 'c', mods = 'CMD', action = act.CopyTo('Clipboard') },
    { key = 'v', mods = 'CTRL|SHIFT', action = act.PasteFrom('Clipboard') },
    { key = 'v', mods = 'CMD', action = act.PasteFrom('Clipboard') },

    { -- TODO
      key = 'e',
      mods = 'CTRL|SHIFT',
      action = act.PromptInputLine {
        description = 'Enter new name for tab',
        action = wezterm.action_callback(function(window, pane, line)
          if line then
            window:active_tab():set_title(line)
          end
        end),
      },
     },
  },

  mouse_bindings = {
    { -- Paste on right-click
      event = {
        Down = {
          streak = 1,
          button = 'Right'
        }
      },
      mods = 'NONE',
      action = act {
        PasteFrom = 'Clipboard'
      }
    }, -- Change the default click behavior so that it only selects
    { -- text and doesn't open hyperlinks
      event = {
        Up = {
          streak = 1,
          button = 'Left'
        }
      },
      mods = 'NONE',
      action = act {
        CompleteSelection = 'PrimarySelection'
      }
    },
    { -- CTRL-Click open hyperlinks
      event = {
        Up = {
          streak = 1,
          button = 'Left'
        }
      },
      mods = 'CMD',
      action = 'OpenLinkAtMouseCursor'
    }
  },

  default_prog = default_prog,
  set_environment_variables = set_environment_variables,
  launch_menu = launch_menu
}

for i = 1, 9 do
  table.insert(config.keys, { key = tostring(i), mods = 'ALT', action = act.ActivateTab(i - 1), })
  table.insert(config.keys, { key = tostring(i), mods = 'CMD', action = act.ActivateTab(i - 1), })
end

wezterm.log_info('Config file ' .. wezterm.config_file)

return config
