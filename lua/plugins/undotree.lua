return {
  "mbbill/undotree",
  config = function()
  vim.keymap.set_keymap("n", "<leader>u", ":UndotreeToggle<CR>", { noremap = true, silent = true })
  end,
}
