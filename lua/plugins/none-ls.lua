return {
	"nvimtools/none-ls.nvim",
	config = function()
		local null_ls = require("null-ls")
    local on_attach = function()

    end

		null_ls.setup({
			sources = {
				null_ls.builtins.formatting.stylua,

				null_ls.builtins.formatting.prettierd,
				null_ls.builtins.diagnostics.eslint_d,
				null_ls.builtins.formatting.eslint_d,
			},
		})

		vim.keymap.set("n", "<leader>ff", vim.lsp.buf.format, {})
	end,
}
