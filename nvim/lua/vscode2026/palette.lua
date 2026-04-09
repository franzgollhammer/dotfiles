local M = {}

M.dark = {
  bg = "#121314",
  bg_float = "#191A1B",
  bg_visual = "#276782",
  bg_search = "#297AA0",
  bg_popup = "#242526",
  fg = "#BBBEBF",
  fg_dim = "#858889",
  fg_dark = "#6E7681",
  border = "#3E4042",
  cursor = "#BBBEBF",
  accent = "#3994BC",
  none = "NONE",

  -- syntax
  keyword = "#ff7b72",
  func = "#d2a8ff",
  string = "#a5d6ff",
  constant = "#79c0ff",
  type = "#7ee787",
  variable = "#ffa657",
  comment = "#858889",
  operator = "#BBBEBF",
  tag = "#7ee787",
  parameter = "#ffa657",
  property = "#79c0ff",
  punctuation = "#858889",
  special = "#d2a8ff",

  -- diagnostics
  error = "#f48771",
  warning = "#e5ba7d",
  info = "#3994BC",
  hint = "#73c991",
  success = "#73c991",

  -- diff
  diff_add = "#244032",
  diff_delete = "#3D1F28",
  diff_change = "#1B3A4B",
  diff_text = "#276782",

  -- git
  git_add = "#73c991",
  git_delete = "#f48771",
  git_change = "#e5ba7d",
}

M.light = {
  bg = "#FFFFFF",
  bg_float = "#FAFAFD",
  bg_visual = "#0069CC40",
  bg_search = "#0069CC40",
  bg_popup = "#EAEAEA",
  fg = "#202020",
  fg_dim = "#606060",
  fg_dark = "#6E7781",
  border = "#D8D8D8",
  cursor = "#202020",
  accent = "#0069CC",
  none = "NONE",

  -- syntax
  keyword = "#cf222e",
  func = "#8250df",
  string = "#0a3069",
  constant = "#0550ae",
  type = "#116329",
  variable = "#953800",
  comment = "#6e7781",
  operator = "#202020",
  tag = "#116329",
  parameter = "#953800",
  property = "#0550ae",
  punctuation = "#606060",
  special = "#8250df",

  -- diagnostics
  error = "#ad0707",
  warning = "#B69500",
  info = "#0069CC",
  hint = "#116329",
  success = "#116329",

  -- diff
  diff_add = "#DAFBE1",
  diff_delete = "#FDEDED",
  diff_change = "#E6F2FA",
  diff_text = "#0069CC40",

  -- git
  git_add = "#116329",
  git_delete = "#ad0707",
  git_change = "#B69500",
}

return M
