local autocmd = require("autocmd.go-test")

vim.api.nvim_create_user_command("GoTestsWatch", function()
  vim.api.nvim_create_autocmd("BufWritePost", {
    group = vim.api.nvim_create_augroup(autocmd.groupname, { clear = true }),
    pattern = "*.go",
    callback = autocmd.watch_tests(),
  })
end, {})

vim.api.nvim_create_user_command("GoTestsStop", function()
  vim.api.nvim_create_augroup(autocmd.groupname, { clear = true })
end, {})

vim.api.nvim_create_autocmd("BufWritePost", {
  group = vim.api.nvim_create_augroup(autocmd.inlinegorupname, { clear = true }),
  pattern = "*_test.go",
  callback = autocmd.go_tests_diagnostics,
})
vim.api.nvim_create_autocmd("BufEnter", {
  group = vim.api.nvim_create_augroup(autocmd.inlinegorupname, { clear = true }),
  pattern = "*_test.go",
  callback = autocmd.go_tests_diagnostics,
})
