local null_ls = require "null-ls"
local b = null_ls.builtins

local sources = {

   -- webdev stuff
   b.formatting.deno_fmt,
   b.formatting.prettier.with { filetypes = { "html", "markdown", "css" } },

   -- Lua
   b.formatting.stylua,

   -- Shell
   b.formatting.shfmt,
   b.diagnostics.shellcheck.with { diagnostics_format = "#{m} [#{c}]" },

   -- cpp
   b.formatting.clang_format,
}

local M = {}

M.setup = function()
   null_ls.setup {
      debug = true,
      sources = sources,
   }
end

return M
-- local ok, null_ls = pcall(require, "null-ls")
-- 
-- if not ok then
-- 	return
-- end
-- 
-- local b = null_ls.builtins
-- 
-- local sources = {
-- 
-- 	-- Lua
-- 	b.formatting.stylua.with({
-- 		-- https://github.com/JohnnyMorganz/StyLua/issues/281
-- 		extra_args = { "--num-threads", "2" },
-- 	}),
-- 
-- 	-- Shell
-- 	b.formatting.shfmt.with({
-- 		extra_args = { "-i", "4" },
-- 	}),
-- }
-- 
-- local M = {}
-- M.setup = function(on_attach)
-- 	null_ls.config({
-- 		sources = sources,
-- 	})
-- 
-- 	local function buf_set_keymap(...)
-- 		vim.api.nvim_buf_set_keymap(bufnr, ...)
-- 	end
-- 
-- 	local opts = { noremap = true, silent = true }
-- 	buf_set_keymap("n", "<leader>fm", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
-- 
-- 	vim.cmd("autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()")
-- 
-- 	require("lspconfig")["null-ls"].setup({ on_attach = on_attach })
-- end
-- 
-- return M
