local p = require("vscode2026.palette").light

return {
  normal = {
    a = { fg = "#FFFFFF", bg = p.accent, gui = "bold" },
    b = { fg = p.fg, bg = p.bg_popup },
    c = { fg = p.fg_dim, bg = "NONE" },
  },
  insert = {
    a = { fg = "#FFFFFF", bg = p.type, gui = "bold" },
    b = { fg = p.fg, bg = p.bg_popup },
  },
  visual = {
    a = { fg = "#FFFFFF", bg = p.func, gui = "bold" },
    b = { fg = p.fg, bg = p.bg_popup },
  },
  replace = {
    a = { fg = "#FFFFFF", bg = p.keyword, gui = "bold" },
    b = { fg = p.fg, bg = p.bg_popup },
  },
  command = {
    a = { fg = "#FFFFFF", bg = p.variable, gui = "bold" },
    b = { fg = p.fg, bg = p.bg_popup },
  },
  inactive = {
    a = { fg = p.fg_dim, bg = "NONE" },
    b = { fg = p.fg_dim, bg = "NONE" },
    c = { fg = p.fg_dim, bg = "NONE" },
  },
}
