vim.cmd([[
augroup RustDisableFmt
  autocmd!
  autocmd FileType rust :RustfmtDisable
augroup END
]])

vim.cmd([[
augroup RustfmtRemapping
  autocmd!
  autocmd FileType rust nnoremap <buffer> <Leader>lf :Rustfmt<CR>
augroup END
]])
