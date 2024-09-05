-- Set Netrw buffers to not be considered normal buffers
vim.cmd [[
  augroup netrw_config
    autocmd!
    autocmd FileType netrw setlocal bufhidden=wipe nobuflisted
  augroup END
]]
