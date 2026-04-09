local p = require("vscode2026.palette").dark

return {
  normal = {
    a = { fg = p.bg, bg = p.accent, gui = "bold" },
    b = { fg = p.fg, bg = p.bg_float },
    c = { fg = p.fg_dim, bg = "NONE" },
  },
  insert = {
    a = { fg = p.bg, bg = p.type, gui = "bold" },
    b = { fg = p.fg, bg = p.bg_float },
  },
  visual = {
    a = { fg = p.bg, bg = p.func, gui = "bold" },
    b = { fg = p.fg, bg = p.bg_float },
  },
  replace = {
    a = { fg = p.bg, bg = p.keyword, gui = "bold" },
    b = { fg = p.fg, bg = p.bg_float },
  },
  command = {
    a = { fg = p.bg, bg = p.variable, gui = "bold" },
    b = { fg = p.fg, bg = p.bg_float },
  },
  inactive = {
    a = { fg = p.fg_dim, bg = "NONE" },
    b = { fg = p.fg_dim, bg = "NONE" },
    c = { fg = p.fg_dim, bg = "NONE" },
  },
}
