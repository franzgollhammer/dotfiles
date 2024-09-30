-- highlight on yank
vim.cmd([[au TextYankPost * silent! lua vim.highlight.on_yank()]])

-- EslintFixAll on save
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = { "*.tsx", "*.ts", "*.jsx", "*.js", "*.vue", "*.cjs", "*.mjs" },
  command = "silent! EslintFixAll",
  group = vim.api.nvim_create_augroup("EsLintFixAll", {}),
})

vim.api.nvim_create_user_command('EslintFix', function()
  vim.cmd([[!eslint --fix %]])
end, {})

vim.api.nvim_create_user_command("Prettier", function()
  vim.cmd([[!prettier --write %]])
end, {})

