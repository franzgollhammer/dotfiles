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

    -- LSP keymaps on attach
    vim.api.nvim_create_autocmd("LspAttach", {
      callback = function(event)
        local bufnr = event.buf
        local keymap = function(keys, func, desc)
          vim.keymap.set("n", keys, func, { buffer = bufnr, desc = "LSP: " .. desc })
        end

        keymap("<Leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
        keymap("<Leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")
        keymap("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")
        keymap("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
        keymap("gI", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")
        keymap("<Leader>D", require("telescope.builtin").lsp_type_definitions, "Type [D]efinition")
        keymap("K", vim.lsp.buf.hover, "Hover Documentation")
        keymap("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
      end,
    })

    -- BLINK CMP capabilities
    local capabilities = require("blink.cmp").get_lsp_capabilities()

    -- BASE CONFIG for MASON and LSP
    require("mason").setup()

    -- Get Volar LSP path (may not be installed yet on first run)
    local mason_registry = require('mason-registry')
    local InstallLocation = require('mason-core.installer.InstallLocation')
    local vue_language_server_path
    local ok, pkg = pcall(mason_registry.get_package, 'vue-language-server')
    if ok and pkg:is_installed() then
      vue_language_server_path = InstallLocation.global():package('vue-language-server')
          .. '/node_modules/@vue/language-server'
    end

    -- Configure servers via vim.lsp.config (Neovim 0.11+)
    local servers = {
      ts_ls = vue_language_server_path and {
        capabilities = capabilities,
        init_options = {
          plugins = {
            {
              name = '@vue/typescript-plugin',
              location = vue_language_server_path,
              languages = { 'vue' },
            },
          },
        },
      } or { capabilities = capabilities },
      vue_ls = { capabilities = capabilities },
      jsonls = { capabilities = capabilities },
      eslint = { capabilities = capabilities },
      html = { capabilities = capabilities },
      cssls = { capabilities = capabilities },
      gopls = { capabilities = capabilities },
      pyright = { capabilities = capabilities },
      rust_analyzer = { capabilities = capabilities },
      bashls = { capabilities = capabilities },
      taplo = { capabilities = capabilities },
      yamlls = { capabilities = capabilities },
      lua_ls = {
        capabilities = capabilities,
        settings = {
          Lua = {
            telemetry = { enable = false },
            diagnostics = {
              globals = { "vim" },
            },
          },
        },
      },
    }

    for server_name, server_config in pairs(servers) do
      vim.lsp.config(server_name, server_config)
    end

    -- mason-lspconfig handles ensure_installed + automatic_enable
    require("mason-lspconfig").setup({
      ensure_installed = vim.tbl_keys(servers),
      automatic_enable = true,
    })
  end,
}
