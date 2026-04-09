local M = {}

M.config = {
  transparent = false,
  styles = {
    comments = {},
    keywords = {},
    functions = {},
    variables = {},
  },
  terminal_colors = true,
}

function M.setup(opts)
  M.config = vim.tbl_deep_extend("force", M.config, opts or {})
end

function M.load(variant)
  variant = variant or (vim.o.background == "light" and "light" or "dark")

  if vim.g.colors_name then
    vim.cmd("hi clear")
  end
  vim.o.termguicolors = true
  vim.o.background = variant == "light" and "light" or "dark"
  vim.g.colors_name = variant == "light" and "light2026" or "dark2026"

  local palette = require("vscode2026.palette")
  local highlights = require("vscode2026.highlights")

  local p = palette[variant]
  local hl = highlights.setup(p, M.config)

  for group, settings in pairs(hl) do
    vim.api.nvim_set_hl(0, group, settings)
  end

  if M.config.terminal_colors then
    M.set_terminal_colors(p)
  end
end

function M.set_terminal_colors(p)
  vim.g.terminal_color_0 = p.bg
  vim.g.terminal_color_1 = p.keyword
  vim.g.terminal_color_2 = p.type
  vim.g.terminal_color_3 = p.variable
  vim.g.terminal_color_4 = p.constant
  vim.g.terminal_color_5 = p.func
  vim.g.terminal_color_6 = p.string
  vim.g.terminal_color_7 = p.fg
  vim.g.terminal_color_8 = p.fg_dim
  vim.g.terminal_color_9 = p.error
  vim.g.terminal_color_10 = p.success
  vim.g.terminal_color_11 = p.warning
  vim.g.terminal_color_12 = p.info
  vim.g.terminal_color_13 = p.special
  vim.g.terminal_color_14 = p.hint
  vim.g.terminal_color_15 = p.fg
end

return M
