-- VS Code 2026 palette
-- Syntax token colors sourced from microsoft/vscode:
--   dark_vs.json + dark_plus.json (Dark Modern)
--   light_vs.json + light_plus.json (Light Modern)
-- Editor chrome colors are the user's custom tones.

local M = {}

M.dark = {
  -- editor chrome (custom tones)
  bg         = "#121314",
  bg_float   = "#191A1B",
  bg_visual  = "#264F78", -- VS Code editor.selectionBackground
  bg_search  = "#613A00", -- VS Code editor.findMatchBackground
  bg_popup   = "#202020", -- VS Code editorWidget.background
  fg         = "#CCCCCC", -- VS Code Dark Modern editor.foreground
  fg_dim     = "#858889",
  fg_dark    = "#6E7681",
  border     = "#3E4042",
  cursor     = "#CCCCCC",
  accent     = "#4FC1FF",
  none       = "NONE",

  -- syntax (VS Code Dark+ canonical)
  keyword          = "#569CD6", -- var, let, const, function, class, import, new, typeof
  keyword_control  = "#C586C0", -- if, else, for, while, return, break, throw, try, catch
  func             = "#DCDCAA", -- function declarations and calls
  string           = "#CE9178", -- string literals
  string_escape    = "#D7BA7D", -- \n, \t, escape sequences
  regexp           = "#D16969", -- regex character classes
  number           = "#B5CEA8", -- numbers
  constant         = "#4FC1FF", -- UPPERCASE/user constants, enumMember (semantic)
  constant_builtin = "#569CD6", -- true, false, null, undefined, this
  type             = "#4EC9B0", -- classes, interfaces, types, namespaces
  variable         = "#9CDCFE", -- variables, parameters, properties, attrs
  comment          = "#6A9955",
  operator         = "#D4D4D4", -- + - = && || (default fg)
  punctuation      = "#CCCCCC", -- , ; (default fg)
  tag              = "#569CD6", -- HTML tag names
  tag_attr         = "#9CDCFE", -- HTML attributes
  tag_delimiter    = "#808080", -- < > /
  parameter        = "#9CDCFE",
  property         = "#9CDCFE",
  namespace        = "#4EC9B0",
  css_selector     = "#D7BA7D", -- CSS class/id/pseudo, tag selectors
  special          = "#D7BA7D",
  label            = "#C8C8C8",

  -- diagnostics (VS Code Dark Modern)
  error   = "#F85149",
  warning = "#CCA700",
  info    = "#3794FF",
  hint    = "#6A9955",
  success = "#89D185",

  -- diff
  diff_add    = "#244032",
  diff_delete = "#3D1F28",
  diff_change = "#1B3A4B",
  diff_text   = "#264F78",

  -- git
  git_add    = "#89D185",
  git_delete = "#F85149",
  git_change = "#E2C08D",
}

M.light = {
  -- editor chrome
  bg        = "#FFFFFF",
  bg_float  = "#F8F8F8",
  bg_visual = "#ADD6FF", -- VS Code editor.selectionBackground
  bg_search = "#F5D8A1", -- softer find match
  bg_popup  = "#F3F3F3",
  fg        = "#3B3B3B", -- VS Code Light Modern editor.foreground
  fg_dim    = "#616161",
  fg_dark   = "#8C8C8C",
  border    = "#E5E5E5",
  cursor    = "#3B3B3B",
  accent    = "#005FB8",
  none      = "NONE",

  -- syntax (VS Code Light+ canonical)
  keyword          = "#0000FF",
  keyword_control  = "#AF00DB",
  func             = "#795E26",
  string           = "#A31515",
  string_escape    = "#EE0000",
  regexp           = "#811F3F",
  number           = "#098658",
  constant         = "#0070C1",
  constant_builtin = "#0000FF",
  type             = "#267F99",
  variable         = "#001080",
  comment          = "#008000",
  operator         = "#000000",
  punctuation      = "#3B3B3B",
  tag              = "#800000",
  tag_attr         = "#E50000",
  tag_delimiter    = "#800000",
  parameter        = "#001080",
  property         = "#001080",
  namespace        = "#267F99",
  css_selector     = "#800000",
  special          = "#EE0000",
  label            = "#000000",

  -- diagnostics
  error   = "#E51400",
  warning = "#BF8803",
  info    = "#1A85FF",
  hint    = "#6C6C6C",
  success = "#388A34",

  -- diff
  diff_add    = "#DAFBE1",
  diff_delete = "#FDEDED",
  diff_change = "#E6F2FA",
  diff_text   = "#ADD6FF",

  -- git
  git_add    = "#388A34",
  git_delete = "#E51400",
  git_change = "#BF8803",
}

return M
