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

CF = function()
  local filename = vim.fn.expand('%:p')
  return filename
end

CopyFileNameToClipBoard = function()
  local filename = CF()
  vim.fn.setreg('+', filename) -- Copy to system clipboard
  print("Copied to clipboard: " .. filename)
end
