return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "saghen/blink.cmp",
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
  },
  config = function()
    -- Diagnostics keymaps
    vim.keymap.set("n", "<space>K", vim.diagnostic.open_float)
    vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)
    vim.keymap.set("n", "]d", vim.diagnostic.goto_next)
    -- vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist)

    -- Gets called when LSP attaches to buffer
    local on_attach = function(_, bufnr) -- (event, bufnr)
      local keymap = function(keys, func, desc)
        if desc then
          desc = "LSP: " .. desc
        end

        vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
      end

      keymap("<Leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
      keymap("<Leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")
      keymap("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")
      keymap("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
      keymap("gI", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")
      keymap("<Leader>D", require("telescope.builtin").lsp_type_definitions, "Type [D]efinition")
      keymap("K", vim.lsp.buf.hover, "Hover Documentation")
      keymap("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
      -- keymap("<C-k>", vim.lsp.buf.signature_help, "Signature Documentation")
    end

    -- BASE CONFIG for MASON and LSP
    require("mason").setup()
    require("mason-lspconfig").setup()
    local mason_lspconfig = require("mason-lspconfig")

    -- Get Volar LSP path
    local mason_registry = require('mason-registry')
    local vue_language_server_path = mason_registry.get_package('vue-language-server'):get_install_path() ..
        '/node_modules/@vue/language-server'

    -- ENSURE INSTALLED SERVERS LIST
    local servers = {
      ts_ls = {
        init_options = {
          plugins = {
            {
              name = '@vue/typescript-plugin',
              location = vue_language_server_path,
              languages = { 'vue' },
            },
          },
        },
      },
      volar = {},
      jsonls = {},
      eslint = {},
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

    -- OLD CMP
    -- nvim-cmp supports additional completion capabilities, so broadcast that to servers
    -- local capabilities = vim.lsp.protocol.make_client_capabilities()
    -- capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

    -- BLINK CMP
    local capabilities = require("blink.cmp").get_lsp_capabilities()

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
}
