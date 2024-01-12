return {
  "nvimtools/none-ls.nvim",
  config = function()
    local null_ls = require("null-ls")

    -- format on save
    local on_attach = function()
      local lang = vim.api.nvim_buf_get_option(0, "filetype")

      -- set up format on save for lua files only
      if lang == "lua" then
        vim.api.nvim_create_autocmd("BufWritePre", {
          callback = function()
            vim.lsp.buf.format()
          end,
        })
      end

      -- set up format on save for js/ts/vue ...
      vim.api.nvim_create_autocmd("BufWritePre", {
        pattern = { "*.tsx", "*.ts", "*.jsx", "*.js", "*.vue" },
        command = "silent! EslintFixAll",
        group = vim.api.nvim_create_augroup("EsLint", {}),
      })
    end

    null_ls.setup({
      sources = {
        -- Lua
        null_ls.builtins.formatting.stylua,

        -- JS / TS
        -- null_ls.builtins.formatting.prettierd,
        null_ls.builtins.diagnostics.eslint,
        null_ls.builtins.formatting.eslint,
      },
      on_attach = on_attach,
    })

    vim.keymap.set("n", "<leader>ff", vim.lsp.buf.format, {})
  end,
}
