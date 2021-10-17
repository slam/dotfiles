local ok, null_ls = pcall(require, "null-ls")

if not ok then
	return
end

local b = null_ls.builtins

local sources = {

	-- Lua
	b.formatting.stylua.with({
		-- https://github.com/JohnnyMorganz/StyLua/issues/281
		extra_args = { "--num-threads", "2" },
	}),

	-- Shell
	b.formatting.shfmt.with({
		extra_args = { "-i", "4" },
	}),
}

local M = {}
M.setup = function(on_attach)
	null_ls.config({
		sources = sources,
	})

	local function buf_set_keymap(...)
		vim.api.nvim_buf_set_keymap(bufnr, ...)
	end

	local opts = { noremap = true, silent = true }
	buf_set_keymap("n", "<leader>fm", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)

	vim.cmd("autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()")

	require("lspconfig")["null-ls"].setup({ on_attach = on_attach })
end

return M
