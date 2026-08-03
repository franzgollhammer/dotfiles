-- ─────────────────────────────────────────────────────────────
--  fg · wezterm configuration
-- ─────────────────────────────────────────────────────────────
--
-- Design rule: tmux owns the multiplexing. WezTerm is a dumb, fast surface —
-- no tab bar, no pane splits, no leader key that could shadow tmux's C-b.
-- Anything that would create a WezTerm-level tab or pane is remapped to spawn
-- a window instead, because with the tab bar off those would be invisible.
--
-- Mirrors ghostty/config: same font, same cursor, same auto light/dark themes.

local wezterm = require 'wezterm'
local themes = require 'themes'

local config = wezterm.config_builder()

-- ═══ Theme ═══════════════════════════════════════════════════
-- Swap this pair for 'steel-dark' / 'steel-light' to match the fzf palette.

local THEME_DARK = 'xterm-dark'
local THEME_LIGHT = 'xterm-light'

-- wezterm.gui is absent in the mux server, so guard the lookup.
local function appearance()
  if wezterm.gui then
    return wezterm.gui.get_appearance()
  end
  return 'Dark'
end

config.color_schemes = themes
config.color_scheme = appearance():find 'Dark' and THEME_DARK or THEME_LIGHT

-- ═══ Font ════════════════════════════════════════════════════

config.font = wezterm.font 'Hack Nerd Font'
config.font_size = 14
config.adjust_window_size_when_changing_font_size = false

-- ═══ Cursor ══════════════════════════════════════════════════

config.default_cursor_style = 'SteadyBlock'
config.cursor_blink_rate = 0

-- ═══ Window ══════════════════════════════════════════════════

config.enable_tab_bar = false
config.window_padding = { left = 6, right = 6, top = 6, bottom = 6 }
config.native_macos_fullscreen_mode = false -- no Spaces animation on fullscreen
config.default_cwd = wezterm.home_dir .. '/dev' -- $DEV, same start point as `d`
config.scrollback_lines = 10000 -- tmux keeps 50k of its own; this is the fallback

-- ═══ Rendering ═══════════════════════════════════════════════
-- WebGpu (Metal) is the fast path on Apple Silicon. Comment it out and WezTerm
-- falls back to OpenGL if anything renders wrong.

config.front_end = 'WebGpu'
config.max_fps = 120

-- ═══ Keyboard ════════════════════════════════════════════════
-- Both Option keys stay in "composed" mode ON PURPOSE: on the German Mac
-- layout Option is how you type @ | { } [ ] \. Turning either into Meta would
-- make those characters untypable. Send Meta from tmux/nvim via Esc-prefix.

config.send_composed_key_when_left_alt_is_pressed = true
config.send_composed_key_when_right_alt_is_pressed = true

config.keys = {
  -- Tab-creating defaults would open an invisible tab (tab bar is off).
  { key = 't', mods = 'CMD', action = wezterm.action.SpawnWindow },
  { key = 't', mods = 'CTRL|SHIFT', action = wezterm.action.SpawnWindow },

  -- Clear the way iTerm does: wipe the scrollback, then let the shell redraw.
  {
    key = 'k',
    mods = 'CMD',
    action = wezterm.action.Multiple {
      wezterm.action.ClearScrollback 'ScrollbackAndViewport',
      wezterm.action.SendKey { key = 'L', mods = 'CTRL' },
    },
  },

  { key = 'Enter', mods = 'CMD', action = wezterm.action.ToggleFullScreen },

  -- New window straight into the tmux project picker (scripts/tmux_session).
  {
    key = 't',
    mods = 'CMD|SHIFT',
    action = wezterm.action.SpawnCommandInNewWindow {
      args = { '/bin/zsh', '-l', '-c', 'tmux_session; exec /bin/zsh -l' },
    },
  },
}

-- ═══ Quick select ════════════════════════════════════════════
-- CMD+SHIFT+Space labels matches for keyboard copy. Defaults cover URLs and
-- paths; these add the things that actually get copied in this workflow.

config.quick_select_patterns = {
  '[0-9a-f]{7,40}',                       -- git sha
  '(?:feat|fix|chore|refactor|docs)/\\S+', -- branch names
  '[\\w.-]+/[\\w.-]+#\\d+',                -- owner/repo#123
}

-- ═══ Notifications ═══════════════════════════════════════════
-- scripts/agent-notify raises agent banners via OSC 777. WezTerm's default is
-- SuppressFromFocusedPane — the same blind spot Ghostty has and cannot turn off.
-- AlwaysShow means a banner still fires while you are staring at the pane.

config.notification_handling = 'AlwaysShow'

-- ═══ Bell ════════════════════════════════════════════════════
-- tmux forwards pane bells (monitor-bell on / bell-action any). Ghostty turns
-- those into a system notification via `bell-features = system`; WezTerm has no
-- such option, so raise the toast by hand. Silent — no audible bell.

config.audible_bell = 'Disabled'

wezterm.on('bell', function(window, pane)
  window:toast_notification('wezterm', pane:get_title(), nil, 4000)
end)

return config
