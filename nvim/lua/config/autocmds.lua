-- highlight on yank
vim.cmd([[au TextYankPost * silent! lua vim.highlight.on_yank()]])

-- EslintFixAll on save
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = { "*.tsx", "*.ts", "*.jsx", "*.js", "*.vue", "*.cjs", "*.mjs" },
  command = "silent! EslintFixAll",
  group = vim.api.nvim_create_augroup("EsLintFixAll", {}),
})
