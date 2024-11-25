vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.have_nerd_font = false

-- Functions
P = function(t)
  print(vim.inspect(t))
  return t
end

CB = function()
  local filename = vim.fn.expand('%:p')
  vim.fn.setreg('+', filename) -- Copy to system clipboard
  print("Copied to clipboard: " .. filename)
end
