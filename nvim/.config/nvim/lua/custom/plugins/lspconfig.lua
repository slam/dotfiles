local M = {}

M.setup_lsp = function(attach, capabilities)
	local lspconfig = require("lspconfig")

	-- lspservers with default config
	local servers = { "html" }

	for _, lsp in ipairs(servers) do
		lspconfig[lsp].setup({
			on_attach = attach,
			capabilities = capabilities,
			-- root_dir = vim.loop.cwd,
			flags = {
				debounce_text_changes = 150,
			},
		})
	end

	lspconfig.pyright.setup({
		on_attach = attach,
		capabilities = capabilities,
		root_dir = function(fname)
			local root_files = {
				"pyproject.toml",
				"pyrightconfig.json",
			}
			return lspconfig.util.root_pattern(unpack(root_files))(fname)
				or lspconfig.util.find_git_ancestor(fname)
				or lspconfig.util.path.dirname(fname)
		end,
	})

	lspconfig.elixirls.setup({
		on_attach = attach,
		capabilities = capabilities,
		cmd = {
			vim.fn.expand("~/.vscode-server/extensions/jakebecker.elixir-ls-0.8.1/elixir-ls-release/language_server.sh"),
		},
	})
end

return M
