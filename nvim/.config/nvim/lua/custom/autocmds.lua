-- autoformat on save
-- vim.cmd [[ augroup fmt
--   autocmd!
--   autocmd BufWritePre * undojoin | Neoformat
-- augroup END ]]

vim.cmd([[ autocmd Filetype lua setlocal expandtab tabstop=4 shiftwidth=4 softtabstop=4 ]])
vim.cmd([[ autocmd Filetype sh setlocal expandtab tabstop=4 shiftwidth=4 softtabstop=4 ]])
