return {
  "nvimtools/none-ls.nvim",
  config = function()
    local null_ls = require("null-ls")

    -- format on save
    local on_attach = function()
      -- vim.api.nvim_create_autocmd("BufWritePost", {
      -- 	callback = function()
      -- 		vim.lsp.buf.format()
      -- 	end,
      -- })
    end

    null_ls.setup({
      sources = {
        -- Lua
        null_ls.builtins.formatting.stylua,

        -- JS / TS
        -- null_ls.builtins.formatting.prettierd,
        null_ls.builtins.diagnostics.eslint_d,
        null_ls.builtins.formatting.eslint_d,
      },
      on_attach = on_attach,
    })

    vim.keymap.set("n", "<leader>ff", vim.lsp.buf.format, {})
  end,
}
