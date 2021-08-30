-------------------- HELPERS -------------------------------
local api, cmd, fn, g = vim.api, vim.cmd, vim.fn, vim.g
local opt, wo = vim.opt, vim.wo
local fmt = string.format

local function map(mode, lhs, rhs, opts)
  local options = {noremap = true}
  if opts then options = vim.tbl_extend('force', options, opts) end
  api.nvim_set_keymap(mode, lhs, rhs, options)
end

g['python_host_prog'] = os.getenv('HOME') .. '/.neovim2/bin/python'
g['python3_host_prog'] = os.getenv('HOME') .. '/.neovim3/bin/python'
