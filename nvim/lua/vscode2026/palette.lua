-- VS Code 2026 Dark / 2026 Light palette
-- Sourced from microsoft/vscode:
--   extensions/theme-defaults/themes/2026-dark.json
--   extensions/theme-defaults/themes/2026-light.json
-- Both are GitHub-Dark / GitHub-Light derived token colors
-- layered on top of dark_modern / light_modern workbench colors.

local M = {}

M.dark = {
  -- editor chrome (from 2026-dark.json workbench colors)
  bg            = "#121314", -- editor.background
  bg_float      = "#191A1B", -- sideBar, panel, activityBar, titleBar
  bg_visual     = "#276782", -- editor.selectionBackground (solid approx of DD alpha)
  bg_search     = "#276782", -- editor.findMatchBackground
  bg_popup      = "#202122", -- editorWidget, menu, notifications
  bg_line       = "#242526", -- editor.lineHighlightBackground
  fg            = "#BBBEBF", -- editor.foreground
  fg_syntax     = "#C9D1D9", -- tokenColors default (variable.other / parameter / member)
  fg_dim        = "#8C8C8C", -- descriptionForeground, icon.foreground
  fg_dark       = "#555555", -- disabledForeground
  border        = "#2A2B2C", -- tab/panel/widget .border
  cursor        = "#BBBEBF", -- editorCursor.foreground
  accent        = "#3994BC", -- focusBorder, badge, statusBar accents
  accent_bright = "#48A0C7", -- textLink, list.highlightForeground
  none          = "NONE",

  -- syntax (2026 Dark tokenColors)
  keyword          = "#FF7B72", -- keyword, storage, storage.type, constant.character, punctuation.section.embedded
  func             = "#D2A8FF", -- entity.name.function, meta.diff.range
  string           = "#A5D6FF", -- string, string.regexp, source.regexp
  string_escape    = "#7EE787", -- string.regexp constant.character.escape (bold)
  number           = "#79C0FF", -- constant, variable.other.constant, variable.other.enummember, variable.language, support.*, meta.property-name, meta.module-reference
  constant_builtin = "#79C0FF", -- variable.language (this, self, super), constant.language (true/false/null)
  type             = "#7EE787", -- entity.name.tag, support.class.component, support.type.property-name.json
  variable_def     = "#FFA657", -- entity.name, meta.export.default, meta.definition.variable, variable (declarations)
  variable         = "#C9D1D9", -- variable.other, variable.parameter.function, meta.object.member, meta.block (usage / default syntax fg)
  comment          = "#8B949E", -- comment, punctuation.definition.comment, brackethighlighter.*
  operator         = "#C9D1D9", -- keyword.operator inherits default fg
  punctuation      = "#C9D1D9",
  parameter        = "#C9D1D9", -- variable.parameter.function
  property         = "#79C0FF", -- meta.property-name
  tag              = "#7EE787", -- entity.name.tag (HTML/JSX/Vue)
  tag_attr         = "#79C0FF", -- entity.other.attribute-name (GitHub-dark convention)
  tag_delimiter    = "#8B949E", -- punctuation.definition.tag / brackethighlighter
  namespace        = "#79C0FF", -- meta.module-reference
  label            = "#79C0FF",
  special          = "#7EE787",

  -- special token types
  invalid     = "#FFA198", -- invalid.*, message.error
  info_token  = "#6796E6",
  warn_token  = "#CD9731",
  error_token = "#F44747",
  debug_token = "#B267E6",

  -- diagnostics (workbench)
  error   = "#F48771",
  warning = "#CCA700",
  info    = "#3A94BC",
  hint    = "#73C991",
  success = "#73C991",

  -- diff (solid approximations of alpha-blended 2026 colors)
  diff_add    = "#244032",
  diff_delete = "#3D1F28",
  diff_change = "#1B3A4B",
  diff_text   = "#276782",

  -- git (gitDecoration, editorOverviewRuler)
  git_add    = "#73C991",
  git_change = "#E5BA7D",
  git_delete = "#F48771",
}

M.light = {
  -- editor chrome (from 2026-light.json workbench colors)
  bg            = "#FFFFFF",
  bg_float      = "#FAFAFD",
  bg_visual     = "#BED4F0", -- editor.selectionBackground approx (was #0069CC40)
  bg_search     = "#BED4F0",
  bg_popup      = "#FAFAFD",
  bg_line       = "#F0F0F3",
  fg            = "#202020", -- editor.foreground
  fg_syntax     = "#1F2328", -- tokenColors default (variable.other / parameter / member)
  fg_dim        = "#606060",
  fg_dark       = "#BBBBBB",
  border        = "#F0F1F2",
  cursor        = "#202020",
  accent        = "#0069CC",
  accent_bright = "#0069CC",
  none          = "NONE",

  -- syntax (2026 Light tokenColors)
  keyword          = "#CF222E",
  func             = "#8250DF",
  string           = "#0A3069",
  string_escape    = "#116329",
  number           = "#0550AE",
  constant_builtin = "#0550AE",
  type             = "#116329",
  variable_def     = "#953800",
  variable         = "#1F2328",
  comment          = "#6E7781",
  operator         = "#1F2328",
  punctuation      = "#1F2328",
  parameter        = "#1F2328",
  property         = "#0550AE",
  tag              = "#116329",
  tag_attr         = "#0550AE",
  tag_delimiter    = "#57606A",
  namespace        = "#0550AE",
  label            = "#0550AE",
  special          = "#116329",

  invalid     = "#82071E",
  info_token  = "#0550AE",
  warn_token  = "#667309",
  error_token = "#CD3131",
  debug_token = "#652D90",

  error   = "#AD0707",
  warning = "#B69500",
  info    = "#0069CC",
  hint    = "#587C0C",
  success = "#587C0C",

  diff_add    = "#DAFBE1",
  diff_delete = "#FDEDED",
  diff_change = "#E6F2FA",
  diff_text   = "#BED4F0",

  git_add    = "#587C0C",
  git_change = "#667309",
  git_delete = "#AD0707",
}

return M
