return {
  {
    "williamboman/mason.nvim",
  },
  {
    "williamboman/mason-lspconfig.nvim",
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      vim.keymap.set("n", "<space>K", vim.diagnostic.open_float)
      vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)
      vim.keymap.set("n", "]d", vim.diagnostic.goto_next)
      -- vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist)

      local on_attach = function(_, bufnr)
        local keymap = function(keys, func, desc)
          if desc then
            desc = "LSP: " .. desc
          end

          vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
        end

        keymap("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
        keymap("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")
        keymap("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")
        keymap("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
        keymap("gI", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")
        keymap("<leader>D", require("telescope.builtin").lsp_type_definitions, "Type [D]efinition")
        keymap("K", vim.lsp.buf.hover, "Hover Documentation")
        -- keymap("<C-k>", vim.lsp.buf.signature_help, "Signature Documentation")
        keymap("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")

        vim.api.nvim_buf_create_user_command(bufnr, "Format", function(_)
          vim.lsp.buf.format()
        end, { desc = "Format current buffer with LSP" })
      end

      require("mason").setup()
      require("mason-lspconfig").setup()

      local mason_lspconfig = require("mason-lspconfig")
      local mason_registry = require('mason-registry')
      local vue_language_server_path = mason_registry.get_package('vue-language-server'):get_install_path() ..
          '/node_modules/@vue/language-server'

      local servers = {
        tsserver = {
          init_options = {
            plugins = {
              {
                name = '@vue/typescript-plugin',
                location = vue_language_server_path,
                languages = { 'javascript', 'typescript', 'vue' },
              },
            },
          },
          filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue' },
        },
        volar = {},
        jsonls = {},
        eslint = {
          filetypes = { "vue", "javascript", "javascriptreact", "typescript", "typescriptreact" },
        },
        html = {},
        cssls = {},
        lua_ls = {
          Lua = {
            telemetry = { enable = false },
            diagnostics = {
              globals = { "vim" },
            },
          },
        },
      }

      -- nvim-cmp supports additional completion capabilities, so broadcast that to servers
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = require("cmp_nvim_lsp").default_capabilities()

      mason_lspconfig.setup({
        ensure_installed = vim.tbl_keys(servers),
      })

      mason_lspconfig.setup_handlers({
        function(server_name)
          require("lspconfig")[server_name].setup({
            capabilities = capabilities,
            on_attach = on_attach,
            settings = servers[server_name],
            filetypes = (servers[server_name] or {}).filetypes,
            init_options = (servers[server_name] or {}).init_options,
          })
        end,
      })
    end,
  },
}
