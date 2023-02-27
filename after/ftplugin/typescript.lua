local autocmd = require("autocmd.jest-test")

vim.api.nvim_create_user_command("JestTestsWatch", function()
  vim.api.nvim_create_autocmd("BufWritePost", {
    group = vim.api.nvim_create_augroup(autocmd.groupname, { clear = true }),
    pattern = { "*.ts", "*.tsx" },
    callback = autocmd.debaunce(autocmd.watch_tests(), 2000),
  })
end, {})

vim.api.nvim_create_user_command("JestTestsStop", function()
  vim.api.nvim_create_augroup(autocmd.groupname, { clear = true })
end, {})
